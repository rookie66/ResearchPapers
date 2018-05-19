clear all; close all; 
c1=128; n1=10000;  
Fs=100; MM=1:.1:13;    %  CCDF的门限值 
M = 16;
ccdf1=zeros(1,121); 
ccdf2=zeros(1,121); 
for i=1:n1;     
    x(:,1)=randsrc(c1,1,[+1 -1 +3 -3]);    
    x(:,2)=randsrc(c1,1,[+1 -1 +3 -3]);    
    y1=squeeze(x);     
    y = modulate(modem.qammod(M),y1); %  QAM modulated information     
    y2=a.';     
    z1=[y2(1:c1/2),zeros(1,3*c1),y2(c1/2+1:c1)];  % 4 oversample     
    w1=ifft(z1);                
    w1=w1*c1;   
    x2=(abs(w1)).^2;    
    m1=mean(x2);     
    v1=max(x2);     
    papr(i)=10*log10(v1/m1);     
    y3=abs(w1);     
    CR=1.4;     
    A=CR*sqrt(2)*std(w1);       %  CR=Amax/sqrt(Pin);  Pin:the input power of the ofdm signal before clipping      
    w2=w1;     
    for h=1:4*c1;         
        if y3(h)>A            
            w2(h)=A*w1(h)/y3(h);         
        end
    end
    x3=(abs(w2)).^2;     
    m2=mean(x3);     
    v2=max(x3);     
    papr0(i)=10*log10(v2/m2);     
    for j=1:121;         
        if papr(i)>MM(j);            
            ccdf1(j)=ccdf1(j)+1;        
        end
        if papr0(i)>MM(j);           
            ccdf2(j)=ccdf2(j)+1;         
        end
    end
end
[c,d]=butter(6,0.5); 
w3=filter(c,d,w2);
MM=1:.1:13; 
ccdf0=ccdf1./n1; 
ccdf3=ccdf2./n1; 
semilogy(MM,ccdf0,'b',MM,ccdf3,'r'); 
xlabel('PAPR门限值/dB');ylabel('CCDF') 
legend('clipping前','clipping后',2); 
title('clipping的CCDF曲线比较'); grid on