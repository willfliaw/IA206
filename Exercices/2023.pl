% Q1

latten([X|L], L1) :-
    is_list(X),
    !,
    flatten(X, X1),
    flatten(L, L2),
    append(X1, L2, L1).

flatten([X|L], [X|L1]) :-
    flatten(L, L1).

flatten([ ], [ ]).

% ===

% Q2

path(X, Y) :-
    path1(X, Y, [X]).

path1(X, Y, _) :-
    edge(X, Y).

path1(X, Y, L) :-
    edge(X, Z),
    not(member(Z, L)),
    path1(Z, Y, [Z|L]).

% ===

% Q3

% a
P1: (∀x) (dog(x) ⊃ mammal(x))
P2: (∃x) (mammal(x) ∧ furry(x))
C: (∃x) (dog(x) ∧ furry(x))

% b

% The conclusion is not valid. Consider as domain the set of integers larger than 3.

% dog is interpreted as 'even', mammal as 'integer' and furry as 'prime'. P1 reads "even integers (larger than 3) are integers"; P2 reads "some integers (larger than 3) are prime. The conclusion “some even numbers (larger than 3) are prime" and it is false.

% ===

% Q4

1. [¬((∃w) (∀x) R(x, w, f(x, w)) ⊃ (∃u) (∀v) (∃y) R(v, u, y))]
2. [(∃w) (∀x) R(x, w, f(x, w))]
3. [(∀u) (∃v) (∀y) ¬R(v, u, y)]
4. [R(x, a, f(x, a))]  % skolemization of 2.
5. [¬R(sk(u), u, y)]   % skolemization of 3.
6. [ ]                 % unification of 4 and 5 with x = sk(u); u = a; y = f(x,a) -> R(sk(a), a, f(sk(a), a))

% ===

% Q6

% The lgg of 1. and 2. is:
c(Y) :- a(Y, X), f(X).
