% PSD功率谱密度分析
%% 
clear,clc,close all
LFM_Basic_Func(pi/4);  %执行LFM_Basic 函数，调制角度为15度
load('LFM_Basic_Func.mat'),load('Comm_signal_Func.mat')
R_LFM_Corr = xcorr(LFM_Signal);
R_LFM_Comm_Corr = xcorr(LFM_Comm);
N = 5001;
PSD_LFM_Signal = fftshift(fft(R_LFM_Corr))/N;
PSD_LFM_Comm = fftshift(fft(R_LFM_Comm_Corr))/N;
figure(1)
plot((-N+1:1:N-1)/N*Fs/2*1e-6,abs(PSD_LFM_Signal)/sum(abs(PSD_LFM_Signal)),'r')
hold on 
plot((-N+1:1:N-1)/N*Fs/2*1e-6,abs(PSD_LFM_Comm)/sum(abs(PSD_LFM_Comm)))
legend('LFM-Signal','LFM-Comm')
xlabel('频率(MHz)'),ylabel('Power/Freq(dB/Hz)'),title('LFM-Signal和LFM-Comm（Deg=15）'),grid on
axis([-50,50,0,0.02])
figure(2)
plot((-N+1:1:N-1)/N*Fs/2*1e-6,20*log10(abs(PSD_LFM_Signal)/sum(abs(PSD_LFM_Signal))),'r')
hold on
plot((-N+1:1:N-1)/N*Fs/2*1e-6,20*log10(abs(PSD_LFM_Comm)/sum(abs(PSD_LFM_Comm))))
legend('LFM-Signal','LFM-Comm')
xlabel('频率(MHz)'),ylabel('Power/Freq(dB/Hz)'),title('LFM-Signal和LFM-Comm（Deg=15）'),grid on
axis([-50,50,-150,0]),grid on

