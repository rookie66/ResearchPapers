clc
clear all
close all
T1=0.1095;
N=41;
alpha=(N-1)/2;
l=0:N-1;wl=(2*pi/N)*l;
Hrs=[zeros(1,6),T1,ones(1,7),T1,zeros(1,11),T1 ones(1,7),T1,zeros(1,6)];
Hdr=[0 0 1 1 0 0];
wdl=[0 0.3 0.3 0.7 0.7 1];
k1=0:floor((N-1)/2);k2=floor((N-1)/2)+1:N-1;
angH=[pi/2-alpha*(2*pi)/N*(0.5+k1),-pi/2+alpha*(2*pi)/N*(N-k2-0.5)];
H=Hrs.*exp(j*angH);
h1=ifft(H,N);
n=0:N-1;
h=real(h1.*exp(j*pi*n/N));
[db,mag,pha,w]=freqz_m(h,[1]);
[Hr,ww,a,L]=Hr_Type3(h);
figure
subplot(221);plot(wl/pi+1/N,Hrs,'.',wdl,Hdr);
axis([0 1 -0.1 1.1]);
title('Bandpass')
grid
subplot(222);stem(l,h,'k')

title('impulse response')
subplot(223);plot(ww/pi,Hr,'k',wl/pi+1/N,Hrs,'.');
axis([0 1 -0.1 1.1]);
title('amplitude response')
grid
subplot(224);plot(w/pi,db,'k');
title('Magnitude response')
grid
axis([0 1 -100 10]);
[Hr,w,b,L]=Hr_Type3(h);
M=length(h);
L=(M-1)/2;
b=[2*h(L+1:-1:1)];
n=[0:L];
w=[0:500]'*2*pi/500;
Hr=sin(w*n)*b';
[db,mag,pha,w]=freqz_m(b,a);
[H,w]=freqz(b,a,1000,'whole');
H=(H(1:501))';
w=(w(1:501))';
mag=abs(H);
db=20*log10((mag+eps)/max(mag));
pha=angle(H);





