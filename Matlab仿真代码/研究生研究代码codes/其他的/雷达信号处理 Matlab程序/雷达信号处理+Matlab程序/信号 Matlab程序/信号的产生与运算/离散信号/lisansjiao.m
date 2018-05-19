%ÀëÉ¢Èý½Çº¯Êý(tri(n/N))
A=2;
N=2;
x=zeros(1,2*N+1);
for i=1:2*N+1
    if i<N+1
    x(i)=(i-1)/N;
 elseif  i==N+1
        x(i)=1;
    else 
        x(i)=(2*N+1-i)/N;
end
end
n=-N:N;
stem(n,x)