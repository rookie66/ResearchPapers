
%close all;clear;clc
clear ;
format long 
%global papr_no_name papr_slm_name ber_no_name ber_slm_name matFiledir p
global index_p  PAPRs_no PAPRs_slm BERs_no_s BERs_slm_s papr_base
% �����ź�
signalsGenerator
%��PAPR�����㷨����
[y_no_Reduction_para,paprs_No_Reduction] = NoPAPRReduction(y_para);
y_no_papr_reduction_serial = reshape(y_no_Reduction_para,1,N*ofdmCodeNums);%���ɷ���Ĵ�������
percent_paprs_CCDF_No_Reduction = paprCCDFCalu(papr_base,paprs_No_Reduction);%����paprs��CCDF����
%����SLM�㷨����
[y_slm_para,paprs_SLM] = SLMProcess( y_para);
y_slm_serial = reshape(y_slm_para,1,(N+1)*ofdmCodeNums);%���ɷ���Ĵ�������
percent_paprs_CCDF_SLM_Reduction = paprCCDFCalu(papr_base,paprs_SLM);%����paprs��CCDF����
%------------------��PAPR��CCDFͼ��----------
PAPRs_no(index_p,:) = percent_paprs_CCDF_No_Reduction;
PAPRs_slm(index_p,:) = percent_paprs_CCDF_SLM_Reduction;
%save(strcat(matFiledir,papr_no_name,num2str(p*10),'.mat'),'percent_paprs_CCDF_No_Reduction');
%save(strcat(matFiledir,papr_slm_name,num2str(p*10),'.mat'),'percent_paprs_CCDF_SLM_Reduction');
%semilogy(papr_base,percent_paprs_CCDF_No_Reduction,'-b*');hold on;
%semilogy(papr_base,percent_paprs_CCDF_SLM_Reduction,'-.r^');legend(' No\_Reduction',' SLM\_Reduction')
%grid on;xlabel('PAPR\_base/dB');ylabel('CCDF');title('OFDM\_LFM\_PAPR\_CCDF����');hold off;
%**********************************************************************************************************
%--------------------�ŵ���������--------------
global EbNos 
%----------------�Է��͵Ĵ��������ڲ�ͬ��������£�������������������������-------------------
BERs_no_reduction =  DemodulationNoPaprReduction(y_no_papr_reduction_serial);
BERs_slm = DemodulationSLM(y_slm_serial);
%----------------------��������ͼ��-------------
disp('������ʣ�')
BERs_no_reduction
BERs_slm
BERs_no_s(index_p,:) = BERs_no_reduction;
BERs_slm_s(index_p,:) = BERs_slm;
%save(strcat(matFiledir,ber_no_name,num2str(p*10),'.mat'),'BERs_no_reduction');
%save(strcat(matFiledir,ber_slm_name,num2str(p*10),'.mat'),'BERs_slm');
%figure,semilogy(EbNos,BERs_no_reduction,'-b*'),hold on;
%grid on ;semilogy(EbNos,BERs_slm,'-.r^');legend(' No\_Reduction',' SLM with side Information')
%xlabel('SNR/dB');ylabel('BER');title('OFDM-LFMϵͳ��BER-SNRͼ��');
