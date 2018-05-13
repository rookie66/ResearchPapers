% C_avg Test
clear ; close ;clc  % 清空
SetValuesOfParams% 设定参数数值
P_R = 300;
% 第一个限制条件：获取信道容量计算信道容量
C_avg= getC_avg(P_R);
C_avg_abs=abs(C_avg);
disp(C_avg)
disp('C_avg_abs:');disp(C_avg_abs);
C=24;
disp('C:');disp(C),disp('bits/symbol')
% 第二个限制条件：
TrRx=getTrRx();
disp('TrRx:');disp(TrRx);
P_C = L_total*M_tC;
disp('P_C:');disp(P_C)
% 第三个限制条件：
L_Tr_Phi=getL_Tr_Phi(P_R);
L_Tr_Phi=ceil(L_Tr_Phi);
disp('L_Tr_Phi:');disp(L_Tr_Phi);
disp('P_R:');disp(P_R)

