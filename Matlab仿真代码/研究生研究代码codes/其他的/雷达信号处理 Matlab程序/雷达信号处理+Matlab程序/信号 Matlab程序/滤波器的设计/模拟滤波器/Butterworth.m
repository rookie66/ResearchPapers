clear all
close all
clc
n=0:0.1:100;

As=50;
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
fp=[40,80];
fs=[30,90];
elseif typeo==2
fs=[40,80];
fp=[30,90];   
elseif typeo==3 
    fp=60;
    fs=50;
elseif typeo==4
     fp=60;
    fs=70;
end
[N,wn]=buttord(fp,fs,Ap,As,'s');
[b,a,k]=butter(N,wn,type,'s');
[b,a]=zp2tf(b,a,k);
[H,w]=freqs(b,a,n);
H1=abs(H);
H2=20*log10((H1+eps)/max(H1));
b=find(w==fp);
Ap1=H2(b)
b=find(w==fs);
As1=H2(b)
% subplot(211)
plot(w,H1)
xlabel('f');
ylabel('|H(jw)|')
title('ButterworthÂË²¨Æ÷')
grid
% subplot(212)
% plot(w,angle(H))
% grid
% xlabel('f');
% ylabel('phase')
