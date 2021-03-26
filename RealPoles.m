function [F] = RealPoles(F)
syms s
assume(s,'real')
simplify(F);
[B,A] = numden(F);
P = -solve(A);
% a = sym('s',1:length(P));

for i = 1:length(P)
    a(i) = simplify((s + P(i))*(B/A));
    a(i) = subs(a(i), s, -P(i));
end
Bi = factor(A);
a = flip(a);
% disp(a)
F = a * (1./(Bi'));
end

