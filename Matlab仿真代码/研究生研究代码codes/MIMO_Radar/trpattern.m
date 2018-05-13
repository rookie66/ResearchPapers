%%%%%%β=1,subfnction for differenttarget location
function [x,y]=trpattern(theta0)

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
        b = ones(M,1);
   
        c1 = (N/M)*(abs(atheta0'*b).^2)*(abs(atheta'*atheta0).^2);        %coherent transmit signals收发形式
        
        c1=c1/1000;
      
        c(1,k) = 10*log10(c1);
       
end
theta = theta*(180/pi);
x=theta;
y=c;
