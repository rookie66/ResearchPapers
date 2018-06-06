% OFDM-LFM系统的所有参数-params
global n n_16 M k N L LN ofdmCodeNums Q U papr_base EbNos p Us
%不同的U值
Us = [2,4,6,8,10];
%信号比特数量
n = 1024*16;   
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
U = 15; %不要大于16
%生成向量因子Q
Q = 1j.^randi([1,4],LN,U);%一列是一组
Q(:,1) = ones(LN,1);
%PAPR-CCDF函数的统计基准
papr_base = 4:0.2:11;
%信噪比
EbNos = -10:3:30;
%DFRFT的阶数
p = 0.5;