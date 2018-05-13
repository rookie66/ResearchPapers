%连续信号的采样
clear all;
clc;
t=-6:0.001:6;
x=(sinc(t)).^2;
figure,plot(t,x);grid on;
fs=2;
ts=1/fs;
n=-12:12;
xn=(sinc(n*ts)).^2;
figure,stem(n,xn);
Xn=fft(xn,64);
k=0:63;
f=fs*k/64;
figure,plot(f,fftshift(abs(Xn)));
axis([0 fs 0 fs])


