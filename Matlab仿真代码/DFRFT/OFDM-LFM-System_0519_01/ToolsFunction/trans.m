function [ B ] = trans( A ,flag )
%transpose the matrix
%���flag = 0,��ȡ����;����ȡ����
%Ĭ�������,��ȡ����ת��
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

