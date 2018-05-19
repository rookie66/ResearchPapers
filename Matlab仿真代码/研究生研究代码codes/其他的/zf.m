function zf()%定义命名函数
clear all
close all
format long; %将数据显示为长整型科学计数 
Nt=4;%发送天线个数
Nr=4;%接收天线数
SNR=[0:2:20];%设置不同信噪比 从0开始0+2 0+2+2 ....到20结束的11个不同的信噪比
channel_n=100*ones(1,length(SNR));%初始化信道矩阵 建立100组 1*length（SNR）的全1信道矩阵
error_zflinp=zeros(1,length(SNR));%初始化误码率
for loop_ebno=1:length(SNR)%不同信噪比的循环
    snr=10.^(SNR(loop_ebno)/10);%将信噪比从分贝形式转化成比例表示
    ea=1;%每个天线发射的功率，也即信号向量中每个元素的功率
    es=ea*Nt;%总共的发射功率
    sigma_n2=es/snr;%噪声功率
    num=200;%发送数据个数
    tic,
    for loop_channel=1:channel_n(loop_ebno)%信道的实现次数的循环
        H=sqrt(1/2)*(randn(Nr,Nt)+j*randn(Nr,Nt));%信道增益矩阵
        zf_F=H'*inv(H*H'); %求出F^,文献MIMO信道预编码技术研究  重要文献p27  线性预编码器取右伪逆矩阵
        beta_zf=sqrt(es/norm(zf_F,'fro').^2);%计算zf_F的Frobenius范数%%求出缩放因子beta
        F_zf=beta_zf*zf_F;%求出预编码矩阵F=F^×beta
        for loop_num=1:num%在一帧数据符号中，信道保持不变。一帧总共有num个数据发送
            gen_u=(sign(randn(Nt,1))+j*sign(randn(Nt,1)));%产生信号
            u=sqrt(1/2)*gen_u;%归一化信号功率
            x_zf=F_zf*u;%发送信号
            noise1=sqrt(sigma_n2/2)*(randn(Nr,1)+j*randn(Nr,1));
            y_zf=H*x_zf+noise1;
            r_zf=1/beta_zf*y_zf;%接收信号
            rev_data_zf=sign(real(r_zf))+j*sign(imag(r_zf));
            error_zflinp(1,loop_ebno)=error_zflinp(1,loop_ebno)+sum(((abs(rev_data_zf-gen_u)).^2)/4);
        end 
    end 
    toc                                                                                  
       ber_zflinp(1,loop_ebno)=error_zflinp(1,loop_ebno)/(num*Nt*2*channel_n(loop_ebno)); %乘以2是因为，产生的数据符号式复数，相当于进行了4QAM调制
end


%画出不同准则下误码率和信噪比的曲线
hold on
P2=semilogy(SNR,ber_zflinp,'*-k');
set(P2,'Linewidth',[2]);%P2线宽2号
grid on;
xlabel('symbol SNR(dB)');ylabel('BER');
title('基于ZF预编码性能')
leg2='zflinear';
legend(leg2);
