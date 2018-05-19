function [M_Seq] = My_M_Seq(primitive,seed,N)
%����ԭ������ʽ����M����
%�������ܣ�
%   1. primitive����ԭ����ʽϵ��,��������������,��[C1,C2,...,Cn]��C0=1ȱʡ
%   2. seedΪ��ʼ״̬������An-1��An-2,...,A0�ݼ�˳��
%   3. N������Ҫ��M���еĳ��ȣ�M���е�ѭ������Ϊ2^n-1,nΪM���м���
%˵���� �����������Ϊ1��������ԭ������ʽϵ����Ҳ����Ϊ2����ԭ������ʽ�ͳ�ʼ״̬
    n = length(primitive);%M���еļ���
    if nargin == 1 % ���������Ϊ1������Ĭ�ϳ�ʼ״̬Ϊ[0 0 0... 1]
        seed = [zeros(1,n-1),1];
        N = 2^n-1;%M���е���С����
    else if nargin == 2% ���������Ϊ2������Ĭ�ϻ�ȡ����ΪN=2^n-1
            N = 2^n-1;
        end
    end
    M_Seq = zeros(1,N);%��ʼ��M����Ϊ0
    for i = 1:N
        M_Seq(i) = seed(n);%seed���������ƶ���M1-Mn���ǳ�ʼ״̬
        An = mod(sum(primitive.*seed),2);%��ȡ�µ�mֵ
        seed = [An,seed(1:n-1)];%�µ�״̬
    end
end
