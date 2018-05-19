function [X,X_abs] = getX(Tao,fd)
% LFM�źŵ�ģ������������ʱ�Ӻ�Ƶ�ƻ�ȡģ��������ֵ
% ���ظ���ֵ�;���ֵ

    if nargin== 1 %ֻ����ʱ�ӣ�Ĭ�������Ƶ��Ϊ0
        fd = 0;
    end
    Tp = 1E-6;
     X = exp(j*pi*fd.*(Tp-Tao)).*(sin(pi*fd.*(Tp-abs(Tao)))/(pi*fd.*(Tp-abs(Tao)))).*((Tp-abs(Tao))/Tp);
     X_abs = abs(X);
end