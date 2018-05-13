function [ u2 ] = u2( u,t_s ,Np)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
for i = 1:length(t_s)
    if (t_s(i)>0)&&(t_s(i)<5001)
        u2(i)=u(t_s(i));
    else
        u2(i)=0;
    end
end
for i = 2:2*Np+1
    u2(i,:)=u2(1,:);
end
end

