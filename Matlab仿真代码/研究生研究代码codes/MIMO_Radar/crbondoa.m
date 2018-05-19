%%%%%CRB on DOA estimation,M=2,with two targets
function [x,y]=crbondoa(theta)

M=2;
snr=1;
theta = theta*(pi/180);
beta=linspace(0,1.0,50);
for k=1:50
    ec=pi*cos(theta);
    es=pi*sin(theta);
    crbtheta(k)=(1+beta(k)*cos(es))/(2*snr*(ec^2)*(2+2*beta(k)*cos(es)-(beta(k)^2)*(sin(es)^2)));
    crbbeta(1,k)=crbtheta(k);
end
crbbeta=crbbeta*(180/pi);
x=beta;
y=crbbeta;

