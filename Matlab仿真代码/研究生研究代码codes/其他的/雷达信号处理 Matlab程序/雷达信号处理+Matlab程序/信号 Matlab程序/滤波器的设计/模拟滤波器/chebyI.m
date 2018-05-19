clear all
close all
clc
n=0:0.1:150;
Rp=0.1;
Rs=10;
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
    fs=80;
end
[N,wn]=cheb1ord(fp,fs,Rp,Rs,'s');
[b,a,k]=cheby1(N,Rp,wn,type,'s');
[b,a]=zp2tf(b,a,k);
[H,w]=freqs(b,a,n);
subplot(211)
H1=abs(H);
H2=db(H1);
b=find(w==fp(1));
Ap1=H2(b)
b=find(w==fs(1));
As1=H2(b)
plot(w,H1)
xlabel('f/Hz');
ylabel('|H(jw)|')
title('ChebyIÂË²¨Æ÷')
grid
subplot(212)
plot(w,angle(H))
grid
xlabel('f/Hz');
ylabel('phase')
