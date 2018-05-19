%序列信号的谱分析
clear all;
clc;
M=21;%M为序列长度
N=(M-13)/2;
% n1=-10:-1;
% xn1=zeros(1,length(n1));
n1=0:4+N;
xn1=ones(1,length(n1));
n2=5+N:12+2*N;
xn2=zeros(1,length(n2));
n=[n1 n2];
xn=[xn1 xn2];
figure,stem(n,xn);
% N=23;
% beta=1.2;
% w=(kaiser(N,beta))';
% xn1=xn.*w;
k=0:M-1;w=2*pi*k/(M);
X=xn*exp(-j*2*pi/(M)).^(n'*k);
magX=abs(X);
figure,stem(k,fftshift(magX));xlabel('k');
figure,stem(w/2/pi,fftshift(magX));xlabel('F');
