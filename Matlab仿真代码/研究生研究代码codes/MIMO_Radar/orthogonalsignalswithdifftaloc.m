%%%%%%%%%%%Beam pattern fororthogonal signals with different target location

clear;
clc;
figure
[x,y]= ortrpattern(0);
plot(x,y,'k-')
hold on
[x,y] = ortrpattern(5);
plot(x,y,'r-.')
hold on
[x,y]= ortrpattern(10);
plot(x,y,'b--')
xlabel('��[deg]'),ylabel('Gain[db]')
legend('�ȡ�=0��','�ȡ�=5��','�ȡ�=10��',1)
title('orthogonalsignalswithdifferenttargetlocation,��=0')