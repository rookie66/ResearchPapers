%ทยีๆ
clear all;
p(1:256,1)=1;
p1=ones(16,16);
load E52net net;
test=input('please input a test image:','s');
x=imread(test,'bmp');
bw=im2bw(x,0.5);
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
 a=round(a)