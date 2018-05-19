clc
clear all
close all
T1=0;
T2=0.5925;
N=60;
alpha=(N-1)/2;
l=0:N-1;
Hrs=[ones(1,7),T2,T1,zeros(1,43),T1,T2,ones(1,6)];
Hdr=[1 1 0 0];
wdl=[0 6/N 8/N 0.5];
k1=0:floor((N-1)/2);k2=floor((N-1)/2)+1:N-1;
angH=[-alpha*(2*pi)/N*(k1),alpha*(2*pi)/N*(N-k2)];
Hdk=Hrs.*exp(j*angH);
h=ifft(Hdk,N);
h2=fft(h,1024);
h3=fft(h.*hann(length(h)).',1024);
figure
plot([0:N-1]/N,Hrs,'pr',wdl,Hdr);
title('lowpass')
hold on;plot([0:1023]/1024,abs(h2),'r');
hold on;plot([0:1023]/1024,abs(h3),'k');
title('Magnitude response')
grid on
axis([0 0.5 -0.1 1.1]);






