function [ result ] = loopSLMProcess( Us )
%PROCESS Summary of this function goes here
%   Detailed explanation goes here
% 生成信号
signalsGenerator
%无PAPR抑制算法处理
[y_no_Reduction_para,paprs_No_Reduction] = NoPAPRReduction(y_para);
percent_paprs_CCDF_No_Reduction = paprCCDFCalu(papr_base,paprs_No_Reduction);%计算paprs的CCDF函数
%进行SLM算法处理
percent_paprs_CCDF_SLM_Reductions = ones(length(Us),length(papr_base));
global U
for ii = 1:length(Us)
    U = Us(ii);
    [y_slm_para,paprs_SLM] = SLMProcess( y_para );
    percent_paprs_CCDF_SLM_Reductions(ii,:) = paprCCDFCalu(papr_base,paprs_SLM);%计算paprs的CCDF函数
end 
result = [percent_paprs_CCDF_No_Reduction;percent_paprs_CCDF_SLM_Reductions];
end

