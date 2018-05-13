clear,clc,close all
% 失败
Fs = 500e6;% 采样频率为500MHz
Ts = 1/Fs;%采样间隔2ns
Tp = 10e-6;%LFM信号长度为10微秒
N = round(Tp/Ts);%采样点数
f0 = 0;%起始频率为0
B = 10e6;%信号频率带宽10MHz
k = B/Tp;%频率上升斜率
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


