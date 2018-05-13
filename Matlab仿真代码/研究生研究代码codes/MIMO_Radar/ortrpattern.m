%%%%%%β=0,subfnction for differenttarget location
function [x,y]=ortrpattern(theta0)

N = 1;
M = 10;
j = sqrt(-1);
theta0 = (theta0*pi)/180;
theta1 = (-30*pi)/180;
theta2 = (50*pi)/180;
theta = linspace(theta1,theta2,1000);
for i=1:M
    atheta0(i,1)=exp(-j*(i-1)*pi*sin(theta0));
end
for k=1:1000
    
        atheta = zeros(M,1);      %导引矢量
                for i=1:M
                    atheta(i,1)=exp(-j*(i-1)*pi*sin(theta(k)));
                end
        d1 = (N/M)*(abs(atheta'*atheta0).^4);                               %orthogonal transmit signals收发形式    
        d1=d1/1000;        
        d(1,k) = 10*log10(d1);
       
end
theta = theta*(180/pi);
x=theta;
y=d;

