clc
clear all
close all
syms t n k k1 k2 ;
A=1;
B=-1/6;
C=-1/6;

if (A+B+C)~=0
cons=4;
i1=0;
i2=12;
xt1=cons;

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

y2=sym('A*yf+B*yf+C*yf=xt1');
f=subs(y2);
f=char(f);
yf=solve(f);
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



n=0:0.1:10;
yf=subs(sym(yf));
yn=subs(sym(yn));
yzi=subs(sym(yzi));
yzs=subs(sym(yzs));
y=subs(sym(y));

figure
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
else disp('注意：A+B+C不能等于零')
end
