function [out] = mgen(g,state,N)
%输入 g:m序列生成多项式（10进制输入）(不包括C0）为C1,C2,...Cn的十进制大小
%state:寄存器初始状态（10进制输入）
% N:输出序列长度
    n = length(dec2bin(g));
    gen = dec2bin(g+2^n)-48;%将字符1转化为数字1，ASCII码差48
    M = length(gen);
    curState = dec2bin(state,M-1) - 48;%将字符1转化为数字1，ASCII码差48
    for k =1:N
        out(k) = curState(M-1);
        a = rem(sum( gen(2:end).*curState),2);
        curState = [a,curState(1:M-2)];
    end
end
