%%Mainº¯Êý
clear all,close all,clc
[ms1,ms2]=produceMS();
MyLFM_Signal;
load 'LFM.mat';
u=LFM_Signal;

%Tao = -Np:Np;
%V = 0:10:100;
Np = 100;
[Tao V]=meshgrid([-Np:Np],linspace(0,100,2*Np+1));

%%LFM_Signal(2500)
X_abs = X_abs(u,Tao,V,Np);
figure(3)
meshz(Tao,V,X_abs)
figure(4)
meshc(Tao,V,X_abs)
%figure(5)
%mesh(Tao,V,X_abs)