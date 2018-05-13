    %%%%%%%%%%%产生雷达发射信号%%%%%%%%%%%%%
code=[1,1,1,1,1,-1,-1,1,1,-1,1,-1,1,];
tao=10e-6;      %脉冲宽度10us
fc=28e6;        %调频信号起始频率
f0=30e6;
fs=100e6;       %采样频率100MHz
ts=1/fs;
B=4e6;          %调频信号带宽
t_tao=0:1/fs:tao-1/fs;
N=length(t_tao);
k=B/fs*2*pi/max(t_tao);
n=length(code);
pha=0;

s=zeros(1,n*N);
for i=1:n
    if code(i)==1
        pha=pi;
    else pha=0;
    end
    s(1,(i-1)*N+1:i*N)=cos(2*pi*fc*t_tao+k*cumsum(t_tao)+pha);
end

t=0:1/fs:13*tao-1/fs;
figure(1),subplot(2,1,1),plot(t,s);
s_fft_result=abs(fft(s(1:N)));
subplot(2,1,2),plot((0:fs/N:fs/2-fs/N),abs(s_fft_result(1:N/2)));

%%%产生脉压系数%%%%%%%%%%%
%%%%%%%%正交解调%%%%%%%%%%%%
N=tao/ts;
n=0:N-1;
sl=s(1:N);
local_oscillator_i=cos(n*f0/fs*2*pi);
local_oscillator_q=sin(n*f0/fs*2*pi);
fbb_i=local_oscillator_i.*sl;
fbb_q=local_oscillator_q.*sl;
window=chebwin(51,40);
[b,a]=fir1(50,2*B/fs,window);
fbb_i=[fbb_i,zeros(1,25)];
fbb_q=[fbb_q,zeros(1,25)];
fbb_i=filter(b,a,fbb_i);
fbb_q=filter(b,a,fbb_q);
fbb_i=fbb_i(26:end);
fbb_q=fbb_q(26:end);
fbb=fbb_i+j*fbb_q;

%产生理想线性调频脉冲压缩匹配系数%
M=131126;
D=B*tao;
match_filter_1=ts*fliplr(conj(fbb))*sqrt(D)*2/tao;
match_filter_1_fft=fft(match_filter_1,M);
figure(2),subplot(2,1,1),plot(real(match_filter_1_fft)),title('脉压系数');
subplot(2,1,2),plot(imag(match_filter_1_fft)),title('脉压系数虚');

N=length(s);
n=0:N-1;
local_oscillator_i=cos(n*f0/fs*2*pi);
local_oscillator_q=sin(n*f0/fs*2*pi);
fbb_i=local_oscillator_i.*s;
fbb_q=local_oscillator_q.*s;
window=chebwin(51,40);
[b,a]=fir1(50,0.5,window);
fbb_i=[fbb_i,zeros(1,25)];
fbb_q=[fbb_q,zeros(1,25)];
fbb_i=filter(b,a,fbb_i);
fbb_q=filter(b,a,fbb_q);
fbb_i=fbb_i(26:end);
fbb_q=fbb_q(26:end);
signal=fbb_i+j*fbb_q;
clear fbb_i;
clear fbb_q;

signal_fft=fft(signal,M);
pc_result_fft=signal_fft.*match_filter_1_fft;
pc_result=ifft(pc_result_fft,M);
figure(3),plot((0:ts:length(signal)*ts-ts),pc_result(1:length(signal))),xlabel('时间，s'),title('回波脉压处理结果');

clear local_oscillator_i;
clear local_oscillator_q;

t=tao*length(code);
match_filter_2=2*ts*fliplr(conj(pc_result))*2/t;
match_filter_2_fft=fft(match_filter_2,M);
figure,subplot(2,1,1),plot(real(match_filter_2_fft)),title('脉压系数实部');
subplot(2,1,2),plot(imag(match_filter_2_fft)),title('脉压系数虚部');
clear fbb;
clear match_filter_1;
clear match_filter_2;
clear signal;
clear signal_fft;
clear pc_result;
clear pc_result_fft;

%%%%%%产生雷达回波%%%%%%%%%%
f_frame=1e3;
T_frame=1/f_frame;
N_echo_frame=18;

f_doppler=3.5e3;
t_frame=0:ts:T_frame-ts;
t_mobj=200e-6;
echo_mobj_pulse=[zeros(1,t_mobj/ts),s,zeros(1,(T_frame-t_mobj)/ts-length(s))];
echo_mobj=repmat(echo_mobj_pulse,1,N_echo_frame);
t_doppler=0:ts:N_echo_frame*T_frame-ts;
s_doppler=cos(2*pi*f_doppler*t_doppler);
s_echo_mobj=echo_mobj.*s_doppler;

t_fobj=450e-6;
echo_fobj_pulse=[zeros(1,t_fobj/ts),s,zeros(1,(T_frame-t_fobj)/ts-length(s))];
s_echo_fobj=repmat(echo_fobj_pulse,1,N_echo_frame);

