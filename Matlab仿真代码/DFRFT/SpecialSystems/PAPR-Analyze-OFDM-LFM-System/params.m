% OFDM-LFM系统的所有参数-params
global n n_16 M k N L LN ofdmCodeNums Q U papr_base EbNos p papr_th lambda
%信号比特数量
n = 1024*4;  
%16QAM调制之后的码元数目
n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%载波个数
N = 256;
%过采样率over_samp
L = 1;  LN = L*N;
%输出的y为一个复数列向量
ofdmCodeNums = n_16/N; %OFDM-LFM的码元总数
%SLM算法的备选信号
U = 6; %不要大于16
%生成向量因子Q
Q = 1j.^randi([1,4],LN,15);%生成一个足够大的相位因子序列
Q(:,1) = ones(LN,1);%另第一列为全1
% U1 = 8;%只需要提供Q和U1即可自动生成Q1
%PAPR-CCDF函数的统计基准
papr_base = 4:0.2:11;
papr_th = 7.0;
%信噪比
EbNos = -10:3:30;
%DFRFT的阶数
p = 0.5;
% 限幅法的限幅率
lambda = 2.1;