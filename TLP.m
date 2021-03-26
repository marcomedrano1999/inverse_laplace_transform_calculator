function [F, f] = TLP(F)
syms s;

[B,A] = numden(F);
r = @(x) length(sym2poly(x))-1;
rB = r(B);
rA = r(A); 


%Check if the degree of the numerator is equal or greater
% than the degree of the denominator
if rB >= rA 
    disp('división')
    [Q,R] = deconv(sym2poly(B),sym2poly(A));
    F = poly2sym(R,s)/A;
end

polos = poles(F);
%Check if F has different or repeated poles
if length(polos) ~= rA
    if length(polos)==1
        disp('Repeated poles')
        F = RepeatedPoles(F, rA);
    else
        disp('Mixed poles')
        F = MixedPoles(F);
    end
else
    disp('Different poles')
    F = DifferentPoles(F);
end


%If F was initially 
if exist('Q','var') == 1
    F = poly2sym(Q,s)+F;
end

f = ilaplace(F,s,'t');

end