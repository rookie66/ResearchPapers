clc
clear all
close all
T1=0.1095;
T2=0.598;
N=61;
alpha=(N-1)/2;
l=0:N-1;wl=(2*pi/N)*l;
Hrs=[zeros(1,22),T1,T2,ones(1,14),T2,T1,zeros(1,21)];
Hdr=[0 0 1 1];
wdl=[0  21.5/N 24/N 0.5];
angH=-pi*l.*(N-1)/N;
Hdk=Hrs.*exp(j*angH);
h1=ifft(Hdk,N);
h2=fft(h1,1024);
h3=fft(h1.*hann(length(h1)).',1024);
figure
plot([0:N-1]/N,Hrs,'pr',wdl,Hdr);
title('lowpass')
hold on;plot([0:1023]/1024,abs(h3),'k');
title('Magnitude response')
hold on
plot([0:1023]/1024,abs(h2),'m');
grid on
axis([0 0.5 -0.1 1.1]);






