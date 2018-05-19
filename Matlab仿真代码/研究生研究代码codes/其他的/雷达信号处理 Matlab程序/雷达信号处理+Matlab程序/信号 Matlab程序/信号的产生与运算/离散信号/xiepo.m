%ÀëÉ¢Ğ±ÆÂĞÅºÅ
N=16;
x=ones(1,N);
for i=1:N
    x(i)=i-1;
end
n=0:N-1;
stem(n,x);
axis([0 16 0 16]);
