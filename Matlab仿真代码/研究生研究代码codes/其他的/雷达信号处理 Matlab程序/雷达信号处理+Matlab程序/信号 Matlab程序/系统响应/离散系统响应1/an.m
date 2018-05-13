clc
clear all
close all
syms t n k k1 k2 ;
A=1;  %y[n]
B=-0.6;%y[n-1]
C=0;%y[n-2]
a=0.4;
i1=10;
i2=0;
Am=1;
xt1=Am*a^n;

y1='A+B/t+C/(t^2)=0';
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

y2=sym('A*c*a^n+B*c*a^n/a+C*c*a^n/a^2');
f=subs(y2);
f1=sym('f/xt1=1');
f=subs(f1);
f=char(f);
c=solve(f);
yf=sym('c*xt1');
yf=subs(yf);
yf=char(yf)

y=yn+yf;
yzi=yn;

f1='y=i1';
fi1='yzi=i1';
n=-1;
f1=subs(f1);
f1=subs(f1);
f1=char(f1);
fi1=subs(fi1);
fi1=subs(fi1);
fi1=char(fi1);

f2='y=i2';
fi2='yzi=i2';
n=-2;
f2=subs(f2);
f2=subs(f2);
f2=char(f2);
fi2=subs(fi2);
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
syms n
yn=subs(yn);
yn=char(yn)
if C~=0
k1=ki1;
k2=ki2;
else k=ki1;
end
yzi=subs(yzi)
y='yf+yn';
yzs='y-yzi';
y=subs(sym(y))
yzs=subs(sym(yzs))



n=0.1:0.1:10;
yf=subs(sym(yf));
yn=subs(sym(yn));
yzi=subs(sym(yzi));
yzs=subs(sym(yzs));
y=subs(sym(y));

figure
subplot(2,3,1)
plot(n,y.*n./n);
title('全响应')
subplot(2,3,2)
plot(n,yf.*n./n);
title('受迫响应')
subplot(2,3,3)
plot(n,yn.*n./n);
title('自然响应')
subplot(2,3,4)
plot(n,yzi.*n./n);
title('零输入响应')
subplot(2,3,5)
plot(n,yzs.*n./n);
title('零状态响应')
   
