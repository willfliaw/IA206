:- op(140, fy, -).  % stands for 'not'
:- op(160, xfy, [and, or, equiv, imp, impinv, nand, nor, nonimp, nonequiv, nonimpinv]).

is_true(V, X and Y) :- is_true(V, X), is_true(V, Y).
is_true(V, X or _) :- is_true(V, X).
is_true(V, _ or Y) :- is_true(V, Y).
is_true(V, -X) :-
    not(is_true(V, X)). % link with Prolog's negation
is_true(v0, a).  % this means that v0 sends a to True and everything else (here, b and c) to false

% Test: is_true(v0, a and -b).

% What do we get?

% 1 ?- is_true(v0, a and -b).
% true.

% ===

% Complete the program by introducing equivalence and implication, in order to test
% de Morgan’s law: ¬(a ∧ b) ≡ (¬a ∨ ¬b)
% and Frege’s axiom: (a ⊃ (b ⊃ a))
% Copy-paste the added lines in the box below. For now, test valuation v0:
% is_true(v0, -(a and b) equiv (-a or -b)).
% . . .

is_true(V, X imp Y) :- is_true(V, -X or Y).
is_true(V, X equiv Y) :- is_true(V, (X imp Y) and (Y imp X)).

% 1 ?- is_true(v0, -(a and b) equiv (-a or -b)).
% true

% ===

is_true(V, X) :-
    member(X,V).    % only true elements are explicitly mentioned in V

valuation(V) :-
    % we keep all elements that V sends to true.
    % all other elements are supposed to be false.
    sub_set(V, [a, b, c]).

sub_set([], []).
sub_set([X|XL], [X|YL]) :-
    sub_set(XL, YL).
sub_set(XL, [_|YL]) :-
    sub_set(XL, YL).

% ?- valuation(V), is_true(V, a and -b).
%     V = [a, c];    % this means that if a and c are true and b false, the formula is true
%     V = [a]        % this means that if a is true, and b and c are false, the formula is true

% ===

% Then test:

% (a ⊃ (b ⊃ c)) ⊃ ((a ⊃ b) ⊃ (a ⊃ c))
% (((a ⊃ b) ∧ (b ⊃ c)) ⊃ ¬(¬c ∧ a))

% What do we get? (copy your result below)

% 1 ?- valuation(V), is_true(V, (a imp (b imp c)) imp ((a imp b) imp (a imp c))).
% V = [a, b, c] ;
% V = [a, b] ;
% V = [a, c] ;
% V = [a, c] ;
% V = [a] ;
% V = [b, c] ;
% V = [b, c] ;
% V = [b] ;
% V = [c] ;
% V = [c] ;
% V = [] ;
% false.

% 2 ?- valuation(V), is_true(V, (((a imp b) and (b imp c)) imp -(-c and a))).
% V = [a, b, c] ;
% V = [a, b] ;
% V = [a, c] ;
% V = [a, c] ;
% V = [a] ;
% V = [b, c] ;
% V = [b] ;
% V = [b] ;
% V = [c] ;
% V = [] ;
% false.

% ===

% Observe (just consider truth tables) that X is a tautology if and only if X ≡ ⊤ is a tautology, and if and only if ⊤ ⊃ X is a tautology.

% Show rigourously (using the replacement theorem) that Y is a tautology if X and (X ⊃ Y) are tautologies.
% (you may note ≡ by writing eq and ⊃ by writing imp).

% This theorem, a.k.a. modus ponens, is one of the most celebrated theorems of Logic, as it serves as basis in axiomatic approaches to reasoning.

%           X eq T
%    X  imp Y eq T
% (- X) or  Y eq T
% (- T) or  Y eq T
%    F  or  Y eq T
%           Y eq T

% ===

% Show that S ⊨ X entails the fact that S U {¬X} is not satisfiable.

% Suppose S ⊨ X. Now, suppose S ⊨ {¬X} is satisfiable. This means there exists a valuation under which all elements of S are assigned the value T, and ¬X is assigned the value T. However, if ¬X is true under this valuation, then X must be assigned to F under the same valuation, because they are negations of each other. But this contradicts the fact that whenever all elements of S are assigned the value T, X is also assigned the value T, as per S ⊨ X. Hence, the assumption that S ⊨ {¬X} is satisfiable leads to a contradiction. Therefore, S ⊨ {¬X} cannot be satisfiable.

% ===

% A system of knowledge production is monotonous if adding new knowledge does not diminish the amount of knowledge that can be inferred. Find (using the Web) an example of a non-monotonic logic system, and explain in a few words why it is not monotonous.

% An example of a non-monotonic logic system is Default Logic. In Default Logic, assumptions are made by default, but these assumptions can be overridden by additional information. For instance, consider a default rule such as "Birds fly." This rule assumes that all birds fly unless explicitly contradicted. However, if we later learn about an ostrich, which is a bird but does not fly, we need to override the default assumption for the ostrich. In Default Logic, adding new information can lead to the retraction or modification of previously drawn conclusions. The system is not monotonic because adding new defaults or exceptions can change the set of inferences that can be made from the knowledge base, making it non-monotonic.

