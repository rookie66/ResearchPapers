function [ paprValue ] = per_Vector_PAPR_Calcu( vector )
%计算1个向量的PAPR值,长度任意
%输入：一个列向量
%返回：该向量的PAPR值
    Len = length(vector);
    p_av = sum(abs(vector).^2)/Len;%这里先算成len
%     sqrt(p_av)
    p_peak = max(abs(vector).^2);
    paprValue = 10*log10(p_peak/p_av);   
end