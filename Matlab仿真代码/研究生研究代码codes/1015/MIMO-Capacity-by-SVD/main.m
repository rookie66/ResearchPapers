% in this programe a highly scattered enviroment is considered. The
% Capacity of a MIMO channel with nt transmit antenna and nr recieve
% antenna is analyzed. The power in parallel channel (after
% decomposition) is distributed as water-filling algorithm
 
% the pdf of the matrix lanada elements is depicted too.
clear all,close all,clc
% MIMO
nt_V = [1 2 3 2 4];
nr_V = [1 2 2 3 4];
%
N0 = 1e-4;
B  = 1;%带宽单位化
Iteration = 1e3; % must be grater than 1e2
% 
SNR_V_db = -10:3:20;%
SNR_V    = 10.^(SNR_V_db/10);%SNR
% 0.1000 0.1995 0.3981 0.7943 1.5849  3.1623  6.3096 12.5893 25.1189 50.1187 100.00
% 
color = ['b';'r';'g';'k';'c'];
notation = ['-o';'->';'<-';'-^';'-s'];
%
for k = 1 : 5
    nt = nt_V(k);
    nr = nr_V(k);
    for i = 1 : length(SNR_V)
        Pt = N0 * SNR_V(i);
        for j = 1 : Iteration
            H = random('rayleigh',1,nr,nt);
            [U D V] = svd(H);
            % landas(:,j)  = diag(V);%提取信道矩阵H的奇异值,第j列
            % [Capacity(i,j) PowerAllo] = WaterFilling_alg(Pt,landas(:,j),B,N0);
            Capacity1(i,j) =getCapacityMean(Pt,D,nt);
            Capacity2(i,j) =getCapacity(Pt,D,nt);
        end
    end
 
    f1 = figure(1);
    hold on
    plot(SNR_V_db,mean(Capacity1'),notation(k,:),'color',color(k,:))
    title('功率平均分配')
    f2 = figure(2);
    hold on
    plot(SNR_V_db,mean(Capacity2'),notation(k,:),'color',color(k,:))
    title('注水法分配功率');
    
end
 

 
legend_str = [];
for( i = 1 : length(nt_V))
    legend_str =[ legend_str ;...
        {['nt = ',num2str(nt_V(i)),' , nr = ',num2str(nr_V(i))]}];
end

 f1 = figure(1)
legend(legend_str)
grid on
set(f1,'color',[1 1 1])
xlabel('SNR in dB')
ylabel('Capacity bits/s/Hz')

 f2 = figure(2)
legend(legend_str)
grid on
set(f2,'color',[1 1 1])
xlabel('SNR in dB')
ylabel('Capacity bits/s/Hz')
 
