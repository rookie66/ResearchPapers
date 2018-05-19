%OFDM-LFM信号
clear;clc;close all
f0 = 0;
Tp = 10e-6;
Bs = 30e6;
Fs = 1000e6;
mu = Bs/Tp;
DeltaF = 1*Bs;
N = 10;
%t = -Tp/2:1/Fs:Tp/2;
t = 0:1/Fs:Tp;
Nt = length(t);
j = sqrt(-1);
s0 = exp(j*2*pi*f0*t+j*pi*mu*t.^2/2);
f1 = f0+DeltaF;
s1 = exp(j*2*pi*f1*t+j*pi*mu*t.^2/2);
f2 = f0+2*DeltaF;
s2 = exp(j*2*pi*f2*t+j*pi*mu*t.^2/2);
f3 = f0+3*DeltaF;
s3 = exp(j*2*pi*f3*t+j*pi*mu*t.^2/2);
f4 = f0+4*DeltaF;
s4 = exp(j*2*pi*f4*t+j*pi*mu*t.^2/2);
f5 = f0+5*DeltaF;
s5 = exp(j*2*pi*f5*t+j*pi*mu*t.^2/2);
f6 = f0+6*DeltaF;
s6 = exp(j*2*pi*f6*t+j*pi*mu*t.^2/2);
f7 = f0+7*DeltaF;
s7 = exp(j*2*pi*f7*t+j*pi*mu*t.^2/2);
f8 = f0+8*DeltaF;
s8 = exp(j*2*pi*f8*t+j*pi*mu*t.^2/2);
f9 = f0+9*DeltaF;
s9 = exp(j*2*pi*f9*t+j*pi*mu*t.^2/2);
s_total = s0+s1+s2+s3+s4+s5+s6+s7+s8+s9;

figure(1)
subplot(511)
plot(t*1e6,real(s0))
subplot(512)
plot(t*1e6,real(s1))
subplot(513)
plot(t*1e6,real(s2))
subplot(514)
plot(t*1e6,real(s3))
subplot(515)
plot(t*1e6,real(s_total))
figure(2)
F0 = fftshift(fft(s0));

Ff = -Fs/2:Fs/(Nt-1):Fs/2;
plot(Ff*1e-6,abs(F0))
F1 = fftshift(fft(s1));
hold on
plot(Ff*1e-6,abs(F1))
F2 = fftshift(fft(s2));
hold on
plot(Ff*1e-6,abs(F2))
F3 = fftshift(fft(s3));
hold on
plot(Ff*1e-6,abs(F3))
F4 = fftshift(fft(s4));
hold on
plot(Ff*1e-6,abs(F4))
F5 = fftshift(fft(s5));
hold on
plot(Ff*1e-6,abs(F5))
F6 = fftshift(fft(s6));
hold on
plot(Ff*1e-6,abs(F6))
F7 = fftshift(fft(s7));
hold on
plot(Ff*1e-6,abs(F7))
F8 = fftshift(fft(s8));
hold on
plot(Ff*1e-6,abs(F8))
F9 = fftshift(fft(s9));
hold on
plot(Ff*1e-6,abs(F9))

axis([-100,500,0,1000])
xlabel('频率（MHz）'),ylabel('幅度')
title('各个子载波的频谱分析')
legend('f0','f1','f2','f3','f4','f5','f6','f7','f8','f9')
figure(3);
F_total = fftshift(fft(s_total));
plot(Ff*1e-6,abs(F_total))
axis([-100,500,0,1000])
xlabel('频率（MHz）'),ylabel('幅度')
title('10个载波合在一起的频谱分析')