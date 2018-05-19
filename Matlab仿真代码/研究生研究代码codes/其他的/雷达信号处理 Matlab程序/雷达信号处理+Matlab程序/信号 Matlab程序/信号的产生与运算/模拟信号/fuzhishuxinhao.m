A=1;
w=pi/3;
theta=0.1;
angle=theta+j*w;
t1=-10;
t2=10;
t=t1:0.01:t2;
x=A*exp(angle*t);
x_real=real(x);
x_imag=imag(x);
x_magnitude=abs(x);
% x_phase=(180/pi)*angle(x);
subplot(221),plot(t,x_real);grid on
subplot(222),plot(t,x_imag);grid on
subplot(223),plot(t,x_magnitude);grid on
% subplot(224),plot(t,x_phase);grid on




