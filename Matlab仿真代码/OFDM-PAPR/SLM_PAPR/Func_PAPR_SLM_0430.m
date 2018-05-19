function [y_min_papr,min_papr] = Func_PAPR_SLM_0430(y_column,Q,L,M)
% ���룺
% �������Ӧ��papr��BER

% �������ԣ�QAM���ƣ��Ե���16���Ƶ�������16���Ƶ��ƽ��һ�������ֻ��Ҫ��
% side information����
N = length(y_column);
LN = L*N;
Us = size(Q); U = Us(1); %��ѡ��������
% ��U����ѡ��PAPR��С��
y_ofdms = zeros(U,LN+1);
paprs = zeros(1,U);
for i = 1:U
    % ������λ����
    y_slm = Q(i,:).*y_column;
    %-------��ӹ���������-------------
    y_slm_oversample = [y_slm(1:N/2),zeros((L-1)*N),y_slm(N/2+1:end)];
    % ע��LN���������Ҫ����L,��Ϊ������ķ��ȱ�Ϊԭ����1/L
    y_ofdm = L*ifft(y_slm_oversample,LN);%Ĭ��Ҳ��LN��ifft
    y_ofdm(LN+1) = modulate(modem.qammod(M),i);
    y_ofdms(i,:) = y_ofdm;%��������
    %����PAPR
    paprs(i) = PAPR_Calcu(y_ofdm(1:end-1));
end
min_papr = min(paprs);
min_indexs = find(paprs == min_papr);
y_min_papr = y_ofdms(min_indexs(1),:);
end