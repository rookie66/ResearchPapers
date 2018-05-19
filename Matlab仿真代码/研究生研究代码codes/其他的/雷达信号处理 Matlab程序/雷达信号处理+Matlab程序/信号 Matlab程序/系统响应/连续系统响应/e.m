close
clc
clear all
syms x t;

A=0;
B=3;
C=2;
w=-3;
Am=4;
taxis=6;
i1=3;%y(0)
i2=4;%Dy(0)
xt1=Am*exp(w*t);

f0='A*D2y+B*Dy+C*y=0';
f0=subs(sym(f0));
f0=char(f0);
ini1='y(0)=i1';
ini1=subs(sym(ini1));
ini1=char(ini1);
ini2='Dy(0)=i2';
ini2=subs(sym(ini2));
ini2=char(ini2);
if i2~=0&A~=0
yzi=dsolve(f0,ini1,ini2);
else
    yzi=dsolve(f0,ini1);
end

yzi=subs(yzi)

yy=A*x^2+B*x+C;
x=solve(yy);
n=size(x,1);
if n==2
  if x(1)~=x(2)& (w==x(1)|w==x(2))
    yf1='k*t*xt1';
   else if x(1)==x(2)&w==x(1)
         yf1='k*t^2*xt1';
         else yf1='k*xt1';
         end
     end
 else if n==1&w==x
       yf1='k*t*xt1';
   else yf1='k*xt1';         
 end
end

funca=sym(yf1);
funca=subs(funca);
y1=A*diff(funca,'t',2)+B*diff(funca,'t',1)+C*funca;
b='y1=xt1';
b=subs(sym(b));
b=char(b);
k=solve(b,'k');
yf=subs(funca)


f='A*D2y+B*Dy+C*y=xt1';
f=subs(sym(f));
f=char(f);
ini1='y(0)=i1';
ini1=subs(sym(ini1));
ini1=char(ini1);
ini2='Dy(0)=i2';
ini2=subs(sym(ini2));
ini2=char(ini2);
if A~=0
y=dsolve(f,ini1,ini2)
else y=dsolve(f,ini1)
end 

yn=y-yf


yzs=y-yzi


figure
t=0:0.01:8;
y=subs(y);subplot(2,3,1)
plot(t,y);
title('全响应')
subplot(2,3,2)
yf=subs(yf);
plot(t,yf);
title('受迫响应')
subplot(2,3,3)
yn=subs(yn);
plot(t,yn);
title('自然响应')
subplot(2,3,4)
yzi=subs(yzi);
plot(t,yzi);
title('零输入响应')
subplot(2,3,5)
yzs=subs(yzs);
plot(t,yzs);
title('零状态响应')