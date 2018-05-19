%sincº¯Êý
t1=-10;
t2=10;
t=t1:0.01:t2;
r=pi.*t;
b=sin(r)./(r);
plot(t,b,'b-')
grid on