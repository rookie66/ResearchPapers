clear,clc,close all
T=1;%m��������ʱ�䳤��
N_sample=8;%ÿ����Ԫȡ������
N=127;%m��������
dt=T/(N_sample*N);%�����ʱ����
t=0:dt:10*T-dt;%ʱ������
X=[1 1 1 1 1 1 1 1];%m���г���
C=[0 1 1 1 0 0 0 1];%�����߼�
%Y=m_sequence(X,C);%����m����
Y = My_M_Seq(C,X);
Y1=Y(1:127);%ȡһ��
matrix1=zeros(N,10);%����10�����ڵ�m����
m_se=zeros(1,10*N);
for i=1:10
      m_se(i*N-N+1:i*N)=Y1;
end
matrix_sample=zeros(N_sample,10*N);%ȡ��
for i=1:N_sample
       matrix_sample(i,:)=m_se;
 end
m_se_sam=reshape(matrix_sample,1,N*10*N_sample);
m_se_sam=1-2*m_se_sam;
m_se_sam1=m_se_sam(1:T/dt);%ȡһ������
[a,b]=xcorr(m_se_sam1,m_se_sam);%�������
subplot(311)
plot(b*dt,a)
N=255;
dt=T/(N_sample*N);
t=0:dt:10*T-dt;
Y1=Y;
matrix1=zeros(N,10);
m_se=zeros(1,10*N);
for i=1:10
      m_se(i*N-N+1:i*N)=Y1;
end
matrix_sample=zeros(N_sample,10*N);
for i=1:N_sample
       matrix_sample(i,:)=m_se;
 end
m_se_sam=reshape(matrix_sample,1,N*10*N_sample);
m_se_sam=1-2*m_se_sam;
m_se_sam1=m_se_sam(1:T/dt);
[a,b]=xcorr(m_se_sam1,m_se_sam);
subplot(312)
plot(b*dt,a)
N=255;
dt=T/(N_sample*N);
t=0:dt:10*T-dt;
X=[1 1 1 1 1 1 1 1];
C=[0 1 0 0 1 1 0 1];
%Y=m_sequence(X,C);
Y = My_M_Seq(C,X);
m_se=zeros(1,10*N);
for i=1:10
      m_se(i*N-N+1:i*N)=Y;
end
matrix_sample=zeros(N_sample,10*N);
for i=1:N_sample
       matrix_sample(i,:)=m_se;
 end
m_se_sam=reshape(matrix_sample,1,N*10*N_sample);
m_se_sam=1-2*m_se_sam;
m_se_sam1=m_se_sam(1:T/dt);
[a,b]=xcorr(m_se_sam1,m_se_sam);
subplot(313)
plot(b*dt,a);