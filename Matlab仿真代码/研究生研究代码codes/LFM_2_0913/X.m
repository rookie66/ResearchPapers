clear ;close all;clc
T=1E-6;
B=5E6;
k=B/T;
[tao,fd]=meshgrid(linspace(-2E-6,2E-6,1000),linspace(-5E6,5E6,1000));
X2 =power(abs((1-abs(tao)./(tao)).*sinc(tao.*(k.*tao+fd).*(1-abs(tao)./tao))),2);
figure(1)
mesh(tao,fd,X2)