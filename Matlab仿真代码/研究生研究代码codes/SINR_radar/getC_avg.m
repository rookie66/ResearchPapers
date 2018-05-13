% 在雷达发射功率P_R下，通信系统的信道容量
function [C_avg]=getC_avg(P_R)
C_total=0;
global H L_total
for l = 1:L_total
    R_xl = getR_xl(l);
      dd = det(eye(4)+log2(inv(getR_Cinl(P_R,l))*H*R_xl*H'));
    C_total=C_total+dd;
end
display(C_total)
C_avg=C_total/L_total;
end

