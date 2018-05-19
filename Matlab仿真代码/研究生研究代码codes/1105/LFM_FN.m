function [LFMSig] = LFM_FN(T, B, FsTimesB)
%T——脉冲时宽
%B——带宽
%FsTimesB——采样频率因子，即带宽的倍数，例如：如果采样频率是带宽的2倍，则FsTimesB = 2。
%T = 10e-6;B = 30e6;FsTimesB = 4;
close all;
clc;
K = B/T; %调频斜率
Fs = FsTimesB*B;Ts=1/Fs; %采样频率(一般取带宽的整数倍)和采样间隔

Nchirp = ceil(T/Ts); %脉冲样点数 
Nfft = 2^nextpow2(2*Nchirp); %用于计算FFT的长度 
t=linspace(-T/2,T/2,Nchirp); %信号采样时间点 
LFMSig = exp(1i*pi*K*t.^2); %线性频率调制信号公式 （1i就是一个i）

figure
set(gca,'FontSize',20);
subplot(2,1,1)
plot(real(LFMSig));
xlabel('样点')
ylabel('幅度')
xlim([0 Nchirp]);
title('LFM信号实部')
subplot(2,1,2)
plot(imag(LFMSig));
xlabel('样点')
ylabel('幅度')
xlim([0 Nchirp]);
title('LFM信号虚部')

LFM_FFT =fftshift(abs(fft(LFMSig,Nfft)));
LFM_FFT_db = 20*log10(LFM_FFT/max(LFM_FFT));
figure
set(gca,'FontSize',20);
ff = 0:Fs/(Nfft-1):Fs;
ff = ff - Fs/2;
plot(ff,LFM_FFT_db);
title('LFM频谱')
xlim([min(-Fs/FsTimesB) max(Fs/FsTimesB)])
xlabel('频率(Hz)')
ylabel('幅度(dB)')