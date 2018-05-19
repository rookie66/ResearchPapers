clear all;
clc;
m=2;
i1=1:21;
x1=zeros(1,length(i1)+m*(length(i1)-1));
x=[0 0 0 0.5 1 1.5 2 2.5 3 3.5 4 3.5 3 2.5 2 1.5 1 0.5 0 0 0];
n=0:length(i1)-1;
subplot(221),stem(n,x,'k');
X=fft(x,64);
k=0:63;
subplot(223),stem(k,fftshift(abs(X)),'k');xlabel('k');
for i2=1:1:length(i1)+m*(length(i1)-1);
 if mod(i2,m+1)==1;
     x1(i2)=x(floor(i2/(m+1))+1);
 end
end
n1=0:length(i1)+m*(length(i1)-1)-1
subplot(222),stem(n1,x1,'k');
X1=fft(x1,128);
subplot(224),stem(fftshift(abs(X1)),'k');xlabel('k');
