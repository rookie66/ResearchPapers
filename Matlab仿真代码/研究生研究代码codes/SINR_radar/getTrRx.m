%  获取Tr(R_xl)的1-L_total的总和，
%  与发射功率P_C比较大小
function [TrRx]=getTrRx()
TrRx=0;
global L_total
for l=1:L_total
    R_xl=getR_xl(l);
    TrRx=TrRx+trace(R_xl);
end
end