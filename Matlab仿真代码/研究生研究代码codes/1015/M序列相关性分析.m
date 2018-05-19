clear,clc,close all
g1 = [1 0 0 0 0 0 1];
g2 = [0 0 1 0 0 0 1];
%seed1 = [1 0 0 0 1 1];
%seed2 = [0 0 0 0 0 1];
seed3 = [0 0 0 0 0 0 1];
%M1 = m_sequence(g1,seed1);
%M2 = m_sequence(g1,seed2);
M1 =  My_M_Seq(g1,seed3);
M2 =  My_M_Seq(g2,seed3);
for i = 1:length(M1)
    if M1(i)==0
        M1(i)=-1;
    end
end
for i = 1:length(M2)
    if M2(i)==0
        M2(i)=-1;
    end
end

%Msum = mod(M1+M2,2);
Msum = M1+M2;

%option = 'unbiased';
option = 'none';
[Rm11,Rtm11]=xcorr(M1,option);
[Rm22,Rtm22]=xcorr(M2,option);
[Rm12,Rtm12]=xcorr(M1,M2,option);
[Rsum1,Rtsum1]=xcorr(Msum,M1,option);
[Rsum2,Rtsum2]=xcorr(Msum,M2,option);
%[Rm11]=CroCorr(M1,M1);
%[Rm22]=CroCorr(M2,M2);
%[Rm12]=CroCorr(M1,M2);
%[Rsum1]=CroCorr(Msum,M1);
%[Rsum2]=CroCorr(Msum,M2);
figure(1)
plot(Rtm11,Rm11/max(Rm11))
title('M1自相关特性')
figure(2)
plot(Rtm22,Rm22/max(Rm22))
title('M2自相关特性')
figure(3)
plot(Rtm12,Rm12/max(Rm12))
title('M1与M2互相关特性')
figure(4)
plot(Rtsum1,Rsum1/max(Rsum1))
title('M1+M2与M1互相关特性')
figure(5)
plot(Rtsum2,Rsum2/max(Rsum2))
title('M1+M2与M2互相关特性')
figure(6)
subplot(311)
plot(Rtm12,Rm12)
title('M1与M2互相关特性')
axis([-150,150,-30,30])
subplot(312)
plot(Rtsum1,Rsum1)
title('M1+M2与M1互相关特性')
axis([-150,150,-30,150])
subplot(313)
plot(Rtsum2,Rsum2)
axis([-150,150,-30,150])
title('M1+M2与M2互相关特性')


