t=-2:0.001:2;
tao=0.05
x=tao./(pi*(t.^2+tao.^2));
plot(t,x)
grid on
xlabel('t');
ylabel('x(t)');
title('tao/(pi*(t^2+tao^2))')