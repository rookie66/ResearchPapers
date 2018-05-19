%仿真
clear all;
p(1:256,1)=1;
p1=ones(16,16);
load E52net net;
test=input('please input a test image:','s');
bw=imread(test,'bmp');
[i,j]=find(bw==0);
imin=min(i);
imax=max(i);
jmin=min(j);
jmax=max(j);
bw1=bw(imin:imax,jmin:jmax);
rate=16/max(size(bw1));
bw1=imresize(bw1,rate);
[i,j]=size(bw1);
i1=round((16-i)/2);
j1=round((16-j)/2);
 p1(i1+1:i1+i,j1+1:j1+j)=bw1;
     p1=-1.*p1+ones(16,16);
 for m=0:15
     p(m*16+1:(m+1)*16,1)=p1(1:16,m+1);
 end
 [a,Pf,Af]=sim(net,p);
 imshow(p1);
 a=round(a);
 switch a
    case 0,ch='A';
    case 1,ch='B';
    case 2,ch='C';
    case 3,ch='D';
    case 4,ch='E';
    case 5,ch='F';
    case 6,ch='G';
    case 7,ch='H';
    case 8,ch='I';
    case 9,ch='J';
    case 10,ch='K';
    case 11,ch='L';
    case 12,ch='M';
    case 13,ch='N';
    case 14,ch='O';
    case 15,ch='P';
    case 16,ch='Q';
    case 17,ch='R';
    case 18,ch='S';
    case 19,ch='T';
    case 20,ch='U';
    case 21,ch='V';
    case 22,ch='W';
    case 23,ch='X';
    case 24,ch='Y';
    case 25,ch='Z';
 end

%显示识别结果