% ===

% Show that propositional Logic is monotonous.
% More precisely, show that if S ⊨ X, then S U {Y} ⊨ X.

% To prove that propositional logic is monotonous, we need to show that if S ⊨ X, then S U {Y} ⊨ X. This means that if X is a propositional consequence of S, then adding another proposition Y to S will not invalidate the consequence X. We can prove this by contradiction. Suppose S ⊨ X but X is not a propositional consequence of S U Y. This implies that there exists a valuation under which all elements of S are assigned to T, but X is assigned to F when Y is also T. However, if X is a propositional consequence of S, then for any valuation that assigns truth values to the propositions in S, X must also be true. Therefore, if Y being true in addition to the elements of S leads to X being false, it contradicts the fact that X is a propositional consequence of S. Hence, our assumption that S U {Y} not being a propositional consequence of X leads to a contradiction. Therefore, if S ⊨ X, then S U {Y} ⊨ X, and propositional logic is indeed monotonous.

% ===

% Show that if S U {X} ⊨ Y, then S ⊨ (X ⊃ Y).

% Suppose S U {X} ⊨ Y. This means that there exists a valutaion that assigns all propositions in S U {X} to T, and Y to T. Assuming all elements of S are assigned to T, we can the following cases:

% 1) X is assigned to T. By definition of the propositional consequence above, Y is also assigned to T. In this case, X imp Y is assigned to T, because T imp T eq T.

% 2) X is assigned to F. In this case, X imp Y is assigned to T, because F imp T eq T, and F imp F eq T.

% Thus, X imp Y eq T, if the hypothesis holds. By definition, S ⊨ (X imp Y)

% ===

% Show the reciprocal: if S ⊨ (X ⊃ Y), then S U {X} ⊨ Y.

% Suppose S ⊨ (X imp Y). This means that there exists a valutaion that assigns all propositions in S to T, and (X imp Y) to T. Assuming all elements of S U {X} are assigned to T, we can observe that:

% 1) S is included in S U {X}. Thus, (X imp Y) must be assigned to T.

% 2) X is included in S U {X}. Thus, X must be assigned to T.

% Consequently, for both observations to be true, Y must also be assigned to T. Then, we can notice that, by definition, S U {X} ⊨ Y, which concludes the proof.

% ===

% Rewrite ¬((A ⊃ (B ⊃ C)) ⊃ ((A ⊃ B) ⊃ (A ⊃ C))) in conjunctive normal form.

% <[¬((A ⊃ (B ⊃ C)) ⊃ ((A ⊃ B) ⊃ (A ⊃ C)))]>
% <[¬(¬(A ⊃ (B ⊃ C)) ∨ ((A ⊃ B) ⊃ (A ⊃ C)))]>
% <[(A ⊃ (B ⊃ C)) ∧ ¬((A ⊃ B) ⊃ (A ⊃ C))]>
% <[(¬A ∨ (B ⊃ C)) ∧ ¬(¬(A ⊃ B) ∨ (A ⊃ C))]>
% <[(¬A ∨ ¬B ∨ C) ∧ (A ⊃ B) ∧ ¬(A ⊃ C)]>
% <[(¬A ∨ ¬B ∨ C) ∧ (¬A ∨ B) ∧ ¬(¬A ∨ C)]>
% <[(¬A ∨ ¬B ∨ C) ∧ (¬A ∨ B) ∧ A ∧ ¬C]>
% <[¬A ∨ ¬B ∨ C], [¬A ∨ B], [A], [¬C]>
% <[¬A, ¬B, C], [¬A, B], [A], [¬C]>
% <[¬B, C], [B], [¬C]>
% <[¬B], [B]>
% <[]>

% ===

% Test this programme by executing:

% cnf([[((a and b) or (c or d))]], Result).

% What do we get?

% 1 ?- cnf([[((a and b) or (c or d))]], Result).
% Result = [[c, d, a and b]] ;
% Result = [[a and b, c or d]] ;
% Result = [[(a and b)or c or d]].

% ===

% Complete oneStep to process double negation and alpha and beta formulas.
% Suggestion : use predicate components that converts these formulas. For instance:
% components(-(X or Y), -X, -Y, alpha).
% Copy the oneStep clause for the alpha formulas below.

% Test your program on a formula that we already encountered:
% ¬((a ⊃ (b ⊃ c)) ⊃ ((a ⊃ b) ⊃ (a ⊃ c)))

% 1 ?- cnf([[-((a imp (b imp c)) imp ((a imp b) imp (a imp c)))]], Result).
% Result = [[-b, c, -a], [-a, b], [a], [-c]] .
