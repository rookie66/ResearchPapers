function [Capacity]=getCapacity(Pt,D,Nt)
% Calculate the Capacity of MIMO Channel 
sigma=0.01;
lambdas = diag(D);
nums = length(lambdas);
lambdas(nums+1:Nt) = 0;
Capacity = 0;
for i = 1:Nt
    Capacity = Capacity + log2(1+lambdas(i)^2*Pt/(Nt*sigma^2));
end
end