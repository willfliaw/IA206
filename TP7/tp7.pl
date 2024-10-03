% Write ProbLog code that describes one throw of two unbiased dice. You should write two predicates:
% 1. die(Id, Value) where Id can be any integer, and Value is the result of rolling one die (so, an integer from 1 to 6).
% 2. roll(Outcome) where Outcome is the result of one round of the game above: roll two dice, then sum their value. Outcome is an integer.

% 1/6::die(Id, 1); 1/6::die(Id, 2); 1/6::die(Id, 3); 1/6::die(Id, 4); 1/6::die(Id, 5); 1/6::die(Id, 6).

% roll(Outcome) :-
%     die(1, X),
%     die(2, Y),
%     Outcome is X + Y.

% query(roll(_)).

% ===

% Alice expects that both of Bob’s dice are biased, with the same bias. Knowing that t(_)::a. means that a is a probabilistic ProbLog atom with a learnable parameter, edit the previous die/2 predicate to have learnable probabilities.

% t(_)::die(Id, 1); t(_)::die(Id, 2); t(_)::die(Id, 3); t(_)::die(Id, 4); t(_)::die(Id, 5); t(_)::die(Id, 6).

% roll(Outcome) :-
%     die(1, X),
%     die(2, Y),
%     Outcome is X + Y.

% ===

% Write a probabilistic clause to express that in the wet state, the weather is 'cloudy-rainy' with probability 4/7, 'fog' with probability 2/7 and 'foggy-rainy' with probability 1/7.

% .5::start(0) ; .5::start(1).

% .3::emit(Time, 0, 'cloudy-dry'); .7::emit(Time, 0, 'sunshine').
% 4/7::emit(Time, 1, 'cloudy-rainy'); 2/7::emit(Time, 1, 'fog'); 1/7::emit(Time, 1, 'foggy-rainy').
% emit(_, 2, 'sunshine+rain').

% ===

% Write a ProbLog clause expressing that from state 2, the weather stays in state 2 w.p. .2, and goes to state 0 or 1 w.p. .4 for each.

% .5::trans(Time, 0, 0); .3::trans(Time, 0, 1); .2::trans(Time, 0, 2).
% .3::trans(Time, 1, 0); .5::trans(Time, 1, 1); .2::trans(Time, 1, 2).
% .4::trans(Time, 2, 0); .4::trans(Time, 2, 1); .2::trans(Time, 2, 2).

% ===

% Try sampling from your program, and paste 10 samples of 8-symbol sequences into the answer form. You can make ProbLog print the probability of each sample using the flag --with-probability.

% query(observe([X1, X2, X3, X4, X5, X6, X7, X8])).

% ===

% Take all the rules about start, trans and emit that we had so far, and change them to turn their probabilities into learnable parameters. Paste in those lines of code into the answer form.

% t(_)::start(0) ; t(_)::start(1).

% t(_)::emit(Time, 0, 'cloudy-dry'); t(_)::emit(Time, 0, 'sunshine').
% t(_)::emit(Time, 1, 'cloudy-rainy'); t(_)::emit(Time, 1, 'fog'); t(_)::emit(Time, 1, 'foggy-rainy').
% t(_)::emit(_, 2, 'sunshine+rain').

% t(_)::trans(Time, 0, 0); t(_)::trans(Time, 0, 1); t(_)::trans(Time, 0, 2).
% t(_)::trans(Time, 1, 0); t(_)::trans(Time, 1, 1); t(_)::trans(Time, 1, 2).
% t(_)::trans(Time, 2, 0); t(_)::trans(Time, 2, 1); t(_)::trans(Time, 2, 2).

% ===

% Rewrite the clauses about start, trans and emit, so that

%     The HMM can start from any of the 3 states (0, 1, or 2)
%     The HMM can transition from any state to any other state
%     The HMM can emit any symbol from any state
%     All probabilities are learnable.

% Paste in those new clauses into the answer form.

t(_)::start(0) ; t(_)::start(1), t(_)::start(2).

t(_)::emit(Time, 0, 'cloudy-dry');
t(_)::emit(Time, 0, 'cloudy-rainy');
t(_)::emit(Time, 0, 'sunshine');
t(_)::emit(Time, 0, 'fog');
t(_)::emit(Time, 0, 'foggy-rainy');
t(_)::emit(Time, 0, 'sunshine+rain').

t(_)::emit(Time, 1, 'cloudy-dry');
t(_)::emit(Time, 1, 'cloudy-rainy');
t(_)::emit(Time, 1, 'sunshine');
t(_)::emit(Time, 1, 'fog');
t(_)::emit(Time, 1, 'foggy-rainy');
t(_)::emit(Time, 1, 'sunshine+rain').

t(_)::emit(Time, 2, 'cloudy-dry');
t(_)::emit(Time, 2, 'cloudy-rainy');
t(_)::emit(Time, 2, 'sunshine');
t(_)::emit(Time, 2, 'fog');
t(_)::emit(Time, 2, 'foggy-rainy');
t(_)::emit(Time, 2, 'sunshine+rain').

t(_)::trans(Time, 0, 0); t(_)::trans(Time, 0, 1); t(_)::trans(Time, 0, 2).
t(_)::trans(Time, 1, 0); t(_)::trans(Time, 1, 1); t(_)::trans(Time, 1, 2).
t(_)::trans(Time, 2, 0); t(_)::trans(Time, 2, 1); t(_)::trans(Time, 2, 2).

% ===

% Use the learnable HMM from the previous question to learn the parameters of the weather model:
% problog lfi weather-learn.pl evidence.pl -O learned-model.pl -v -n 500
% This command will run up to 500 learning iterations, which should take about 10 minutes. Take that opportunity to get up and stretch your legs. You can find the learned parameters in learned-model.pl. Compare the learned parameters to the parameters of the original model. What do you notice?

% conda activate ia206; problog lfi weather-learn.pl evidence.pl -O learned-model2.pl -v -n 500
