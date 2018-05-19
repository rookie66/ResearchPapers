clear;clc,close all
[tao,fd]=meshgrid(linspace(-2E-6,2E-6,10),linspace(-5E6,5E6,10));
X2 = getX2(tao,fd);
surf(tao,fd,X2)