% Using the resolution algorithm, prove that:
% (((A ⊃ B) ∧ (B ⊃ C)) ⊃ ¬(¬C ∧ A))
% To do so, start from an single clause containing the negation of the formula to prove.

% <[¬(((A ⊃ B) ∧ (B ⊃ C)) ⊃ ¬(¬C ∧ A))]>
% <[¬(¬((A ⊃ B) ∧ (B ⊃ C)) ∨ ¬(¬C ∧ A))]>
% <[(A ⊃ B) ∧ (B ⊃ C) ∧ ¬C ∧ A]>
% <[(¬A ∨ B) ∧ (¬B ∨ C) ∧ ¬C ∧ A]>
% <[¬A ∨ B], [¬B ∨ C], [¬C], [A]>
% <[¬A, B], [¬B, C], [¬C], [A]>
% <[B], [¬B, C], [¬C]>
% <[C], [¬C]>
% <[]>

% (((A ⊃ B) ∧ (B ⊃ C)) ⊃ ¬(¬C ∧ A)) is a tautology.

% ===

% Show that if S ∪ {X} ⊢ Y, then S ⊢ (X ⊃ Y).
% (after answering, read the proof of the reciprocal in the solution).

% To show that S ⊢ (X ⊃ Y) using proof by resolution, we need to prove that ¬(S ∪ {¬(X ⊃ Y)}) is a tautology, that is leads to a S ∪ {¬(X ⊃ Y)} contradiction.

% <[S], [¬(X ⊃ Y)]>
% <[S], [¬(¬X ∨ Y)]>
% <[S], [X ∧ ¬Y]>
% <[S], [X], [¬Y]>

% Under the assumption that S ∪ {X} ⊢ Y, we know, by proof by resolution, that

% <[S], [X], [¬Y]>
% <[], ...>

% This results in an empty clause (possibly followed by other statements), which indicates a contradiction. Hence, we have proven, under the assumption S ∪ {X} ⊢ Y, that S ⊢ (X ⊃ Y).

% ===

prove(F) :-
    cnf([[ - F]], CNF),
    write('CNF of -'),
    write(F),
    write(' = '),
    write(CNF), nl,
    resolve(CNF).

resolve(CNF) :-
    member([], CNF),
    write('This is a true formula'), nl.
resolve(CNF) :-
    write('Examining '),
    write(CNF), nl,
    get0(_), % waits for user action
    select(C1, CNF, _), % forgetting this parent clause
    select(C2, CNF, RCNF), % keeping this parent clause
    remove(P, C1, RCNF1),
    remove(-P, C2, RCNF2),
    append(RCNF1, RCNF2, RC),
    resolve([RC | RCNF]).

% 1 ?- go.
% CNF of -(a imp b imp c)imp(a imp b)imp a imp c = [[-b,c,-a],[-a,b],[a],[-c]]
% Examining [[-b,c,-a],[-a,b],[a],[-c]]
% |:
% Examining [[-b,-a],[-b,c,-a],[-a,b],[a]]

% Examining [[-a,-a],[-b,c,-a],[-a,b],[a]]

% Examining [[-a,c,-a],[-a,-a],[-a,b],[a]]

% Examining [[c],[-a,-a],[-a,b],[a]]

% This is a true formula
% true .

% ===

% Give two different models for a language with the constants {a, b, c}, the binary predicate ‘<’ and the ternary predicate ‘+’.

% Model 1:

% Consider a domain consisting of the set of natural numbers (including zero) denoted by N = {0, 1, 2, 3, ...}.
% Interpretation I:
%     Constants:
%         a: 0
%         b: 1
%         c: 2
%     Predicates:
%         '<' (less than): The usual less than relation on two terms concerning natural numbers.
%         '+' (addition): The relation (3 terms operation) of x=y+z on natural numbers.

% Model 2:

% Consider a domain consisting of the set of integers, denoted by Z = {..., -3, -2, -1, 0, 1, 2, 3, ...}.

% Interpretation II:
%     Constants:
%         a: -3
%         b: 0
%         c: 3
%     Predicates:
%         '<' (less than): The usual less than relation on two terms concerning integers.
%         '+' (addition): The relation (3 terms operation) of x=y+z on integers.

% ===

% Give a model for a language consisting of the constants {a, b, c} and the ternary predicate ‘+’ in which (∀x) +(a, x, x) is true (x is a variable). Give another model in which the same formula is not true.

% Model 1:

% Consider a domain consisting of only the number 0, denoted by Z = {0}.

% Interpretation II:
%     Constants:
%         a: 0
%         b: 0
%         c: 0
%     Predicate:
%         '+' (addition): The relation (3 terms operation) of x=y+z on integers.

% Model 2:

% Consider a domain consisting of the set of integers, denoted by Z = {..., -3, -2, -1, 0, 1, 2, 3, ...}.

% Interpretation II:
%     Constants:
%         a: 1
%         b: 2
%         c: 3
%     Predicate:
%         '+' (addition): The relation (3 terms operation) of x=y+z on integers.

