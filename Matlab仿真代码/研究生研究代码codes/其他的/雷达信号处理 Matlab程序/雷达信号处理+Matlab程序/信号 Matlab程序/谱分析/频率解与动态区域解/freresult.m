A1=1;
A2=1;
f0=30;
deltaf=1;
switch 2
    case 1
        %����Ƶ��90HZ,NΪ180,NFFTΪ2048
        t=0:1/90:2-1/90;
        x=A1*cos(2*pi*f0*t)+A2*cos(2*pi*(f0+deltaf)*t);
%         t2=1.00:1/90:20.47;
%         x2=zeros(1,length(t2));
%         t=[t1 t2];
%         x=[x1 x2];
        X=abs(fftshift(fft(x,2048)));
        f=([0:2047]-1024)/2048*90;
        subplot(211),plot(f(1400:end),X(1400:end));title('���δ�');grid on
        %�Ӻ�����
        w=(hanning(length(t)))';
        xa=x.*w;
        Xa=abs(fftshift(fft(xa,2048)));
        fa=([0:2047]-1024)/2048*90;
        subplot(212),plot(fa(1400:end),Xa(1400:end));title('������');grid on

    
        case 2
        %����Ƶ��90HZ,NΪ360,NFFTΪ2048
        t=0:1/90:4-1/90;
        x=A1*cos(2*pi*f0*t)+A2*cos(2*pi*(f0+deltaf)*t);
%         t2=2.00:0.01:20.47;
%         x2=zeros(1,length(t2));
%         t=[t1 t2];
%         x=[x1 x2];
        X=abs(fftshift(fft(x,2048)));
        f=([0:2047]-1024)/2048*90;
        subplot(211),plot(f(1250:end),X(1250:end));title('���δ�');grid on
        %�Ӻ�����
        w=(hanning(length(t)))';
        xa=x.*w;
        Xa=abs(fftshift(fft(xa,2048)));
        fa=([0:2047]-1024)/2048*90;
        subplot(212),plot(fa(1250:end),Xa(1250:end));title('������');grid on
        
        
    case 3
        %����Ƶ��90HZ,NΪ540,NFFTΪ2048
        t=0:1/90:6-1/90;
        x=A1*cos(2*pi*f0*t)+A2*cos(2*pi*(f0+deltaf)*t);
%         t2=4.00:0.01:20.47;
%         x2=zeros(1,length(t2));
%         t=[t1 t2];
%         x=[x1 x2];
        X=abs(fftshift(fft(x,2048)));
        f=([0:2047]-1024)/2048*90;
        subplot(211),plot(f(1250:end),X(1250:end));title('���δ�');grid on
        %�Ӻ�����
        w=(hanning(length(t)))';
        xa=x.*w;
        Xa=abs(fftshift(fft(xa,2048)));
        fa=([0:2047]-1024)/2048*90;
        subplot(212),plot(fa(1250:end),Xa(1250:end));title('������');grid on
end    
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        %     case 2
%         %����Ƶ��100HZ,NΪ200,NFFTΪ2048
%         t1=0:0.01:1.99;
%         x1=A1*cos(2*pi*f0*t1)+A2*cos(2*pi*(f0+deltaf)*t1);
%         t2=2.00:0.01:20.47;
%         x2=zeros(1,length(t2));
%         t=[t1 t2];
%         x=[x1 x2];
%         X=abs(fftshift(fft(x)));
%         f=(t/length(t)*100-0.499)*100;
%         subplot(211),plot(f(1250:end),X(1250:end));title('���δ�');grid on
%         %�Ӻ�����
%         w=(hanning(length(t)))';
%         xa=x.*w;
%         Xa=abs(fftshift(fft(xa)));
%         fa=(t/length(t)*100-0.499)*100;
%         subplot(212),plot(fa(1250:end),Xa(1250:end));title('������');grid on
%         
%         
%     case 3
%         %����Ƶ��100HZ,NΪ400,NFFTΪ2048
%         t1=0:0.01:3.99;
%         x1=A1*cos(2*pi*f0*t1)+A2*cos(2*pi*(f0+deltaf)*t1);
%         t2=4.00:0.01:20.47;
%         x2=zeros(1,length(t2));
%         t=[t1 t2];
%         x=[x1 x2];
%         X=abs(fftshift(fft(x)));
%         f=(t/length(t)*100-0.499)*100;
%         subplot(211),plot(f(1250:end),X(1250:end));title('���δ�');grid on
%         %�Ӻ�����
%         w=(hanning(length(t)))';
%         xa=x.*w;
%         Xa=abs(fftshift(fft(xa)));
%         fa=(t/length(t)*100-0.499)*100;
%         subplot(212),plot(fa(1250:end),Xa(1250:end));title('������');grid on
% end























