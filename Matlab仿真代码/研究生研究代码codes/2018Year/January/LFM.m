% LFM�ź�
clear ,clc ,close all
fc = 0e8;       %�ز�Ƶ��2GHz
B = 100e6;        %�źŴ���500MHz
Tp = 10e-6;     %�ź�ʱ����Ϊ10΢��
mu = B/Tp;      %��Ƶб��
fs = 500e6;     %����Ƶ��
t = 0:1/fs:Tp;
A = 1;          %����
phi0 = 0;       %��ʼ��λ
LFM_Signal = A*exp(1i*2*pi*(fc*t+mu*t.^2/2)+1i*phi0);
figure(1)
plot(t(1:2000)*1e6,real(LFM_Signal(1:2000)))
xlabel('time��\mus��'),ylabel('Amplitude')



