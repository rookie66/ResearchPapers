clear all;
clc;
A=2;
t1=-8:0.001:-A;
x1=zeros(1,length(t1));
t2=-A:0.001:A;
x2=stepfun(t2,-A);
t3=A:0.001:8;
x3=zeros(1,length(t3));
t=[t1 t2 t3];
x=[x1 x2 x3];
plot(t,x);
%%%%%%%%%%%%%����%%%%%%%%%%%%%%%
n1=-8:-A;
xn1=zeros(1,length(n1));
n2=-A:A;
xn2=stepfun(n2,-A);
n3=A:8;
xn3=zeros(1,length(n3));
n=[n1 n2 n3];
xn=[xn1 xn2 xn3];
figure,stem(n,xn);
k=0:63;
X=xn*exp(-j*2*pi/64).^(n'*k);
magX=abs(X);
figure,stem(k,fftshift(magX));
