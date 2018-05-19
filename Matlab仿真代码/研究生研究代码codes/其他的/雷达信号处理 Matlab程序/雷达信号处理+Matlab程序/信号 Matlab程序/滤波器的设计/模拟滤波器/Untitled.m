clear all
close all
clc
n=0:0.01:2;
nfft=128;
Fs=44;
As=30;
Ap=0.5;

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
Wp=[0.4*pi,0.8*pi];
Ws=[0.3*pi,0.9*pi];
elseif typeo==2
Ws=[0.4*pi,0.8*pi];
Wp=[0.3*pi,0.9*pi];   
elseif typeo==3 
    Wp=0.6*pi;
    Ws=0.5*pi;
elseif typeo==4
     Wp=0.6*pi;
    Ws=0.8*pi;
end
[N,wn]=buttord(Wp/pi,Ws/pi,Ap,As);
[b,a,k]=butter(N,wn,type,'z');
[b,a]=zp2tf(b,a,k);
[h,f,s]=freqz(b,a,nfft,Fs,'whole');
s.yunits='square'
subplot(221)
plot(abs(h))
grid on
title('Butterworth�����˲���')
typeo=3;

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
Wp=[0.4*pi,0.8*pi];
Ws=[0.3*pi,0.9*pi];
elseif typeo==2
Ws=[0.4*pi,0.8*pi];
Wp=[0.3*pi,0.9*pi];   
elseif typeo==3 
    Wp=0.6*pi;
    Ws=0.5*pi;
elseif typeo==4
     Wp=0.6*pi;
    Ws=0.8*pi;
end
[N,wn]=buttord(Wp/pi,Ws/pi,Ap,As);
[b,a,k]=butter(N,wn,type,'z');
[b,a]=zp2tf(b,a,k);
[h,f,s]=freqz(b,a,nfft,Fs,'whole');
s.yunits='square'
subplot(222)
plot(abs(h))
grid on
title('Butterworth�����˲���')
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
Wp=[0.4*pi,0.8*pi];
Ws=[0.3*pi,0.9*pi];
elseif typeo==2
Ws=[0.4*pi,0.8*pi];
Wp=[0.3*pi,0.9*pi];   
elseif typeo==3 
    Wp=0.6*pi;
    Ws=0.5*pi;
elseif typeo==4
     Wp=0.6*pi;
    Ws=0.8*pi;
end
[N,wn]=buttord(Wp/pi,Ws/pi,Ap,As);
[b,a,k]=butter(N,wn,type,'z');
[b,a]=zp2tf(b,a,k);
[h,f,s]=freqz(b,a,nfft,Fs,'whole');
s.yunits='square'
subplot(223)
plot(abs(h))
grid on
title('Butterworth�����˲���')
typeo=1;

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
Wp=[0.4*pi,0.8*pi];
Ws=[0.3*pi,0.9*pi];
elseif typeo==2
Ws=[0.4*pi,0.8*pi];
Wp=[0.3*pi,0.9*pi];   
elseif typeo==3 
    Wp=0.6*pi;
    Ws=0.5*pi;
elseif typeo==4
     Wp=0.6*pi;
    Ws=0.8*pi;
end
[N,wn]=buttord(Wp/pi,Ws/pi,Ap,As);
[b,a,k]=butter(N,wn,type,'z');
[b,a]=zp2tf(b,a,k);
[h,f,s]=freqz(b,a,nfft,Fs,'whole');
s.yunits='square'
subplot(224)
plot(abs(h))
grid on
title('Butterworth�����˲���')