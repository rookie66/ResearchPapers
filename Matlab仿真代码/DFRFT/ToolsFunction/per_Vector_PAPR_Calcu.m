function [ paprValue ] = per_Vector_PAPR_Calcu( vector )
%����1��������PAPRֵ,��������
%���룺һ��������
%���أ���������PAPRֵ
    Len = length(vector);
    p_av = sum(abs(vector).^2)/Len;%���������len
%     sqrt(p_av)
    p_peak = max(abs(vector).^2);
    paprValue = 10*log10(p_peak/p_av);   
end