%% ���ﶨ��һ��vr����
%theta�Ƕȶ��ǲ���360����
function [Vr_theta,Vt_theta]=getVrandVt(theta_k)
%�ز�Ƶ�ʼ�����
f_C=60*10^9;lambda_C=3*10^8/f_C;
%Radar RX antenna�����������,4X2,ÿһ��Ϊһ���������ߵ�����
D_RX=[10 10;20 20;30 30;40 40];
d1_r=conj(D_RX(1,:))';  
d2_r=conj(D_RX(2,:))'; 
d3_r=conj(D_RX(3,:))'; 
d4_r=conj(D_RX(4,:))'; 
exp_1=2*pi*dot(d1_r,u(theta_k))/lambda_C;
exp_2=2*pi*dot(d2_r,u(theta_k))/lambda_C;
exp_3=2*pi*dot(d3_r,u(theta_k))/lambda_C;
exp_4=2*pi*dot(d4_r,u(theta_k))/lambda_C;
Vr_theta=[exp(j*exp_1);exp(j*exp_2);exp(j*exp_3);exp(j*exp_4)];
Vt_theta=[exp(j*exp_1);exp(j*exp_2);exp(j*exp_3);exp(j*exp_4)];
end
