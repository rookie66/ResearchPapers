function runRadarSim_v2(handles)
% function runRadarSim(handles,isAnalyzeBufferMode);

    warning off all
    handleRadarControlls(handles,'off');
    
    displayTargets(handles,'in radar display')

    isAnalyzeBufferMode = get(handles.bufferAnalyze,'value');    
    
    temp = get(handles.bufferSize,'string');
    ind = get(handles.bufferSize,'value');
    nPRI = str2double( temp{ind} ) ;
    
    freqRes = nPRI * 2;
    freqInd = fftshift( 1:freqRes );
    handles.antenaGain = buildAntenaGain(handles);
    
    figure(handles.figure1);
    currentTime = handles.currentTime;
    miniDisplayUpdateTime = 0;
    pulseNum = handles.pulseNum;
    
    temp = get(handles.PRI,'string');
    ind = get(handles.PRI,'value');
    PRI = str2double( temp{ind} )/1e3 ; %PRI was entered in msec
    
    temp = get(handles.ZSA,'string');
    ind = get(handles.ZSA,'value');
    antenaTurnVelocity = str2num( temp{ind} ) ;
    
    temp = get(handles.updateRate,'string');
    ind = get(handles.updateRate,'value');
    updateRate = str2double( temp{ind} );
    
    temp = get(handles.samplingRate,'string');
    ind = get(handles.samplingRate,'value');
    Fs = str2double( temp{ind} )*1e3 ; %Fs was entered in Khz
    
    lastUpdate = currentTime;
    antenaGain = handles.antenaGain;
    temp = get(handles.RadarBW,'string');
    radarBWOptions = zeros( length(temp),1 );
    for n=1 :length(temp)
        radarBWOptions(n) = str2double( temp(n) );
    end
    
    PRISize = PRI*Fs;   %number of samples in PRI
    bufferSize = round(PRISize*nPRI);  %number of samples in buffer
    
    if bufferSize > 1e5
        set(handles.run,'string','Pause');
        radarSimulation('run_Callback',handles.run,[],guidata(handles.run));
        ERRORDLG('requested PRI, buffer size & sampling rate require too large a vector for simulation !!!');
    end
    
    returnPulses = zeros( bufferSize,1);
    numRadarTurn = handles.numRadarTurn;   
    
    randVecLength = 1e6;
    randVec = randn(randVecLength,1);
    
    if Fs > 44e3
        soundFs = 11e3;
        sound2SampleRatio = round(Fs/soundFs);
    else
        soundFs = 11e3;
        sound2SampleRatio = 1;
    end
    player = audioplayer(0, soundFs);
        
    % Digitizer Noise
    n = get(handles.digitizerNoiseLevel,'value');
    temp = get(handles.digitizerNoiseLevel,'string');
    if strcmp(temp{n},'off')
        digitizerNoiseLevel = 0;
    else 
        n=str2double(temp{n});
        digitizerNoiseLevel = 10^n;
    end

    % RF noise
    n = get(handles.RFnoise,'value');
    temp = get(handles.RFnoise,'string');
    if strcmp(temp{n},'off')
        RFnoiseLevel = 0;
    else 
        n=str2double(temp{n});
        RFnoiseLevel = 10^n;
    end
    
    hold on;
    PW = get(handles.PW,'value')  * PRI;
    PWn = round( PW*Fs );   PWn = max(1,PWn);
    transmisionInd = zeros(PWn*nPRI,1);
    pulseTransmitionPoints = ones( nPRI,1 );

% -------------- stagger ------------------------
    transmisionInd( 1:PWn ) = (1:PWn);
    temp = get(handles.stagger,'value');
    options = get(handles.stagger,'string');
    stagger = str2double( options{temp} );
    ratio = 2*PW / PRI;
    ratio = max(ratio, 0.05);
    intervals = (1+( (0:stagger-1)-(stagger-1)/2)*ratio)*PRI;
    numSamplesInInterval = round( intervals*Fs );
    numSamplesInInterval(end) = round( numSamplesInInterval(end)- mod(sum(numSamplesInInterval),PRISize));
    numIntervals = length(intervals);
    numSamplesInPRI = round( sum( intervals )*Fs );
    maxDist = numSamplesInPRI*150/Fs*1e6;
    for n=2:nPRI
        interval = numSamplesInInterval(mod(n-1,numIntervals)+1);
        transmisionInd( (n-1)*PWn+1:n*PWn ) = transmisionInd( (n-2)*PWn+1:(n-1)*PWn ) + interval;
        pulseTransmitionPoints( n ) = transmisionInd( (n-1)*PWn+1 );
    end
   
    rangeCellInd = zeros(nPRI,numSamplesInPRI);
    for n = 1 : nPRI
        rangeCellInd(n,:) = transmisionInd( (n-1)*PWn+1 );
    end
    temp = repmat( 0:numSamplesInPRI-1,nPRI, 1 );
    rangeCellInd = rangeCellInd + temp;
    rangeCellInd = mod( rangeCellInd-1,bufferSize ) + 1;
    rangeCellInd = rangeCellInd';
