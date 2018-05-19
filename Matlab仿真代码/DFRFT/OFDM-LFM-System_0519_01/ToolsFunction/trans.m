function [ B ] = trans( A ,flag )
%transpose the matrix
%如果flag = 0,不取共轭;否则取共轭
%默认情况下,不取共轭转置
narginchk(1,2)
if nargin == 1
    flag = 0;
end
if flag == 0
    B = conj(A');
else
    B = A';
end
end

