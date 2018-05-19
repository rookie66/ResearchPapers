clear all;
close all;
 c1=128;
 n1=100 ; 
 Fs=10;
 MM=16;
 NN=1:.1:10;%CCDF的门限值
 ccdf0=zeros(1,91);
 ccdf1=ccdf0;
 for i=1:n1; 
 x(:,1)=randsrc(c1,1,[+1 -1 +3 -3]);
 x(:,2)=randsrc(c1,1,[+1 -1 +3 -3]);
 y1=squeeze(x);
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=ammod(y1,Fs,'qam');    %qam modulated information
y2=a.';
z1=[y2(1:c1/2),zeros(1,3*c1),y2(c1/2+1:c1)];
w1=ifft(z1);
w1=w1*c1;
x1=(abs(w1)).^2;
m1=mean(x1);
v1=max(x1);
papr0(i)=10*log10(v1/m1);
for k=1:MM;    %slm的循环次数
 p=randsrc(1,c1,[+1,-1,+j,-j]);
 y3=y2.*p;
z2=[y3(1:c1/2),zeros(1,3*c1),y3(c1/2+1:c1)]; 
 w2=ifft(z2);
w2=w2*c1;
x2=(abs(w2)).^2;
m2=mean(x2);
v2=max(x2);
papr3(i,k)=10*log10(v2/m2);
papr1(k)=10*log10(v2/m2);
end
papr2(i)=min(papr1);
for l=1:91;
if papr0(i)>NN(l);
    ccdf0(l)=ccdf0(l)+1;
end  
if papr2(i)>NN(l);
    ccdf1(l)=ccdf1(l)+1;
end
end
end
ccdf2=ccdf0;
ccdf3=ccdf1;
 NN=1:.1:10;
plot(NN,ccdf2,'r',NN,ccdf3,'b')
 title('SLM方法的CCDF曲线')
xlabel('papr(dB)'),
ylabel('ccdf')
legend('原来','SLM后',2)