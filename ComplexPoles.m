function [F] =ComplexPoles(F)
syms s

[B,A] = numden(F);
P = -solve(A);
Ai = s+P;
As = prod(Ai);
assume(s,'real')

a = sym('s',1:length(P));
for i = 1:length(P)
    a(i) = simplify((s+P(i))*(B/As));
    a(i) = subs(a(i),s,-P(i));
end
F = a*(1./(Ai));
end

