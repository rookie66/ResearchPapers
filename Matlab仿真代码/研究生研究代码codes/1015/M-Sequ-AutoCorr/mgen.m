function [out] = mgen(g,state,N)
%���� g:m�������ɶ���ʽ��10�������룩(������C0��ΪC1,C2,...Cn��ʮ���ƴ�С
%state:�Ĵ�����ʼ״̬��10�������룩
% N:������г���
    n = length(dec2bin(g));
    gen = dec2bin(g+2^n)-48;%���ַ�1ת��Ϊ����1��ASCII���48
    M = length(gen);
    curState = dec2bin(state,M-1) - 48;%���ַ�1ת��Ϊ����1��ASCII���48
    for k =1:N
        out(k) = curState(M-1);
        a = rem(sum( gen(2:end).*curState),2);
        curState = [a,curState(1:M-2)];
    end
end
