clear;clc,close
%1. DFRFT的基本参数
p = -1;          %FRFT的阶数
alpha = p*pi/2; %旋转角度
beta = csc(alpha);
gama = cot(alpha);
A_alpha = sqrt(1-1i*cot(alpha));%核函数的Aa
%2. 量纲归一化部分
T = 1e-6;  %观察时间
Fs = 128e6; %采样频率
S = sqrt(T/Fs);
delta_x = sqrt(T*Fs);
delta_x_2 = 2*delta_x;
%Ts_old = 1/Fs;%原来的采样间隔
Ts_new = 1/delta_x_2;%现在的采样间隔
N = round(delta_x^2);
%3. 输入的x序列
n_bit = 1024*128*16; %信号比特数据n
n_16 = n_bit/4;
% MQAM
M = 16;  k = log2(M);
%过采样率over_samp
L = 1; LN = L*N;
%生成随机二进制比特流(行向量）
x_bit = randi([0 1],1,n_bit); 
%转换矩阵维度，每k个bit一组
x_4 = reshape(x_bit,length(x_bit)/k,k);
%变成16进制
x_16 = bi2de(x_4,'right-msb');%right-msb参数表示第一列为最低位置
%用16QAM调制器对信号进行调制
y = modulate(modem.qammod(M),x_16);
%y输出的y为一个复数向量
colums_num = length(y)/2/N;
x = reshape(y,2*N,colums_num);
x = x(:,1);
%首先构造需要卷积的链两个序列x_conv和h_conv

%利用FFT实现卷积
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
%y_ifft_cut-y_conv_cut<0.01+0.01i  %将卷积结果和FFT计算结果相比较
figure(1)
plot(abs(real(y_ifft_cut)))
figure(2)
F_x = ifft(x);
plot(abs(real(F_x)))
figure(3)
F_spe = fft(y_ifft_cut);
plot(abs(real(F_spe)))

%% 
%卷积前面一部分，与n无关，至于alpha有关
F_before = A_aplha/delta_x_2*exp(1i*pi*(gama-beta)*(m/delta_x_2).^2);
%最终结果DFRFT
F_alpha = A_before.*F_conv;

