A=1;
w=pi/3;
theta=0.1;
angle=theta+j*w;
n1=-10;
n2=10;
n=n1:n2;
x=A*exp(angle*n);
x_real=real(x);
x_imag=imag(x);
x_magnitude=abs(x);
% x_phase=(180/pi)*angle(x);
subplot(221),stem(n,x_real);grid on
subplot(222),stem(n,x_imag);grid on
subplot(223),stem(n,x_magnitude);grid on
% subplot(224),stem(n,x_phase);grid on