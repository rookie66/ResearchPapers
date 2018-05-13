clc;close all;clear;
% function LFM_radar(T,B,Rmin,Rmax,R,RCS)
%===============产生点目标回波=======================%
T=10e-6;                                          % 脉宽10us
B=30e6;                                           % 带宽30MHz
Rmin=10000; Rmax=15000;                           % 距离范围
R=[11000, 13000, 13002];                          % 点目标的距离坐标
RCS=[1  1  1];                                    % 点目标的后向散射系数
C=3e8;                                            % 光速
K=B/T;                                            % 调频斜率
Rwid=Rmax-Rmin;                                  
Twid=2*Rwid/C;                                    % 秒为单位的接收窗函数
Fs=5*B;Ts=1/Fs;                                   % 采样频率和时间间隔
Nwid=ceil(Twid/Ts);                               % 接收窗的采样点数  
t=linspace(2*Rmin/C,2*Rmax/C,Nwid);               % 距离范围采样                                                                          
M=length(R);                                      % 目标的数目                                     
td=ones(M,1)*t-2*R'/C*ones(1,Nwid);
Srt=RCS*(exp(j*pi*K*td.^2).*(abs(td)<T/2));       % 雷达从点目标处的回波 

%================脉压========================%

Nchirp=ceil(T/Ts);                                % 对一个脉冲持续时间进行采样
Nfft=2^nextpow2(Nwid+Nwid-1);                     % fft的点数
Srw=fft(Srt,Nfft);                                % 对回波做Nfft点的傅里叶变换
t0=linspace(-T/2,T/2,Nchirp); 
St=exp(j*pi*K*t0.^2);                             % 线性调频函数              
Sw=fft(St,Nfft);                                  % 对线性调频函数进行傅里叶变换
Sot=fftshift(ifft(Srw.*conj(Sw)));                % 脉压  未加时延因子？？


N0=Nfft/2-Nchirp/2;
Z=abs(Sot(N0:N0+Nwid-1));                        % 截取数据？？？                     
Z=Z/max(Z);
% Z=20*log10(Z+1e-6);                            % 加1e-6？？                            
Z=20*log10(Z);

%=============加窗=================%
Nchirp=ceil(T/Ts);                                % 对一个脉冲持续时间进行采样
Nfft=2^nextpow2(Nwid+Nwid-1);                     % fft的点数
Srw=fft(Srt,Nfft);                                % 对回波做Nfft点的傅里叶变换
t0=linspace(-T/2,T/2,Nchirp); 
St=exp(j*pi*K*t0.^2);                             % 线性调频函数              
Sw=fft(St,Nfft);                                  % 对线性调频函数进行傅里叶变换
Sot=fftshift(ifft(Srw.*conj(Sw).*abs((fftshift(fft(hamming(16),Nfft))).')));                % 脉压  未加时延因子？？


N0=Nfft/2-Nchirp/2;
Z1=abs(Sot(N0:N0+Nwid-1));                        % 截取数据？？？                     
Z1=Z1/max(Z1);
% Z=20*log10(Z+1e-6);                            % 加1e-6？？                            
Z1=20*log10(Z1);


figure(1)
plot(t*1e6,real(Srt));axis tight;
xlabel('Time in u sec');ylabel('Amplitude')
title('Radar echo without compression');
figure(2)
plot(t*C/2,Z)
axis([10000,15000,-60,0]);
xlabel('Range in meters');ylabel('Amplitude in dB')
title('Radar echo after compression');
figure(3)
plot(t*C/2,Z1)
axis([10000,15000,-60,0]);
xlabel('Range in meters');ylabel('Amplitude in dB')
title('Radar echo after compression with hamming');
 







