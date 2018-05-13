% LFM信号
clear ,clc ,close all
fc = 0e8;       %载波频率2GHz
B = 100e6;        %信号带宽500MHz
Tp = 10e-6;     %信号时间宽度为10微秒
mu = B/Tp;      %调频斜率
fs = 500e6;     %采样频率
t = 0:1/fs:Tp;
A = 1;          %幅度
phi0 = 0;       %初始相位
LFM_Signal = A*exp(1i*2*pi*(fc*t+mu*t.^2/2)+1i*phi0);
figure(1)
plot(t(1:2000)*1e6,real(LFM_Signal(1:2000)))
xlabel('time（\mus）'),ylabel('Amplitude')



