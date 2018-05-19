% 该程序功能改进：(Deprecated)
%     在QAM_2_OFDM_PAPR.m基础上,添加了过采样功能
%     在添加信噪比修改了
%     SLM算法：该代码并不是符合SLM算法
%     SLM算法应该是对个符号都进行筛选，从而选择出PAPR最低的那个。
%     改进的算法见QAM_2_OFDM_PAPR_SLM.m
close all;clear;clc
%信号比特数据n
n = 1024*128*16;  n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%载波个数
N = 512;
%过采样率over_samp
L = 1; LN = L*N;
%SLM算法的备选信号
U = 10;
%生成随机二进制比特流(行向量）
x = randi([0 1],1,n); 
%转换矩阵维度，每k个bit一组
x_4 = reshape(x,length(x)/k,k);
%变成16进制
x_16 = bi2de(x_4,'right-msb');%right-msb参数表示第一列为最低位置
%用16QAM调制器对信号进行调制
y = modulate(modem.qammod(M),x_16);
%输出的y为一个复数向量
colums_num = length(y)/N;
%串变并
y_para = reshape(y,N,colums_num);
%生成向量因子Q
Q = 1j.^randi([1,4],U,N);
%PAPR的CCDF节点
papr_baseS = 5:0.5:15;
%信噪比
EbNos = -10:1:30;
%下面进行SLM算法抑制PAPR
percent_papr_SLM = zeros(U,length(papr_baseS));
bers_SLM = zeros(U,length(EbNos));
for u = 1:U
   [percent_papr,ber] = Func_PAPR_SLM_old(y_para,Q(u,:),N,L,M,n,colums_num,papr_baseS,EbNos,x);
   percent_papr_SLM(u,:) = percent_papr;
   bers_SLM(u,:) = ber;
end
%-----不采用PAPR抑制算法的的PAPR性能------
[percent_papr_ofdm,ber_ofdm] = Func_PAPR_SLM_old(y_para,ones(1,N),N,L,M,n,colums_num,papr_baseS,EbNos,x);
%------作PAPR图分析-----------
figure(1);
semilogy(papr_baseS,percent_papr_SLM(1,:)); hold on;
semilogy(papr_baseS,percent_papr_SLM(2,:)); hold on;
semilogy(papr_baseS,percent_papr_SLM(3,:)); hold on;
semilogy(papr_baseS,percent_papr_SLM(4,:)); hold on;
semilogy(papr_baseS,percent_papr_ofdm); hold on;
grid on;xlabel('PAPR0/dB');ylabel('CCDF');title('PAPR-CCDF曲线');
legend(['q = 1';'q = 2';'q = 3';'q = 4';'OFDM ']);
%------作BER图分析-----------
figure(2);  
semilogy(EbNos,ber_ofdm);hold on;
semilogy(EbNos,bers_SLM(1,:));hold on;
semilogy(EbNos,bers_SLM(2,:));hold on;
semilogy(EbNos,bers_SLM(3,:));hold on;
semilogy(EbNos,bers_SLM(4,:));hold on;grid on;
xlabel('SNR/dB');ylabel('BER');title('不采用PAPR抑制算法下BER-SNR图像分析曲线')
legend(['OFDM ';'q = 1';'q = 2';'q = 3';'q = 4']);

