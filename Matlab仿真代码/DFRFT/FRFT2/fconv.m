function z = fconv(x,y)
% convolution by fft
N = length([x(:);y(:)])-1;
P = 2^nextpow2(N);
z = ifft( fft(x,P) .* fft(y,P));
z = z(1:N); 