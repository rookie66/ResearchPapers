%% �ĵ�����
% Part 1 LFM_Signal��LFM-Comm�źŵ������;
% Part 2 ��ɢ���ϲ���LFM�ź���LFM-Comm�ź���ط����ϲ�;
% Part 3 ������ɢ���ַ�������ԣ������Ƕ�����Ƶ�ƣ�LFM�ź���ɢ���ֽ��ʹ��trapz��cumtrapz����ʵ��;
% Part 4 ������ɢ���ַ�������ԣ������Ƕ�����Ƶ�ƣ�LFM-Comm�ź���ɢ���ֽ��ʹ��trapz��cumtrapz����ʵ��;
%% Part1  LFM_Signal��LFM-Comm�źŵ������
clear,clc,close all
LFM_Basic  %ִ��LFM_Basic �ļ�����
load('LFM_Basic.mat'),load('Comm_signal.mat')
[Corr_LFM_Signal,x1] = xcorr(LFM_Signal);%δ����֮ǰ��LFM�ź������
[Corr_LFM_Comm,x2] = xcorr(LFM_Comm);%��λ����֮���LFM-Comm�ź������
N = 5001;figure(1)
subplot(211),plot(10*x1/N,abs(Corr_LFM_Signal)/max(abs(Corr_LFM_Signal)))
xlabel('ʱ��\mus'),ylabel('����'),title('LFM-Signal�źŵ�����ط���')
subplot(212),plot(10*x2/N,abs(Corr_LFM_Comm)/max(abs(Corr_LFM_Comm)))
xlabel('ʱ��\mus'),ylabel('����'),title('LFM-Comm�źŵ�����ط���')
%% Part2 ��ɢ���ϲ���LFM�ź���LFM-Comm�ź���ط����ϲ�
clear,clc,close all
LFM_Basic  %ִ��LFM_Basic �ļ�����
load('LFM_Basic.mat'),load('Comm_signal.mat')
tao = -10e-6:Ts:10e-6; %�ӳ�ʱ��
% tao = -10e-6:20*Ts:10e-6; %�ӳ�ʱ��
Corr_LFM_Discrete = zeros(1,length(tao));
Corr_LFM_Comm_Discrete = zeros(1,length(tao));
for i = 1:length(tao)
     if tao(i)<0
            int_region = 0:Ts:(Tp+tao(i));
     else 
            int_region = tao(i):Ts:Tp;
     end
     tt = int_region;
     y_LFM =  LFM_Signal(floor(tt/Ts+1)).*conj(LFM_Signal(floor((tt-tao(i))/Ts+1)));
     y_Comm =  LFM_Comm(floor(tt/Ts+1)).*conj(LFM_Comm(floor((tt-tao(i))/Ts+1)));
     if  length(tt) ~= 1
         Corr_LFM_Discrete(i) = trapz(tt,y_LFM); 
         Corr_LFM_Comm_Discrete(i) = trapz(tt,y_Comm);
     else
         Corr_LFM_Discrete(i) = 0;
         Corr_LFM_Comm_Discrete(i) = 0;
     end
end
Corr_LFM_Discrete = Corr_LFM_Discrete/max(Corr_LFM_Discrete);                %��һ��
Corr_LFM_Comm_Discrete = Corr_LFM_Comm_Discrete/max(Corr_LFM_Comm_Discrete); %��һ��
figure(2),subplot(211),plot(tao*1e6,abs(Corr_LFM_Discrete));
xlabel('ʱ��\mus'),ylabel('��һ����ֵ'),title('LFM�źŵ�����ط�����������ɢ������')
subplot(212),plot(tao*1e6,abs(Corr_LFM_Comm_Discrete));
xlabel('ʱ��\mus'),ylabel('��һ����ֵ'),title('LFM-Comm�źŵ�����ط�����������ɢ������')
%% Part3 ������ɢ���ַ�������ԣ������Ƕ�����Ƶ�ƣ�LFM�ź���ɢ���ֽ��ʹ��trapz��cumtrapz����ʵ��
clear,clc,close all
LFM_Basic  %ִ��LFM_Basic �ļ�����
load('LFM_Basic.mat'),load('Comm_signal.mat')
tao = -10e-6:Ts:10e-6; %�ӳ�ʱ��
Corr_LFM_Discrete = zeros(1,length(tao));
for i = 1:length(tao)
     if tao(i)<0
            int_region = 0:Ts:(Tp+tao(i));
     else 
            int_region = tao(i):Ts:Tp;
     end
     tt = int_region;
     y_LFM =  LFM_Signal(floor(tt/Ts+1)).*conj(LFM_Signal(floor((tt-tao(i))/Ts+1)));
     if  length(tt) ~= 1
         Corr_LFM_Discrete(i) = trapz(tt,y_LFM); 
     else
         Corr_LFM_Discrete(i) = 0;
     end
end
Corr_LFM_Discrete = Corr_LFM_Discrete/max(Corr_LFM_Discrete);  %��һ��
figure(3),plot(tao*1e6,abs(Corr_LFM_Discrete));
xlabel('ʱ��\mus'),ylabel('��һ����ֵ'),title('LFM�źŵ�����ط�����������ɢ������')
%% Part4 ������ɢ���ַ�������ԣ������Ƕ�����Ƶ�ƣ�LFM-Comm�ź���ɢ���ֽ��ʹ��trapz��cumtrapz����ʵ��
clear,clc,close all
load('LFM.mat');
tao = -10e-6:Ts:10e-6; %�ӳ�ʱ��
Corr_LFM_Comm_Discrete = zeros(1,length(tao));
for i = 1:length(tao)
     if tao(i)<0
            int_region = 0:Ts:(Tp+tao(i));
     else 
            int_region = tao(i):Ts:Tp;
     end
     tt = int_region;
     y_Comm =  LFM_Comm(floor(tt/Ts+1)).*conj(LFM_Comm(floor((tt-tao(i))/Ts+1)));
     if  length(tt) ~= 1
         Corr_LFM_Comm_Discrete(i) = trapz(tt,y_Comm); 
     else
         Corr_LFM_Comm_Discrete(i) = 0;
     end
end
Corr_LFM_Comm_Discrete = Corr_LFM_Comm_Discrete/max(Corr_LFM_Comm_Discrete);
figure(4),plot(tao*1e6,abs(Corr_LFM_Comm_Discrete));
xlabel('ʱ��\mus'),ylabel('��һ����ֵ'),title('LFM-Comm�źŵ�����ط�����������ɢ������')