t=-2:0.001:2;
tao=0.05
x=(2/tao)*exp(-abs(t)/tao);
plot(t,x)
grid on
xlabel('t');
ylabel('x(t)');
title('(2/tao)*exp(-abs(t)/tao)')