%ÀëÉ¢sincº¯Êı
N=5;
n=-3*N:3*N;
if n==0
    x=n-n+1;
else 
    x=sin(n*pi/N)./(n*pi/N)+eps;
end
stem(n,x)