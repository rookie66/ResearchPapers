
clear all;
M=1;               %人数
N=26*M;            %样本数
%---------------------------------------------------
for kk=0:N-1
     p1=ones(16,16);
     m=strcat(int2str(kk),'.bmp');
     bw=imread(m,'bmp');
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
end
%--------------------------------------------------
for kk=0:M-1
    for ii=0:25
       t(kk+ii+1)=ii;
    end
end
save E52PT p t;