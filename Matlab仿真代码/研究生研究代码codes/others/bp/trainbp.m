%´´½¨ºÍÑµÁ·ÍøÂç
clear all;
load E52PT p t;
pr(1:256,1)=0;
pr(1:256,2)=1;
net=newff(pr,[26 1],{'logsig' 'purelin'},'traingdx','learngdm');
net.trainParam.epochs=5000;
net.trainParam.goal=0.001;
net.trainParam.show=10;
net.trainParam.lr=0.05;
net=train(net,p,t);
save E52net net;