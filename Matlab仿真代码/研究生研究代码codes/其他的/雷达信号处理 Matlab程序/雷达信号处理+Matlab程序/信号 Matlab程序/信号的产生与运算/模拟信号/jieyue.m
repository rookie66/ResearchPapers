%½×Ô¾º¯Êý
t0=0;
t1=-10;
t2=10;
t=t1:0.001:t2;
x=(t-t0)>=0;
plot(t,x,'r-'),axis([t1 t2 -0.5 1.5]);
xlabel('t');ylabel('x');title('step signal');
grid on


