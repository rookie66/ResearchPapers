clear all
close all
clc
n=0:0.1:60;
Rp=0.4;
Rs=22;
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
fp=[40 80];
fs=[30 90];
elseif typeo==2
fs=[40 80];
fp=[30 90];   
elseif typeo==3 
    fp=60;
    fs=50;
elseif typeo==4
     fp=60;
    fs=80;
end
[N,Wn]=ellipord(fp/pi,fs/pi,Rp,Rs,'s');
[b,a,k]=ellip(N,Rp,Rs,Wn,type,'s');
[b,a]=zp2tf(b,a,k);
[H,w]=freqs(b,a,n);
H1=(abs(H));
H2=db(H1);
b=find(w==fp(1));
Ap1=H2(b)
b=find(w==fs(1));
As1=H2(b)
subplot(211)
plot(w,H1)
xlabel('w');
ylabel('|H(jw)^2|')
title('ellipse�˲���')
grid
subplot(212)
plot(w,angle(H))
grid
xlabel('w');
ylabel('phase')