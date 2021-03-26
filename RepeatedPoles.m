function [F] = RepeatedPoles(F, r)

syms s;
[B,A] = numden(F);
P = -solve(A);
% b = sym('s',1:r);
for i = 1:r
    b(i) = simplify(((s+P(1))^r) *(B/A));
    b(i) = (1/factorial(r -i)) * diff(b(i),s,r - i);
    b(i) = subs(b(i), s, -P(1));
    b(i) = b(i) / ((s + P(1))^i);
end
F = sum(b);
end

