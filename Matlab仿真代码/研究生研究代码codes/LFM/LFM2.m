% demo of LFM pulse radar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       参数
% T：chirp信号的持续脉宽
% B：chirp信号的调频带宽
% Rmin：观测目标距雷达的最近位置
% Rmax：观测目标距雷达的最远位置
% R：一维数组，数组值表示每个目标相对雷达的斜距
% RCS：一维数组，数组值表示每个目标的雷达散射截面
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function LFM_radar(T,B,Rmin,Rmax,R,RCS)
% if nargin==0
    T=10e-6;
    B=30e6;
    Rmin=10000;
    Rmax=15000;
    R=[10500,11000,12000,12008,13000,13002];
    RCS=[1 1 1 1 1 1];
% end
%                   parameter
c=3e8;
K=B/T;
Rwid=Rmax-Rmin;  % 接收到的 距离窗
Twid=2*Rwid/c;   % 时延
Fs=5*B;          % 采样频率
Ts=1/Fs; 
Nwid=ceil(Twid/Ts);             % 5000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 雷达回波
t=linspace(2*Rmin/c,2*Rmax/c,Nwid);   % t的有效时间范围
M=length(R);     % 目标的个数
td=ones(M,1)*t-2*R'/c*ones(1,Nwid);  

% ?????
% Srt=RCS*(exp(j*pi*K*td.^2).*(abs(td)<T/2));
Srt=RCS*exp(j*pi*K*td.^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nchirp=ceil(T/Ts);              % Nchirp=1500
Nfft=2^nextpow2(Nwid+Nwid-1);   % FFT点数  Nfft=16384    Nwid=5000
Srw=fft(Srt,Nfft);
t0=linspace(-T/2,T/2,Nchirp);
St=exp(j*pi*K*t0.^2);
Sw=fft(St,Nfft);
Sot=fftshift(ifft(Srw.*conj(Sw)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N0=Nfft/2-Nchirp/2;
Z=abs(Sot(N0:N0+Nwid-1));
Z=Z/max(Z);
Z=20*log10(Z+1e-6);

figure
subplot(211)
plot(t*1e6,real(Srt));axis tight;
xlabel('时间/s'),ylabel('幅度');
title('未压缩的雷达回波');
subplot(212)
plot(t*c/2,Z);
axis([10000,15000,-60,0]);
xlabel('距离单元');ylabel('幅度/dB');
title('压缩后的的雷达回波');