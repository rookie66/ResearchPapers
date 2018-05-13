clc,clear 
A = [1 0 1];%A多项式
B = [1 0 1];%B多项式
result = polyMultiByFFT(A,B);
result%1     0     2     0     1

conv(A,B)