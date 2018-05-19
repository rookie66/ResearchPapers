clc
clear all
close all
T1=0.5925;
T2=0.1399;
N=36;%wpl=0.35pi,wph=0.65pi,wsl=0.25pi,wsh=0.75pi,Apl=2db,Aph=2db,Asl=20db,Ash=20db
     %k=N*w/2pi 
alpha=(N-1)/2;
 l=0:N-1;
  Hrs=[zeros(1,6),T1,ones(1,7),T1,zeros(1,6),T1,ones(1,7),T1,zeros(1,6)];
Hdr=[0 0 1 1 0 0];
wdl=[0 6/N 6/N 14/N 14/N 0.5];
angH=-pi*l.*(N-1)/N;
H=Hrs.*exp(j*angH);
h1=ifft(H,N);
h=fft(h1,1024);
h2=fft(h1.*hann(length(h1)).',1024);
figure
plot([0:(N-1)]/N,Hrs,'pr');
axis([0 1 -0.1 1.1]);
title('Bandpass')
grid
hold on
plot([0:1023]/1024,abs(h2),'k');
axis([0 0.5 -0.1 1.1]);
title('amplitude response')
hold on
plot(wdl,Hdr)
hold on
plot([0:1023]/1024,abs(h),'m')







