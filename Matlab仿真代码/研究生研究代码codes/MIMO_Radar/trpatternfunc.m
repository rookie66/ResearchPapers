%%%%%%Beampatternfororthogonalandcoherentsignalswithdifferenttargetlocalizations
clear all
clc

N = 1;
M = 10;
j = sqrt(-1);
theta1 = (-30*pi)/180;
theta2 = (50*pi)/180;
theta = linspace(theta1,theta2,1000);
theta0 = 0:(5*pi)/180:(10*pi)/180;
k=length(theta);
for theta0
    atheta0 = zeros(M,1);
    for i = 1:M
        atheta0(i,1)=exp(-j*(i-1)*pi*sin(theta0));
    end
  for k=1:1000
      atheta = zeros(M,1);      %导引矢量
                for p=1:M
                    atheta(i,1)=exp(-j*(p-1)*pi*sin(theta(k)));
                end
        b = ones(M,1);      
        c1 = (N/M)*(abs(atheta0'*b).^2)*(abs(atheta'*atheta0).^2);        %coherent transmit signals收发形式                                     %orthogonal transmit signals收发形式
        c1=c1/1000;      
        c(1,k) = 10*log10(c1);       
  end
  d(theta0)=c;
  plot(d,theta)

