%%Sa函数的特性
x = -30:0.01:30;
y = sin(x)./x;
y_abs = abs(y);
y_dB = 20*log(abs(y));
figure %作图
subplot(311),plot(x,y),%作一个Sa函数图
axis([-30,30,-0.3,1]),xlabel('t'),ylabel('幅值'),title('Sa函数')
subplot(312),plot(x,y_abs)%作一个Sa函数图，其值取绝对值
axis([-30,30,0,1]),xlabel('t'),ylabel('幅值'),title('Sa函数')
subplot(313),plot(x,y_dB)%作一个Sa函数，其值取dB值
axis([-30,30,-100,0]),xlabel('t'),ylabel('幅值(dB)'),title('Sa函数(dB)')
