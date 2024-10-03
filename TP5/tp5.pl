% Modify predicate learn(N) in marienb.pl to allow the program to play against itself. You may use the dynamic predicate silent that is already declared to avoid display and turn taking during the learning phase (just insert the goal assert(silent). when entering the learning phase and then retract it when the learning phase is over).
% You should observe that if you let the computer play about 600 games against itself, then it becomes unbeatable.
% Paste your 'Learn' predicate in the box below.
% (paste your ‘Learn' predicate only)

learn(N) :-
    % You may use a combination  repeat(N),.... fail.
    % to have the program play N games against itself
    repeat(N),
    assert(silent),    % silence output during learning phase
    game,
    retract(silent),   % restore normal output after learning phase
    fail.              % to repeat the game

% ===

% Complete predicat lgg.
% (Paste *only* ‘lgg' and any other new clause it may use)
% Test your program by executing matchTest. Observe, among the different admissible matches, the one that has minimal cost.

lgg(Shape1, Shape2, Shape, Cost) :-
    ancestor(Shape, Shape1, Cost1),  % Find the common ancestor
    ancestor(Shape, Shape2, Cost2),  % Find the common ancestor
    Cost is Cost1 + Cost2.

% 1 ?- matchTest.
% [square(_19856),circle(_19866),vPos(_19856,2),vPos(_19866,1)]
% [triangle(_19900),square(_19910),vPos(_19900,2),vPos(_19910,1)]
% [form(object_1),form(object_2),vPos(object_1,2),vPos(object_2,1)] --- 8
% true ;
% [form(object_2),form(object_1),vPos(object_2,2),vPos(object_1,1)] --- 8
% true ;
% [polygon(object_1),form(object_2),vPos(object_1,2),vPos(object_2,1)] --- 6
% true ;
% [polygon(object_2),form(object_1),vPos(object_2,2),vPos(object_1,1)] --- 6
% true ;
% false.

% ===

% Try to apply inverse resolution to find the least general generalization of the two following examples:

% E1: a ∧ b ∧ c
% E2: a ∧ d ∧ e ∧ f

% using the following background knowledge:

% 1.    d :- c.
% 2.    d :- a, g.
% 3.    f :- a, b.
% You may first generalize E1 using 1.
% Then generalize the new clause using 3, through an inverse resolution around b to make it closer to E2.
% And eventually keep what is common with E2.

% E1: a ∧ b ∧ c
% [E1, ¬a, ¬b, ¬c]

% E2: a ∧ d ∧ e ∧ f
% [E2, ¬a, ¬d, ¬e, ¬f]

% 1. d :- c.
% [d, ¬c]

% 2. d :- a, g.
% [d, ¬a, ¬g]

% 3. f :- a, b.
% [f, ¬a, ¬b]

% Generalizing E1 using 1.
% [E1, ¬a, ¬b, ¬d]

% Generalizing new clause using 3, through inverse resolution around b.
% [E1, ¬a, a, ¬f, ¬d]

% Keeping what is in common with E2.
% [¬a, ¬f, ¬d]

% The least general generalization would be:
% E :- a ∧ d ∧ f

% ===

% Add an argument Trace to prove in order to gather all the example's features that are used in the proof (you may use swi-prolog's append to build the trace).
% You'll get a set of relevant features such as:

% [feature(myphone, bluetooth), partOf(myphone, tc), touchScreen(tc), hasSoftware(tc, s2), dialingSoftware(s2), feature(myphone, bluetooth)]
% Observe that myphone is a telephone in several ways.


