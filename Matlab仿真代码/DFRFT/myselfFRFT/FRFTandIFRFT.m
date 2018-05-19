clear ;clc;close

n = 10;
p = 0.8;%1,2,3,
%s = round(rand(1,n)) ;
s = 1:n;
Fr = frft(s,-p);
IFr = frft(Fr,p);
s
IFr = reshape(IFr,[1,n]);
real(IFr)
abs(IFr)
conj((s(:)-IFr(:))') < 0.01+1i*0.01