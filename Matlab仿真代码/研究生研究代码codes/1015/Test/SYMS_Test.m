clear,clc,close all
% ʧ��
Fs = 500e6;% ����Ƶ��Ϊ500MHz
Ts = 1/Fs;%�������2ns
Tp = 10e-6;%LFM�źų���Ϊ10΢��
N = round(Tp/Ts);%��������
f0 = 0;%��ʼƵ��Ϊ0
B = 10e6;%�ź�Ƶ�ʴ���10MHz
k = B/Tp;%Ƶ������б��
syms t tao
phi = 2*pi*f0*t+pi*k*t^2;
%gT = heaviside(t+0.5)-heaviside(t-0.5);
gT = heaviside(t)-heaviside(t-Tp);
i = sqrt(-1);
ut = gT*exp(i*(phi));
gT_tao = heaviside(t-tao)-heaviside(t-tao-Tp);
%phi2 = 2*pi*f0*(t-tao)+pi*k*(t-tao)^2;
phi2 = 2*pi*f0*(t+tao)+pi*k*(t+tao)^2;
ut_tao= gT_tao*exp(i*(-phi2));
ff = ut*ut_tao;
Rtao = int(ff,t,tao,Tp);
Rtao
plot(subs(Rtao,tao,-Tp:Ts:Tp))


