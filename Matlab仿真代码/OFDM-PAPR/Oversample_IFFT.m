% �Թ����������
% ���������м䲹0�����0��N����õĶ���ͬ�����õ��ǹ���������һ���֡�
% ������������ӣ�Ƶ���м䲹0��ʱ��4�����Ϊ2.5��-0.5��-0.5��-0.5
%                Ƶ���0��ʱ��4�����ҲΪ2.5��-0.5��-0.5��-0.5
%         ��ͬ���ǣ�����������һЩ�㡣

%%  Ƶ���м䲹0
% Ƶ��0;��Ӧʱ�� ������
% X1 Ƶ���źţ��м䲹0��ΪX2
% ifft�任��Ϊʱ���ź�x1��x2
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
%%   Ƶ�����0
% Ƶ��0;��Ӧʱ�� ������
% X1 Ƶ���źţ����0��ΪX2
% ifft�任��Ϊʱ���ź�x1��x2
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
