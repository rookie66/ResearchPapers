function [ result ] = loopProcess(  )
%PROCESS Summary of this function goes here
%   Detailed explanation goes here
% �����ź�
signalsGenerator
global U1
%��PAPR�����㷨����
[y_no_Reduction_para,paprs_No_Reduction] = A_OriginalProcess(y_para);% U = 1;
percent_paprs_CCDF_No_Reduction = paprCCDFCalu(papr_base,paprs_No_Reduction);%����paprs��CCDF����
%����SLM�㷨����
[y_slm_para,paprs_SLM] = B_SLMProcess( y_para ); %U=6
percent_paprs_CCDF_SLM_Reduction = paprCCDFCalu(papr_base,paprs_SLM);%����paprs��CCDF����
%����PJ-SLM�㷨����
U1 = 6;
[y_slm_para_opti,paprs_SLM_opti] = C_PJSLMProcess( y_para);%U1=U=6
percent_paprs_CCDF_SLM_Reduction_opti = paprCCDFCalu(papr_base,paprs_SLM_opti);%����paprs��CCDF����
%����PJ-SLM�㷨����
U1 = 8;
[y_slm_para_opti8,paprs_SLM_opti8] = C_PJSLMProcess( y_para);%U1=U=8
percent_paprs_CCDF_SLM_Reduction_opti8 = paprCCDFCalu(papr_base,paprs_SLM_opti8);%����paprs��CCDF����
%ֱ���޷�������
[y_Clipping_para,paprs_Clipping] = D_ClippingProcess( y_para);%lambda = 2.1
percent_paprs_CCDF_Clipping_Reduction = paprCCDFCalu(papr_base,paprs_Clipping);%����paprs��CCDF����
%����PJ-SLM-C�㷨����
U1 = 6;
[y_slm_clipping_para,paprs_SLM_Clipping] = E_PJSLMClippingProcess( y_para);
percent_paprs_CCDF_SLM_Clipping_Reduction = paprCCDFCalu(papr_base,paprs_SLM_Clipping);%����paprs��CCDF����
%����PJ-SLM-C�㷨����
U1 = 8;
[y_slm_clipping_para8,paprs_SLM_Clipping8] = E_PJSLMClippingProcess( y_para);%U1 = 8
percent_paprs_CCDF_SLM_Clipping_Reduction8 = paprCCDFCalu(papr_base,paprs_SLM_Clipping8);%����paprs��CCDF����

result = [percent_paprs_CCDF_No_Reduction;percent_paprs_CCDF_SLM_Reduction;
          percent_paprs_CCDF_SLM_Reduction_opti;percent_paprs_CCDF_SLM_Reduction_opti8
          percent_paprs_CCDF_Clipping_Reduction;
          percent_paprs_CCDF_SLM_Clipping_Reduction;percent_paprs_CCDF_SLM_Clipping_Reduction8];
end

