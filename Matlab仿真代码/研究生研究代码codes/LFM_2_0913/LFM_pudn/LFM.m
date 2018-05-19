%线性调频
clear al;
close all;
clc;

BT=50;                                      %时宽带宽积
T=1;                                        %归一化脉宽
B=BT/T;                                     %调频带宽
Fs=50*B;Ts=1/Fs;                            %计算机采样率
t=-1:Ts:1;
xt=exp(1j*pi*B*t.^2/T);                     %线性调频信号
figure(1)
plot(t,real(xt));
xlabel('归一化时间t/T');ylabel('幅度');
title('BT积为50时的LFM的时域波形');

BT=100;                                     %时宽带宽积
T=1;                                        %归一化脉宽
B=BT/T;                                     %调频带宽
Fs=20*B;Ts=1/Fs;                            %计算机采样率
N=T/Ts;                                     %计算机采样点数
t=linspace(-T/2,T/2,N);
xt=exp(1j*pi*B/T*t.^2);                     %线性调频信号
X=fftshift(abs(fft(xt)));                   %线性调频信号的傅里叶变换
f=linspace(-Fs/(max(Fs)),Fs/(max(Fs)),N);   
n=N*B/Fs;
f=-n*Fs:Fs:n*Fs;                            %取频域中的一部分显示
f=f/max(f);                                 %频率归一化
figure(2)
X=X/(max(X));                               %幅度归一化
plot(f,X(N/2-n:N/2+n));
xlabel('归一化频率F/B');ylabel('幅度');
title('BT积为100时的LFM频谱');
Ht=exp(-1j*pi*B/T*t.^2);                    %匹配滤波器单位冲激响应
Sot=abs(conv(xt,Ht));                       %匹配滤波输出
L=2*N-1;                                    %匹配滤波后的时域长度
t1=linspace(-T,T,L);
Sot=Sot/(max(Sot));                         %幅度归一化
figure(3)
plot(t1,Sot);
xlabel('归一化时延t/T');ylabel('归一化幅度');
title('BT积为100时的LFM匹配滤波后的输出');
N0=T/20/Ts;
figure(4)
t2=-N0*Ts:Ts:N0*Ts;
plot(t2,Sot(N-N0:N+N0));                    %取匹配滤波后时域的一部分进行显示
xlabel('归一化时延t/T');ylabel('归一化幅度');
title('匹配滤波后的输出---中心部分放大图');



