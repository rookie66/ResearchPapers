% n1=0:4;
% x1=ones(1,length(n1));
% n2=5:14;
% x2=zeros(1,length(n2));
% n=[n1 n2];
% x=[x1 x2];
% figure(1),stem(n,x);
% X=fft(x,32);figure(2),stem(fftshift(abs(X)));
% 
% n3=0;
% x3=1;
% n4=1:2;
% x4=zeros(1,2);
% n5=3;
% x5=1;
% n6=4:5;
% x6=zeros(1,2);
% n7=6;
% x7=1;
% n8=7:8
% x8=zeros(1,2);
% n9=9;
% x9=1;
% n10=10:11;
% x10=zeros(1,2);
% n11=12;
% x11=1;
% n12=13:14;
% x12=zeros(1,2);
% n13=15:44;
% x13=zeros(1,length(n13));
% n=[n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13];
% x=[x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13];
% figure(3),stem(n,x);
% X=fft(x,128);figure(4),stem(fftshift(abs(X)));






clear all;
clc;
m=2;%mÎª²åÁãµãÊý
i1=1:15;
x1=zeros(1,length(i1)+m*(length(i1)-1));
n2=0:4;
x2=ones(1,length(n2));
n3=5:14;
x3=zeros(1,length(n3));
n=[n2 n3];
x=[x2 x3];
n=0:length(i1)-1;
subplot(221),stem(n,x);
X=fft(x,length(x));
k=0:length(x)-1;
subplot(223),stem(k,fftshift(abs(X)));xlabel('k');
for i2=1:1:length(i1)+m*(length(i1)-1);
 if mod(i2,m+1)==1;
     x1(i2)=x(floor(i2/(m+1))+1);
 end
end
n1=0:length(i1)+m*(length(i1)-1)-1
subplot(222),stem(n1,x1);
X1=fft(x1,length(x1));
subplot(224),stem(fftshift(abs(X1)));xlabel('k');


















