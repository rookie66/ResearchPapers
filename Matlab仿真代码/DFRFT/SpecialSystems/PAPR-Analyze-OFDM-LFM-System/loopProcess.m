function [ result ] = loopProcess(  )
%PROCESS Summary of this function goes here
%   Detailed explanation goes here
% �����ź�
signalsGenerator
%��PAPR�����㷨����
[y_no_Reduction_para,paprs_No_Reduction] = NoPAPRReduction(y_para);
percent_paprs_CCDF_No_Reduction = paprCCDFCalu(papr_base,paprs_No_Reduction);%����paprs��CCDF����
%����SLM�㷨����
[y_slm_para,paprs_SLM] = SLMProcess( y_para );
percent_paprs_CCDF_SLM_Reduction = paprCCDFCalu(papr_base,paprs_SLM);%����paprs��CCDF����
%����PJ-SLM�㷨����
[y_slm_para_opti,paprs_SLM_opti] = OptimizeSLMProcess( y_para);
percent_paprs_CCDF_SLM_Reduction_opti = paprCCDFCalu(papr_base,paprs_SLM_opti);%����paprs��CCDF����
%����PJ-SLM-C�㷨����
[y_slm_clipping_para,paprs_SLM_Clipping] = SLMClippingProcess( y_para);
percent_paprs_CCDF_SLM_Clipping_Reduction = paprCCDFCalu(papr_base,paprs_SLM_Clipping);%����paprs��CCDF����
%ֱ���޷�������
[y_Clipping_para,paprs_Clipping] = ClippingProcess( y_para);
percent_paprs_CCDF_Clipping_Reduction = paprCCDFCalu(papr_base,paprs_Clipping);%����paprs��CCDF����

result = [percent_paprs_CCDF_No_Reduction;percent_paprs_CCDF_SLM_Reduction;
          percent_paprs_CCDF_SLM_Reduction_opti;percent_paprs_CCDF_SLM_Clipping_Reduction;
          percent_paprs_CCDF_Clipping_Reduction];
end

