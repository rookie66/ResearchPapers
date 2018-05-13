A = magic(3);
tr1 = trace(A*A');
tr1
i = 1;
B = zeros(3);
for i=1:3
    B = B + A(:,i)*(A(:,i))';
end
tr2 = trace(B);
tr2