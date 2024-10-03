% A simplified model of weather
% There are 3 hidden states for the weather. You can change that number by adding appropriate lines.
% Inspired from https://dtai.cs.kuleuven.be/problog/tutorial/various/06_hmm.html

state/2.                 % Time, State. State is an integer.
trans/3.                 % Time, From_state, To_state.
emit/3.                  % Time, State, Symbol. Symbol is the types of weather that we observe: 'cloudy-dry', 'cloudy-rainy', 'sunshine+rain', 'fog', 'foggy-rainy', 'sunshine'
observe/2.               % Time, Symbol. Symbol observed at time Time.
observe_sequence/1.      % Sequence. List of symbols.
observe_sequence_aux/1.  % Time, Current_state, Sequence of symbols.
state_sequence/1.        % Sequence. List of states.
state_sequence_aux/1.    % Time, Current_state, Sequence of symbols.

observe(Time, Symbol) :- state(Time, State), emit(Time, State, Symbol).

print([]) :- nl.
print(X) :- write(X), nl.
print(X,Y) :- write(X), write(' - '), write(Y), nl.

observe_sequence_aux(Time, State, [Symbol|Tail]) :-
    trans(Time, State, State1), % transition states
    Time1 is Time+1,
    emit(Time1, State1, Symbol), % emit symbol
    observe_sequence_aux(Time1, State1, Tail). % observe the rest of the sequence

observe_sequence_aux(_,_,[]). % the empty sequence has probability 1.

observe_sequence([First|Rest]) :-
    start(Start_state),
    emit(0, Start_state, First),
    observe_sequence_aux(0, Start_state, Rest).

state_sequence_aux(_,_,[]).

state_sequence_aux(Time, State, [State1|Rest]) :-
    trans(Time, State, State1),
    Time1 is Time+1,
    state_sequence_aux(Time1, State1, Rest).

state_sequence([Start|Rest]) :-
    start(Start),
    state_sequence_aux(0, Start, Rest).

% start conditions
state(0, State) :- start(State).

state(Time, State) :-
    Time > 0,
    Previous is Time - 1,
    state(Previous, Previous_state),
    trans(Previous, Previous_state, State).

% this can be used to sample from the model
generate_sequence(L, N) :- length(L, N), observe_sequence(L).

% ===

% Try sampling from your program, and paste 10 samples of 8-symbol sequences into the answer form. You can make ProbLog print the probability of each sample using the flag --with-probability.

% .5::start(0) ; .5::start(1).

% .3::emit(Time, 0, 'cloudy-dry'); .7::emit(Time, 0, 'sunshine').
% 4/7::emit(Time, 1, 'cloudy-rainy'); 2/7::emit(Time, 1, 'fog'); 1/7::emit(Time, 1, 'foggy-rainy').
% emit(_, 2, 'sunshine+rain').

% .5::trans(Time, 0, 0); .3::trans(Time, 0, 1); .2::trans(Time, 0, 2).
% .3::trans(Time, 1, 0); .5::trans(Time, 1, 1); .2::trans(Time, 1, 2).
% .4::trans(Time, 2, 0); .4::trans(Time, 2, 1); .2::trans(Time, 2, 2).

% query(observe_sequence([X1, X2, X3, X4, X5, X6, X7, X8])).

% conda activate ia206; problog sample weather-learn.pl -N 10 --with-probability

% % problog sample weather-learn.pl -N 10 --with-probability
% observe_sequence(['foggy-rainy', 'cloudy-rainy', 'sunshine', 'sunshine', 'sunshine', 'sunshine+rain', 'sunshine+rain', 'sunshine']).
% % Probability: 5.88e-06
% ----------------
% observe_sequence(['sunshine', 'cloudy-rainy', 'fog', 'cloudy-rainy', 'fog', 'fog', 'fog', 'fog']).
% % Probability: 1.0199832e-06
% ----------------
% observe_sequence(['sunshine', 'foggy-rainy', 'cloudy-dry', 'sunshine', 'sunshine', 'sunshine+rain', 'sunshine', 'cloudy-rainy']).
% % Probability: 1.5876e-06
% ----------------
% observe_sequence(['fog', 'cloudy-rainy', 'sunshine', 'sunshine', 'sunshine+rain', 'fog', 'cloudy-dry', 'sunshine']).
% % Probability: 2.16e-06
% ----------------
% observe_sequence(['fog', 'sunshine+rain', 'cloudy-rainy', 'sunshine+rain', 'cloudy-rainy', 'fog', 'sunshine', 'sunshine+rain']).
% % Probability: 1.7912536e-06
% ----------------
% observe_sequence(['cloudy-rainy', 'cloudy-rainy', 'sunshine+rain', 'sunshine', 'sunshine+rain', 'sunshine+rain', 'sunshine+rain', 'sunshine']).
% % Probability: 1.024e-05
% ----------------
% observe_sequence(['cloudy-rainy', 'sunshine', 'sunshine+rain', 'sunshine', 'sunshine', 'sunshine', 'cloudy-rainy', 'sunshine+rain']).
% % Probability: 1.4112e-05
% ----------------
% observe_sequence(['cloudy-rainy', 'cloudy-rainy', 'cloudy-rainy', 'cloudy-dry', 'fog', 'sunshine', 'sunshine', 'sunshine+rain']).
% % Probability: 2.644898e-06
% ----------------
% observe_sequence(['sunshine', 'cloudy-dry', 'cloudy-dry', 'foggy-rainy', 'sunshine', 'sunshine', 'sunshine+rain', 'sunshine+rain']).
% % Probability: 9.9225e-07
% ----------------
% observe_sequence(['cloudy-rainy', 'cloudy-rainy', 'cloudy-rainy', 'sunshine', 'cloudy-dry', 'sunshine', 'sunshine', 'sunshine+rain']).
% % Probability: 1.8e-05
% (True, <generator object sample at 0x0000017851E79D20>)

% ===

% Take all the rules about start, trans and emit that we had so far, and change them to turn their probabilities into learnable parameters. Paste in those lines of code into the answer form.

% t(_)::start(0) ; t(_)::start(1).

% t(_)::emit(Time, 0, 'cloudy-dry'); t(_)::emit(Time, 0, 'sunshine').
% t(_)::emit(Time, 1, 'cloudy-rainy'); t(_)::emit(Time, 1, 'fog'); t(_)::emit(Time, 1, 'foggy-rainy').
% emit(_, 2, 'sunshine+rain').

% t(_)::trans(Time, 0, 0); t(_)::trans(Time, 0, 1); t(_)::trans(Time, 0, 2).
% t(_)::trans(Time, 1, 0); t(_)::trans(Time, 1, 1); t(_)::trans(Time, 1, 2).
% t(_)::trans(Time, 2, 0); t(_)::trans(Time, 2, 1); t(_)::trans(Time, 2, 2).

% query(observe_sequence([X1, X2, X3, X4, X5, X6, X7, X8])).

% conda activate ia206; problog lfi weather-learn.pl evidence.pl -O learned-model.pl -v

% ===

t(_)::start(0); t(_)::start(1); t(_)::start(2).

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

query(observe_sequence([X1, X2, X3, X4, X5, X6, X7, X8])).

% conda activate ia206; problog lfi weather-learn.pl evidence.pl -O learned-model.pl -v -n 100
