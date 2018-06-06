% OFDM-LFM系统的所有参数-params
global n n_16 M k N L LN ofdmCodeNums Q Q1 U U1 papr_base EbNos p papr_th lambda
%信号比特数量
n = 1024*4;  
% n = 256*16*4;  
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
U = 4; %不要大于16
%生成向量因子Q
Q = 1j.^randi([1,4],LN,U);%一列是一组
Q(:,1) = ones(LN,1);
U1 = 8;
Q1 = 1j.^randi([1,4],LN,U1+1);%一列是一组
if U1+1 == U
   Q1 = Q;%Q1和Q应该保持一致？这样才会具有可比性。
else if U1+1 > U
     Q1(:,1:U) = Q;%另前U列相同
    else%U1+1<U
        Q1 = Q(:,1:U1);
    end
end
%PAPR-CCDF函数的统计基准
papr_base = 4:0.2:11;
papr_th = 7.2;

%信噪比
EbNos = -10:3:30;
%DFRFT的阶数
p = 0.5;
% 限幅法的限幅率
lambda = 2.1;