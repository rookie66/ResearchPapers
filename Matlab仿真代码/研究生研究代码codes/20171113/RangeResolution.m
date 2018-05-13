%Range Resolution
%距离分辨率
clear;close all;clc
load('LFM_OFDM')
LFM_OFDM_Comm_Base = [LFM_OFDM_Comm,zeros(1,15000)];
LFM_OFDM_Comm_echo1 = [zeros(1,500),LFM_OFDM_Comm,zeros(1,14500)];
LFM_OFDM_Comm_echo2 = [zeros(1,510),LFM_OFDM_Comm,zeros(1,14490)];
LFM_OFDM_Comm_echo6 = [zeros(1,520),LFM_OFDM_Comm,zeros(1,14480)];
LFM_OFDM_Comm_echo3 = [zeros(1,600),LFM_OFDM_Comm,zeros(1,14400)];
LFM_OFDM_Comm_echo4 = [zeros(1,4000),LFM_OFDM_Comm,zeros(1,11000)];
LFM_OFDM_Comm_echo5 = [zeros(1,4900),LFM_OFDM_Comm,zeros(1,10100)];
LFM_OFDM_Comm_echo7 = [zeros(1,2500),LFM_OFDM_Comm,zeros(1,12500)];

LFM_OFDM_Comm_Sum = LFM_OFDM_Comm_echo1+LFM_OFDM_Comm_echo2+LFM_OFDM_Comm_echo3+LFM_OFDM_Comm_echo4+...
    LFM_OFDM_Comm_echo5+LFM_OFDM_Comm_echo6+LFM_OFDM_Comm_echo7;
[Corr,x] = xcorr(LFM_OFDM_Comm_Sum,LFM_OFDM_Comm_Base);
figure(1)
plot(x*0.6,abs(Corr)/max(abs(Corr)))
xlabel('距离（m）'),ylabel('归一化幅值'),title('雷达匹配滤波输出结果')
axis([0,3000,0,1])

LFM_OFDM_Comm_Resolution = LFM_OFDM_Comm_echo1+LFM_OFDM_Comm_echo2...
    +LFM_OFDM_Comm_echo6+LFM_OFDM_Comm_echo7;
[Corr_Resolution,x2] = xcorr(LFM_OFDM_Comm_Resolution,LFM_OFDM_Comm_Base);
figure(2)
plot(x2*0.6,abs(Corr_Resolution)/max(abs(Corr_Resolution)))
xlabel('距离（m）'),ylabel('归一化幅值'),title('雷达匹配滤波输出结果(距离分辨率）')
axis([260,360,0,1.2])