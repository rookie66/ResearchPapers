function [ B ] = trans( A ,flag )
%transpose the matrix
%如果flag = 0,只转置不共轭;否则共轭转置
%默认情况下,只转置不共轭
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

