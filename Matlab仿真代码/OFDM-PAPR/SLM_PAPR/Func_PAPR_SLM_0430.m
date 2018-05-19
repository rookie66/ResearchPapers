function [y_min_papr,min_papr] = Func_PAPR_SLM_0430(y_column,Q,L,M)
% 输入：
% 输出：对应的papr、BER

% 经过测试，QAM调制：对单个16进制调制与多个16进制调制结果一样；因此只需要把
% side information经过
N = length(y_column);
LN = L*N;
Us = size(Q); U = Us(1); %备选向量个数
% 从U个中选择PAPR最小的
y_ofdms = zeros(U,LN+1);
paprs = zeros(1,U);
for i = 1:U
    % 乘以相位序列
    y_slm = Q(i,:).*y_column;
    %-------添加过采样功能-------------
    y_slm_oversample = [y_slm(1:N/2),zeros((L-1)*N),y_slm(N/2+1:end)];
    % 注意LN点采样后需要乘以L,因为采样后的幅度变为原来的1/L
    y_ofdm = L*ifft(y_slm_oversample,LN);%默认也是LN点ifft
    y_ofdm(LN+1) = modulate(modem.qammod(M),i);
    y_ofdms(i,:) = y_ofdm;%保存下来
    %计算PAPR
    paprs(i) = PAPR_Calcu(y_ofdm(1:end-1));
end
min_papr = min(paprs);
min_indexs = find(paprs == min_papr);
y_min_papr = y_ofdms(min_indexs(1),:);
end