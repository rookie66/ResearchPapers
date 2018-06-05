function [ result ] = loopSLMProcess( Us )
%PROCESS Summary of this function goes here
%   Detailed explanation goes here
% �����ź�
signalsGenerator
%��PAPR�����㷨����
[y_no_Reduction_para,paprs_No_Reduction] = NoPAPRReduction(y_para);
percent_paprs_CCDF_No_Reduction = paprCCDFCalu(papr_base,paprs_No_Reduction);%����paprs��CCDF����
%����SLM�㷨����
percent_paprs_CCDF_SLM_Reductions = ones(length(Us),length(papr_base));
global U
for ii = 1:length(Us)
    U = Us(ii);
    [y_slm_para,paprs_SLM] = SLMProcess( y_para );
    percent_paprs_CCDF_SLM_Reductions(ii,:) = paprCCDFCalu(papr_base,paprs_SLM);%����paprs��CCDF����
end 
result = [percent_paprs_CCDF_No_Reduction;percent_paprs_CCDF_SLM_Reductions];
end

