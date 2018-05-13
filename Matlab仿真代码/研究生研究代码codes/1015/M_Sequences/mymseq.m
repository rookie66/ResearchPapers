function [mseq]=mymseq(coefficients)
% coefficients为特征多项式1的位置
% 例如1+s+s4  要把1去掉，写为【1 0 0 1】,幂从小到大排列
% 序列的顺序与手算的可能有区别，但是应该是正确的。
len = length(coefficients);
L = 2^len - 1;
registers = [ones(1,len-1),1];
mseq(1)=registers(1);
for i=2:L
    newregisters(1:len-1) = registers(2:len);
    newregisters(len)=mod(sum(coefficients.*registers),2);
    registers=newregisters;
    mseq(i)=registers(1);
end
end