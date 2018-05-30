function F=getDFRFTMatrix(N,a,ord)
% 获取DFRFT的转移矩阵
% 参数N为维度；a为阶数
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

