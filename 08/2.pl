num(S,I,O) :- segp(N, S), O is 10 * I + N.
process(C, N) :- all(con, C), foldl(num, N, 0, M), write(M), nl.
