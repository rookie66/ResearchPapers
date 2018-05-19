function [LFMSig] = LFM_FN(T, B, FsTimesB)
%T��������ʱ��
%B��������
%FsTimesB��������Ƶ�����ӣ�������ı��������磺�������Ƶ���Ǵ����2������FsTimesB = 2��
%T = 10e-6;B = 30e6;FsTimesB = 4;
close all;
clc;
K = B/T; %��Ƶб��
Fs = FsTimesB*B;Ts=1/Fs; %����Ƶ��(һ��ȡ�����������)�Ͳ������

Nchirp = ceil(T/Ts); %���������� 
Nfft = 2^nextpow2(2*Nchirp); %���ڼ���FFT�ĳ��� 
t=linspace(-T/2,T/2,Nchirp); %�źŲ���ʱ��� 
LFMSig = exp(1i*pi*K*t.^2); %����Ƶ�ʵ����źŹ�ʽ ��1i����һ��i��

figure
set(gca,'FontSize',20);
subplot(2,1,1)
plot(real(LFMSig));
xlabel('����')
ylabel('����')
xlim([0 Nchirp]);
title('LFM�ź�ʵ��')
subplot(2,1,2)
plot(imag(LFMSig));
xlabel('����')
ylabel('����')
xlim([0 Nchirp]);
title('LFM�ź��鲿')

LFM_FFT =fftshift(abs(fft(LFMSig,Nfft)));
LFM_FFT_db = 20*log10(LFM_FFT/max(LFM_FFT));
figure
set(gca,'FontSize',20);
ff = 0:Fs/(Nfft-1):Fs;
ff = ff - Fs/2;
plot(ff,LFM_FFT_db);
title('LFMƵ��')
xlim([min(-Fs/FsTimesB) max(Fs/FsTimesB)])
xlabel('Ƶ��(Hz)')
ylabel('����(dB)')