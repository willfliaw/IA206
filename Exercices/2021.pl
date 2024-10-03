% Q1

second([ ], [ ]).
second([X], [X]).
second([X, _ | R], [X | R1]) :-
    second(R, R1).

% ===

% Q2

% first-order logic language
1. (∀i) (∀c) ((child(i) ∧ candy(c)) ⊃ loves(i, c))
2. (∀i) (((∃c) (candy(c) ∧ loves(i, c))) ⊃ ¬nfan(i))
3. (∀i) (((∀p) (pumpkin(p) ⊃ eat(i, p))) ⊃ nfan(i))

% prenex form
1. (∀i) (∀c) ((child(i) ∧ candy(c)) ⊃ loves(i, c))
2. (∀i) (∀c) ((candy(c) ∧ loves(i, c)) ⊃ ¬nfan(i))
3. (∀i) (∃p) ((pumpkin(p) ⊃ eat(i, p)) ⊃ nfan(i))

% skolemized form
1. ((child(i) ∧ candy(c)) ⊃ loves(i, c))
2. ((candy(c) ∧ loves(i, c)) ⊃ ¬nfan(i))
3. ((pumpkin(p(i)) ⊃ eat(i, p(i))) ⊃ nfan(i))

% conjunctive normal form
1. < [¬child(i), ¬candy(c), loves(i, c)] >
2. < [¬candy(c), ¬loves(i, c), ¬nfan(i)] >
3. < [pumpkin(p(i)), nfan(i)], [¬eat(i, p(i)), nfan(i)] >

% ===

% Q3

% {(∀x) (P(x) ∨ Q(x)), (∃x) ¬P(x)} |- (∃x) Q(x)

% Hypotheses :
[(∀x) (P(x) ∨ Q(x))]
[(∃x) ¬P(x)]

% Negated conclusion:
[¬(∃x) Q(x)]

% Skolemization:
[P(x), Q(x)]
[¬P(a)]
[¬Q(x)]

% Two resolutions:
[]

% ===

% Q5

% The lgg of 1. and 2. is:
c(Y) :- a(Y,X), f(X).
