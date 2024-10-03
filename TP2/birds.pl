:- dynamic locomotion/2.

% ontology
isa(bird, animal).
isa(albert, albatross).
isa(albatross, bird).
isa(kiwi, bird).
isa(willy, kiwi).
isa(ostrich, bird).
isa(crow, bird).

locomotion(bird, fly).
locomotion(kiwi, walk).

% does albert fly or walk? albert is an albatross and an albatross is a bird, so albert is a bird...
% inheritance rule:
locomotion(Entity, Locomotion) :-
    isa(Entity, SuperEntity),
    locomotion(SuperEntity, Locomotion).

food(albatross, fish).
food(bird, grain).
% how to avoid writing inheritance rules for each predicate?
% we do predicate surgery:
known(Fact) :-
    Fact,
    !.
known(Fact) :-
    Fact =.. [Pred, Arg1, Arg2], % this is the only way to "get" the predicate. Pred(Arg1, Arg2) won't unify.
    isa(Arg1, SuperArg1),
    SuperFact =.. [Pred, SuperArg1, Arg2],
    known(SuperFact).

% usage of =.. is as follows:
% f(a,b,c) =.. L succeeds with L = [f,a,b,c]

habitat(Animal, continent) :-
    locomotion(Animal, Locomotion),
    Locomotion \= fly,
    !.
habitat(_, unknown).

% ?- known(habitat(ostrich, L)).
% ?- asserta(locomotion(ostrich, run)).
% ?- known(habitat(ostrich, L)).

