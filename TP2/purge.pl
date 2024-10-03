purge([X|L], Lnodup) :-
    member(X, L),
    !,
    purge(L, Lnodup).

purge([X|L], [X|Lnodup]) :-
    purge(L, Lnodup).

purge([], []).
