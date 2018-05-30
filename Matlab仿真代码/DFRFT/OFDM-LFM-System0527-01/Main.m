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
%进行优化SLM算法处理
[y_slm_para_opti,paprs_SLM_opti] = OptimizeSLMProcess( y_para);
y_slm_serial_opti = reshape(y_slm_para_opti,1,( LN+1 )*ofdmCodeNums);%生成发射的串行数据
percent_paprs_CCDF_SLM_Reduction_opti = paprCCDFCalu(papr_base,paprs_SLM_opti);%计算paprs的CCDF函数
%进行优化SLM算法处理
[y_slm_clipping_para,paprs_SLM_Clipping] = SLMClippingProcess( y_para);
y_slm_clipping_serial_opti = reshape(y_slm_clipping_para,1,( LN+1 )*ofdmCodeNums);%生成发射的串行数据
percent_paprs_CCDF_SLM_Clipping_Reduction = paprCCDFCalu(papr_base,paprs_SLM_Clipping);%计算paprs的CCDF函数

%------------------作PAPR的CCDF图像----------
semilogy(papr_base,percent_paprs_CCDF_No_Reduction,'-k*');hold on;
semilogy(papr_base,percent_paprs_CCDF_SLM_Reduction,'-.bo');
semilogy(papr_base,percent_paprs_CCDF_SLM_Reduction_opti,'--r^');
% semilogy(papr_base,percent_paprs_CCDF_SLM_Clipping_Reduction,'--gd');
percent_paprs_CCDF_No_Reduction
percent_paprs_CCDF_SLM_Reduction
percent_paprs_CCDF_SLM_Reduction_opti
% percent_paprs_CCDF_SLM_Clipping_Reduction
% legend(' Original',' SLM',' PJ-SLM',' PJ-SLM-C','Location','west')
legend(' Original',' SLM',' PJ-SLM','Location','west')
grid on;xlabel('PAPR\_th/dB');ylabel('PAPR-CCDF');title('OFDM-LFM-RCI系统的PAPR-CCDF曲线');hold off;
%**********************************************************************************************************
%%--------------------信道传输与解调--------------
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
% semilogy(EbNos,BERs_slm_clipping,'--gd');
% legend(' Original',' SLM',' PJ-SLM',' PJ-SLM-C','Location','west')
legend(' Original',' SLM',' PJ-SLM','Location','west')
xlabel('SNR');ylabel('BER');title('OFDM-LFM-RCI系统的BER-SNR图像');
