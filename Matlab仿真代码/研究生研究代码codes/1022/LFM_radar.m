clc;close all;clear;
% function LFM_radar(T,B,Rmin,Rmax,R,RCS)
%===============������Ŀ��ز�=======================%
T=10e-6;                                          % ����10us
B=30e6;                                           % ����30MHz
Rmin=10000; Rmax=15000;                           % ���뷶Χ
R=[11000, 13000, 13002];                          % ��Ŀ��ľ�������
RCS=[1  1  1];                                    % ��Ŀ��ĺ���ɢ��ϵ��
C=3e8;                                            % ����
K=B/T;                                            % ��Ƶб��
Rwid=Rmax-Rmin;                                  
Twid=2*Rwid/C;                                    % ��Ϊ��λ�Ľ��մ�����
Fs=5*B;Ts=1/Fs;                                   % ����Ƶ�ʺ�ʱ����
Nwid=ceil(Twid/Ts);                               % ���մ��Ĳ�������  
t=linspace(2*Rmin/C,2*Rmax/C,Nwid);               % ���뷶Χ����                                                                          
M=length(R);                                      % Ŀ�����Ŀ                                     
td=ones(M,1)*t-2*R'/C*ones(1,Nwid);
Srt=RCS*(exp(j*pi*K*td.^2).*(abs(td)<T/2));       % �״�ӵ�Ŀ�괦�Ļز� 

%================��ѹ========================%

Nchirp=ceil(T/Ts);                                % ��һ���������ʱ����в���
Nfft=2^nextpow2(Nwid+Nwid-1);                     % fft�ĵ���
Srw=fft(Srt,Nfft);                                % �Իز���Nfft��ĸ���Ҷ�任
t0=linspace(-T/2,T/2,Nchirp); 
St=exp(j*pi*K*t0.^2);                             % ���Ե�Ƶ����              
Sw=fft(St,Nfft);                                  % �����Ե�Ƶ�������и���Ҷ�任
Sot=fftshift(ifft(Srw.*conj(Sw)));                % ��ѹ  δ��ʱ�����ӣ���


N0=Nfft/2-Nchirp/2;
Z=abs(Sot(N0:N0+Nwid-1));                        % ��ȡ���ݣ�����                     
Z=Z/max(Z);
% Z=20*log10(Z+1e-6);                            % ��1e-6����                            
Z=20*log10(Z);

%=============�Ӵ�=================%
Nchirp=ceil(T/Ts);                                % ��һ���������ʱ����в���
Nfft=2^nextpow2(Nwid+Nwid-1);                     % fft�ĵ���
Srw=fft(Srt,Nfft);                                % �Իز���Nfft��ĸ���Ҷ�任
t0=linspace(-T/2,T/2,Nchirp); 
St=exp(j*pi*K*t0.^2);                             % ���Ե�Ƶ����              
Sw=fft(St,Nfft);                                  % �����Ե�Ƶ�������и���Ҷ�任
Sot=fftshift(ifft(Srw.*conj(Sw).*abs((fftshift(fft(hamming(16),Nfft))).')));                % ��ѹ  δ��ʱ�����ӣ���


N0=Nfft/2-Nchirp/2;
Z1=abs(Sot(N0:N0+Nwid-1));                        % ��ȡ���ݣ�����                     
Z1=Z1/max(Z1);
% Z=20*log10(Z+1e-6);                            % ��1e-6����                            
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
 







