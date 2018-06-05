clc ;clear;close all
global xx2 xx1 N1 sina cota cosa x11 x22 p
x1 = ones(1,40);
x2 = ones(1,40);
x11 = [x1,zeros(1,25)];
x22 = [x2,zeros(1,25)];
% figure(1);stem(x11);
% figure(2);stem(x22);
p = 0.5;
N1 = length(x11);
n = 0:N1-1;
cota = 1/tan(p*pi/2);sina = sin(p*pi/2);cosa = cos(p*pi/2);
xx1 = x11.*exp(1j*cota*n.^2/2);
xx2 = x22.*exp(1j*cota*n.^2/2);
convx1x2 = zeros(1,N1);
 
for nn = 0:N1-1
    convx1x2(nn+1) = sqrt((sina-1j*cosa)/N1).*exp(-1j*cota*nn.^2/2)*Xigema(nn);
end

X33 = convx1x2*getDfrftMatrix(N1,p);
% ·ÖÊý½×Óò
X1 = x11*getDfrftMatrix(N1,p);
X2 = x22*getDfrftMatrix(N1,p);
% figure;stem(abs(real(X1)));title('X1')
% figure;stem(abs(X2));title('X2')
X3 = X1.*X2.*exp(-1j*cota*n.^2/2);

figure;stem(abs(real(X33)));title('X33')
figure;stem(abs(real(X3)));title('X3')

x33_after = X3*getDfrftMatrix(N1,-p);
figure;stem(abs(real(convx1x2)));title('x3\_conv')
figure;stem(abs(real(x33_after)));title('x33\_after')

