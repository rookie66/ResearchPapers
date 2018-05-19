clear ;clc
%验证DFRFT的卷积序列为2N+1，结果也为2N+1
% conv和FFT的计算方法都没有发生变化，
% 变化的是结果只需要取中间的2N+1个值，前面和结尾的N个值去除。
x = 1:10;
h = x.*2;
N = length(x);
N_half = floor(N/2);%注意N是不是偶数
y = conv(x,h);
y_result_conv = y(N/2+1:end-N/2);
%利用FFT计算卷积
L = 2*N-1;
x_1 = [x,zeros(1,L-N)];
h_1 = [h,zeros(1,L-N)];
X_1 = fft(x_1);
H_1 = fft(h_1);
y_1 = ifft(X_1.*H_1);
y_result_fft = y_1(N/2+1:end-N/2);
y_result_conv
y_result_fft