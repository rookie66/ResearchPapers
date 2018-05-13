% 本程序功能：
%   在QAM_1.m基础上，添加了for循环，在不同EbNo下，计算各自的误比特率，并做出BER-SNR曲线
close all;clear;clc
%信号比特数据n
n = 1024*128;  n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%过采样率
L = 1; %over_samp
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
i = 0;
EbNos = -10:1:30;
rates = zeros(1,length(EbNos));
for EbNo= EbNos 
snr=EbNo+10*log10(k)-10*log10(L);%信噪比
yn=awgn(y,snr,'measured');%加入高斯白噪声
%h=scatterplot(yn,L,0,'b.');%经过信道后接收到的含白噪声的信号
%星座图
%hold on;scatterplot(y,1,0,'k+',h);%加入不含白噪声的信号星座图?
%title('接收信号与原来信号星座图');legend('含噪声接收信号','不含噪声信号');
%axis([-5 5 -5 5]);
%scatterplot(yn);%画出16QAM信号的星座图
%axis([-5 5 -5 5]);
yd=demodulate(modem.qamdemod(M),yn);%此时解调出来的是16进制信号?
z=de2bi(yd,'right-msb'); %转化为对应的二进制比特流?
z=reshape(z,1,n);
[number_of_errors,bit_error_rate]=biterr(x,z);
i = i+1;
rates(i) = bit_error_rate;
end 
figure,semilogy(EbNos,rates),grid on
xlabel('SNR/dB');ylabel('BER');title('BER-SNR图像分析曲线')
