clear;clc;close all
% sinc插值与线性插值的比较
%The function is the sequence x[n] = n a^n u[n].
a = 0.9;
N = 64;
n = 0:N-1;
x = n.*a.^n;
figure(1)
plot(n,x)
% 傅里叶变换(频谱分析)
y = fft(x);
k= 0:N/2;
figure(2)
plot(k/N,abs(y(1:N/2+1)));
%正弦插值
s = linspace(0,N-1,512);%插值后变为512点，插值之前64点
x2 = sinc_interp(x,s);
figure(3)
plot(s(1:256),x2(1:256));
hold on
xi = interp1(n,x,s);
plot(s(1:256),xi(1:256),'k');
plot(n(1:N/2),x(1:N/2),'o');
hold off
figure(4)
plot(s,xi-x2);
ylabel('difference');
xlabel('duration');