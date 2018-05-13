for i = 1:length(X2)
    if (X2(i)==0)
        continue
    elseif (X2(i)>0.01)
        X2(i)
    else
        %X2(i)
    end
   
end

X2(find(X2(find(X2 > 1))>4))
X2(find(X2 > 4))