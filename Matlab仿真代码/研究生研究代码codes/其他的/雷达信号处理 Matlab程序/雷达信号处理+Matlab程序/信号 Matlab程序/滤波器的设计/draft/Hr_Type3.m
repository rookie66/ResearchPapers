function [Hr,w,b,L]=Hr_Type3(h);
M=length(h);
L=(M-1)/2;
b=[2*h(L+1:-1:1)];
n=[0:L];
w=[0:500]'*2*pi/500;
Hr=sin(w*n)*b';