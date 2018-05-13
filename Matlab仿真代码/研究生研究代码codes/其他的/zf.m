function zf()%������������
clear all
close all
format long; %��������ʾΪ�����Ϳ�ѧ���� 
Nt=4;%�������߸���
Nr=4;%����������
SNR=[0:2:20];%���ò�ͬ����� ��0��ʼ0+2 0+2+2 ....��20������11����ͬ�������
channel_n=100*ones(1,length(SNR));%��ʼ���ŵ����� ����100�� 1*length��SNR����ȫ1�ŵ�����
error_zflinp=zeros(1,length(SNR));%��ʼ��������
for loop_ebno=1:length(SNR)%��ͬ����ȵ�ѭ��
    snr=10.^(SNR(loop_ebno)/10);%������ȴӷֱ���ʽת���ɱ�����ʾ
    ea=1;%ÿ�����߷���Ĺ��ʣ�Ҳ���ź�������ÿ��Ԫ�صĹ���
    es=ea*Nt;%�ܹ��ķ��书��
    sigma_n2=es/snr;%��������
    num=200;%�������ݸ���
    tic,
    for loop_channel=1:channel_n(loop_ebno)%�ŵ���ʵ�ִ�����ѭ��
        H=sqrt(1/2)*(randn(Nr,Nt)+j*randn(Nr,Nt));%�ŵ��������
        zf_F=H'*inv(H*H'); %���F^,����MIMO�ŵ�Ԥ���뼼���о�  ��Ҫ����p27  ����Ԥ������ȡ��α�����
        beta_zf=sqrt(es/norm(zf_F,'fro').^2);%����zf_F��Frobenius����%%�����������beta
        F_zf=beta_zf*zf_F;%���Ԥ�������F=F^��beta
        for loop_num=1:num%��һ֡���ݷ����У��ŵ����ֲ��䡣һ֡�ܹ���num�����ݷ���
            gen_u=(sign(randn(Nt,1))+j*sign(randn(Nt,1)));%�����ź�
            u=sqrt(1/2)*gen_u;%��һ���źŹ���
            x_zf=F_zf*u;%�����ź�
            noise1=sqrt(sigma_n2/2)*(randn(Nr,1)+j*randn(Nr,1));
            y_zf=H*x_zf+noise1;
            r_zf=1/beta_zf*y_zf;%�����ź�
            rev_data_zf=sign(real(r_zf))+j*sign(imag(r_zf));
            error_zflinp(1,loop_ebno)=error_zflinp(1,loop_ebno)+sum(((abs(rev_data_zf-gen_u)).^2)/4);
        end 
    end 
    toc                                                                                  
       ber_zflinp(1,loop_ebno)=error_zflinp(1,loop_ebno)/(num*Nt*2*channel_n(loop_ebno)); %����2����Ϊ�����������ݷ���ʽ�������൱�ڽ�����4QAM����
end


%������ͬ׼���������ʺ�����ȵ�����
hold on
P2=semilogy(SNR,ber_zflinp,'*-k');
set(P2,'Linewidth',[2]);%P2�߿�2��
grid on;
xlabel('symbol SNR(dB)');ylabel('BER');
title('����ZFԤ��������')
leg2='zflinear';
legend(leg2);
