%% 输出结果为y，输入参数为n
function [y] = jiecheng(n)
if nargin == 0
    y = -1;
    return ;
end 
if n < 0
    y = -1;
elseif n==0 || n ==1
    y = 1;
else
    y = n*jiecheng(n-1);
end