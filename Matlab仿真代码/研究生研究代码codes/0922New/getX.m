function [X,X_abs] = getX(Tao,fd)
% LFM信号的模糊函数，根据时延和频移获取模糊函数的值
% 返回复数值和绝对值

    if nargin== 1 %只输入时延，默认情况下频移为0
        fd = 0;
    end
    Tp = 1E-6;
     X = exp(j*pi*fd.*(Tp-Tao)).*(sin(pi*fd.*(Tp-abs(Tao)))/(pi*fd.*(Tp-abs(Tao)))).*((Tp-abs(Tao))/Tp);
     X_abs = abs(X);
end