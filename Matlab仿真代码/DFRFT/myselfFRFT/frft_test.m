
close all ,clear ;clc
Fs = 10e6;
Ts = 1/Fs;
Tp = 10e-6;
N = Tp/Ts;
t = -N/2*Ts:Ts:N/2*Ts;
mu = 10e3;
mu2 =30e3;
f0 = 0;
f = exp(1i*(2*pi*f0*t+pi*mu*t.^2));
f2 = 2*exp(1i*(2*pi*f0*t+pi*mu2*t.^2));
ffs = f+f2;
Fa = frft(f,1);
plot(real(Fa));
figure(2)
Fa2 = frft(f2,1);
plot(real(Fa2));
figure(3)
Fas = frft(ffs,1);
plot(real(Fas));
Fa == Fa2
Fa