t_clutter=700e-6;
t_clutter_pulse=39e-6;
sigma=2;
tl=0:ts:t_clutter_pulse-ts;
rand('state',0);
u=rand(1,length(tl));
echo_clutter=0.08*sqrt(2*log(1./u))*sigma;%.*s;
s_echo_clutter_pulse=[zeros(1,t_clutter/ts),echo_clutter,zeros(1,(T_frame-t_clutter)/ts-length(echo_clutter))];
s_echo_clutter=repmat(s_echo_clutter_pulse,1,N_echo_frame);

s_noise=0.1*rand(1,N_echo_frame*T_frame/ts);

s_echo=s_echo_mobj+s_echo_fobj+s_echo_clutter+s_noise;
figure,plot(s_echo);
clear s_echo_mobj;
clear s_echo_fobj;
clear s_echo_clutter;
clear s_echo_clutter_pulse;
clear s_noise;
clear echo_mobj_pulse;
clear echo_mobj;
clear echo_fobj_pulse;
clear echo_clutter;
clear s_doppler;
clear t_doppler;

%%%%%%%%%%%%%正交解调%%%%%%%%%%%%%%
N=N_echo_frame*T_frame/ts;
n=0:N-1;
local_oscillator_i=cos(n*f0/fs*2*pi);
local_oscillator_q=sin(n*f0/fs*2*pi);
s_echo_i=local_oscillator_i.*s_echo;
s_echo_q=local_oscillator_q.*s_echo;
window=chebwin(51,40);
[b,a]=fir1(50,2*B/fs,window);
s_echo_i=[s_echo_i,zeros(1,25)];
s_echo_q=[s_echo_q,zeros(1,25)];
s_echo_i=filter(b,a,s_echo_i);
s_echo_q=filter(b,a,s_echo_q);
s_echo_i=s_echo_i(26:end);
s_echo_q=s_echo_q(26:end);
s_echo_mf=s_echo_i+j*s_echo_q;
clear s_echo;
clear local_oscillator_i;
clear local_oscillator_q;
clear s_echo_i;
clear s_echo_q;
clear n;

%%%%%%%%%%%%%%%%脉压处理%%%%%%%%%%%%%%%%%%%%
for i=1:N_echo_frame
    s_echo_fft_result=fft(s_echo_mf(1,(i-1)*T_frame/ts+1:i*T_frame/ts),M);
    s_pc_fft_1=s_echo_fft_result.*match_filter_1_fft;
    s_pc_fft_2=s_pc_fft_1.*match_filter_2_fft;
    s_pc_result(i,:)=ifft(s_pc_fft_2,M);
end
clear s_echo_mf;

s_pc_result_1=s_pc_result';
s_pc_result_1=reshape(s_pc_result_1,1,N_echo_frame*M);
figure,subplot(2,1,1),plot(real(s_pc_result_1)),xlabel('t(单位：s)'),title('脉压处理结果（实部）');
subplot(2,1,2),plot(imag(s_pc_result_1)),xlabel('t(单位：s)'),title('脉压处理结果（虚部）');

%%%%%%%%%%%%%%%%%%%%MTI固定杂波对消处理%%%%%%%%%%%%%%%%%%%%%%
for i=1:16
    s_MTI_result(i,:)=s_pc_result(i,:)+s_pc_result(i+2,:)-2*s_pc_result(i+1,:);
end

clear s_pc_result;
clear s_pc_result_1;
s_MTI_result_1=s_MTI_result';
s_MTI_result_1=reshape(s_MTI_result_1,1,(N_echo_frame-2)*M);
figure,subplot(2,1,1),plot(real(s_MTI_result_1));
xlabel('t(单位：s)'),title('MTI处理结果（实部）');
subplot(2,1,2),plot(imag(s_MTI_result_1));
xlabel('t(单位：s)'),title('MTI处理结果（虚部）');
clear s_MTI_result_1;

%%%%%%%%%%%%%%%%MTD%%%%%%%%%%%%%%%%%%%%%%
% for i=1:T_frame/ts
%     s_MTD_result_1(:,i)=fft(s_MTI_result(:,i),16);
% end
% for i=1:T+frame/ts
%     s_MTD_result(i)=abs(max(s_MTD_result_1));
% end
% figure,plot(s_MTD_result),
% xlabel('t(单位：s)'),title('MTD处理求模结果（信号最大通道）');

%%%%%%%%%%%%%%%%CFAR处理%%%%%%%%%%%%%%%%%%%%%%
% N=T_frame/ts;
% cfar_result(1,1)=s_MTD_result(1,1)/(sqrt(2)/pi*mean(s_MTD_result1,2:17)));
% 
% for i=2:16
%     noise_mean=sqrt(2)/pi*(mean(s_MTD_result(1,1:i-1))+mean(s_MTD_result(1,i+1:i+16)))/2;
%     cfar_result(1,i)=s_MTD_result(1,i)/noise_mean;
% end
% for i=17:N-17
%     noise_mean=sqrt(2)/pi*max(mean(s_MTD_result(1,i-16:i-1)),mean(s_MTD_result(1,i+1:i+16)));
%     cfar_result(1,i)=s_MTD_result(1,i)/noise_mean;
% end
% 
% cfar_result(1,N)=s_MTD_result(1,N)/(sqrt(2)/pi*mean(s_MTD_result(1,N-16:N-1)));
% figure,plot((0:ts:N_echo_frame*T_frame-ts,cfar_result),xlabel('t(单位：s)'),title('采用恒虚警处理结果');