%µ¥Î»Ð±ÆÂÐÅºÅ
t=-2:0.001:2;
t0=0;
u=stepfun(t,t0);
n=length(t);
for i=1:n
    u(i)=u(i)*(t(i)-t0);
end
    plot(t,u)
    axis([-2 2 -0.5 2])
    grid on
    