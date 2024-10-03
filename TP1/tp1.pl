% === ok

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

female(mona).
female(jackie).
female(marge).
female(ann).
female(patty).
female(selma).
female(ling).
female(lisa).
female(maggie).
male(abraham).
male(herb).
male(homer).
male(bart).
male(clancy).


child(X,Y) :-
    parent(Y,X).

mother(X,Y) :-
    parent(X,Y),
    female(X).

grandparent(X,Y) :-
    parent(X,Z), % note that the a variable's scope is the clause
    parent(Z,Y). % variable Z keeps its value within the clause

sister(X,Y) :-
    parent(Z,X), % if X gets instantiated, Z gets instantiated as well
    parent(Z,Y),
    female(X),
    X \== Y. % can also be noted: not(X = Y).

ancestor(X,Y) :-
    parent(X,Y).
ancestor(X,Y) :-
    parent(X,Z),
    ancestor(Z,Y). % recursive call

% Write a clause to define the predicate aunt.

aunt(X, Y) :-
    sister(X, Z),
    parent(Z, Y).

% ===

extract(X, [X|L], L).
extract(X, [Y|L], [Y|L1]) :-
    extract(X, L, L1).

% Write last_elt that extracts the last element of a list.

last_elt([X], X).
last_elt([_|T], X) :-
    last_elt(T, X).

% ===

% Write attach that joins two lists. (append)

attach([], List, List).
attach([Head|Tail1], List2, [Head|Result]) :-
    attach(Tail1, List2, Result).

% ===

% Use attach (previously written) to design assemble that joins three lists:
% Is your predicate reversible? i.e. can it be used to split a list in three pieces?

assemble(L1, L2, L3, Result) :-
    attach(L1, L2, Temp),
    attach(Temp, L3, Result).

% ===

% Use attach to write sub_list
% where IncludedList is a continuous 'chunk' of the list IncludingList. For instance, sub_list([3, 4], [1, 2, 3, 4, 5, 6]) should succeed.

sub_list(IncludedList, IncludingList) :-
    attach(_, Temp, IncludingList),
    attach(IncludedList, _, Temp).

% ===

add(X, L, L) :-
    member(X, L),
    !. % nothing to do, and don't visit next clause
add(X, L, [X|L]).

% More modestly, we can start by writing a predicate, remove, that removes all occurrences of an element in a list. Write this predicate remove.
% Use a cut at an appropriate location (try to use neither the negation not nor the 'different' operator \== that could do the job as well).
% Attention: this predicate has to be deterministic (i.e. it should provide only one solution; check by using the semicolon ';' when executing). You may insert a cut at an appropriate location.

remove(_, [], []).
remove(X, [X|T], Result) :-
    remove(X, T, Result),
    !.
remove(X, [H|T], [H|Result]) :-
    remove(X, T, Result).

% ===

% Write duplicate to duplicate each element in a list :

duplicate([], []).
duplicate([X|Xs], [X,X|Ys]) :-
    duplicate(Xs, Ys).
