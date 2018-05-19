function vel = MTIcalcVelocityFromFourier(energyInFreqRangeCells,ind,freqRes,intermidateFreq,PRI)
% vel = MTIcalcVelocityFromFourier(energyInFreqRangeCells,ind,freqRes,intermidateFreq,PRI)

    [range freq] = ind2sub(size(energyInFreqRangeCells).*[1 0.5],ind);
    
    if freq < freqRes & freq > 1
        sig = energyInFreqRangeCells(range, freq-1:freq+1);
        freq = parbolFit( (freq-freqRes/2-2:freq-freqRes/2)/freqRes/PRI,sig );
        if abs(freq) < 1
            freq = 0;
        end
        vel = 3e8*freq/(2*intermidateFreq);
    else
        vel = 3e8*(freq-freqRes/2)/(2*intermidateFreq);
    end
        
        
function x0 = parbolFit(x,y)
    
    c = y(2);
    a = (y(1)+y(3)-2*c)*0.5;
    b = y(3)-c-a;
    peak = -b/(2*a);
    x0 = x(2)+peak*(x(3)-x(2));
            