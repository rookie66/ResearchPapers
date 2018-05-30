% 生成二进制比特序列x
% 转换为16进制x_16列向量
% 对x_16序列16QAM调制成复数序列

global x
% 获取基本参数
params
%生成随机二进制比特流(行向量）,最原始的比特序列
x = randi([0 1],1,n); 
%转换矩阵维度，每k(k=4)个bit一组
x_4_column = reshape(x,k,length(x)/k);%目的：保证4个连续比特组成一个码元
x_4 = conj(x_4_column');%一行k个比特，调制成1个码元
%变成16进制;%right-msb参数表示第一列为最低位置
x_16 = bi2de(x_4,'right-msb'); %变成1个列向量
%用16QAM调制器对信号进行调制
y = modulate(modem.qammod(M),x_16);%将16进制数据变成复数(1对1)
%串变并S/P
y_para = reshape(y,N,ofdmCodeNums);%1列就是OFDM-LFM的一个码元的叠加