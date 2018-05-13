function [db]=FIRwin(a,b)
choosetype=a;
%1 BARTLETT;2 BLACKMAN; 3 BOXCAR;4 CHEBWIN;5 HAMMING; 6HANN; 7 KAISER; 8 TRIANG
 choose=b;
 %1 lp;2 hp;3bp;4bs
switch choose
case 1    
wp=0.2*pi;
ws=0.4*pi;
width=ws-wp;
wc=(wp+ws)/2;
case 2
 wp=0.4*pi;
ws=0.2*pi;
 width=wp-ws;
 wc=(wp+ws)/2;
case 3
    wsl=0.2*pi;
    wsh=0.8*pi;
    wpl=0.4*pi;
    wph=0.6*pi;
    wcl=(wsl+wpl)/2;
    wch=(wsh+wph)/2;
    width=min((wpl-wsl),(wsh-wpl));
case 4
    wpl=0.2*pi;
    wph=0.8*pi;
    wsl=0.4*pi;
    wsh=0.6*pi;
    wcl=(wsl+wpl)/2;
    wch=(wsh+wph)/2;
    width=min((wsl-wpl),(wph-wsh));
end

N=ceil(6.2*pi/width)+1;
switch choosetype
    case 1
        type=BARTLETT(N);
        titl='BARTLETT';
        wvtool(type);
    case 2
        type=BLACKMAN(N);
        titl='BLACKMAN';
        wvtool(type);
     case 3
        type=BOXCAR(N); 
        titl='BOXCAR';
        wvtool(type);
    case 4
            r=100;
        type=CHEBWIN(N,r);   
        wvtool(type);
        titl='CHEBWIN';
         case 5
        type=HAMMING(N);
        titl='HAMMING';
        wvtool(type);
        case 6
        type=HANN(N);
        titl='HANN';
        wvtool(type);
        case 7
            beta=2.5;
            titl='KAISER';
        type=KAISER(N,beta); 
        wvtool(type);
         case 8
        type=TRIANG(N); 
        titl='TRIANG';
        wvtool(type);
   
end

window=(type)';
n=0:N-1;
tao=(N-1)/2;
switch choose
 case 1
hd=sin(wc*(n-tao))./(pi*(n-tao));
case 2
    hd=[sin(pi*(n-tao))-sin(wc*(n-tao))]./(pi*(n-tao));
case 3
    hd=[sin(wch*(n-tao))-sin(wcl*(n-tao))]./(pi*(n-tao));
case 4
    hd=[sin(wcl*(n-tao))-sin(wch*(n-tao))+sin(pi*(n-tao))]./(pi*(n-tao));
end
h=hd.*window;
[H,w]=freqz(h,[1]);
H=(H(1:501))';
w=(w(1:501))';
mag=abs(H);
db=20*log10((mag+eps)/max(mag));
plot(w/pi,db);
grid
title(titl);