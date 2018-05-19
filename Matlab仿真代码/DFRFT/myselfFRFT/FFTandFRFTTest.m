%% 
clear 
clc

a = randn(1,10);
p = -1;
Fr = frft(a,p);
Ff = fftshift(fft(a)/sqrt(length(a)));
abs(real(Fr))
abs(real(Ff))
A = abs(Fr);
A'
B = abs(Ff)
abs(A'-B ) <0.01


%fftÓëifft´æÔÚ¿ÉÄæ
F = fft(a);
f = ifft(F);
a - f < 0.01 % 1 1 1 1 1 1 1 1 1

