function analyzBufferWithMTI(handles,recievedSignal,processedRecivedSignal,energyInFreqRangeCells,PWn,Th,freqInRangeCells,PRIn,rangeCellInd);
% function analyzBufferWithMTI(handles,recievedSignal,processedRecivedSignal,energyInFreqRangeCells,PWn,Th,freqInRangeCells,PRIn,rangeCellInd);
%
% This function displays the frequency content of the range-cells

temp = get(handles.samplingRate,'string');
ind = get(handles.samplingRate,'value');
Fs = str2num( temp{ind} )*1e3 ; %Fs was entered in Khz

temp = get(handles.PRI,'string');
ind = get(handles.PRI,'value');
PRI = str2num( temp{ind} )/1e3 ; %PRI was entered in msec

signalInRangeCells = processedRecivedSignal(rangeCellInd);
energyInRangeCells = sum( abs(signalInRangeCells).^2,2 );
analyzBuffer(handles,recievedSignal,processedRecivedSignal,energyInRangeCells,PWn,Th,rangeCellInd,[]);

energyInFreqRangeCells = energyInFreqRangeCells';
[freqRes nRangeCells] = size(energyInFreqRangeCells);
figure('name','time-freq Display');
imagesc( [1:nRangeCells]/Fs*3e8/2/1e3, ([1:freqRes]-freqRes/2)/freqRes/PRI/2*3e8/handles.IF_Freq, log10(energyInFreqRangeCells)); colorbar;
xlabel('Range Cells [Km]'); 
ylabel('Velocity [m/s]');
title('Time-Freq display (logarythmic scale)');