%����ϵͳ�����
close all;clear;clc
format long 
format compact
% �����ź�
signalsGenerator
%��PAPR�����㷨����
[y_no_Reduction_para,paprs_No_Reduction] = NoPAPRReduction(y_para);
y_no_papr_reduction_serial = reshape(y_no_Reduction_para,1,LN*ofdmCodeNums);%���ɷ���Ĵ�������
percent_paprs_CCDF_No_Reduction = paprCCDFCalu(papr_base,paprs_No_Reduction);%����paprs��CCDF����
%����SLM�㷨����
[y_slm_para,paprs_SLM] = SLMProcess( y_para );
y_slm_serial = reshape(y_slm_para,1,(LN+1)*ofdmCodeNums);%���ɷ���Ĵ�������
percent_paprs_CCDF_SLM_Reduction = paprCCDFCalu(papr_base,paprs_SLM);%����paprs��CCDF����
%�����Ż��㷨����
% y_para
[y_slm_para_opti,paprs_SLM_opti] = OptimizeSLMProcess( y_para);
y_slm_serial_opti = reshape(y_slm_para_opti,1,( LN+1 )*ofdmCodeNums);%���ɷ���Ĵ�������
percent_paprs_CCDF_SLM_Reduction_opti = paprCCDFCalu(papr_base,paprs_SLM_opti);%����paprs��CCDF����
%------------------��PAPR��CCDFͼ��----------
semilogy(papr_base,percent_paprs_CCDF_No_Reduction,'-k*');hold on;
semilogy(papr_base,percent_paprs_CCDF_SLM_Reduction,'-.b^');
semilogy(papr_base,percent_paprs_CCDF_SLM_Reduction_opti,'-.r^');
legend(' No\_Reduction',' SLM\_Reduction',' OptiSLM\_Reduction','Location','west')
grid on;xlabel('PAPR\_base/dB');ylabel('CCDF');title('OFDM-LFM-RCIϵͳ��PAPR\_CCDF����');hold off;
%**********************************************************************************************************
%%--------------------�ŵ���������--------------
global EbNos 
%----------------�Է��͵Ĵ��������ڲ�ͬ��������£�������������������������-------------------
BERs_no_reduction =  DemodulationNoPaprReduction(y_no_papr_reduction_serial);
BERs_slm = DemodulationSLM(y_slm_serial);
BERs_slm_opti = DemodulationOptiSLM(y_slm_serial_opti);
%----------------------��������ͼ��-------------
disp('������ʣ�')
BERs_no_reduction
BERs_slm
BERs_slm_opti
figure,semilogy(EbNos,BERs_no_reduction,'-k*'),hold on;grid on ;
semilogy(EbNos,BERs_slm,'-.b^');
semilogy(EbNos,BERs_slm_opti,'-.r^');
legend(' No\_Reduction',' SLM with side Information',' OptiSLM with side Information','Location','west')
xlabel('SNR/dB');ylabel('BER');title('OFDM-LFM-RCIϵͳ��BER-SNRͼ��');
