function aa = xxx2(n)
global x22 N1
    while(n<0)
        n = n + N1;
    end
    while(n>N1-1)
        n = n-N1;
    end
    if n >= 0 && n <= N1-1
        aa = x22(n+1);
    end
end
