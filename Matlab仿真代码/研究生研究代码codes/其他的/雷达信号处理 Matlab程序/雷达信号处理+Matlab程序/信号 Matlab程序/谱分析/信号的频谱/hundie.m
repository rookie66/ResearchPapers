n1 = 0:0.01:5;
x1 =sin(2*pi*(22)*n1);
figure;subplot(2,3,1);
plot(n1,x1);grid on
title('f=22时的模拟时域图')
subplot(2,3,4);
plot((n1/length(n1)*100-0.499)*100,abs(fftshift(fft(x1))));grid on
title('f=22时的频谱')
n2 = 0:0.05:5;
nn2 = 0:1:length(n2)-1;
x2 = sin(2*pi*(22)*n2);
subplot(2,3,2);
stem(nn2,x2);grid on
title('F=22/20时的离散时域图')
subplot(2,3,5);
plot((n2/length(n2)*20-0.49)-round(n2/length(n2)*20-0.49),abs(fftshift(fft(x2))));grid on
title('F=22/20时的频谱')
n3 = 0:0.02:5;
nn3 = 0:1:length(n3)-1;
x3 = sin(2*pi*(22)*n3);
subplot(2,3,3);
stem(nn3,x3);grid on
title('F=22/50时的离散时域图')
subplot(2,3,6);
plot((n3/length(n3)*50-0.499)-round(n3/length(n3)*50-0.499),abs(fftshift(fft(x3))));grid on
title('F=22/50时的频谱')
%%%%%%%%%%%%%恢复的正弦信号的频率小于原信号的频率
figure;subplot(2,2,1);
plot(n2,x2);grid on;
title('混叠的时域信号(f=22Hz)')
n1 = 0:0.01:5;
x1 = cos(2*pi*(22)*n1);
subplot(2,2,2);
plot(n1,x1);grid on
title('原时域信号(f=22Hz)')
subplot(2,2,3);
plot(((n2/length(n2)*20-0.49)-round(n2/length(n2)*20-0.49))*100,abs(fftshift(fft(x2))));grid on
title('混叠的时域信号的频谱(f=22Hz)')
subplot(2,2,4);
plot((n1/length(n1)*100-0.499)*100,abs(fftshift(fft(x1))));grid on;
title('原时域信号的频谱(f=22Hz)');








