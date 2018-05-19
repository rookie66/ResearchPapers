clear all
close all
clc
nfft=256;

Rp=0.1;
Rs=50;
typeo=2;
% switch typeo
% case 1
%     type='bandpass';
% case 2
%     type='stop';
% case 3
%     type='high';
% case 4
%     type='low';
% end
  

if typeo==1
 Fs=1000;
Wp1=2*100*pi;
Ws1=2*50*pi;
Wp2=2*200*pi;
Ws2=2*250*pi;
Wp=[Wp1,Wp2];
Ws=[Ws1,Ws2];
elseif typeo==2
 Fs=1500;   
 Ws1=400*pi;
Wp1=300*pi;
Ws2=500*pi;
Wp2=600*pi;
Wp=[Wp1,Wp2];
Ws=[Ws1,Ws2];
   
elseif typeo==3
    Fs=1000;   
Wp1=200*2*pi;
Ws1=100*2*pi;
Wp2=0;
Wp=Wp1;
Ws2=0;
Ws=Ws1;
elseif typeo==4
 Fs=5000;
Wp1=1000*2*pi;
Ws1=1500*2*pi;
Wp2=0;
Wp=Wp1;
Ws2=0;
Ws=Ws1;
end
[N,wn]=cheb1ord(Wp,Ws,Rp,Rs,'s');
[b,a,k]=cheb1ap(N,Rp); 
[A,B,C,D]=zp2ss(b,a,k);
Wn=Wp2-Wp1;
Wo=sqrt(Wp2*Wp1);
switch typeo
case 1
   [A,B,C,D]=lp2bp(A,B,C,D,Wo,Wn);% type='带通';
case 2
    [A,B,C,D]=lp2bs(A,B,C,D,Wo,Wn);%type='带阻';
case 3
    [A,B,C,D]=lp2hp(A,B,C,D,wn);%type='高通';
case 4
    [A,B,C,D]=lp2lp(A,B,C,D,wn);%type='底通';
end
[b,a]=ss2tf(A,B,C,D);
if typeo==2|typeo==3
[b,a]=bilinear(b,a,Fs);
else [b,a]=impinvar(b,a,Fs);
end
[H,w]=freqz(b,a,nfft,Fs);
plot(w*Fs/(2*pi),abs(H));
grid on
xlabel('frequency/Hz')
ylabel('magnitude')
title('ChebyI数字滤波器')


