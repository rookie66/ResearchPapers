function antenaGain = buildAntenaGain(handles)
% antenaGain = buildAntenaGain(handles)
% This function builds the antena response curve (as a function of angle)

% build Antena
n=get(handles.antenaMode,'value');
antenaMode = get(handles.antenaMode,'string');
switch antenaMode{n}
    case 'Antena Connected'
        antenaGain = sinc(-1:0.001:1).^500;
        s = trapz(antenaGain)*2*pi/length(antenaGain); %integral over antena gain
        antenaGain = antenaGain/s;
    case 'Antena with Side Lobes'
        antenaGain = sinc(-2.5:0.001:2.5).^4;
        s = trapz(antenaGain)*2*pi/length(antenaGain); %integral over antena gain
        antenaGain = antenaGain/s;
    case 'Omni'
        antenaGain = [ 1/2/pi 1/2/pi];
    case 'Antena Disconnected'
        antenaGain = 0;
end