function [ result ] = loopSLMProcess( )
%PROCESS Summary of this function goes here
%   Detailed explanation goes here
% 生成信号
signalsGenerator
global p ps
%无PAPR抑制算法处理
percent_paprs_CCDF_No_Reductions = ones(length(ps),length(papr_base));
for ii = 1:length(ps)
    p = ps(ii);
    [y_no_Reduction_para,paprs_No_Reduction] = NoPAPRReduction(y_para);
    percent_paprs_CCDF_No_Reductions(ii,:) = paprCCDFCalu(papr_base,paprs_No_Reduction);%计算paprs的CCDF函数
end
% %进行SLM算法处理
% percent_paprs_CCDF_SLM_Reductions = ones(length(ps),length(papr_base));
% for ii = 1:length(ps)
%     p = ps(ii);
%     [y_slm_para,paprs_SLM] = SLMProcess( y_para );
%     percent_paprs_CCDF_SLM_Reductions(ii,:) = paprCCDFCalu(papr_base,paprs_SLM);%计算paprs的CCDF函数
% end 
% result = [percent_paprs_CCDF_No_Reductions;percent_paprs_CCDF_SLM_Reductions];
result = percent_paprs_CCDF_No_Reductions;
end

