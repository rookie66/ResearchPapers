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
xlabel('¦È[deg]'),ylabel('Gain[db]')
legend('¦È¡£=0¡ã','¦È¡£=5¡ã','¦È¡£=10¡ã',1)
title('orthogonalsignalswithdifferenttargetlocation,¦Â=0')