%ÖÜÆÚº¯Êý
a1=2;
a2=3;
a3=2.5;
b1=2/3;
b2=1/2;
b3=1/3;
t=-40:0.001:40;
x1=a1*sin(b1*pi*t);
x2=a2*sin(b2*pi*t);
x3=a3*sin(b3*t);
x4=x1+x2+x3;
c1=2*pi/(b1*pi);
c2=2*pi/(b2*pi);
c3=2*pi/(b3*pi);
for i=1:1000
    if (mod(i,c1)|mod(i,c2)|mod(i,c3))
        i=i;
    else 
        break;
    end
end
a=i;
figure,plot(t,x1);grid on
figure,plot(t,x2);grid on
figure,plot(t,x3);grid on
figure,plot(t,x4);grid on
a