clear;clc,close
%1. DFRFT�Ļ�������
p = -1;          %FRFT�Ľ���
alpha = p*pi/2; %��ת�Ƕ�
beta = csc(alpha);
gama = cot(alpha);
A_alpha = sqrt(1-1i*cot(alpha));%�˺�����Aa
%2. ���ٹ�һ������
T = 1e-6;  %�۲�ʱ��
Fs = 128e6; %����Ƶ��
S = sqrt(T/Fs);
delta_x = sqrt(T*Fs);
delta_x_2 = 2*delta_x;
%Ts_old = 1/Fs;%ԭ���Ĳ������
Ts_new = 1/delta_x_2;%���ڵĲ������
N = round(delta_x^2);
%3. �����x����
n_bit = 1024*128*16; %�źű�������n
n_16 = n_bit/4;
% MQAM
M = 16;  k = log2(M);
%��������over_samp
L = 1; LN = L*N;
%������������Ʊ�����(��������
x_bit = randi([0 1],1,n_bit); 
%ת������ά�ȣ�ÿk��bitһ��
x_4 = reshape(x_bit,length(x_bit)/k,k);
%���16����
x_16 = bi2de(x_4,'right-msb');%right-msb������ʾ��һ��Ϊ���λ��
%��16QAM���������źŽ��е���
y = modulate(modem.qammod(M),x_16);
%y�����yΪһ����������
colums_num = length(y)/2/N;
x = reshape(y,2*N,colums_num);
x = x(:,1);
%���ȹ�����Ҫ���������������x_conv��h_conv

%����FFTʵ�־��
n = -N : 1: N-1;
N_num_conv = length(n);
L_num_conv = 2*N_num_conv-1;
N_num_cut = N;
h_before_conv = exp(1i*pi*beta*(n/delta_x_2).^2);
x_before_conv = exp(1i*pi*(gama-beta)*(n/delta_x_2).^2).*conj(x');
y_conv_part = conv(h_before_conv,x_before_conv);
%y_conv_cut = y_conv_part(N_num_cut+1:L_num_conv-N_num_cut);
%y_conv_cut
h_before_conv_fft = [h_before_conv,zeros(1,L_num_conv-N_num_conv)];
x_before_conv_fft = [x_before_conv,zeros(1,L_num_conv-N_num_conv)];
H_fft = fft(h_before_conv_fft);
X_fft = fft(x_before_conv_fft);

y_ifft_part = ifft(H_fft.*X_fft);
y_ifft_cut = y_ifft_part(N_num_cut+1:L_num_conv-N_num_cut);
y_ifft_cut
%y_ifft_cut-y_conv_cut<0.01+0.01i  %����������FFT��������Ƚ�
figure(1)
plot(abs(real(y_ifft_cut)))
figure(2)
F_x = ifft(x);
plot(abs(real(F_x)))
figure(3)
F_spe = fft(y_ifft_cut);
plot(abs(real(F_spe)))

%% 
%���ǰ��һ���֣���n�޹أ�����alpha�й�
F_before = A_aplha/delta_x_2*exp(1i*pi*(gama-beta)*(m/delta_x_2).^2);
%���ս��DFRFT
F_alpha = A_before.*F_conv;

