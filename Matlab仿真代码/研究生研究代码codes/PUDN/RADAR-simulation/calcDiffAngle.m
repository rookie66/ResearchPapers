function dAngle = calcDiffAngle(a,b)
% function dAngle = calcDiffAngle(a,b)
% This function calculate the angle diffrence between a & b
% a & b  should be in range of [0 2pi]
% This function don't have any data checks (real-time performance)

dAngle = mod(b-a,2*pi);
dAngle( dAngle > pi ) = dAngle( dAngle > pi ) -2*pi;