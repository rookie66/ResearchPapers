function [Capacity]=getCapacityMean(Pt,D,Nt)
% Calculate the Capacity of MIMO Channel 
% the Power is mean
sigma = 0.01;
Capacity = 0;
lambdas = diag(D)+eps;
nums = length(lambdas);
mu = Pt;
Nt;
for i = 1:nums
    mu = mu + sigma^2/lambdas(i) ;
end
mu = mu / nums;
for i = 1:nums
    Pi = mu-sigma^2/lambdas(i);
    if Pi < 0
        Pi = 0;
    end
    Capacity = Capacity + log2(1+(lambdas(i)^2*Pi)/sigma^2);
end
end