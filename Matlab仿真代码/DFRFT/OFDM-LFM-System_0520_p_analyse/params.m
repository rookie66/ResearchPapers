% OFDM-LFM系统的所有参数-params

global n n_16 M k N L LN U ofdmCodeNums Q papr_base EbNos p

%信号比特数量
%n = 64*1024*128*16;  
n = 64*16*256;  
%16QAM调制之后的码元数目
n_16 = n/4;
%MQAM
M = 16;  k = log2(M);
%载波个数
%N = 256;
N = 16;
%过采样率over_samp
L = 1;  LN = L*N;
%SLM算法的备选信号
U = 4; %不要大于16
%输出的y为一个复数列向量
ofdmCodeNums = n_16/N; %OFDM-LFM的码元总数
%生成向量因子Q
Q = 1j.^randi([1,4],LN,U);%一列是一组
%PAPR-CCDF函数的统计基准
papr_base = 5:0.3:13;
%信噪比
EbNos = -10:3:30;
%DFRFT的阶数
p = 0.5;
