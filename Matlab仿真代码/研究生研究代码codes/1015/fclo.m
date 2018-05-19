function fclo(num)
% 关闭num中指定的图像窗口
% 如 fclo([1 3 5])关闭figure1、3、5
    len = length(num);
    if len >0
        for i = 1: len
            close(num(i));
        end
    end
end