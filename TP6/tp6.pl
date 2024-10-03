% Write a clause to express "Alice is happy with probability 50%" using the atom alice_is_happy.
% .5 :: alice_is_happy.

% ===

% Write a clause to express "There is a school test with probability 5%" using the atom school_test.

% .05 :: school_test.


% ===

% Write a clause to express "The class is fun with probability 10%" using the atom fun_class.

% .1 :: fun_class.

% ===

% Write a rule to express "Alice is happy if the class was fun, with probability 30%" using the atoms defined previously.

% .3 :: alice_is_happy :- fun_class.

% ===

% Write a rule to express "Alice is not happy if it's raining, with probability 70%" using the atoms defined previously, including raining, used in the introduction of this section.

% .2 :: raining.
% .7 :: \+ alice_is_happy :- raining.

% ===

% Write a rule to express "Alice is not happy if there is a test, with probability 90%" using the atoms defined previously.

% .9 :: \+ alice_is_happy :- school_test.

% ===

% Taking all the rules defined until now, what is the probability that Alice is happy, knowing that there is a school test, that Bob is happy, and Charlie is not happy? Don’t forget to adapt the happy predicate in the rules previously defined to take 1 argument.

% evidence(fun_class).

% query(alice_is_happy).

% ===

% Write a rule to express "A pupil P is happy if one of their friends Q is happy, with probability 80%". You may test whether the syntax of your rule is correct by running it through the ProbLog interpreter.

% .8 :: happy(P) :- friend(P, Q), happy(Q).

% ===

% Taking all the rules defined until now, what is the probability that Alice is happy, knowing that there is a school test, that Bob is happy, and Charlie is not happy? Don’t forget to adapt the happy predicate in the rules previously defined to take 1 argument.

.5 :: happy(P).
.3 :: happy(P) :- fun_class.
.8 :: happy(P) :- friend(P,Q), happy(Q).
.7 :: \+happy(P) :- raining.
.9 :: \+happy(P) :- school_test.
.1 :: fun_class.
.05 :: school_test.
.2 :: raining.

friend(alice, charlie).
friend(charlie, bob).
friend(dorothy, emily).
friend(X, Y) :- Y @< X, friend(Y, X). % symmetry of friend relationship
friend(X, Y) :- X \= Y, friend(X, Z), friend(Z, Y). % transitivity of friend relationship

evidence(school_test).
evidence(happy(bob)).
evidence(\+happy(charlie)).

query(happy(alice)).

% ===

% As a warmup, write a prolog predicate flips(+PastFlips,-NewFlips) where PastFlips is a list containing heads and tails, and NewFlips is the same as PastFlips but with a new element added at the beginning. You should assume access to a predicate coin/1, defined by two clauses: coin(heads). coin(tails).
% After submitting your answer, read the expected answer carefully, as it contains important information for the following questions.

% .5::coin(tails) ; .5::coin(heads).

% flips(PastFlips, [Flip|PastFlips]) :-
%     coin(Flip).

% ===

% Write a ProbLog program that can compute the outcome of the game. Formally, write a predicate game(Win) that simulates a game, where Win is equal to the amount of marbles that Bob has won. Assume that Bob starts with 15 marbles. Win can be positive or negative.
% To help you write this program: you should write a predicate next(+Marbles,+Stake,+Flips,-Result,-Sequence) where Marbles is the number of marbles Bob has, Stake is the current value of the stake, Flips is the sequence of flips so far, Result is the number of marbles Bob has at the end of the game, and Sequence is the sequence of flips at the end of the game. Result and Sequence serve to store values at the end of the game, like we did in the second lab session with the actions of the monkey. next will call to the code provided to you in the answer of the previous question.

.4::coin(heads, Id); .6::coin(tails, Id).

flip(PastFlips, [Flip|PastFlips]) :-
    length(PastFlips, N),
    coin(Flip, N).

game(Win) :-
    next(15, 1, [], Result, _),
    Win is Result - 15.

% winning and stopping
next(Marbles, Stake, Flips, Marbles + Stake, [heads|Flips]) :-
    flip(Flips, [heads|Flips]).

% loosing and stopping
next(Marbles, Stake, Flips, Marbles - Stake, [tails|Flips]) :-
    Marbles - Stake < 2*Stake,
    flip(Flips, [tails|Flips]).

% loosing and continuing
next(Marbles, Stake, Flips, Result, Sequence) :-
    flip(Flips, [tails|Flips]),
    Marbles - Stake >= 2*Stake,
    next(Marbles - Stake, 2*Stake, [tails|Flips], Result, Sequence).

query(game(_)).
