function[mseq]=MSequence_New(fbconnection,seed) 
n=length(fbconnection); 
N=2^n-1;  
register= seed;  %��λ�Ĵ����ĳ�ʼ״̬ 
mseq(1)=register(n);        %m���еĵ�һ�������Ԫ 
for i=2:N      
newregister(1)=mod(sum(fbconnection.*register),2);     
for j=2:n          
newregister(j)=register(j-1);     
end;      
register=newregister;     
mseq(i)=register(n); 
end    
end