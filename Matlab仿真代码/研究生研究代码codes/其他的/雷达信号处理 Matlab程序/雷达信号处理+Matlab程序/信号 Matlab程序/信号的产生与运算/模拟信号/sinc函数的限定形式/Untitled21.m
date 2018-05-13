%(1/tao)*sinc(t/tao)^2
A=8;
tao=0.1;
t=-A:0.001:A;
x=(1/tao)*((sinc(t./tao)).^2);
plot(t,x)
grid on