%目标信号为chirp signal f0=7000,B=1750,T=0.5845,fs=4*f0;
%滤波器，噪声的功率改成dbHz
%直方图做法：
clc
clear all
close all
%常量设置
f0=7000;
B=1750;
ts=0.5;
fl=f0-B/2;
fh=f0+B/2;
beita=B/ts;
fs=4*f0;

alfa=80*pi/180;
alf=30*pi/180;
point=ts*fs+1;
t=-1*ts/2:1/fs:ts/2;
S=sqrt(ts/fs);
dx=sqrt(ts*fs);
tt=-1*dx/2:1/dx:dx/2;%归一化之后的数据

snr1=15;
snr2=15;
%滤波器
% b=fir1(256,[(fl-B/2)/(fs/2),(fh+B/2)/(fs/2)]);

        signal11=exp(i*2*pi*(f0-B/2)*tt*S+i*pi*(B/ts)*tt.*tt*S*S);
        signal10=chirp(t,fl,ts,fh);%方位80度
        signal20=chirp(t,7000,ts,7500);%方位30度
        noise=normrnd(0,1,1,point);
        nx=normrnd(0,1,1,point);
        ny=normrnd(0,1,1,point);
        %  信噪比db/Hz
        b1=10^(snr1/10); 
        n1=sqrt(b1);
%         a1=std(signal);
%         a2=std(noise)*B/fs;
b2=10^(snr2/10);       
n2=sqrt(b2);    
        signal1=n1*signal10;
        signal2=n2*signal20;
        signal=signal1+signal2;
        
        p=signal+noise;
        vx=signal1*cos(alfa)+signal2*cos(alf)+nx;
        vy=signal1*sin(alfa)+signal2*sin(alf)+ny;
        p11=signal11+noise;
        vx11=signal11*cos(alfa)+nx;
        vy11=signal11*sin(alfa)+nx;

        
%         %通过滤波器
%         p1=conv(b,p); 
%         p2=p1(129:1:point+128); 
% 
%         vx=signal1*cos(alfa)+nx;
%         vx1=conv(b,vx);
%         vx2=vx1(129:1:point+128);
% 
%         vy=signal1*sin(alfa)+ny;
%         vy1=conv(b,vy);
%         vy2=vy1(129:1:point+128);

        p3=fft(p);
        vx3=fft(vx);
        vy3=fft(vy);
%         
%         pvy=real(p3.*conj(vy3));
%         pvx=real(p3.*conj(vx3));
%         alfa1=atan(pvy./pvx)*180/pi;
       a=atan(-1/(S*S*B/ts))*2/pi;
        p31=frft(p11,a);
        vx31=frft(vx11,a);
        vy31=frft(vy11,a);
 
        pvy=real(p3.*conj(vy3));
        pvx=real(p3.*conj(vx3));
        alfa1=atan(pvy./pvx)*180/pi;
%         pvy31=real(p31.*conj(vy31));
%         pvx31=real(p31.*conj(vx31));
%         alfa1=atan(pvy31./pvx31)*180/pi;
  fai=zeros(1,181);
  for ka=1:length(alfa1) 
      
      for k=1:181
        if(abs(alfa1(ka)-k+90)<0.5)
            fai(k)=fai(k)+abs(p3(ka));
        end
      end
  end
  
jiao=[-90:1:90];
plot(jiao,fai);  

% error=abs(alfa2-alfa)*180/pi;
% errorlog=log10(error);
% plot(snr,error,'*');