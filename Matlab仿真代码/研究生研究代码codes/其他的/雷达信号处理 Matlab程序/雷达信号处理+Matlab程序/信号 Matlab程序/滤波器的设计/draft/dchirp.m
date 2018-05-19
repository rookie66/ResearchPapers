function s=dchirp(tw,p)
% p=3;
% tw=50;
N=p*tw;
a=1/(2*p*p*tw);
n=0:N/501:N-N/501;
s=exp(j*2*pi*a*(n-N).^2);

