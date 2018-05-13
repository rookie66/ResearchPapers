function [t a phi] = targetsReturn(targets, antenaGain,Amp,currTime,w,targetsTime,IF_Freq)
% This function returns the time phase and amplitude of the return signal
% from existing targets.

    dt = targetsTime-currTime;
    radarAngle = currTime*w;
    if length(antenaGain)==1 && ~antenaGain %order of comparison is important for performance
        % antena is diconected
        t = [];
        a = [];
        phi = [];
        return
    end
    
    N = length(antenaGain);
    M = length(targets);

    meterPerSec = 2/3e8;    %I multiply by two as the distance travelled is doubled then targets distance (pulse has to come back as well)
    RCS = [targets.RCS];
    v = [targets(:).v];
    v = reshape(v,2,M)';
    cor = [targets(:).XY];
    cor = reshape(cor,2,M)';
    acc = [targets(:).a];
    acc = reshape(acc,2,M)';
%     v = cell2mat({targets(:).v}');
%     cor = cell2mat({targets(:).XY}');
%     acc = cell2mat({targets(:).a}');
    cor = cor + v*dt+acc/2*dt^2;
    distSquer = sum( cor.^2, 2 )';
    t = sqrt( distSquer ) * meterPerSec;
    targetsRelAngle = atan2(cor(:,2) , cor(:,1));
    targetsRelAngle = mod(targetsRelAngle-radarAngle+pi,2*pi);  
    in = round( (targetsRelAngle)/2/pi*N );    %finding the antena gain in this angle
    in = min( in,N(ones(M,1)) );
    in = max( in,ones(M,1) );
    a = RCS .* (antenaGain(in).^2) ./ (distSquer.^2) * Amp ; % here should come the radar formula (dist2 - is already the distance squared) 
    phi = mod(IF_Freq*2*pi*t,2*pi)';
    t = t';
    a = a';