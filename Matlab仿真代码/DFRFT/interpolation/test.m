clear;clc;close all
% sinc��ֵ�����Բ�ֵ�ıȽ�
%The function is the sequence x[n] = n a^n u[n].
a = 0.9;
N = 64;
n = 0:N-1;
x = n.*a.^n;
figure(1)
plot(n,x)
% ����Ҷ�任(Ƶ�׷���)
y = fft(x);
k= 0:N/2;
figure(2)
plot(k/N,abs(y(1:N/2+1)));
%���Ҳ�ֵ
s = linspace(0,N-1,512);%��ֵ���Ϊ512�㣬��ֵ֮ǰ64��
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