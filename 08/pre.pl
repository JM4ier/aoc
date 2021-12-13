seg(0, [a,b,c,e,f,g]).
seg(1, [c,f]).
seg(2, [a,c,d,e,g]).
seg(3, [a,c,d,f,g]).
seg(4, [b,c,d,f]).
seg(5, [a,b,d,f,g]).
seg(6, [a,b,d,e,f,g]).
seg(7, [a,c,f]).
seg(8, [a,b,c,d,e,f,g]).
seg(9, [a,b,c,d,f,g]).

segp(N, L) :- seg(N, M), permutation(L, M).
con(C) :- segp(_, C).

all(_, []).
all(P, [X|XS]) :- call(P, X), all(P, XS).