% So, in Model 1, the formula (∀x) +(a, x, x) is true as 0 = 0 + 0, while in Model 2, it is not true.

% ===

% What do you think of:
% ((∀x) (∃y) P(x, y)) ∧ ((∀x) (∃y) ¬P(x, y))

% The presented formula can be translated into English as follows:

% "There exists a y for every x such that P(x, y) is true, and for every x there exists a y such that ¬P(x, y) is true."

% It is important to notice, however, that the formula has two parts, each of which provides statements concerning possibly different x's and y's. It is, thus, possible for the formula to evaluate to true.

% ===

% Using the resolution method, show that the following formula is valid: (∀x) (∃y) (A(y) ⊃ A(x))

% 1. [¬((∀x) (∃y) (A(y) ⊃ A(x)))]
% 2. [(∃x) (∀y) (A(y) ∧ ¬A(x))]
% 3. [(∀y) (A(y) ∧ ¬A(c))]         % skolemization
% 4. [A(y) ∧ ¬A(c)]                % dropping universal quantifiers
% 5. [A(y)]                        % development of 4. (alpha rule)
% 6. [¬A(c)]                       % development of 4. (alpha rule)
% 7. []                            % 5. and 6. unification with y = c

% Success! -> the formula is valid

% ===

% Write the following formula in prenex and skolemized form:
% ((∀x) (∀y) (p(x) ∧ p(y)) ⊃ (∀x) (∀y) (p(x) ∨ p(y)))
% (consider renaming variables when they do not refer to the same entity)

% ((∀x) (∀y) (p(x) ∧ p(y)) ⊃ (∀x) (∀y) (p(x) ∨ p(y)))
% ((∀x) (∀y) (p(x) ∧ p(y)) ⊃ (∀z) (∀w) (p(z) ∨ p(w)))     % renaming variables
% (∃x) (∃y) ((p(x) ∧ p(y)) ⊃ (∀x) (∀y) (p(z) ∨ p(w)))
% (∃x) (∃y) (∀z) (∀w) ((p(x) ∧ p(y)) ⊃ (p(z) ∨ p(w)))
% (∃x) (∃y) (∀z) (∀w) (¬(p(x) ∧ p(y)) ∨ (p(z) ∨ p(w)))
% (∃x) (∃y) (∀z) (∀w) (¬p(x) ∨ ¬p(y) ∨ p(z) ∨ p(w))
% (∀z) (∀w) (¬p(a) ∨ ¬p(b) ∨ p(z) ∨ p(w))
% ¬p(a) ∨ ¬p(b) ∨ p(z) ∨ p(w)

% ===

% Test the validity of the following formula:
% (∀x) (∃y) (∀z) (∃w) (R(x,y) ⊃ R(w,z))
% (There is a trap here: the presented formula is in prenex form, but not as desired: we would like to see the existential quantifiers in front).

% 1. [¬(∀x) (∃y) (∀z) (∃w) (R(x, y) ⊃ R(w, z))]
% 2. [¬(∀x) (∃y) (∀z) (R(x, y) ⊃ R(c, z))]       % skolemization
% 3. [¬(∀x) (∀z) (∃y) (R(x, y) ⊃ R(c, z))]       % the quantifiers in formula (∀x) (∃y) ¬(A(x) ⊃ A(y)) are inversible
% 4. [¬(∀x) (∀z) (R(x, d) ⊃ R(c, z))]            % skolemization
% 5. [(∃x) (∃z) ¬(R(x, d) ⊃ R(c, z))]
% 6. [(∃x) ¬(R(x, d) ⊃ R(c, e))]                 % skolemization
% 7. [¬(R(f, d) ⊃ R(c, e))]                      % skolemization
% 8. [R(f, d)]                                   % development of 7. (alpha rule)
% 9. [¬R(c, e)]                                  % development of 7. (alpha rule)
% 10. []                                         % 8. and 9. unification with c=f and d=e

% ===

go :-
    prove(a(X) imp (b imp c)) imp ((a(Y) imp b) imp (a(3) imp c)).

% 1 ?- go.
% CNF of -(a(_8236)imp b imp c)imp(a(_8258)imp b)imp a(3)imp c = [[-b,c,-a(_8236)],[-a(_8258),b],[a(3)],[-c]]
% Examining [[-b,c,-a(_8236)],[-a(_8258),b],[a(3)],[-c]]
% |:
% Examining [[-b,-a(_8236)],[-b,c,-a(_8236)],[-a(_8258),b],[a(3)]]

% Examining [[-a(_8258),-a(_8236)],[-b,c,-a(_8236)],[-a(_8258),b],[a(3)]]

% Examining [[-a(_8258),c,-a(_8236)],[-a(_8258),-a(_8236)],[-a(_8258),b],[a(3)]]

% Examining [[c],[-a(3),-a(3)],[-a(3),b],[a(3)]]

% This is a true formula
% true .
