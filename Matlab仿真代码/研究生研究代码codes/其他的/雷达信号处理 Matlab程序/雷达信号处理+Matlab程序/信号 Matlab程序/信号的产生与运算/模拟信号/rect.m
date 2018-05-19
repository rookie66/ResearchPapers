%¾ØÐÎº¯Êý
function  x=rect(t)
t=-10;t0=0;
tao=4;
t1=-10;
t2=10;
t=t1:0.001:t2;
x=[abs(t-t0)<=(tao/2)];
plot(t,x,'r-'),axis([t1 t2 -0.5 1.5]);
xlabel('t');ylabel('rect(t)');title('rect signal');
grid on