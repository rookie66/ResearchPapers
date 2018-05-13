function [result] = polyMultiByFFT(A,B)
% A first polynomial ,high first,low after 
% A first polynomial ,high first,low after 
% result ,high bit first,low bit after
% the result  is same as conv(A,B).
N_A = length(A);
N_B = length(B);
N_use = N_A+N_B-1;
N_R = pow2(ceil(log2(N_use)));%��֤��2����
A_new = [A,zeros(1,N_R-N_A)];%��A����ʽ��λ����
B_new = [B,zeros(1,N_R-N_B)];%��B����ʽ��λ����
Y_A = fft(A_new);
Y_B = fft(B_new);
Y_R = Y_A.*Y_B;
y_r = ifft(Y_R);
result = y_r(1:N_use);
end