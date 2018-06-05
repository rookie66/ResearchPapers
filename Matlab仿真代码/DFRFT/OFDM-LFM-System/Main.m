%整个系统的入口
close all;clear;clc
format long 
format compact
% 生成信号
signalsGenerator
%无PAPR抑制算法处理
[y_no_Reduction_para,paprs_No_Reduction] = NoPAPRReduction(y_para);
y_no_papr_reduction_serial = reshape(y_no_Reduction_para,1,LN*ofdmCodeNums);%生成发射的串行数据
percent_paprs_CCDF_No_Reduction = paprCCDFCalu(papr_base,paprs_No_Reduction);%计算paprs的CCDF函数
%进行SLM算法处理
[y_slm_para,paprs_SLM] = SLMProcess( y_para );
y_slm_serial = reshape(y_slm_para,1,(LN+1)*ofdmCodeNums);%生成发射的串行数据
percent_paprs_CCDF_SLM_Reduction = paprCCDFCalu(papr_base,paprs_SLM);%计算paprs的CCDF函数
%进行PJ-SLM算法处理
[y_slm_para_opti,paprs_SLM_opti] = OptimizeSLMProcess( y_para);
y_slm_serial_opti = reshape(y_slm_para_opti,1,( LN+1 )*ofdmCodeNums);%生成发射的串行数据
percent_paprs_CCDF_SLM_Reduction_opti = paprCCDFCalu(papr_base,paprs_SLM_opti);%计算paprs的CCDF函数
%进行PJ-SLM-C算法处理
[y_slm_clipping_para,paprs_SLM_Clipping] = SLMClippingProcess( y_para);
y_slm_clipping_serial_opti = reshape(y_slm_clipping_para,1,( LN+1 )*ofdmCodeNums);%生成发射的串行数据
percent_paprs_CCDF_SLM_Clipping_Reduction = paprCCDFCalu(papr_base,paprs_SLM_Clipping);%计算paprs的CCDF函数
%进行PJ-SLM-P算法处理
% [y_slm_part_para,paprs_SLM_Part] = SLMPartProcess( y_para);
% y_slm_part_serial_opti = reshape(y_slm_part_para,1,( LN+1 )*ofdmCodeNums);%生成发射的串行数据
% percent_paprs_CCDF_SLM_Part_Reduction = paprCCDFCalu(papr_base,paprs_SLM_Part);%计算paprs的CCDF函数
%------------------作PAPR的CCDF图像----------
semilogy(papr_base,percent_paprs_CCDF_No_Reduction,'-k*');hold on;
semilogy(papr_base,percent_paprs_CCDF_SLM_Reduction,'-.bo');
semilogy(papr_base,percent_paprs_CCDF_SLM_Reduction_opti,'--r^');
semilogy(papr_base,percent_paprs_CCDF_SLM_Clipping_Reduction,'--gd');
% semilogy(papr_base,percent_paprs_CCDF_SLM_Part_Reduction,'--g*');

% percent_paprs_CCDF_No_Reduction
% percent_paprs_CCDF_SLM_Reduction
% percent_paprs_CCDF_SLM_Reduction_opti
% percent_paprs_CCDF_SLM_Clipping_Reduction
% legend(' Original',' SLM',' PJ-SLM',' PJ-SLM-C','PJ_SLM_P','Location','west')
legend(' Original',' SLM',' PJ-SLM',' PJ-SLM-C','Location','west')
% legend(' Original',' SLM',' PJ-SLM','Location','west')
hold off;
grid on;xlabel('PAPR\_th/dB');ylabel('PAPR-CCDF');
% title('OFDM-LFM-RCI系统的PAPR-CCDF曲线');
title('PAPR-CCDF');
%**********************************************************************************************************
%% --------------------信道传输与解调--------------
global EbNos 
%----------------对发送的串行数据在不同的信噪比下，添加噪声、解调并计算误码率-------------------
BERs_no_reduction =  DemodulationNoPaprReduction(y_no_papr_reduction_serial);
BERs_slm = DemodulationSLM(y_slm_serial);
BERs_slm_opti = DemodulationOptiSLM(y_slm_serial_opti);
BERs_slm_clipping =  DemodulationSLMClipping(y_slm_clipping_serial_opti);
%----------------------做误码率图像-------------
disp('误比特率：')
BERs_no_reduction
BERs_slm
BERs_slm_opti
BERs_slm_clipping
figure,semilogy(EbNos,BERs_no_reduction,'-k*'),hold on;grid on ;
semilogy(EbNos,BERs_slm,'-.bo');
semilogy(EbNos,BERs_slm_opti,'-.r^');
semilogy(EbNos,BERs_slm_clipping,'--gd');
legend(' Original',' SLM',' PJ-SLM',' PJ-SLM-C','Location','west')
% legend(' Original',' SLM',' PJ-SLM','Location','west')
xlabel('SNR/dB');ylabel('BER');
title('OFDM-LFM-RCI系统的BER-SNR图像');
title('');
%%雷达性能分析
% 对象：加过噪声的信号。
% 求自相关:就是分析距离分辨率的特征。
% 接收信号为y_receive
% y_recieve = y_slm_serial;


