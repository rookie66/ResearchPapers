clc
clear
close all
choosetype=1;
%  1 BOXCAR;2 BARTLETT; 3 HANN;4 HAMMING; 5 BLACKMAN;
 choose=4;
 %1 lp;2 hp;3bp;4bs
switch choose
case 1    
wp=2*pi;
ws=4*pi;
s=20;
width=(ws-wp)/pi/s;
wc=(wp+ws)/2/pi/s;
case 2
 wp=4*pi;
ws=2*pi;
s=20;
width=(wp-ws)/pi/s;
  wc=0.5-(wp+ws)/2/pi/s;
case 3
    wsl=2*pi;
    wsh=12*pi;
    wpl=4*pi;
    wph=8*pi;
    s=25;
    wcl=(wsl+wpl)/2/pi/s;
    wch=(wsh+wph)/2/pi/s;
    F0=(wpl+wph)/2/pi/s;
   wc=(wsh+wph)/2/pi/s-F0;
    width=min((wpl-wsl),(wsh-wph))/pi/s;
case 4
    wpl=2*pi;
    wph=8*pi;
    wsl=4*pi;
    wsh=6*pi;
    s=10;
    wcl=(wsl+wpl)/2/s;
    wch=(wsh+wph)/2/s;
    F0=(wsl+wsh)/2/pi/s;
    wc=(wsh+wph)/2/pi/s-F0;
    width=min((wsl-wpl),(wph-wsh))/pi/s;
end


switch choosetype
       case 1
         N=13;
        type=BOXCAR(N); 
        titl='BOXCAR';
        f=abs(fft(type,1024));
         f=10*log(f);
         
        case 2
        N=31;
        type=BARTLETT(N);
        titl='BARTLETT';
        f=abs(fft(type,1024));
         f=10*log(f);
        case 5
        N=ceil(5.71/width);
        type=BLACKMAN(N);
        titl='BLACKMAN';
        f=abs(fft(type,1024));
         f=10*log(f);     
        case 4
         N=ceil(3.47/width);
        type=HAMMING(N);
        titl='HAMMING';
        f=abs(fft(type,1024));
         f=10*log(f);   
        case 3
             N=ceil(3.21/width)+1;
        type=HANN(N);
        titl='HANN';
         f=abs(fft(type,1024));
         f=10*log(f);        
end

window=type.';
n=0:N-1;
tao=(N-1)/2;
switch choose
case 1
hd= 2*wc*sinc(2*wc*(n-tao));
case 2
    hd=2*wc*(-1).^(n-tao).*sinc(2*wc*(n-tao));
case 3
    hd=4*wc*sinc(2*(n-tao).*wc).*cos(2*pi*(n-tao).*F0);
case 4
%      hd=(n==tao)-4*wc*sinc(2*(n-tao).*wc).*cos(2*pi*(n-tao).*F0);
hd=sin(pi/3*(n-tao+eps))./(pi*(n-tao+eps))+sin(pi*(n-tao+eps))./(pi*(n-tao+eps))-sin(2*pi/3*(n-tao+eps))./(pi*(n-tao+eps));
end
h=hd.*window;
H=abs(fft(h,1024));
mag=abs(H);
db=20*log10((mag+eps)/max(mag));
% figure
% subplot(211)
% stem(type)
% grid on
% subplot(212)
% plot(f)
% grid on
figure
plot([0:1023]/1024,db)
grid on
title(titl);
