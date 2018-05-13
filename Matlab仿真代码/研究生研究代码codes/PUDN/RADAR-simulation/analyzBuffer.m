function analyzBuffer(handles,recievedSignal,processedRecivedSignal,energyInRangeCells,PWn,Th,rangeCellInd,localMaxEnergy)
% function analyzBuffer(handles,recievedSignal,processedRecivedSignal,energyInRangeCells,PWn,Th,rangeCellInd)
%
% This function will display the radars bufer content in seperate figures. 

temp = get(handles.samplingRate,'string');
ind = get(handles.samplingRate,'value');
Fs = str2num( temp{ind} )*1e3 ; %Fs was entered in Khz

temp = get(handles.bufferSize,'string');
ind = get(handles.bufferSize,'value');
nPRI = str2num( temp{ind} ) ;

temp = get(handles.PRI,'string');
ind = get(handles.PRI,'value');
PRI = str2num( temp{ind} )/1e3 ; %PRI was entered in msec

isMatchFilterUsed = get(handles.useMatchFilter,'value');

%--------------------------------------------------------------------------------------
% plotting the time signal
figure('name','Buffer Content');
subplot(2,1,1);
N = length(recievedSignal);
plot([0:N-1]/Fs,abs(recievedSignal));
if isMatchFilterUsed
    % if match filter is used - adding the signal after the match filter
    % over the original recived signal
    hold on;
    semilogy([0:N-1]/Fs,abs(processedRecivedSignal),'g');
    legend( {'Recived Signal' ; 'Signal after match Filter'} );
else
    legend( {'Recived Signal'} );
end
title('Buffer Content');
xlabel('[sec]');    ylabel('volt (log scale)');

nRangeCells = length(energyInRangeCells);

if isMatchFilterUsed
    subplot(2,1,2);
    h1 = semilogy( [1:nRangeCells]/Fs/1e3*3e8/2, energyInRangeCells,'g' );
    hold on;
    h2 = semilogy(  [1 nRangeCells]/Fs/1e3*3e8/2, [Th Th], 'r');
    temp = recievedSignal(rangeCellInd);
    engCellsNoMatchFilter = sum( abs(temp).^2,2);
    h3 = semilogy([PWn:nRangeCells]/Fs/1e3*3e8/2, engCellsNoMatchFilter(PWn:end),'b');
    legend([h3 h1 h2], {'Signal in range cells' ; 'Signal after match filter' ; 'used Threshold'} );
else
    subplot(2,1,2);
    h1 = semilogy( [1:nRangeCells]/Fs/1e3*3e8/2, energyInRangeCells,'b' );
    hold on;
    h2 = semilogy(  [1 nRangeCells]/Fs/1e3*3e8/2, [Th Th], 'r');
    legend( {'Signal in range cells' ; 'Threshold'} );
end
xlabel('Range Cells [Km]');
ylabel('volt^2 (log scale)');


%--------------------------------------------------------------------------------------
% plotting the Amplitude in range-cells
signalInRangeCells = processedRecivedSignal(rangeCellInd);

figure('name','Amp in Range-Cells');
imagesc( [1:nRangeCells]/Fs*3e8/2/1e3, [1:nPRI]*PRI*1e3, log(abs(signalInRangeCells'))/log(10));
ylabel('Time [msec] (PRI steps)');xlabel('Range Cells [Km]'); title('Amplitude in range Cells (logarythmic scale)');
colorbar;

% plotting the Phase in range-cells
figure('name','Phase in Range-Cells');
imagesc( [1:nRangeCells]/Fs*3e8/2/1e3,[1:nPRI]*PRI*1e3, angle(signalInRangeCells'));
ylabel('Time [msec] (PRI steps)');xlabel('Range Cells [Km]'); title('Phase in range Cells');
colorbar;

if ~isempty(localMaxEnergy)
    % plotting the local maximum of the recived signal (intresting in cases
    % of stagger)
    figure; plot( [1 : nRangeCells]/Fs/1e3*3e8/2,abs( energyInRangeCells'));
    hold on;
    plot([1 : nRangeCells]/Fs/1e3*3e8/2,localMaxEnergy','r');
    title('Local maximum signal in range cells (affected by the stagger)');
    xlabel('Range [Km]');    ylabel('v^2');
end

set(handles.bufferAnalyze,'value',0);
