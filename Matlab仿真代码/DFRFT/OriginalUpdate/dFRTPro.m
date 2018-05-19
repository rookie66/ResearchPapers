function [ Fr_trans ] = dFRTPro(s,p)
%对dFRT函数进一步封装
%作为信号的调制与解调函数
%输入：s为待调制的信号,一列为一个OFDM码元信号
%-----s为矢量时，应该为N*1；输出为N*1
%-----s为矩阵式，应该为N*M，每一列为一个OFDM码元

narginchk(2,2)
[N,~] = size(s);%M个信号需要调制(N)
s_trans = trans(s);%非共轭转置下(编程M*N)，一行为一个信号
Fr = s_trans*dFRT(N,p);%(M*N)*(N*N) = M*N
if(p>0)
    Fr = Fr/sqrt(N);
else
    Fr = Fr*sqrt(N);
end
Fr_trans = trans(Fr);%变成N*M,一列为1个码元



%DISCRETE FRACTIONAL FOURIER TRANSFORM MATRIX GENERATOR
%by Cagatay Candan <candan@ieee.org>, July 1998, Ankara
%Copyright 1998 Cagatay Candan
%This code may be used for scientific and educational purposes 
%provided credit is given to the publications below:
%
%This Matlab function generates the discrete fractional
%Fourier transform matrix originally described in:
%Cagatay Candan, M. Alper Kutay, and Haldun M. Ozaktas,
%The discrete fractional Fourier Transform,
%IEEE Transactions on Signal Processing, 48:1329-1337, May 2000,
%(also in Proc ICASSP'99, pages 1713-1716, IEEE, 1999);
%and further described in:
%Haldun M. Ozaktas, Zeev Zalevsky, and M. Alper Kutay,
%The Fractional Fourier Transform with Applications in Optics and
%Signal Processing, Wiley, 2000, chapter 6.

function F=dFRT(N,a,ord)
%function F=dFRT(N,a,ord) returns the NxN discrete fractional 
%Fourier transform matrix with fractional order 'a'. 
%The optional argument 'ord' is the order of approximation 
%of the S matrix (default 2). 

%Note: This Matlab file has some subfunctions for generating S_{2k}
%      matrices, eigenvector ordering etc. These functions are not
%      visible from the Matlab workspace.

global Evec Eval ordp

if nargin==2, ord=2;end;

if (length(Evec)~=N | ordp~=ord),
	[Evec,Eval]=dis_s(N,ord);
	ordp=ord;
end;

even=~rem(N,2);
F=Evec*diag(exp(-1j*pi/2*a*([0:N-2 N-1+even])))*Evec';

%%%%%%

function M=cconvm(v)
%Generates circular Convm matrix

v=v(:);N=length(v);
M=zeros(N,N);dum=v;
for k=1:N,
	M(:,k)=dum;
	dum=[dum(N); dum(1:N-1)];
end;

%%%%%%

function S=creates(N,ord)
%Creates S matrix of approximation order ord
%When ord=1, elementary S matrix is returned

ord=ord/2;
dum=[1 -2 1];s=0;
for k=1:ord,
	s=(-1)^(k-1)*prod(1:(k-1))^2/prod(1:2*k)*2*[0 dum(k+2:2*k+1) zeros(1,N-1-2*k) dum(1:k)]+s;
	dum=conv(dum,[1 -2 1]);
end;
S=cconvm(s)+diag(real(fft(s)));

%%%%%%

function [Evec,Eval]=dis_s(N,ord)
%function [Evec,Eval]=dis_s(N)
%Returns sorted eigenvectors and eigenvalues of corresponding vectors

if nargin==1, ord=2;end;

%%Construct S Matrix
%S=diag(2*cos(2*pi/N*([0:N-1])))+diag(ones(1,N-1),1)+diag(ones(1,N-1),-1);
%S(1,N)=1;S(N,1)=1;
%%
S=creates(N,ord);

%%%%%%

%Construct P matrix

p=N;
r=floor(p/2);
P=zeros(p,p);

P(1,1)=1;
even=~rem(p,2);
for k=1:r-even,
	P(k+1,k+1)=1/sqrt(2);
	P(k+1,p-(k+1)+2)=1/sqrt(2);
end;

if (even), P(r+1,r+1)=1; end;

for k=r+1:p-1,
	P(k+1,k+1)=-1/sqrt(2);
	P(k+1,p-(k+1)+2)=1/sqrt(2);
end;

%%%%%%

CS=P*S*P';C2=CS(floor(1:N/2+1),floor(1:N/2+1));S2=CS(floor(N/2+2):N,floor(N/2+2):N);

[vc,ec]=eig(C2);[vs,es]=eig(S2);
qvc=[vc ;zeros(ceil(N/2-1),floor(N/2+1))];
SC2=P*qvc;	%Even Eigenvector of S

qvs=[zeros(floor(N/2+1),ceil(N/2-1));vs];
SS2=P*qvs;	%Odd Eigenvector of S

es=diag(es);ec=diag(ec);
[d,in]=sort(-ec);
SC2=SC2(:,in);
ec=ec(in);

[d,in]=sort(-es);
SS2=SS2(:,in);
es=es(in);

if rem(N,2)==0,
	S2C2=zeros(N,N+1);
	SS2(:,size(SS2,2)+1)=zeros(N,1);
	S2C2(:,[0:2:N]+1)=SC2;
	S2C2(:,[1:2:N]+1)=SS2;
	S2C2(:,N)=[];
else 
	S2C2=zeros(N,N);
	S2C2(:,[0:2:N]+1)=SC2;
	S2C2(:,[1:2:N-1]+1)=SS2;
end;

Evec=S2C2;
Eval=(-1j).^[ 0:N-2 (N-1)+even];

%END
