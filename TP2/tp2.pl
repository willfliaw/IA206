% Definition of the possible actions with the state associated constraints
action(
    state(middle, onbox, X, not_holding),
    grab,
    state(middle, onbox, X, holding)
).
action(state(P, floor, P, T), climb, state(P, onbox, P, T)).
action(state(P1, floor, P1, T), push(P1, P2), state(P2, floor, P2, T)).
action(state(P1, floor, B, T), walk(P1, P2), state(P2, floor, B, T)).

% Definition of the success conditions in the problem of the monkey
success(state(_, _, _, holding)).

success(State1) :-
    action(State1, A, State2),
    write('Action : '),
    write(A),
    nl,
    write(' --> '),
    write(State2),
    nl,
    success(State2).

go1 :-
    success(state(door, floor, window, not_holding)).

% By changing the order of actions, we change the order in which the interpreter search
% for actions that will lead it to success. For instance, by putting the walk action
% first asking the interpreter "success(state(door, floor, window, not_holding))." it
% begins to walk aimlessly, and infinitely.

% Definition of the success conditions in the problem of the monkey
success(state(_, _, _, holding), []).

success(State1, [A|Plan]) :-
    action(State1, A, State2),
    success(State2, Plan).

go2 :-
    success(state(door, floor, window, not_holding), P),
    write(P).

% ===

mirror2(Left, Right) :-
    invert(Left, [], Right).
invert([X|L1], L2, L3) :-  % the list is 'poured'
    invert(L1, [X|L2], L3).  % into the second argument
invert([], L, L).  % at the deepest level, the result L is merely copied

palindrome1(List) :-
    mirror2(List, List).

palindrome2(L) :-
    palindrome_acc(L,[]).

palindrome_acc(L, L) :- !.
palindrome_acc(L, [_|L]) :- !.
palindrome_acc([T|Q], L) :-
    palindrome_acc(Q, [T|L]).

% ===

empty(Predicate) :-
    retract(Predicate),
    fail.
empty(_).


% ?- assert(well_known(katy)).
% ?- assert(well_known('Elvis')).
% ?- assert(well_known(madonna)).
% ?- assert(well_known(michael)).
% ?- empty(well_known(_)).

% ===

findany(Var, Pred, _) :-
    retractall(found(_)),
    Pred,
    asserta(found(Var)),
    fail.

findany(_, _, Results) :-
    collect_found(Results).

collect_found([X|Xs]) :-
    retract( found(X) ),
    !,
    collect_found(Xs).
collect_found([]).

% ?- findall(P, parent(P, _), ParentList).
% ?- findany(P, parent(P, _), ParentList).

% ===

habitat(Animal, Location) :-
    locomotion(Animal, Locomotion),
    Locomotion \= fly,
    !,
    Location = continent.
habitat(_, unknown).

% ?- known(habitat(ostrich, L)).
% ?- asserta(locomotion(ostrich, run)).
% ?- known(habitat(ostrich, L)).

% ===

% aunt [=def] woman [and-square] exist sister.parent
