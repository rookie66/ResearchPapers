function fclo(num)
% �ر�num��ָ����ͼ�񴰿�
% �� fclo([1 3 5])�ر�figure1��3��5
    len = length(num);
    if len >0
        for i = 1: len
            close(num(i));
        end
    end
end