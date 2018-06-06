function [ result ] = loopProcess(  )
%PROCESS Summary of this function goes here
%   Detailed explanation goes here
% 生成信号
signalsGenerator
%无PAPR抑制算法处理
[y_no_Reduction_para,paprs_No_Reduction] = NoPAPRReduction(y_para);
percent_paprs_CCDF_No_Reduction = paprCCDFCalu(papr_base,paprs_No_Reduction);%计算paprs的CCDF函数
%进行SLM算法处理
[y_slm_para,paprs_SLM] = SLMProcess( y_para );
percent_paprs_CCDF_SLM_Reduction = paprCCDFCalu(papr_base,paprs_SLM);%计算paprs的CCDF函数
%进行PJ-SLM算法处理
[y_slm_para_opti,paprs_SLM_opti] = OptimizeSLMProcess( y_para);
percent_paprs_CCDF_SLM_Reduction_opti = paprCCDFCalu(papr_base,paprs_SLM_opti);%计算paprs的CCDF函数
%进行PJ-SLM-C算法处理
[y_slm_clipping_para,paprs_SLM_Clipping] = SLMClippingProcess( y_para);
percent_paprs_CCDF_SLM_Clipping_Reduction = paprCCDFCalu(papr_base,paprs_SLM_Clipping);%计算paprs的CCDF函数
%直接限幅法处理
[y_Clipping_para,paprs_Clipping] = ClippingProcess( y_para);
percent_paprs_CCDF_Clipping_Reduction = paprCCDFCalu(papr_base,paprs_Clipping);%计算paprs的CCDF函数

result = [percent_paprs_CCDF_No_Reduction;percent_paprs_CCDF_SLM_Reduction;
          percent_paprs_CCDF_SLM_Reduction_opti;percent_paprs_CCDF_SLM_Clipping_Reduction;
          percent_paprs_CCDF_Clipping_Reduction];
end

