%==========================================================================
%
%Chuong trinh con
%
%==========================================================================

function [y]=OFDM_Modulator(data,NFFT,G);

chnr=length(data);
N=NFFT;

x=[data, zeros(1,NFFT-chnr)];
a=ifft(x);
y=[a(NFFT-G+1:NFFT),a];