function [F] = DifferentPoles(F)
    
syms s;

polos = poles(F);

if polos == real(polos)
   disp('Real poles')
   F = RealPoles(F);
else
    disp('Complex poles')
    F = ComplexPoles(F);
end
end

