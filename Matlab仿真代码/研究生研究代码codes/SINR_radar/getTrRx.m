%  ��ȡTr(R_xl)��1-L_total���ܺͣ�
%  �뷢�书��P_C�Ƚϴ�С
function [TrRx]=getTrRx()
TrRx=0;
global L_total
for l=1:L_total
    R_xl=getR_xl(l);
    TrRx=TrRx+trace(R_xl);
end
end