n1 = 0:0.01:5;
x1 =sin(2*pi*(22)*n1);
figure;subplot(2,3,1);
plot(n1,x1);grid on
title('f=22ʱ��ģ��ʱ��ͼ')
subplot(2,3,4);
plot((n1/length(n1)*100-0.499)*100,abs(fftshift(fft(x1))));grid on
title('f=22ʱ��Ƶ��')
n2 = 0:0.05:5;
nn2 = 0:1:length(n2)-1;
x2 = sin(2*pi*(22)*n2);
subplot(2,3,2);
stem(nn2,x2);grid on
title('F=22/20ʱ����ɢʱ��ͼ')
subplot(2,3,5);
plot((n2/length(n2)*20-0.49)-round(n2/length(n2)*20-0.49),abs(fftshift(fft(x2))));grid on
title('F=22/20ʱ��Ƶ��')
n3 = 0:0.02:5;
nn3 = 0:1:length(n3)-1;
x3 = sin(2*pi*(22)*n3);
subplot(2,3,3);
stem(nn3,x3);grid on
title('F=22/50ʱ����ɢʱ��ͼ')
subplot(2,3,6);
plot((n3/length(n3)*50-0.499)-round(n3/length(n3)*50-0.499),abs(fftshift(fft(x3))));grid on
title('F=22/50ʱ��Ƶ��')
%%%%%%%%%%%%%�ָ��������źŵ�Ƶ��С��ԭ�źŵ�Ƶ��
figure;subplot(2,2,1);
plot(n2,x2);grid on;
title('�����ʱ���ź�(f=22Hz)')
n1 = 0:0.01:5;
x1 = cos(2*pi*(22)*n1);
subplot(2,2,2);
plot(n1,x1);grid on
title('ԭʱ���ź�(f=22Hz)')
subplot(2,2,3);
plot(((n2/length(n2)*20-0.49)-round(n2/length(n2)*20-0.49))*100,abs(fftshift(fft(x2))));grid on
title('�����ʱ���źŵ�Ƶ��(f=22Hz)')
subplot(2,2,4);
plot((n1/length(n1)*100-0.499)*100,abs(fftshift(fft(x1))));grid on;
title('ԭʱ���źŵ�Ƶ��(f=22Hz)');








