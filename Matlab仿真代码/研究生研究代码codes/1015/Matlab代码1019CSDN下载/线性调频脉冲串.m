close all;clear all;clc;
x=-4:0.1:4;          %shijian
y=-2:0.1:2;          %pinlv
[X,Y]=meshgrid(x,y);
%%%%%%%canshu sheji%%%%%%%%%%%%%
N=5;                %zimaichong geshu
T=0.2;                 %zimaichong kuandu
K=2;            %pinlv bujin liang
Tr=0.8;                 %maijian kuandu
Z=zeros(size(X));
d=pi*Y*Tr+eps;
for p=-(N-1):(N-1)
    ss=abs(X-p*Tr);
    b=zeros(size(ss));
    c=zeros(size(ss));
   [m,n]=size(ss);
   for i=1:m
       for j=1:n
           if ss(i,j)>T
              c(i,j)=0;
           else
               b(i,j)=pi*(Y(i,j)+K*X(i,j))*(T-ss(i,j))+eps;
                 c(i,j)=((sin(b(i,j))*(T-ss(i,j)))/(T*b(i,j)));
                 
           end
       end
   end

 f=sin((N-abs(p))*d);
  fudu=f./sin(d);
Z=Z+abs(fudu).*abs(c);
end
Z=Z/N;

surf(X,Y,Z)