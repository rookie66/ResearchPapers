clc,clear 
A = [1 0 1];%A����ʽ
B = [1 0 1];%B����ʽ
result = polyMultiByFFT(A,B);
result%1     0     2     0     1

conv(A,B)