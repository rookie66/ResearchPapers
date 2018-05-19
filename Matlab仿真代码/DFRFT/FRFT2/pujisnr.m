%目标信号为单频信号,f0=3000,信号谱级为20db,noise 5db,T=1;
%滤波器，噪声的功率改成dbHz
clc
clear all
close all
%常量设置
f0=3000;
SS=20;
SN=5;
ts=4;

fs=4*f0;

t=0:1/fs:ts-1/fs;

point = ts*fs;
A=sqrt(4*10^(SS/10)/point);
signal=A*cos(2*pi*f0*t);
N=sqrt(10^(SN/10));
noise=N*normrnd(0,1,1,point);
snr=10*log10(std(signal)^2*point/2/(std(noise)^2));

p=signal+noise;
ps=fft(p);
pss=(ps.*conj(ps))/point;
psss=10*log10(pss);
f=fs*(0:point/2)/point;
plot(f,psss(1:point/2+1));
[c,I]=max(abs(pss));
std(pss)
%  n=1:point;
%  for k=1:point
%      xx=signal.*exp(-i*2*pi*k*n/point);
%      X(k)=sum(xx);
%  end
%  [wei,am]=max(abs(X));
%  plot(k,abs(X))
%      
 

% fs=1000;%谱级信噪比
% t = 0:1/fs:0.511;
% A=sqrt(2*10^(20/10));
% x = sin(2*pi*90*t);
% N=sqrt(10^(5/10)*fs);
% noise=randn(size(t));
% y = x+noise ;
% nb=10*log10(std(noise)^2/fs);
% sb=10*log10(std(x)^2);
% % plot(1000*t(1:50),y(1:50))
% % title('Signal Corrupted with Zero-Mean Random Noise')
% % xlabel('time (milliseconds)')
% Y = fft(y,512);
% Pyy=Y.*conj(Y)/512;
% Pyyy=10*log10(Pyy);
% f = 1000*(0:256)/512;
% plot(f,Pyyy(1:257))
% title('Frequency content of y')
% xlabel('frequency (Hz)')
% %帕赛瓦尔定理验证
% syn=mean(x.*x);
% pyn=mean(Pyy);
