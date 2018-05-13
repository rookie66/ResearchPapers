function [  ] = AF_Func_Discrete( LFM_Signal )
% ���������Ӧ��LFM�źż���ģ��������������ͼ��
%  �������LFM_Signal ��
%  ����һ���ԣ�������LFM_Signal����LFM_Comm��LFM_OFDM_Signal��LFM_OFDM_Comm
tic
tao = -10e-6:10*Ts:10e-6;  %�ӳ�ʱ��
fd = 0:10:100;%������Ƶ��
AF_LFM = zeros(length(fd),length(tao));
for i = 1:length(tao)
     if tao(i)<0
            int_region = 0:Ts:(Tp+tao(i));
        else 
            int_region = tao(i):Ts:Tp;
    end
    for k = 1:length(fd)
        for tt = int_region
            AF_LFM(k,i)= AF_LFM(k,i)+ LFM_Signal(floor(tt/Ts+1))*conj(LFM_Signal(floor((tt-tao(i))/Ts+1)))*exp(1j*2*pi*fd(k)*tt)*Ts;
        end
    end
 end
AF_LFM = AF_LFM/max(max(AF_LFM));
figure(1),colormap jet
mesh(tao*1e6,fd,abs(AF_LFM));
xlabel('ʱ��\mus'),ylabel('������Ƶ��(Hz)'),zlabel('��һ����ֵ'),title('LFM-Signal�źŵ�ģ������ͼ������������ɢ������')
figure(2),colormap jet
AF_LFM_dB = 20*log10(abs(AF_LFM)*1e4);
AF_LFM_dB(find(AF_LFM_dB<0))=0;
mesh(tao*1e6,fd,AF_LFM_dB);
xlabel('ʱ��\mus'),ylabel('������Ƶ��(Hz)'),zlabel('��ֵ(dB)'),title('LFM-Signal�źŵ�ģ������ͼ������������ɢ������')
toc
end

