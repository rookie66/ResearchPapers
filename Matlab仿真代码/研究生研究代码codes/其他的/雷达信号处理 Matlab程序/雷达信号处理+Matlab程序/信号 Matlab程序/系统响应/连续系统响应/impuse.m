clc
clear
syms t;

taxis=4;
yaxis=0.5;
A=1;
B=3;
C=2;
if A==0
i1=1;  % y(0)=i1
i2=0;  % Dy(0)=i2
else 
    i1=0;
    i2=1;
end
xt1=0;

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
y=dsolve(f,ini1,ini2);
else
    y=dsolve(f,ini1);
end

y=subs(y)

t=0:0.01:8;
y=subs(y);
figure,plot(t,y);
title('y*u(t)');
grid
