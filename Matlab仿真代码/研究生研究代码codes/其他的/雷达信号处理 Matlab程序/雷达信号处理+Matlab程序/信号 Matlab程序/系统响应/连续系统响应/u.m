clc
clear
syms t;

taxis=6;
yaxis=10;
A=0;
B=3;
C=3;
i1=0;
i2=0;
cons=3;
xt1=cons;

f0='A*D2y+B*Dy+C*y=0';
f0=subs(sym(f0));
f0=char(f0);
ini1='y(0)=i1';
ini1=subs(sym(ini1));
ini1=char(ini1);
ini2='Dy(0)=i2';
ini2=subs(sym(ini2));
ini2=char(ini2);
if A~=0
yzi=dsolve(f0,ini1,ini2);
else
    yzi=dsolve(f0,ini1);
end

yzi=subs(yzi)

funca1=sym('k');
x1=A*diff(funca1,'t',2)+B*diff(funca1,'t',1)+C*funca1;
b='x1=cons';
b=subs(sym(b));
b=char(b);
k=solve(b,'k');
yf=subs(funca1)


f='A*D2y+B*Dy+C*y=xt1';
f=subs(sym(f));
f=char(f);
ini1='y(0)=i1';
ini1=subs(sym(ini1));
ini1=char(ini1);
ini2='Dy(0)=i2';
ini2=char(subs(ini2));
ini2=char(ini2);
if A~=0
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
