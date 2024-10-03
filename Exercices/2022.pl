% Q1

oneWayRoad([lussac, gayac, figeac, trelissac, tourtoirac, dignac,
fronsac, agonac, jumillac]).

travel(City1, City2) :-
    oneWayRoad(R),
    path(R, City1, City2).

path([City1|R], City1, City2) :-
    !,
    member(City2, R).

path([_|R], City1, City2) :-
    path(R, City1, City2).

% ===

% Q2

% a. p(X, f(X), Z) and p(g(Y),f(g(b)), Y)
X = g(b)
Z = Y = b

% b. p(X, f(X)) and p(f(Y), Y)
X = f(Y)
f(X) = Y
% No, recursive unification should fail

% c. p(X, f(Z)) and p(f(Y), Y)
X = f(f(Z))
f(Z) = Y

% ===

% Q3

1. [(∀x) (child(x) ⊃ loves(x, santa))]
2. [(∀x) (loves(x, santa) ⊃ (∀y) (reindeer(y) ⊃ loves(x, y)))]
3. [reindeer(rudolph) ∧ red_nose(rudolph)]
4. [(∀x) (red_nose(x) ⊃ (weird(x) ∨ clown(x)))]
5. [(∀x) (reindeer(x) ⊃ ¬clown(x))]
6. [(∀x) (loves(scrooge, x) ⊃ ¬weird(x))]
7. [child(scrooge)]

8. [¬child(x), loves(x, santa)]
9. [¬loves(x, santa), ¬reindeer(y), loves(x, y)]
10. [reindeer(rudolph)]
11. [red_nose(rudolph)]
12. [¬red_nose(x), weird(x), clown(x)]
13. [¬reindeer(x), ¬clown(x)]
14. [¬loves(scrooge, x), ¬weird(x)]
15. [loves(scrooge, santa)]
16. [¬reindeer(y), loves(scrooge, y)]
17. [loves(scrooge, rudolph)]
18. [weird(rudolph), clown(rudolph)]
19. [¬clown(rudolph)]
20. [weird(rudolph)]
21. [¬loves(scrooge, rudolph)]
22. []

% ===

% Q4

% Prove: (∀x) (P(x) ⊃ (∀y) P(y))
[¬ (∀x) (P(x) ⊃ (∀y) P(y))]
[¬ (∀x) (∀y) (P(x) ⊃ P(y))]
[(∃x) (∃y) ¬(P(x) ⊃ P(y))]
[¬(P(c) ⊃ P(d))]
[¬(¬P(c) ∨ P(d))]
[P(c) ∧ ¬P(d)]
[P(c)]
[¬P(d)]
[] % c = d, one single element

% ===

% Q6

nice_food(X) :- edible(X), juicy(X).
