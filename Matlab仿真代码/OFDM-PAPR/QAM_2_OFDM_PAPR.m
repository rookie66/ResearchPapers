% 本程序改进：
%       在QAM_2_OFDM.m基础上,添加了计算PAPR-CCDF的功能,并绘制PAPR-CCDF图像;
%       去除了16进制原信号图像和星座图;但是过采样仍然没有实现
close all;clear;clc
%信号比特数据n
n = 1024*128;  n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%载波个数
N = 64;
%过采样率
L = 1;  LN = L*N;
%生成随机二进制比特流(行向量）
x = randi([0 1],1,n); 
%转换矩阵维度，每k个bit一组
x_4 = reshape(x,length(x)/k,k);
%变成16进制
x_16 = bi2de(x_4,'right-msb');%right-msb参数表示第一列为最低位置
%用16QAM调制器对信号进行调制
y = modulate(modem.qammod(M),x_16);
%y输出的y为一个复数向量
colums_num = length(y)/N;
y_para = reshape(y,N,colums_num);

%-----------对QAM调制后的数据进行IFFT并计算PAPR---------
x_ofdm = zeros(N,colums_num);%x_ofdm 存放调制后的数据
papr = zeros(1,colums_num);
for i = 1:colums_num
     %注意LN点采样后需要乘以L,因为采样后的幅度变为原来的1/L
       x_ofdm(:,i) = L*ifft(y_para(:,i),LN);%默认也是LN点ifft  
       p_av = 1/N*sum(abs(x_ofdm(:,i)).^2);
       p_peak = max(abs(x_ofdm(:,i)).^2);
       papr(i) = 10*log10(p_peak/p_av);
end
papr_baseS = 5:0.5:15;
percent_papr = zeros(1,length(papr_baseS));
i = 0;
for papr_base = papr_baseS
    i = i + 1;
    percent_papr(i) = length(find(papr > papr_base))/length(papr);
end
figure
semilogy(papr_baseS,percent_papr),grid on
xlabel('PAPR0/dB');ylabel('CCDF');title('PAPR-CCDF曲线');
%-------PAPR分析结束---------------
%-------下面进行发送到信道，加噪声，fft、dQAM,计算误比特率----------
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
z = de2bi(yd,'right-msb'); %转化为对应的二进制比特流?
z = reshape(z,1,n);
[number_of_errors,bit_error_rate] = biterr(x,z);
j_index = j_index + 1;
rates(j_index) = bit_error_rate;
end 
disp('误比特率：')
rates
figure,semilogy(EbNos,rates),grid on;
xlabel('SNR/dB');ylabel('BER');title('不采用PAPR抑制算法下BER-SNR图像分析曲线')
