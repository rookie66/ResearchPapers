function phi = dAngle(a,b)

d = a-b;
phi = mod(d,2*pi);
if phi > pi
    phi = 2*pi-phi;
end