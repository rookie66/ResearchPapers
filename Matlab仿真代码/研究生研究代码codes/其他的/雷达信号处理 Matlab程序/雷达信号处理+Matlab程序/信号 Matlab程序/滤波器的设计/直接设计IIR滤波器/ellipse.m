clear all
close all
clc
nfft=256;
Fs=44;
Rp=0.5;
Rs=32;
typeo=4;
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
[N,Wn]=ellipord(Wp/pi,Ws/pi,Rp,Rs,'z');

[b,a,k]=ellip(N,Rp,Rs,Wn,type,'z');
[b,a]=zp2tf(b,a,k);
[H,w]=freqz(b,a,nfft,Fs);
plot([0:nfft-1]/nfft,abs(H))
axis([0 0.5 0 1])
grid on
title('ellipseÂË²¨Æ÷')
grid on