%%Sa����������
x = -30:0.01:30;
y = sin(x)./x;
y_abs = abs(y);
y_dB = 20*log(abs(y));
figure %��ͼ
subplot(311),plot(x,y),%��һ��Sa����ͼ
axis([-30,30,-0.3,1]),xlabel('t'),ylabel('��ֵ'),title('Sa����')
subplot(312),plot(x,y_abs)%��һ��Sa����ͼ����ֵȡ����ֵ
axis([-30,30,0,1]),xlabel('t'),ylabel('��ֵ'),title('Sa����')
subplot(313),plot(x,y_dB)%��һ��Sa��������ֵȡdBֵ
axis([-30,30,-100,0]),xlabel('t'),ylabel('��ֵ(dB)'),title('Sa����(dB)')