[Corr_Resolution_No_Reduction,x0] = xcorr(y_no_papr_reduction_serial,y_no_papr_reduction_serial);
Corr_Resolution_No_Reduction = abs(Corr_Resolution_No_Reduction)/max(abs(Corr_Resolution_No_Reduction));
[Corr_Resolution_SLM_Reduction,x1] = xcorr(y_slm_serial,y_slm_serial);
Corr_Resolution_SLM_Reduction = abs(Corr_Resolution_SLM_Reduction)/max(abs(Corr_Resolution_SLM_Reduction));
[Corr_Resolution_SLM_Opti_Reduction,x2] = xcorr(y_slm_serial_opti,y_slm_serial_opti);
Corr_Resolution_SLM_Opti_Reduction = abs(Corr_Resolution_SLM_Opti_Reduction)/max(abs(Corr_Resolution_SLM_Opti_Reduction));
[Corr_Resolution_Clipping_Opti_Reduction,x3] = xcorr(y_slm_clipping_serial_opti,y_slm_clipping_serial_opti);
Corr_Resolution_Clipping_Opti_Reduction = abs(Corr_Resolution_Clipping_Opti_Reduction)/max(abs(Corr_Resolution_Clipping_Opti_Reduction));

% [Corr_Resolution_Clipping_Reduction,x3] = xcorr(y_slm_clipping_serial_opti,y_slm_clipping_serial_opti);
% Corr_Resolution_Clipping_Reduction = abs(Corr_Resolution_Clipping_Reduction)/max(abs(Corr_Resolution_Clipping_Reduction));
%作图：自相关性
figure,plot(x0,Corr_Resolution_No_Reduction,'-k'),hold on;grid on ;
plot(x1,Corr_Resolution_SLM_Reduction,'-.b');
plot(x2,Corr_Resolution_SLM_Opti_Reduction,'--r');
plot(x3,Corr_Resolution_Clipping_Opti_Reduction,'-g');
legend(' Original',' SLM',' PJ-SLM','PJ-SLM-C','Location','northeast')
space = 50;axis([-space,space,0,1.1])
ylabel('归一化幅值'),title('共享信号的自相关性')
ylabel('Amplitude'),title('the performance of auto-correlation')
%% 距离分辨率实例
interval = 10;
y_recieve0 = [zeros(1,80000),y_recieve,zeros(1,80000)]; 
y_recieve1 = [zeros(1,80000+interval*2),y_recieve,zeros(1,80000-interval*2)]; %目标123相隔3m
y_recieve2 = [zeros(1,80000+interval*3),y_recieve,zeros(1,80000-interval*3)];
y_recieve3 = [zeros(1,80000+interval*4),y_recieve,zeros(1,80000-interval*4)];
y_recieve4 = [zeros(1,80000+interval*5),y_recieve,zeros(1,80000-interval*5)];
y_recieve5 = [zeros(1,80000+interval*2.5),y_recieve,zeros(1,80000-interval*2.5)];
y_recieve6 = [zeros(1,80000+interval*2.7),y_recieve,zeros(1,80000-interval*2.7)];
y_recieve_sum = y_recieve1 + y_recieve2 + y_recieve3 + y_recieve4 + y_recieve5 + y_recieve6;
[Corr_Resolution_No_Reduction2,x22] = xcorr(y_recieve_sum,y_recieve0);
figure(2)
xx2 = double(x22*0.3);
Corr_Resolution_abs = abs(Corr_Resolution_No_Reduction2)/max(abs(Corr_Resolution_No_Reduction2));
plot(xx2,Corr_Resolution_abs)
xlabel('目标距离（m）'),ylabel('归一化幅值'),title('LFM-Comm雷达匹配滤波输出')
space = 20;
axis([0,space,0,1.1])
% axis([-20,20,0,1.1])



