function [Hr,w,b,L]=Hr_Type1(h);
M=length(h);
L=(M-1)/2;
a=[h(L+1) 2*h(L:-1:1)];
n=[0:L];
ww=[0:500]'*pi/500;
Hr=cos(ww*n)*a';
