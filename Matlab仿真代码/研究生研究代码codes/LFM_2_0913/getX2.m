function [ X2 ] = getX2( tao,fd )
%UNTITLED3 Summary of this function goes here
%  
T=1E-6;
B=5E6;
k=B/T;
X2 =abs((1-abs(tao)/T).*sinc(tao.*(k.*tao+fd).*(1-abs(tao)/T)));
X2 = power(X2,2);
end

