function [percent_papr,bit_error_rates] = PAPR_Func_SLM(y_para,q,N,L,M,n,colums_num,papr_baseS,EbNos,x)
% 规定figure(1)为PAPR图像；figure(2)为BER图像
% 输入：
% 输出：对应的papr、BER
LN = L*N;
 %-------添加过采样功能-------------
y_para_oversample = [y_para(1:N/2,:);zeros((L-1)*N,colums_num);y_para(N/2+1:end,:)];
q_over = [q(1:N/2),zeros(1,(L-1)*N),q(N/2+1:end)];
%-----------对QAM调制后的数据进行IFFT并计算PAPR---------
x_ofdm = zeros(LN,colums_num);%x_ofdm 存放调制后的数据
papr = zeros(1,colums_num);
for i = 1:colums_num
        % 乘以相位序列
        % 注意LN点采样后需要乘以L,因为采样后的幅度变为原来的1/L
       x_ofdm(:,i) = L*ifft(y_para_oversample(:,i).*q_over',LN);%默认也是LN点ifft  
       p_av = 1/N*sum(abs(x_ofdm(:,i)).^2); %这里先算成N
       p_peak = max(abs(x_ofdm(:,i)).^2);
       papr(i) = 10*log10(p_peak/p_av);
end
percent_papr = zeros(1,length(papr_baseS)); 
i = 0;
for papr_base = papr_baseS
    i = i + 1;
    percent_papr(i) = length(find(papr > papr_base))/length(papr);
end
%----------PAPR分析结束---------------
%-------下面进行发送到信道，加噪声，fft、去过采样、dQAM,计算误比特率----------
%并变串
y_Serial_ifft = reshape(x_ofdm,1,LN*length(x_ofdm));
j_index = 0;  
bit_error_rates = zeros(1,length(EbNos));
for EbNo= EbNos 
    %snr = EbNo+10*log10(k)-10*log10(L);%信噪比
    snr = EbNo;
    % yn = y_Serial_ifft;
    yn=awgn(y_Serial_ifft,snr,'measured');%加入高斯白噪声
    %串变并
    colums_num_R = length(yn)/LN;
    y_para_R = reshape(yn,LN,colums_num_R);
    %fft变换
    y_fft = zeros(LN,colums_num_R);
    for i = 1:colums_num_R
        y_fft(:,i) = fft(y_para_R(:,i),LN)./q_over';
    end
    %---------去除过采样-------------
    y_fft_quoversample = [y_fft(1:N/2,:);y_fft(end-N/2+1:end,:)];
    %-----------------------------------------
    yd = demodulate(modem.qamdemod(M),y_fft_quoversample);%此时解调出来的是16进制信号
    z=de2bi(yd,'right-msb'); %转化为对应的二进制比特流
    z=reshape(z,1,n);
    [number_of_errors,bit_error_rate] = biterr(x,z);
    j_index = j_index+1;
    bit_error_rates(j_index) = bit_error_rate;
end 

end

