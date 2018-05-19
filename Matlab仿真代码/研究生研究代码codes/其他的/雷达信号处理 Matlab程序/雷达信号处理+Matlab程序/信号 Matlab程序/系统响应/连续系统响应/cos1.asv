clc
close
clear
syms t;
Am=1;
omega=2;
beta=0;
A=1;
B=1;
C=2;
i1=1;
i2=2;
xt1=Am*cos(omega*t+beta);

f0='A*D2y+B*Dy+C*y=0';
f0=subs(sym(f0));
f0=char(f0)
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

funca1=sym('k1*cos(omega*t)+k2*sin(omega*t)');
funca1=subs(funca1);
x1=A*diff(funca1,'t',2)+B*diff(funca1,'t',1)+C*funca1;
b='x1=xt1';
b=subs(sym(b));
b=char(b);
ff1=subs(b,t,0);
ff2=subs(b,t,pi/2/omega);
s=solve(ff1,ff2,'k1','k2');
k1=s.k1;
k2=s.k2;
yf=subs(funca1)

f='A*D2y+B*Dy+C*y=xt1';
f=char(subs(f));
ini1='y(0)=i1';
ini1=subs(sym(ini1));
ini1=char(ini1);
ini2='Dy(0)=i2';
ini2=subs(sym(ini2));
ini2=char(ini2);
if i2~=0&A~=0
y=dsolve(f,ini1,ini2);
else y=dsolve(f,ini1);
end
y=subs(y)
 
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

