function z = sinc(x)
if isequal(x,sym(0))
    z = 1;
else 
    z = sin(x)/x;
end