%     bufferSize = size(rangeCellInd);
    
% -----------------------------------------------    
    
    targetsTime = 0;
    
    rangeRes = PWn; rangeRes = rangeRes + ~mod(rangeRes,2);
    dilateKer = zeros(max(numSamplesInInterval)+rangeRes-1,1);
    dilateKer(1:rangeRes) = 1;
    dilateKer(1:3) = 1; %In case PWn == 1
    stagger = length(numSamplesInInterval);
    for n=1:stagger-1
        for m = 1:stagger
            ind = mod( m:m+n-1, stagger )+1;
            offset = numSamplesInPRI - sum(numSamplesInInterval(ind));
            dilateKer(offset:offset+PWn) = 1;
        end
    end
    dilateKer = [dilateKer(end:-1:rangeRes+1) ; dilateKer];

%   An option to link the angle resolution to the antena gain (should be
%   used only in low SNRs 
%     [M n] = max(antenaGain);
%     f = find( antenaGain/M < 0.001 );
%     m = min( abs(f-n) );
%     angleRes = m/length(antenaGain)*4*pi; 

    angleRes = 1.1*2*pi*(nPRI*PRI)*(antenaTurnVelocity/2/pi);    % 2 * [2*pi*bufferTime/(antena turn time)]
    rangeRes = PW*3e8/2;
    velocityRes = 3e8/(handles.IF_Freq)/ nPRI*1000/2;
    
    foundTargetInBuffer = 0;
    
    radarSector = antenaTurnVelocity*updateRate;  % a buffer sector
    updatedDisplay = false;
    
    tic;
    lastUpdateRealTime = toc;
    
    
    % ----------------------------- Start the RADAR scan ---------------------------------
    while get(handles.run,'value')
             
        if get(handles.CFAR,'value')
            useCFAR = true;
            CFAR = get(handles.Th,'value');
        else
            useCFAR = false;
            Th = 10^(get(handles.Th,'value'));
        end
        
        Amp = 10^ get(handles.Amp,'value') ;
        
        currentTime = currentTime+PRI;
        radarAngle = mod(antenaTurnVelocity*currentTime,2*pi); %radar angle in the middle of the buffer
        
        
        % -------------------------------- Finding the return pulses --------------------------------------------
        targets = [handles.Targets ; handles.mountains];
        curentReturnPulses = zeros( bufferSize,1 );
        if ~isempty(targets)
            [t a phi] = targetsReturn(targets,antenaGain,Amp, currentTime,antenaTurnVelocity, targetsTime,handles.IF_Freq);
            tIn = round( t*Fs );
            tIn = max(tIn,1);   tIn = min(tIn,bufferSize);
            for n=1:length(t)
                curentReturnPulses(tIn(n):tIn(n)+PWn-1) = curentReturnPulses(tIn(n):tIn(n)+PWn-1) + a(n)*exp(i*phi(n));
%                 targetReturns = mod( transmisionInd + tIn(n)-1, bufferSize )+1;
%                 curentReturnPulses( targetReturns ) = curentReturnPulses( targetReturns ) + a(n)*exp(i*phi(n));
            end
        end
        
        % -------------------------------- Adding new reception --------------------------------
        transmitInd = pulseTransmitionPoints( mod(pulseNum-1,nPRI)+1 );    % !!!! needs to fix this in case of stagger with small PRI
        index = transmitInd : transmitInd + bufferSize-1;
        index( bufferSize-transmitInd + 2 : bufferSize ) = 1:transmitInd-1; %!!! bug in case of sampling 20Khz and PRI 0.53 
        returnPulses(index) = returnPulses(index)+curentReturnPulses;  
        
        
        % --------------------------------- Processing Buffer ------------------------------------------
        if ~mod(pulseNum,nPRI)  %Only processing every N number of pulses
            
            recievedSignal = returnPulses;

            n = get(handles.RadarBW,'value');
            radarBW=radarBWOptions(n) * 1e6;
            %  -------------------------- Creating RF noise ----------------------------------------------------
            if RFnoiseLevel
%                  RFnoise = randn( length(returnPulses),2 )* RFnoiseLevel *[1 ; i];
                 RFnoise = fastSemiRandn( length(returnPulses))* RFnoiseLevel *[1 ; i]*radarBW;                 
                 recievedSignal = recievedSignal+RFnoise;
            end
            
            % --------------------------------- Passing reception through the radars reciver BW------------------
            a = -pi^2*radarBW^2/log(0.5)*log(exp(1));
            responseStart = sqrt(-log(0.1)/log(exp(1))/a);
            t = -responseStart : 1/Fs : responseStart;
            response = exp(-t'.^2*a);
            response = response/sum(response);
            recievedSignal = conv2(recievedSignal,response,'same');
            % Gausian sigma freq and time: Gf = 1/(2Gt)
            % Gf = BW/sqrt(2ln2)    => Gt = ln2/(sqrt(2)BW)

            %  -------------------------- Creating Digitizer noise --------------------------------------------------
            if digitizerNoiseLevel
%                  DigiNoise = randn( bufferSize,2)* digitizerNoiseLevel * [1 ; i];
                DigiNoise = fastSemiRandn( bufferSize )* digitizerNoiseLevel * [1 ; i];
                recievedSignal = recievedSignal+DigiNoise;
            end

            recievedSignal(transmisionInd) = 0;  % Deleting the time which the radar transmited (couldn't recieve)
            returnPulses = zeros( bufferSize,1);    % Cleaning the pulses buffer

            %  ------------------------- Performing Match Filter ----------------------------------------------------
            if get(handles.useMatchFilter,'value');
                if length(response) > PWn
                    matchFilter = response;
                else
                    matchFilter = ones(PWn,1)/PWn;
                end
                
                processedRecivedSignal = conv2(recievedSignal,matchFilter,'same');
            else
                processedRecivedSignal = recievedSignal;
            end

            % ------------------------------- Was there a target ---------------------------------------------------
            signalInRangeCells = processedRecivedSignal(rangeCellInd);

            isMTIused = get(handles.useMTI,'value');
            if isMTIused
                freqInRangeCells = fft( signalInRangeCells,freqRes,2 );
                energyInFreqRangeCells = abs( freqInRangeCells(:,freqInd) ).^2;
                if useCFAR
                    noiseLevel = median( energyInFreqRangeCells(:) );    % Th is per frequency
                    freqTh = noiseLevel * CFAR * nPRI; 
                else
                    freqTh = Th * nPRI;
                end

                % Find in each range cell the maximum frequency (I only
                % allow one target per range cell)
                [maxFreq maxFreqInd] = max( energyInFreqRangeCells,[],2);
                localMaxEnergy = imdilate( maxFreq , dilateKer );
                rangeCell = find( localMaxEnergy == maxFreq & maxFreq > freqTh );
                targetInd = sub2ind( [numSamplesInPRI freqRes], rangeCell, maxFreqInd( rangeCell ) );
            else 
                % no MTI             
                energyInRangeCells = sum( abs(signalInRangeCells).^2,2 );
                if useCFAR
                    noiseLevel = median( energyInRangeCells );
                    Th = noiseLevel * CFAR;
                end
                % Thresholding to find targets
                localMaxEnergy = imdilate(energyInRangeCells,dilateKer);
                targetInd = find ( energyInRangeCells == localMaxEnergy & energyInRangeCells > Th);
            end % if isMTIused

        if ~isempty(targetInd)
            foundTargetInBuffer = 1;
            if isMTIused
                [rangeCell ans] = ind2sub(size(energyInFreqRangeCells),targetInd(:));
                RCS = energyInFreqRangeCells(targetInd(:));
            else
                rangeCell = targetInd;
                RCS = energyInRangeCells(targetInd);
            end
            targetRange = ( rangeCell -PWn/2) / Fs / 2 * 3e8;   %target ranges
            targetV = ones(length(targetInd),1)*12345;

            for Rind = 1:length(targetInd)     
                %Processing each Target
                pos = targetRange(Rind)*[cos(radarAngle) sin(radarAngle)];

                if isMTIused
                    % Calculating the targets velocity acording to its dopler frequency
                    targetV(Rind) = MTIcalcVelocityFromFourier(energyInFreqRangeCells,targetInd(Rind),freqRes,handles.IF_Freq,PRI);
                end

                if isempty(handles.foundTargets)
                    % adding the new target to the foundTargets structure
                    handles.foundTargets(end+1) = ...
                            createTargetObj( pos, RCS(Rind), targetRange(Rind), targetV(Rind), radarAngle,0, radarAngle,radarAngle,[],numRadarTurn );
                    h = plotTarget( handles.foundTargets(end), handles );
                    handles.foundTargets(end).hPlot = h;
                else

                    % ---------------- Checking if this target was already detected ------------------------------
                    M = length(handles.foundTargets);

%                     angleToOldTargets = zeros(M,1);
                    dAngle = zeros(M,1);
                    dRange = zeros(M,1);
                    dV = zeros(M,1);
                    for mm=1:M
                        d1 = calcDiffAngle( handles.foundTargets(mm).counterClockWise, radarAngle );
%                         d2 = -calcDiffAngle( handles.foundTargets(mm).clockWise, radarAngle );
                        d2 = pi;
                        dAngle(mm) = min ( d1, d2)/angleRes;
                        dRange(mm) = abs( handles.foundTargets(mm).R - targetRange(Rind) )/rangeRes;
                        dV(mm) = abs( handles.foundTargets(mm).v - targetV(Rind) )/velocityRes ;
                    end
                    
                    [sameTargetScore sameTargetInd] = min( dAngle.^2 + dRange.^2 + dV.^2 );

                    % Was this target already detected
                    if  sameTargetScore < 1
                        % This target was already detected !
                        if handles.foundTargets(sameTargetInd).RCS < RCS(Rind)
                            % Keeping the parameters of the better recived target;
                            handles.foundTargets(sameTargetInd).pos = pos;
                            handles.foundTargets(sameTargetInd).RCS = RCS(Rind);
                            handles.foundTargets(sameTargetInd).R = targetRange(Rind);
                            handles.foundTargets(sameTargetInd).v = targetV(Rind);
                            handles.foundTargets(sameTargetInd).angle = radarAngle;
                            delete( handles.foundTargets(sameTargetInd).hPlot );
                            h = plotTarget( handles.foundTargets(sameTargetInd), handles );
                            handles.foundTargets(sameTargetInd).hPlot = h;
%                             handles.foundTargets(sameTargetInd).foundInTurn = numRadarTurn;
                        end 
                        
                        if d1 < d2 % new target is before old target
                            handles.foundTargets(sameTargetInd).counterClockWise = radarAngle;
                        else
                            handles.foundTargets(sameTargetInd).clockWise = radarAngle;
                        end                         
                    else  
                        % This is a new target (wasn't detected yet)
                        handles.foundTargets(end+1) = ...
                            createTargetObj( pos, RCS(Rind), targetRange(Rind), targetV(Rind), radarAngle,0, radarAngle,radarAngle,[],numRadarTurn );
                        h = plotTarget( handles.foundTargets(end), handles );
                        handles.foundTargets(end).hPlot = h;
                    end % m <  angleRes & distFromOldTarget < rangeRes % Was this target already detected
                end % if isempty(handles.foundTargets)
                
            end % for n = 1:length(R)
        end %if ~isempty(f)            

        %---------------------------------------------------------------------------------------------------------------------
        dt = currentTime-lastUpdate ;
        if dt > updateRate  %Is it time to update the display
            lastUpdate = currentTime;
            currentRealTime = toc;
            delay = dt - (currentRealTime - lastUpdateRealTime); % syncronizing to real time
            lastUpdateRealTime = currentRealTime;
%             delay = max(delay,1e-5);  %to allowupdate of the display and
%             GUI response
            if delay > 0
                pause(delay);
            end
            % -------------------------------------------------------------------------
            isPersistentDisplay = get(handles.persistentDisplay,'value');
            handles = plotFOV(handles,currentTime,antenaTurnVelocity,radarSector,maxDist,isPersistentDisplay);         
            updatedDisplay = true;
            
            % updating the mini-map display every 5 seconds
            if currentTime > miniDisplayUpdateTime + 5
                if ~get( handles.scopeDisplay,'value' )
                    miniDisplayUpdateTime = currentTime;
                    displayTargets(handles,'in radar display')
                    numRadarTurn = ceil(currentTime*antenaTurnVelocity/2/pi);
                end
                if isPersistentDisplay
                    if length( handles.persistentPlotHandle ) > 1000
                        temp = handles.persistentPlotHandle;
						delete( temp( 1:end-1000 ) );
                        handles.persistentPlotHandle = temp(end-999:end);
                    end
                end
            end

            %---------------------------------------------------------------------------------------------------------------------
            % Updating targets position, velocity & accelaration  
            targetsTime = currentTime; % the time in which the target position was updated
            for n =1:length(handles.Targets)
                handles.Targets(n).XY = handles.Targets(n).XY + dt*handles.Targets(n).v+dt^2*handles.Targets(n).a;
                handles.Targets(n).v = handles.Targets(n).v + dt*handles.Targets(n).a;
                handles.Targets(n).a = handles.Targets(n).a * 0.95^dt;
                targetsManuv = handles.Targets(n).maneuverability;
                if (1-exp(-dt/targetsManuv)) > rand(1) % deciding if the target changes it's acceleration
                    phi = atan( handles.Targets(n).v(2)/handles.Targets(n).v(1) );
                    phi = phi + 2*pi*(rand(1)-0.5);
                    handles.Targets(n).a = randn(1)*20*[cos(phi) sin(phi)] - handles.Targets(n).v/targetsManuv/2;
                end
                
            end

        end % if dt > updateRate  %Is it time to update the display        
                            
        %---------------------------------------------------------------------------------------------------------------------
        if isAnalyzeBufferMode
            if get(handles.waitForTarget,'value')
                % wait for a target in the buffer
                if foundTargetInBuffer
                    if isMTIused
                        analyzBufferWithMTI(handles,recievedSignal,processedRecivedSignal,energyInFreqRangeCells,PWn,freqTh,freqInRangeCells,numSamplesInPRI,rangeCellInd);
                    else
                        analyzBuffer(handles,recievedSignal,processedRecivedSignal,energyInRangeCells,PWn,Th,rangeCellInd,localMaxEnergy);
                    end
                    set(handles.run,'string','Pause');
                    radarSimulation('run_Callback',handles.run,[],guidata(handles.run));
                end
            else
                if isMTIused
                    analyzBufferWithMTI(handles,recievedSignal,processedRecivedSignal,energyInFreqRangeCells,PWn,freqTh,freqInRangeCells,numSamplesInPRI,rangeCellInd);
                else
                    analyzBuffer(handles,recievedSignal,processedRecivedSignal,energyInRangeCells,PWn,Th,rangeCellInd,localMaxEnergy);
                    set(handles.run,'string','Pause');
                    radarSimulation('run_Callback',handles.run,[],guidata(handles.run));
                end
                set(handles.run,'string','Pause');
                radarSimulation('run_Callback',handles.run,[],guidata(handles.run));
            end
        end

        % ------------------------------------------------------------------------------------
        % play recived signal sound
        if get(handles.soundOn,'value')
%             soundSig = abs(processedRecivedSignal);
            soundSig = tanh( abs(processedRecivedSignal) );
%             soundSig = abs( tanh( processedRecivedSignal ) );
%             soundSig = angle(processedRecivedSignal); %I tried to listen
%             to targets velocity
            soundSig = soundSig / max(soundSig);
            soundSamples = decimate(soundSig,sound2SampleRatio );         
            player.stop;
            player = audioplayer( soundSamples, soundFs );
            play(player);
        end
        % ------------------------------------------------------------------------------------            
        % Display analog scope  !!!!!
        if get(handles.scopeDisplay,'value')
            hold( handles.miniDisplay,'off');
            sig = abs(processedRecivedSignal(rangeCellInd));
            plot(handles.miniDisplay,log( sig( PWn+1:end,:) ),'color',[239 255 250]/256,'linewidth',1);
            set( handles.miniDisplay,'color',[118 219 237]/256);
            ylim(handles.miniDisplay,[-22 -8]);
            xlim( handles.miniDisplay,[1 numSamplesInPRI-PWn] );
            grid( handles.miniDisplay,'on');
            if ~updatedDisplay
                drawnow;
                updatedDisplay = false;
            end
        end
        % ------------------------------------------------------------------------------------            
            
    end %if ~mod(pulseNum,nPRI)  %Only processing every N number of pulses
    pulseNum = pulseNum+1;
        

    end % while get(handles.run,'value')
    
    handles.numRadarTurn = numRadarTurn;
    handles.pulseNum = pulseNum;
    handles.currentTime = currentTime;
    guidata(handles.run,handles);
    handleRadarControlls(handles,'on');
    set(handles.PW,'value',PW/PRI);
    
    function x = fastSemiRandn(N)
        % this nested function recives the number of elements to return
        % it allways returns an N by 2 matrix of random numbers samppled
        % from the vector randVec
        
        vInd = ceil(rand(2)* (randVecLength-N));
        x = [ randVec(vInd(1):vInd(1)+N-1) randVec(vInd(2):vInd(2)+N-1)];
    end
        
end