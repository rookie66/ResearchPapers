function [mseq]=mymseq(coefficients)
% coefficientsΪ��������ʽ1��λ��
% ����1+s+s4  Ҫ��1ȥ����дΪ��1 0 0 1��,�ݴ�С��������
% ���е�˳��������Ŀ��������𣬵���Ӧ������ȷ�ġ�
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