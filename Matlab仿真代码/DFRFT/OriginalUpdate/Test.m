clear ;clc;close

n = 10;
p = 0.5;%1,2,3,
s = round(rand(1,n)) +1i*round(rand(1,n));

If =s*dFRT(n,-p)/sqrt(n);
If2 = ifft(s);
If
If2
If-If2 < 0.1+1i*0.1
ss = If*dFRT(n,p)*sqrt(n)
s
sss = round(real(ss));
s - ss < 0.01+1i*0.01
%%
IFr = dFRT(Fr,p);
s
IFr = reshape(IFr,[1,n]);
real(IFr)
abs(IFr)
conj((s(:)-IFr(:))') < 0.01+1i*0.01
%% Test1 
s = rand(1,10)+1i*rand(1,10);
p = 0.5;
Fr = dFRTPro(s,p);
so = dFRTPro(Fr,-p);
s
so
s - so < 0.01+1i*0.01

