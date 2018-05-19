clc
clear all
close all
T1=0.1095;
N=41;
alpha=(N-1)/2;
l=0:N-1;wl=(2*pi/N)*l;
Hrs=[ones(1,6),T1,zeros(1,7),T1,ones(1,11),T1 zeros(1,7),T1,ones(1,6)];
Hdr=[1 1 0 0 1 1];
wdl=[0 6/N 6/N 14/N 14/N 0.5];
k1=0:floor((N-1)/2);k2=floor((N-1)/2)+1:N-1;
angH=-pi*l.*(N-1)/N;
H=Hrs.*exp(j*angH);
h1=ifft(H,N);
h2=fft(h1.*hann(length(h1)).',1024);
h3=fft(h1,1024);
figure
plot([0:N-1]/N,Hrs,'pk',wdl,Hdr);
title('lowpass')
hold on;plot([0:1023]/1024,abs(h2),'k');
hold on;plot([0:1023]/1024,abs(h3),'m');
title('Magnitude response')
grid on
axis([0 0.5 -0.1 1.1]);

