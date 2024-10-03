parent(marge, lisa).
parent(marge, bart).
parent(marge, maggie).
parent(homer, lisa).
parent(homer, bart).
parent(homer, maggie).
parent(abraham, homer).
parent(abraham, herb).
parent(mona, homer).
parent(jackie, marge).
parent(clancy, marge).
parent(jackie, patty).
parent(clancy, patty).
parent(jackie, selma).
parent(clancy, selma).
parent(selma, ling).

child(X, Y) :- parent(Y, X).
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).

female(marge).
female(lisa).
female(maggie).
female(mona).
female(jackie).
female(patty).
female(selma).
female(ling).

male(bart).
male(homer).
male(abraham).
male(herb).
male(clancy).

sister(X, Y) :- parent(Z, X), parent(Z, Y), female(X).

findany(Var, Pred, _) :-
    Pred,
    assert(found(Var)),
    fail.

findany(_, _, Results) :-
    collect_found(Results, []).

collect_found([X|Xs], Temp) :-
    retract(found(X)),
    !,
    collect_found(Xs, [X|Temp]).

collect_found(Results, Results).

% ?- findall(P, parent(P, _), ParentList).
% ?- findany(P, parent(P, _), ParentList).
