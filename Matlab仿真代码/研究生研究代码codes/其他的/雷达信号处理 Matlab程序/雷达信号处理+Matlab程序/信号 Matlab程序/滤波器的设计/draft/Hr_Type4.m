function [Hr,w,b,L]=Hr_Type4(h);
M=length(h);
L=M/2;
b=2*[h(L:-1:1)];
n=[1:L];
n=n-0.5;
w=[0:500]'*pi/500;
Hr=sin(w*n)*b';