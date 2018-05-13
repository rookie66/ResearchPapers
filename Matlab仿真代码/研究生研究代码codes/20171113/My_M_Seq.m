function [M_Seq] = My_M_Seq(primitive,seed,N)
%根据原本多项式生成M序列
%参数介绍：
%   1. primitive：本原多项式系数,按照幂升序排列,即[C1,C2,...,Cn]，C0=1缺省
%   2. seed为初始状态，按照An-1，An-2,...,A0递减顺序
%   3. N：所需要的M序列的长度，M序列的循环周期为2^n-1,n为M序列级数
%说明： 输入参数可以为1个，就是原本多项式系数；也可以为2个，原本多项式和初始状态
    n = length(primitive);%M序列的级数
    if nargin == 1 % 若输入参数为1个，则默认初始状态为[0 0 0... 1]
        seed = [zeros(1,n-1),1];
        N = 2^n-1;%M序列的最小周期
    else if nargin == 2% 若输入参数为2个，则默认获取长度为N=2^n-1
            N = 2^n-1;
        end
    end
    M_Seq = zeros(1,N);%初始化M序列为0
    for i = 1:N
        M_Seq(i) = seed(n);%seed数组向右移动，M1-Mn都是初始状态
        An = mod(sum(primitive.*seed),2);%获取新的m值
        seed = [An,seed(1:n-1)];%新的状态
    end
end
