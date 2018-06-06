% OFDM-LFM系统的所有参数-params
global n n_16 M k  L LN ofdmCodeNums papr_base EbNos p 
% global Ns 
%信号比特数量
n = 64*1024*4;  
%16QAM调制之后的码元数目
n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
% %载波个数
% N = 256;
% Ns = [32,64,128,256];
%过采样率over_samp
L = 1;  LN = L*N;
%输出的y为一个复数列向量
ofdmCodeNums = n_16/N; %OFDM-LFM的码元总数
%PAPR-CCDF函数的统计基准
papr_base = 5:0.3:13;
%信噪比
EbNos = -10:1:30;
%DFRFT的阶数
p = 0.5;