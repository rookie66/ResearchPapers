function [percent_papr,bit_error_rates] = PAPR_Func_SLM(y_para,q,N,L,M,n,colums_num,papr_baseS,EbNos,x)
% �涨figure(1)ΪPAPRͼ��figure(2)ΪBERͼ��
% ���룺
% �������Ӧ��papr��BER
LN = L*N;
 %-------��ӹ���������-------------
y_para_oversample = [y_para(1:N/2,:);zeros((L-1)*N,colums_num);y_para(N/2+1:end,:)];
q_over = [q(1:N/2),zeros(1,(L-1)*N),q(N/2+1:end)];
%-----------��QAM���ƺ�����ݽ���IFFT������PAPR---------
x_ofdm = zeros(LN,colums_num);%x_ofdm ��ŵ��ƺ������
papr = zeros(1,colums_num);
for i = 1:colums_num
        % ������λ����
        % ע��LN���������Ҫ����L,��Ϊ������ķ��ȱ�Ϊԭ����1/L
       x_ofdm(:,i) = L*ifft(y_para_oversample(:,i).*q_over',LN);%Ĭ��Ҳ��LN��ifft  
       p_av = 1/N*sum(abs(x_ofdm(:,i)).^2); %���������N
       p_peak = max(abs(x_ofdm(:,i)).^2);
       papr(i) = 10*log10(p_peak/p_av);
end
percent_papr = zeros(1,length(papr_baseS)); 
i = 0;
for papr_base = papr_baseS
    i = i + 1;
    percent_papr(i) = length(find(papr > papr_base))/length(papr);
end
%----------PAPR��������---------------
%-------������з��͵��ŵ�����������fft��ȥ��������dQAM,�����������----------
%���䴮
y_Serial_ifft = reshape(x_ofdm,1,LN*length(x_ofdm));
j_index = 0;  
bit_error_rates = zeros(1,length(EbNos));
for EbNo= EbNos 
    %snr = EbNo+10*log10(k)-10*log10(L);%�����
    snr = EbNo;
    % yn = y_Serial_ifft;
    yn=awgn(y_Serial_ifft,snr,'measured');%�����˹������
    %���䲢
    colums_num_R = length(yn)/LN;
    y_para_R = reshape(yn,LN,colums_num_R);
    %fft�任
    y_fft = zeros(LN,colums_num_R);
    for i = 1:colums_num_R
        y_fft(:,i) = fft(y_para_R(:,i),LN)./q_over';
    end
    %---------ȥ��������-------------
    y_fft_quoversample = [y_fft(1:N/2,:);y_fft(end-N/2+1:end,:)];
    %-----------------------------------------
    yd = demodulate(modem.qamdemod(M),y_fft_quoversample);%��ʱ�����������16�����ź�
    z=de2bi(yd,'right-msb'); %ת��Ϊ��Ӧ�Ķ����Ʊ�����
    z=reshape(z,1,n);
    [number_of_errors,bit_error_rate] = biterr(x,z);
    j_index = j_index+1;
    bit_error_rates(j_index) = bit_error_rate;
end 

end

