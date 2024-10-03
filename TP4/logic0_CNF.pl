:- op(140, fy, -).
:- op(160, xfy, [and, or, imp, impinv, nand, nor, nonimp, equiv, nonimpinv]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Conjunctive normal form %
%%%%%%%%%%%%%%%%%%%%%%%%%%%


/* table for unary, alpha and beta formulas */

components(- -X, X, _, unary).
components(X and Y, X, Y, alpha).
components(-(X or Y), -X, -Y, alpha).
components(X or Y, X, Y, beta).
components(-(X and Y), -X, -Y, beta).
components(X imp Y, -X, Y, beta).
components(-(X imp Y), X, -Y, alpha).
components(X impinv Y, X, -Y, beta).
components(-(X impinv Y), -X, Y, alpha).
components(X nand Y, -X, -Y, beta).
components(-(X nand Y), X, Y, alpha).
components(X nor Y, -X, -Y, alpha).
components(-(X nor Y), X, Y, beta).
components(X nonimp Y, X, -Y, alpha).
components(-(X nonimp Y), -X, Y, beta).
components(X nonimpinv Y, -X, Y, alpha).
components(-(X nonimpinv Y), X, -Y, beta).


% Predicate cnf puts more elementary processing together
cnf(Conjunction, NewConjunction) :-
    oneStep(Conjunction, C1),
    cnf(C1, NewConjunction).
cnf(C, C).

/*------------------------------------------------*/
/* Auxiliary predicates                           */
/*------------------------------------------------*/

/* remove does as select, but removes all occurrences of X */
remove(X, L, NL) :-
    member(X, L),  % so that remove fails if X absent from L
    remove1(X, L, NL).
remove1(X, L, L) :-
    not(member(X, L)).
remove1(X, L, NL) :-
    select(X, L, L1),   % available in SWI-Prolog
    remove1(X, L1, NL).

% ===


oneStep([Clause | Rest_Conjunction], [[F1, F2 | Rest_Clause] | Rest_Conjunction]) :-
    % looking for a beta formula in the clause
    components(F, F1, F2, beta),
    remove(F, Clause, Rest_Clause).

oneStep([Clause | Rest_Conjunction], [[F1 | Rest_Clause] | Rest_Conjunction]) :-
    % looking for a unary in the clause
    components(F, F1, _, unary),
    remove(F, Clause, Rest_Clause).

oneStep([Clause | Rest_Conjunction], [[F1 | Rest_Clause], [F2 | Rest_Clause] | Rest_Conjunction]) :-
    % looking for alpha formula in the clause
    components(F, F1, F2, alpha),
    remove(F, Clause, Rest_Clause).

oneStep([F | Rest], [F | New_Rest ]) :-
    % nothing left to do on F
    oneStep(Rest, New_Rest).

% 1 ?- cnf([[-((a imp (b imp c)) imp ((a imp b) imp (a imp c)))]], Result).
% Result = [[-b, c, -a], [-a, b], [a], [-c]] .

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

% TEST
go :-
    % prove((a imp (b imp c)) imp ((a imp b) imp (a imp c))).
    % prove(a and -a).
    % prove(-((-a or -b or c) and -c)).
    prove((a(X) imp (b imp c)) imp ((a(Y) imp b) imp (a(3) imp c))).
