%function pulse_compression
clear 
close all
Ts=.2e-6;%%range sample
tau=2e-6;%%pulse width
miu=4e+10;%%FM rate
%           Tr=1e-3;%%azimuth sample
N=100;%%range sample length
Nfft=128;%%filter bank length of FFT 
A=1;%%signal amplitude
%%produce the reference signal of PC
n=0:N-1;
ref_sig=exp(-j*pi*miu*((N-1-n)*Ts).^2); %相当于h（）
%%PC processing)
fd=1e+3;
n=0:N-1;
sig=A*exp(j*(2*pi*fd*n*Ts+pi*miu*(n*Ts).^2));%时宽为n*Ts=0.2ms,带宽为[0,2*pi*miu*t]=[0,8*pi(MHZ)]

sig=A*exp(j*(pi*miu*(n*Ts).^2));

sig_pc=conv(ref_sig,sig);
%%FFT processing of signal
Fs=1/Ts;
[FFT_sig_f,f]=freqz(sig,1,Nfft,Fs);
[PC_sig_f,f]=freqz(sig_pc,1,Nfft,Fs);
% FFT_sig_f=fft(sig,Nfft);
% PC_sig_f=fft(sig_pc,Nfft);
% XX_f=FFT_sig_f.*fft(ref_sig,Nfft);
% sig_pc=ifft(XX_f);
%%plot

% subplot(211),
plot(real(sig)) 
title('线性调频信号')
% subplot(212),
figure,plot(real(sig_pc))%
title('脉压信号')

%subplot(211),
figure,plot(f,abs(FFT_sig_f))%
title('线性调频信号的频谱')
%subplot(212),
figure,plot(f,abs(PC_sig_f))
title('脉压信号的频谱')
Y=fft(sig);Y=fftshift(Y);figure,plot(abs(Y));title('3')
YY=abs(fft(sig_pc));YY=fftshift(YY);figure,plot(YY);;title('4')

ref_sig_R=real(ref_sig);
sig_R=real(sig);         %线形调频信号 h=h(1:2:50);

figure,plot(sig_R)
sig_pc2=conv(ref_sig_R,sig_R);
figure,plot(sig_pc2)
[PC_sig_f2,f]=freqz(sig_pc2,1,Nfft,Fs);
figure,plot(abs(PC_sig_f2))

x=(sig_R*2^6)
h=(ref_sig_R(1:40)*2^6)

s0=conv(x,h)
n1=length(x);
n2=length(h);
x1=[zeros(1,n2-1) x zeros(1,n2)];
h1=[h,zeros(1,n1+n2-1)];
for i=1:(n1+n2-1)
    for j=1:(n1+n2-1)
        s(j)=x1(j)*h1(j);
    end
    s0(i)=sum(s);
    h1=[zeros(1,i),h,zeros(1,n1+n2-1-i)];
end

figure,plot(x)
title('x')
Y12=fft(x);Y12=fftshift(Y12);figure,plot(abs(Y12))
figure,stem(h)
title('h')
figure,plot(s0)
title('s0')
Y22=fft(s0);Y22=fftshift(Y22);figure,plot(abs(Y22))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=round(sig_R(1:50)*2^6)
h=round(ref_sig_R(1:50)*2^6)
s=conv(x,h);
figure,plot(s);title('s')
S=fftshift(fft(s));
figure,plot(abs(S));title('S')