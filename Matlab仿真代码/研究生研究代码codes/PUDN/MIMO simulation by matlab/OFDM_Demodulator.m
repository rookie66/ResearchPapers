%==========================================================================
%
%Chuong trinh con
%
%==========================================================================

function [y]=OFDM_Demodulator(data,chnr,NFFT,G);
x_remove_guard_interval=[data(G+1:NFFT+G)];
x=fft(x_remove_guard_interval);
y=x(1:chnr);