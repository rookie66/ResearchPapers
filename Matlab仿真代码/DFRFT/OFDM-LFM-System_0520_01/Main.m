
%close all;clear;clc
clear ;
format long 
%global papr_no_name papr_slm_name ber_no_name ber_slm_name matFiledir p
global index_p  PAPRs_no PAPRs_slm BERs_no_s BERs_slm_s papr_base
% 生成信号
signalsGenerator
%无PAPR抑制算法处理
[y_no_Reduction_para,paprs_No_Reduction] = NoPAPRReduction(y_para);
y_no_papr_reduction_serial = reshape(y_no_Reduction_para,1,N*ofdmCodeNums);%生成发射的串行数据
percent_paprs_CCDF_No_Reduction = paprCCDFCalu(papr_base,paprs_No_Reduction);%计算paprs的CCDF函数
%进行SLM算法处理
[y_slm_para,paprs_SLM] = SLMProcess( y_para);
y_slm_serial = reshape(y_slm_para,1,(N+1)*ofdmCodeNums);%生成发射的串行数据
percent_paprs_CCDF_SLM_Reduction = paprCCDFCalu(papr_base,paprs_SLM);%计算paprs的CCDF函数
%------------------作PAPR的CCDF图像----------
PAPRs_no(index_p,:) = percent_paprs_CCDF_No_Reduction;
PAPRs_slm(index_p,:) = percent_paprs_CCDF_SLM_Reduction;
%save(strcat(matFiledir,papr_no_name,num2str(p*10),'.mat'),'percent_paprs_CCDF_No_Reduction');
%save(strcat(matFiledir,papr_slm_name,num2str(p*10),'.mat'),'percent_paprs_CCDF_SLM_Reduction');
%semilogy(papr_base,percent_paprs_CCDF_No_Reduction,'-b*');hold on;
%semilogy(papr_base,percent_paprs_CCDF_SLM_Reduction,'-.r^');legend(' No\_Reduction',' SLM\_Reduction')
%grid on;xlabel('PAPR\_base/dB');ylabel('CCDF');title('OFDM\_LFM\_PAPR\_CCDF曲线');hold off;
%**********************************************************************************************************
%--------------------信道传输与解调--------------
global EbNos 
%----------------对发送的串行数据在不同的信噪比下，添加噪声、解调并计算误码率-------------------
BERs_no_reduction =  DemodulationNoPaprReduction(y_no_papr_reduction_serial);
BERs_slm = DemodulationSLM(y_slm_serial);
%----------------------做误码率图像-------------
disp('误比特率：')
BERs_no_reduction
BERs_slm
BERs_no_s(index_p,:) = BERs_no_reduction;
BERs_slm_s(index_p,:) = BERs_slm;
%save(strcat(matFiledir,ber_no_name,num2str(p*10),'.mat'),'BERs_no_reduction');
%save(strcat(matFiledir,ber_slm_name,num2str(p*10),'.mat'),'BERs_slm');
%figure,semilogy(EbNos,BERs_no_reduction,'-b*'),hold on;
%grid on ;semilogy(EbNos,BERs_slm,'-.r^');legend(' No\_Reduction',' SLM with side Information')
%xlabel('SNR/dB');ylabel('BER');title('OFDM-LFM系统的BER-SNR图像');
