%%%%%%%%%%%Beam pattern for coherent signals with different target location

clear;
clc;
figure
[x,y]= trpattern(0);
plot(x,y,'k-')
hold on
[x,y] = trpattern(5);
plot(x,y,'r-.')
hold on
[x,y]= trpattern(10);
plot(x,y,'b--')
xlabel('¦È[deg]'),ylabel('Gain[db]')
legend('¦È¡£=0¡ã','¦È¡£=5¡ã','¦È¡£=10¡ã',1)
title('coherentsignalswithdifferenttargetlocation,¦Â=1')