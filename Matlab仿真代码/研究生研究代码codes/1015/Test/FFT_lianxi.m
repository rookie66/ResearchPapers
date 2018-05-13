clear ,clc,close all
Fs = 5000;
Ts = 1/Fs;
Tp = 1;
t = 0:Ts:Tp;
f = cos(2*pi*1000*t);
figure(1)
plot(t,f)
figure(2)
N = Tp/Ts;
df = Fs/(N-1);
F = fft(f(1:N))/N*2;
%F = fftshift(F);
f = 0:df:(N-1)*df;
plot(f(1:N/2),abs(F(1:N/2)))