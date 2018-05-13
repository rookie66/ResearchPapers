function [Phi]=getPhi(P)
   global L 
   Phi =P*P'/L;    %Phi=P*P^H/L
end