% 对过采样的理解
% 对于序列中间补0或最后补0，N点采用的都相同，不用的是过采样的那一部分。
% 比如下面的例子：频域中间补0，时域4点采样为2.5、-0.5、-0.5、-0.5
%                频域后补0，时域4点采样也为2.5、-0.5、-0.5、-0.5
%         不同的是：过采样的那一些点。

%%  频域中间补0
% 频域补0;对应时域 过采样
% X1 频域信号，中间补0后为X2
% ifft变换后为时域信号x1和x2
clear;  clc;  close all
X1 = [1 2 3 4];
N = length(X1);
x1 = ifft(X1,4);
L = 2;  LN = L*N;
X2 = [X1(1:N/2),zeros(1,(L-1)*N),X1(N/2+1:end)];
x2 = L*ifft(X2,LN);
Ts = 1/N;
Ts2 = 1/LN;
n = 0:N-1;
n2 = 0:LN-1;
figure
stem(n.*Ts,real(x1),'b+--');
hold on
stem(n2.*Ts2,real(x2),'ro:');
disp('x1:');x1
disp('x2:');x2
%%   频域最后补0
% 频域补0;对应时域 过采样
% X1 频域信号，最后补0后为X2
% ifft变换后为时域信号x1和x2
clear;clc;close all
X1 = [1 2 3 4];
N = length(X1);
x1 = ifft(X1,4);
L = 2;  LN = L*N;
X2 = [X1,zeros(1,(L-1)*N)];
x2 = L*ifft(X2,LN);
Ts = 1/N;
Ts2 = 1/LN;
n = 0:N-1;
n2 = 0:LN-1;
figure
stem(n.*Ts,real(x1),'b+--');
hold on
stem(n2.*Ts2,real(x2),'ro:');
disp('x1:');x1
disp('x2:');x2
