function [ sum ] = Xigema( nn )
%XIGEMA Summary of this function goes here
%   Detailed explanation goes here
global N1 xx1 cota 
sum = 0;
for i = 0:N1-1
   sum = sum + xx1(i+1).*xxx2((nn-i)).*exp(1j*cota*(nn-i)^2/2);
end
end

