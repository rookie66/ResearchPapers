% AF_Discrete����
% �ֳ������֣���һ����������ɢ�����ͨLFM�źŵ�ģ��������
%           Part1.1�Ǹ��ݹ�ʽ����ģ��������Part1.2�Ǹ�����ɢ��������ģ��������
% �ڶ�����������ɢ���OFDM-LFM��ģ��������
% ��������������ɢ���OFDM-LFM-Comm��ģ��������
 %% Part 1.1 ���ù�ʽ���LFM�źŵ�ģ��������Ambiguity Function��
clear,clc,close all
LFM_Basic                 %ִ��LFM_Basic �ļ�����
load('LFM_Basic.mat')
tao = -10e-6:10*Ts:10e-6; %�ӳ�ʱ��
B_range = B/50;  %������Ƶ�Ƶķ�Χ
fd = linspace(-B_range,B_range,length(tao));  %������Ƶ�Ƶķ�Χ
[tao_New,fd_New]=meshgrid(tao,fd);
%���ݹ�ʽ����ģ������ֵ
AF_LFM_gongshi = sinc((fd_New-k*tao_New).*(Tp-abs(tao_New))).*(Tp-abs(tao_New))/Tp;  %ģ������
%������ͼ
figure(1),colormap jet;
mesh(tao*1e6,fd_New/1e3,abs(AF_LFM_gongshi))      %����άģ��ͼ
title('LFM�ź�Ambiguity Functionͼ'),xlabel('ʱ��(\mus)'),ylabel('������Ƶ��(kHz)'),zlabel('��ֵ')
%ȡdB����dBͼ��
AF_dB = 20*log10(abs(AF_LFM_gongshi)*10000+eps);
figure(2),colormap jet;
AF_dB(find(AF_dB<0))=0;
mesh(tao*1e6,fd_New/1e3,AF_dB)                    %����άģ��ͼ
title('LFM�ź�ģ������ͼ'),xlabel('ʱ��(\mus)'),ylabel('������Ƶ��(kHz)'),zlabel('��ֵ��dB��')

%% Part 1.2 LFM�ź���ɢ���ֽ��
clear,clc,close all
LFM_Basic  %ִ��LFM_Basic �ļ�����
load('LFM_Basic.mat')
tao = -10e-6:10*Ts:10e-6;%�ӳ�ʱ��
B_range = B/50;
fd = -B_range:1e4:B_range;%������Ƶ��
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
%��ʼ��ͼ��ģ������ͼ
figure(3),colormap jet
mesh(tao*1e6,fd/1e3,abs(AF_LFM));
xlabel('ʱ��\mus'),ylabel('������Ƶ��(kHz)'),zlabel('��һ����ֵ'),title('LFM-Signal�źŵ�ģ������ͼ������������ɢ������')
%��dBͼ
AF_LFM_dB = 20*log10(abs(AF_LFM)*1e4);
AF_LFM_dB(find(AF_LFM_dB<0))=0;
figure(4),colormap jet
mesh(tao*1e6,fd/1e3,AF_LFM_dB);
xlabel('ʱ��\mus'),ylabel('������Ƶ��(kHz)'),zlabel('��ֵ(dB)'),title('LFM-Signal�źŵ�ģ������ͼ������������ɢ������')

 %% Part 2 OFDM-LFM�ź���ɢ���ֽ��
clear,clc,close all
LFM_OFDM  %ִ��LFM_OFDM �ļ�����
load('LFM_OFDM.mat')
tao = -10e-6:10*Ts:10e-6;%�ӳ�ʱ��
B_range = B/50;
fd = -B_range:1e3:B_range;%������Ƶ��
AF_OFDM_LFM = zeros(length(fd),length(tao));
for i = 1:length(tao)
     if tao(i)<0
            int_region = 0:Ts:(Tp+tao(i));
        else 
            int_region = tao(i):Ts:Tp;
    end
    for k = 1:length(fd)
        for tt = int_region
            AF_OFDM_LFM(k,i)= AF_OFDM_LFM(k,i)+ LFM_OFDM_Signal(floor(tt/Ts+1))*conj(LFM_OFDM_Signal(floor((tt-tao(i))/Ts+1)))*exp(1j*2*pi*fd(k)*tt)*Ts;
        end
    end
 end
AF_OFDM_LFM = AF_OFDM_LFM/max(max(AF_OFDM_LFM));
figure(5),colormap jet
mesh(tao*1e6,fd/1e3,abs(AF_OFDM_LFM));
xlabel('ʱ��\mus'),ylabel('������Ƶ��(kHz)'),zlabel('��һ����ֵ'),title('OFDM-LFM�źŵ�ģ������ͼ����')
figure(6),colormap jet
AF_OFDM_LFM_dB = 20*log10(abs(AF_OFDM_LFM)*1e4);
AF_OFDM_LFM_dB(find(AF_OFDM_LFM_dB<0))=0;
mesh(tao*1e6,fd/1e3,AF_OFDM_LFM_dB);
xlabel('ʱ��\mus'),ylabel('������Ƶ��(kHz)'),zlabel('��ֵ(dB)'),title('OFDM-LFM�źŵ�ģ������ͼ����')

 %% Part 3 OFDM-LFM-Comm�ź���ɢ���ֽ��
clear,clc,close all
LFM_OFDM  %ִ��LFM_OFDM �ļ�����
load('LFM_OFDM.mat')
tao = -10e-6:10*Ts:10e-6;%�ӳ�ʱ��
B_range = B/50;
fd = -B_range:1e3:B_range;%������Ƶ��
AF_OFDM_LFM_Comm = zeros(length(fd),length(tao));
for i = 1:length(tao)
     if tao(i)<0
            int_region = 0:Ts:(Tp+tao(i));
        else 
            int_region = tao(i):Ts:Tp;
    end
    for k = 1:length(fd)
        for tt = int_region
            AF_OFDM_LFM_Comm(k,i)= AF_OFDM_LFM_Comm(k,i)+ LFM_OFDM_Comm(floor(tt/Ts+1))*conj(LFM_OFDM_Comm(floor((tt-tao(i))/Ts+1)))*exp(1j*2*pi*fd(k)*tt)*Ts;
        end
    end
 end
AF_OFDM_LFM_Comm = AF_OFDM_LFM_Comm/max(max(AF_OFDM_LFM_Comm));
figure(7),colormap jet
mesh(tao*1e6,fd/1e3,abs(AF_OFDM_LFM_Comm));
xlabel('ʱ��\mus'),ylabel('������Ƶ��(kHz)'),zlabel('��һ����ֵ'),title('LFM-Signal�źŵ�ģ������ͼ������������ɢ������')
figure(8),colormap jet
AF_OFDM_LFM_Comm_dB = 20*log10(abs(AF_OFDM_LFM_Comm)*1e4);
AF_OFDM_LFM_Comm_dB(find(AF_OFDM_LFM_Comm_dB<0))=0;
mesh(tao*1e6,fd/1e3,AF_OFDM_LFM_Comm_dB);
xlabel('ʱ��\mus'),ylabel('������Ƶ��(kHz)'),zlabel('��ֵ(dB)'),title('LFM-Signal�źŵ�ģ������ͼ������������ɢ������')
  