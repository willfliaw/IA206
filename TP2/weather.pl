nice :-
    sunshine,
    \+ raining.

funny :-
    sunshine,
    raining.

disgusting :-
    raining,
    fog.

raining.
fog.

:- dynamic sunshine/0.
:- dynamic fog/0.

% ?- nice.
% ?- disgusting.
% ?- retract(fog).
% ?- disgusting.
% ?- assert(sunshine).
% ?- funny.
% ?- assert(umbrella).
% ?- assert((wet :- raining, not(umbrella))).
% ?- wet.
% ?- retract(umbrella).
% ?- wet.

myprint :-
    retract(item(X)), % reussit tant qu'il y a des items
    write(X),
    nl,
    fail.
myprint.

myprint1 :-
    retract(item(X)),
    !, % avoids unwanted behahaviour if some predicate fails after a call to myprint1
    myprint1,
    write(X),nl,
    asserta(item(X)). % asserta = version of assert that adds item on top of the memory stack
myprint1.
