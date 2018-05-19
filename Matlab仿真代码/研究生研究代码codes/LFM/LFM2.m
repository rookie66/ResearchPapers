% demo of LFM pulse radar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       ����
% T��chirp�źŵĳ�������
% B��chirp�źŵĵ�Ƶ����
% Rmin���۲�Ŀ����״�����λ��
% Rmax���۲�Ŀ����״����Զλ��
% R��һά���飬����ֵ��ʾÿ��Ŀ������״��б��
% RCS��һά���飬����ֵ��ʾÿ��Ŀ����״�ɢ�����
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
Rwid=Rmax-Rmin;  % ���յ��� ���봰
Twid=2*Rwid/c;   % ʱ��
Fs=5*B;          % ����Ƶ��
Ts=1/Fs; 
Nwid=ceil(Twid/Ts);             % 5000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% �״�ز�
t=linspace(2*Rmin/c,2*Rmax/c,Nwid);   % t����Чʱ�䷶Χ
M=length(R);     % Ŀ��ĸ���
td=ones(M,1)*t-2*R'/c*ones(1,Nwid);  

% ?????
% Srt=RCS*(exp(j*pi*K*td.^2).*(abs(td)<T/2));
Srt=RCS*exp(j*pi*K*td.^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nchirp=ceil(T/Ts);              % Nchirp=1500
Nfft=2^nextpow2(Nwid+Nwid-1);   % FFT����  Nfft=16384    Nwid=5000
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
xlabel('ʱ��/s'),ylabel('����');
title('δѹ�����״�ز�');
subplot(212)
plot(t*c/2,Z);
axis([10000,15000,-60,0]);
xlabel('���뵥Ԫ');ylabel('����/dB');
title('ѹ����ĵ��״�ز�');