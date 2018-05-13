t=-2:0.001:2;
tao=0.5
x=(1/tao)*exp(-pi*((t/tao).^2));
plot(t,x)
grid on
xlabel('t');
ylabel('x(t)');
title('(1/tao)*exp(-pi*(t/tao)^2)')