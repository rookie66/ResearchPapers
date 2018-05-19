function [result] = polyMultiByFFT(A,B)
% A first polynomial ,high first,low after 
% A first polynomial ,high first,low after 
% result ,high bit first,low bit after
% the result  is same as conv(A,B).
N_A = length(A);
N_B = length(B);
N_use = N_A+N_B-1;
N_R = pow2(ceil(log2(N_use)));%保证是2的幂
A_new = [A,zeros(1,N_R-N_A)];%对A多项式高位补领
B_new = [B,zeros(1,N_R-N_B)];%对B多项式高位补领
Y_A = fft(A_new);
Y_B = fft(B_new);
Y_R = Y_A.*Y_B;
y_r = ifft(Y_R);
result = y_r(1:N_use);
end