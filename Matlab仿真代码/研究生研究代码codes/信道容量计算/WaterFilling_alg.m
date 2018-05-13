function [Capacity PowerAllo] = WaterFilling_alg(PtotA,ChA,B,N0);
%
% WaterFilling in Optimising the Capacity
%===============
% Initialization
%===============
ChA = ChA + eps;%  奇异值
NA = length(ChA);  % the number of subchannels allocated to
%奇异值的个数代表需要分配能量的子信道的个数，默认其他子信道不需要分配能量
H = ChA.^2/(B*N0);  % the parameter relate to SNR in subchannels
% assign the power to subchannel
PowerAllo = (PtotA + sum(1./H))/NA - 1./H;
while(length(find(PowerAllo < 0 ))>0)
    IndexN = find(PowerAllo <= 0 );
    IndexP = find(PowerAllo > 0);
    MP = length(IndexP);
    PowerAllo(IndexN) = 0;
    ChAT = ChA(IndexP);
    HT = ChAT.^2/(B*N0);
    PowerAlloT = (PtotA + sum(1./HT))/MP - 1./HT;
    PowerAllo(IndexP) = PowerAlloT;
end
PowerAllo = PowerAllo.';   
Capacity  = sum(log2(1+ PowerAllo.' .* H));

