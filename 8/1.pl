num(S) :- segp(N, S), write(N), nl.
process(C, N) :- all(con, C), all(num, N).
