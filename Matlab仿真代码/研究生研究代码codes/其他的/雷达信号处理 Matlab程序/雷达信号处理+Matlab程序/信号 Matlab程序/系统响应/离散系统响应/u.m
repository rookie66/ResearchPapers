clc
clear all
close all
syms t n k k1 k2 ;
A=1;
B=-1;
C=-2;
cons=6;
m1=n;
Am1=2;%Am1*x[n]
m2=n-1;
Am2=-1;%Am2*x[n-1]
m3=n+1;
Am3=0;%Am3*x[n+1]

i1=-1;
i2=4;
xt1=cons;

y1='A+B/t+C/t^2=0';
f=subs(sym(y1));
f=char(f);
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

y2=sym('A*yf+B*yf+C*yf=xt1');
f=subs(y2);
f=char(f);
yf=solve(f);
yff=yf;
yf=yff*'u(t)'
yf=char(yff);

y=yn+yf;
yzi=yn;

f1='y=i1';
fi1='yzi=i1';
n=-1;
f1=subs(sym(f1));
f1=subs(f1);
f1=char(f1);
fi1=subs(sym(fi1));
fi1=subs(fi1);
fi1=char(fi1);

f2='y=i2';
fi2='yzi=i2';
n=-2;
f2=subs(sym(f2));
f2=subs(f2);
f2=char(f2);
fi2=subs(sym(fi2));
fi2=subs(fi2);
fi2=char(fi2);

if C~=0
s=solve(f1,f2,'k1','k2');
s1=solve(fi1,fi2,'k1','k2');

k1=s.k1;
k2=s.k2;
ki1=s1.k1;
ki2=s1.k2;
else 
    k=solve(f1);
    ki1=solve(fi1);
end
syms n;
yn=subs(sym(yn));
yn=char(yn);
if C~=0
k1=ki1;
k2=ki2;
else k=ki1;
end
yzi=subs(yzi);
yzi=char(yzi);
yzii=yzi;
y='yf+yn';
yzs='y-yzi';
y=subs(sym(y));
y=char(y);
yy=y;
yzs=subs(sym(yzs));
yzs=char(yzs);

yyzi=inline(yzi,'n');
yyzs=inline(yzs,'n');
yzi=yyzi;
yzs=yyzs;


yzi=yzi(m1)*'u(m1)';
yzs=Am1*yzs(m1)*'u(m1)'+Am2*yzs(m2)*'u(m2)'+Am3*yzs(m3)*'u(m3)';
y=yzi+yzs;
y=subs(sym(y))
yzi=subs(sym(yzi))
yzs=subs(sym(yzs))

yzs1=Am1*yyzs(m1)+Am3*yyzs(m3);
yzs2=yzs1+Am2*yyzs(m2);
n=0:0.1:0.9;
yzs=subs(sym(yzs1));
m=zeros(1,91);
ymzs1=[yzs,m];
n=1:0.1:10;
yzs=subs(sym(yzs2));
m=zeros(1,10);
ymzs2=[m,yzs];
yzs=ymzs1+ymzs2;
n=0:0.1:10;
figure
yzi=subs(yzii);
yf=subs(yf);
yn=subs(yn);
y=subs(yy);
subplot(2,3,1)
plot(n,y);
title('全响应')
subplot(2,3,2)
plot(n,yf);
title('受迫响应')
subplot(2,3,3)
plot(n,yn);
title('自然响应')
subplot(2,3,4)
plot(n,yzi);
title('零输入响应')
subplot(2,3,5)
plot(n,yzs);
title('零状态响应')
   
