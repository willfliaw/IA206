invert1([H|T], R) :-
    invert1(T, [H|R]).

invert1([], _).

invert2(L, R) :- invert2(L, [], R).

invert2([X|L], A, R) :-
    invert2(L, [X|A], R).

invert2([], A, A).
