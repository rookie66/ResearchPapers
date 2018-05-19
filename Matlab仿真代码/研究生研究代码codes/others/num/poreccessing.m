clear all;
for kk=0:29
     p1=ones(16,16);
     m=strcat(int2str(kk),'.bmp');
     x=imread(m,'bmp');
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
         p(m*16+1:(m+1)*16,kk+1)=p1(1:16,m+1);
     end
     switch kk
         case {0,10,20}
             t(kk+1)=0;
         case{1,11,21}
             t(kk+1)=1;
         case{2,12,22}
             t(kk+1)=2;
          case{3,13,23}
             t(kk+1)=3;
         case{4,14,24}
             t(kk+1)=4;
         case{5,15,25}
             t(kk+1)=5;
             case{6,16,26}
             t(kk+1)=6;
             case{7,17,27}
             t(kk+1)=7;
             case{8,18,28}
             t(kk+1)=8;
             case{9,19,29}
             t(kk+1)=9;
     end
end
save E52PT p t;