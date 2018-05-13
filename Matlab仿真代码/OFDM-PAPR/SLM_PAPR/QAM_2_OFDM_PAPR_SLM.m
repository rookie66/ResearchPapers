% 该程序功能改进：
%     在QAM_2_OFDM_PAPR.m基础上,添加了过采样功能
%     在添加信噪比修改了
%     SLM算法：该代码并不是符合SLM算法
%     SLM算法应该是对个符号都进行筛选，从而选择出PAPR最低的那个。
%     改进的算法见
close all;clear;clc
%信号比特数据n
n = 1024*128*64;  n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%载波个数
N = 256;
%过采样率over_samp
L = 1; LN = L*N;
%SLM算法的备选信号
U = 4;%不要大于16
%生成随机二进制比特流(行向量）
x = randi([0 1],1,n); 
%转换矩阵维度，每k个bit一组
x_4 = reshape(x,length(x)/k,k);
%变成16进制
x_16 = bi2de(x_4,'right-msb'); %right-msb参数表示第一列为最低位置
%用16QAM调制器对信号进行调制
y = modulate(modem.qammod(M),x_16);
%输出的y为一个复数向量
colums_num = length(y)/N;
%串变并
y_para = reshape(y,N,colums_num);
%生成向量因子Q
Q = 1j.^randi([1,4],U,N);
%下面进行SLM算法抑制PAPR
y_slm_para = zeros(LN+1,colums_num);%待发送的信号
paprs = zeros(1,colums_num);
for i = 1:colums_num
   [y_slm_para(:,i), paprs(i)]= Func_PAPR_SLM_0430(conj(y_para(:,i)'),Q,L,M);
end
% 普通OFDM下PAPR-CCDF分析
%-------添加过采样功能-------------
y_para_oversample = [y_para(1:N/2,:);zeros((L-1)*N,colums_num);y_para(N/2+1:end,:)];
%-----------对QAM调制后的数据进行IFFT并计算PAPR---------
x_ofdm = zeros(LN,colums_num);%x_ofdm 存放调制后的数据
paprs_ofdm = zeros(1,colums_num);
for i = 1:colums_num
      %注意LN点采样后需要乘以L,因为采样后的幅度变为原来的1/L
       x_ofdm(:,i) = L*ifft(y_para_oversample(:,i),LN);%默认也是LN点ifft  
       p_av = 1/N*sum(abs(x_ofdm(:,i)).^2);%这里先算成N
       p_peak = max(abs(x_ofdm(:,i)).^2);
       paprs_ofdm(i) = 10*log10(p_peak/p_av);
end
% 下面统计PAPR的CCDF,并作图
papr_baseS = 5:0.3:13;
percent_papr_ofdm = zeros(1,length(papr_baseS)); 
percent_papr_slm = zeros(1,length(papr_baseS));i = 0;
for papr_base = papr_baseS
    i = i + 1;  
    percent_papr_ofdm(i) = length(find(paprs_ofdm > papr_base))/length(paprs_ofdm);
    percent_papr_slm(i) = length(find(paprs > papr_base))/length(paprs);
end
figure
semilogy(papr_baseS,percent_papr_ofdm,'-r*'); hold on;
semilogy(papr_baseS,percent_papr_slm,'-.b^'); 
legend(' OFDM',' SLM')
grid on;xlabel('PAPR0/dB');ylabel('CCDF');title('PAPR-CCDF曲线');
%%%-------------开始SLM解调计算BER------------------------------------
y_slm_serial = reshape(y_slm_para,1,colums_num*(LN+1));%并变串
j_index = 0;EbNos = -10:3:30;
rates = zeros(1,length(EbNos));
for EbNo = EbNos 
%添加噪声
y_slm_serial_noise = awgn(y_slm_serial,EbNo,'measured');
%串变并
y_slm_para_noise = reshape(y_slm_serial_noise,LN+1,colums_num);
%-------------------开始解调-------------------
y_slm_after_fft_over = zeros(LN,colums_num); 
for i = 1:colums_num
    %当SNR较低时，导致q严重错误
    q = round(demodulate(modem.qamdemod(M),y_slm_para_noise(LN+1,i)));
    if ( q>U || q<1 )
        q = randi([1,4]);
    end
    %q_No_noise = demodulate(modem.qamdemod(M), y_slm_para(LN+1,i));
    y_slm_after_fft_over(:,i) = fft(y_slm_para_noise(1:LN,i),LN)./conj(Q(q,:)');
end
 %---------去除过采样-------------
y_slm_after_fft_quover = [y_slm_after_fft_over(1:N/2,:); y_slm_after_fft_over(end-N/2+1:end,:)];
y_slm_after_fft = demodulate(modem.qamdemod(M),y_slm_after_fft_quover);
z = de2bi(y_slm_after_fft,'right-msb'); %转化为对应的二进制比特流
z = reshape(z,1,n);
[number_of_errors,bit_error_rate] = biterr(x,z);
j_index = j_index + 1;
rates(j_index) = bit_error_rate;
end
%%-------------普通OFDM-------------
j_index_ofdm = 0;
rates_ofdm = zeros(1,length(EbNos));
y_ofdm_serial = reshape(x_ofdm,1,colums_num*LN);
for EbNo = EbNos 
%添加噪声
y_ofdm_serial_noise = awgn(y_ofdm_serial,EbNo,'measured');
%串变并
y_ofdm_para_noise = reshape(y_ofdm_serial_noise,LN,colums_num);
%开始解调
y_ofdm_after_fft_over = zeros(LN,colums_num);
for i = 1:colums_num
    y_ofdm_after_fft_over(:,i) =  fft(y_ofdm_para_noise(1:LN,i),LN);
end
%---------去除过采样-------------
y_ofdm_after_fft_quover = [y_ofdm_after_fft_over(1:N/2,:);y_ofdm_after_fft_over(end-N/2+1:end,:)];
y_ofdm_after_fft = demodulate(modem.qamdemod(M),y_ofdm_after_fft_quover);
z = de2bi(y_ofdm_after_fft,'right-msb'); %转化为对应的二进制比特流
z = reshape(z,1,n);
[number_of_errors,bit_error_rate_ofdm] = biterr(x,z);
j_index_ofdm = j_index_ofdm + 1;
rates_ofdm(j_index_ofdm) = bit_error_rate_ofdm;
end
disp('误比特率：')
rates
rates_ofdm
figure,semilogy(EbNos,rates),grid on;
hold on ;semilogy(EbNos,rates_ofdm);
xlabel('SNR/dB');ylabel('BER');title('BER-SNR图像分析曲线');
legend(' SLM',' OFDM')



