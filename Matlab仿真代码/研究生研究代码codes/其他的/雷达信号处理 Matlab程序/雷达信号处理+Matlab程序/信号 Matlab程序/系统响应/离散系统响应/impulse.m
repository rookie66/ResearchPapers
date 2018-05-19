clc
clear all
close all
syms t n k k1 k2 ;
A=1;  %y[n]
B=-0.6;%y[n-1]
C=0;%y[n-2]
xt1=0;
m1=n;
Am1=4;
m2=n-1;
Am2=0;
m3=n+1;
Am3=0;
    
i1=1;
i2=0;


y1='A+B/t+C/t^2=0';
f=char(subs(y1));
z=solve(f);

if C~=0
    if z(1)~=z(2)&imag(z(1))==0
    yn=k1*(z(1)^n)+k2*(z(2)^n);    
elseif z(1)~=z(2)&imag(z(1))~=0
    omega=angle(double(z(1)));
    r=abs(z(1));
    yn=r^n*(k1*cos(n*omega)+k2*sin(n*omega));
elseif z(1)==z(2)&imag(z(1))==0
    yn=z(1)^n*(k1+k2*n);
elseif z(1)==z(2)&imag(z(1))~=0
    ;
end
elseif C==0
    yn=k*(z^n);
end

y=yn;


f1='y=i1';
n=0;
f1=subs(f1);
f1=subs(f1);
f1=char(f1);
f2='y=i2';
n=-1;
f2=subs(f2);
f2=subs(f2);
f2=char(f2);
if C~=0
s=solve(f1,f2,'k1','k2');
k1=s.k1;
k2=s.k2;
else 
    k=solve(f1);
end
syms n
y=subs(y);
y=char(y);
yy=inline(y,'n');
y=yy;
y=Am1*y(m1)*'u(m1)'+Am2*y(m2)*'u(m2)'+Am3*y(m3)*'u(m3)';
y=subs(sym(y))
y1=Am1*yy(m1)+Am3*yy(m3);
y2=y1+Am2*yy(m2);

n=0:0.1:0.9;
y=subs(sym(y1));
m=zeros(1,91);
ym1=[y,m];
n=1:0.1:10;
y=subs(sym(y2));
m=zeros(1,10);
ym2=[m,y];
y=ym1+ym2;
n=0:0.1:10;
plot(n,y);
title('³å»÷ÏìÓ¦')
grid