clc
A = randi([1,4],1,1000)+1j*randi([1,4],1,1000);
theta = -1;
N = length(A);
A2 = [A(1:N/4),theta*A(1:N/4),theta*A(1:N/4),theta*theta*A(1:N/4)];
a = ifft(A);
a2 = ifft(A2);
per_Vector_PAPR_Calcu(a)
per_Vector_PAPR_Calcu(a2)