%% 验证M序列的循环性
A = My_M_Seq([1 0 0 0 0 0 1],[0 0 0 0 0 0 1],1270);
for i = 0:9
    A1 = A(1+127*i:127*(i+1));
    for j = i+1:9
        if (A1 == A((1+127*j):127*(j+1)))==ones(1,127)
            disp('equal')
        end
    end
end