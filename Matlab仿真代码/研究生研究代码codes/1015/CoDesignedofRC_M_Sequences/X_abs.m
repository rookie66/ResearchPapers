function [ X ] = X_abs( u,Tao,V ,Np)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
X = 0;
for t = 1:Np 
      %X = X + u(t).*conj(u(t-Tao)).*exp(j*2*pi*V*t);

  X = X + u(t)*conj(u2(u ,t-Tao,Np)).*exp(j*2*pi*V*t);
end 
X = 10*log10(abs(X))
end

