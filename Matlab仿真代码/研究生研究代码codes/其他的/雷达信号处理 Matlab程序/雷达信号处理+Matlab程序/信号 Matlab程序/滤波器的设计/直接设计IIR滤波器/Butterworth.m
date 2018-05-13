clear all
close all
clc
n=0:0.01:2;
nfft=1024;
Fs=44;
As=30;
Ap=0.5;

typeo=2;

switch typeo
case 1
    type='bandpass';
case 2
    type='stop';
case 3
    type='high';
case 4
    type='low';
end
if typeo==1
Wp=[0.15*pi,0.35*pi];
Ws=[0.1*pi,0.4*pi];
elseif typeo==2
Ws=[0.15*pi,0.35*pi];
Wp=[0.1*pi,0.4*pi];   
elseif typeo==3 
    Wp=0.25*pi;
    Ws=0.2*pi;
elseif typeo==4
     Wp=0.25*pi;
    Ws=0.3*pi;
end
[N,wn]=buttord(Wp/pi,Ws/pi,Ap,As);
[b,a,k]=butter(N,wn,type,'z');
[b,a]=zp2tf(b,a,k);
[h,f,s]=freqz(b,a,nfft,Fs,'whole');
plot([0:nfft-1]/nfft,abs(h))
axis([0 0.5 0 1])
grid on
title('ButterworthÊý×ÖÂË²¨Æ÷')

