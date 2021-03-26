function [F] = MixedPoles(F)
syms s
assume(s,'real')
simplify(F);
[B,A] = numden(F);
P = -solve(A);

[GC,GR]=groupcounts(P);

for j=1:length(GR)
    if(GC(j)==1)
        if(GR(j)==real(GR(j)))
            dist(j) = simplify((s + GR(j))*(B/A));
            dist(j) = subs(dist(j), s, -GR(j));
            dist(j) = dist(j) / (s+GR(j));
        else
            disp('Polos complejos');
            Ai = s+P;
            dist(j) = simplify((s+GR(j))*(B/prod(Ai)));
            dist(j) = subs(GR(j),s,-GR(j));
        end
%         disp(dist(j))
%         rep(j) = 0;
    else
        r = GC(j);
        for i=1:GC(j) 
            b(i) = simplify(((s+GR(j))^r) *(B/A));
            b(i) = (1/factorial(r -i)) * diff(b(i),s,r - i);
            b(i) = subs(b(i), s, -GR(j));
            b(i) = b(i) / ((s + GR(j))^i);
        end
        rep(j) = sum(b);
%         dist(j)=0;
    end
   
if exist('rep','var') == 1
    if exist('dist','var') == 1
       F = sum(rep)+ sum(dist);
    else
       F =  sum(rep);
    end
else
    F = sum(dist);
end

% F = sum(rep) + sum(dist);
% disp(F);
end

