clear ;clc
%��֤DFRFT�ľ������Ϊ2N+1�����ҲΪ2N+1
% conv��FFT�ļ��㷽����û�з����仯��
% �仯���ǽ��ֻ��Ҫȡ�м��2N+1��ֵ��ǰ��ͽ�β��N��ֵȥ����
x = 1:10;
h = x.*2;
N = length(x);
N_half = floor(N/2);%ע��N�ǲ���ż��
y = conv(x,h);
y_result_conv = y(N/2+1:end-N/2);
%����FFT������
L = 2*N-1;
x_1 = [x,zeros(1,L-N)];
h_1 = [h,zeros(1,L-N)];
X_1 = fft(x_1);
H_1 = fft(h_1);
y_1 = ifft(X_1.*H_1);
y_result_fft = y_1(N/2+1:end-N/2);
y_result_conv
y_result_fft