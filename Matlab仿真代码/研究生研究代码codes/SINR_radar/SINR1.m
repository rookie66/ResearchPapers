%获取SINR
clear ; close ;clc  % 清空
SetValuesOfParams% 设定参数数值
step_PR=10;
SINR=zeros(1,6)
theta_k=60;
P_R_Max=900;
for P_R=0:step_PR:P_R_Max
   SINR_1=getSINR_k(1,theta_k,P_R);
   SINR_2=getSINR_k(2,theta_k,P_R);
   SINR_3=getSINR_k(3,theta_k,P_R);
   SINR(P_R/step_PR+1)=(SINR_1+SINR_2+SINR_3)/K;
   disp('SINR值：'),disp(SINR);
end

SINR_dB=10*log10(SINR);
P_R=0:step_PR:P_R_Max;
close ; figure
plot(P_R,abs(SINR_dB));
hold on;
%plot(P_R,abs(SINR_dB),'rs');
plot(P_R,abs(SINR_dB));
xlabel('Radar TX Power Budget P_R');ylabel('SINR in dB');

