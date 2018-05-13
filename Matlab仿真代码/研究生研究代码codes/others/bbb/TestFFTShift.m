%%
clear;clc;
t=0:0.001:2;
n=2001;
Fs=1000;
Fc=200;
x=cos(2*pi*Fc*t);
y1=fft(x);
y2=fftshift(y1);
f=(0:2000)*Fs/n-Fs/2;
hold on;
plot(f,abs(y1),'r') 
figure(2)
plot(f,abs(y2),'b')
%%
clear all;clc;close
t=0:0.001:2;N=2001;
fc=300;%�ز�Ƶ��
fc2=400;
Fs=1000;%����Ƶ��
f1=(0:2000)*Fs/N;%Ƶ�ʺ�����
f2=(0:2000)*Fs/N-Fs/2;%Ƶ�ʺ������
y =cos(2*pi*fc*t)+sin(2*pi*fc2*t)+randn(1,N);
F=fft(y);%FFT
F2=fftshift(F);%ע�⣺fftshift��������fft�����Ļ����Ͻ��е�
subplot(311);plot(f1,abs(F))
subplot(312);plot(f2,abs(F))
subplot(313);plot(f2,abs(F2))



