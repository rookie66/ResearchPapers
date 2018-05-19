clear all
close all
clc

Rp=0.2;
Rs=40;
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
[N,wn]=ellipord(Wp/(Fs/2),Ws/(Fs/2),Rp,Rs,'s');
[b,a,k]=ellipap(N,Rp,Rs); 
Wn=Wp2-Wp1;
Wo=sqrt(Wp2*Wp1);
[b,a]=zp2tf(b,a,k);
switch typeo
case 1
   [b,a]=lp2bp(b,a,Wo,Wn); type='带通';
case 2
    [b,a]=lp2bs(b,a,Wo,Wn);type='带阻';
case 3
    [b,a]=lp2hp(b,a,wn*Fs/2);type='高通';
case 4
    [b,a]=lp2lp(b,a,wn*Fs/2);type='底通';
end
if typeo==2|typeo==3
[b,a]=bilinear(b,a,Fs);
else [b,a]=impinvar(b,a,Fs);
end
[H,w]=freqz(b,a);
plot(w*Fs/pi/2,abs(H));

grid on
xlabel('frequency/Hz')
ylabel('magnitude')
% axis([0 2*10^5 0 1.3]);
title('ellipse数字滤波器')


