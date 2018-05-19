clear all
clc
figure
[x,y]=crbondoaest(5);
plot(x,y,'r-x')
hold on
[x,y]=crbondoaest(10);
plot(x,y,'b-*')
hold on
[x,y]=crbondoaest(15);
plot(x,y,'g-o')
xlabel('beta'),ylabel('RMSE[deg]')