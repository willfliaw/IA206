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
