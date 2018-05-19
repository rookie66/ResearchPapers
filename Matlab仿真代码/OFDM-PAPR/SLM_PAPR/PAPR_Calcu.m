function [ papr_value ] = PAPR_Calcu(y_ofdm )
%PAPR_CALCU Summary of this function goes here
% ¼ÆËãPAPRµÄº¯Êý
    N = length(y_ofdm);
    p_av = 1/N*sum(abs(y_ofdm).^2);
    p_peak = max(abs(y_ofdm).^2);
    papr_value= 10*log10(p_peak/p_av);
end

