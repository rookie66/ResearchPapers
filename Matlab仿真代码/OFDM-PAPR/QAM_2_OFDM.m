% 程序功能：
%   在QAM_2.m基础上，增添了IFFT与FFT调制，实现OFDM信号

%对16QAM进行了调制和解调仿真，得到BER-SNR曲线
close all;clear;clc
%信号比特数据n
n = 1024*128*16;  n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%载波个数
N = 64;
%过采样率
L = 1;%over_samp
%生成随机二进制比特流(行向量）
x = randi([0 1],1,n); 
%转换矩阵维度，每k个bit一组
x_4 = reshape(x,length(x)/k,k);
%变成16进制
x_16 = bi2de(x_4,'right-msb');%right-msb参数表示第一列为最低位置
figure(1);
stem(x_16(1:n_16));%画出相应的16进制信号序列
xlabel('信号序列'); ylabel('16进制--信号幅度');title('16进制随机信号');
%用16QAM调制器对信号进行调制
y = modulate(modem.qammod(M),x_16);
%y输出的y为一个复数向量
%h = modem.qammod('M', 16, 'SymbolOrder', 'Gray'); 
scatterplot(y);%画出16QAM信号的星座图
colums_num = length(y)/N;
y_para = reshape(y,N,colums_num);
%x_ofdm 存放调制后的数据
x_ofdm = zeros(N,colums_num);
for i = 1:colums_num
       x_ofdm(:,i) = ifft(y_para(:,i),N);%默认也是N点ifft
end
%并变串
y_Serial_ifft = reshape(x_ofdm,1,N*length(x_ofdm));

j_index = 0;EbNos = -10:1:30;
rates = zeros(1,length(EbNos));
for EbNo= EbNos 
snr = EbNo+10*log10(k)-10*log10(L);%信噪比
yn=awgn(y_Serial_ifft,snr,'measured');%加入高斯白噪声
%串变并
colums_num_R = length(yn)/N;
y_para_R = reshape(yn,N,colums_num_R);
%fft变换
y_fft = zeros(N,colums_num_R);
for i = 1:colums_num_R
    y_fft(:,i) = fft(y_para_R(:,i),N);
end
yd = demodulate(modem.qamdemod(M),y_fft);%此时解调出来的是16进制信号
z=de2bi(yd,'right-msb'); %转化为对应的二进制比特流?
z=reshape(z,1,n);
[number_of_errors,bit_error_rate]=biterr(x,z);
j_index = j_index+1;
rates(j_index) = bit_error_rate;
end 
disp('误比特率：');rates
figure,semilogy(EbNos,rates),grid on;
xlabel('SNR/dB');ylabel('BER');title('BER-SNR图像分析曲线')
