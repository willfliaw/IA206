state/2.
trans/3.
emit/3.
observe/2.
observe_sequence/1.
observe_sequence_aux/1.
state_sequence/1.
state_sequence_aux/1.
observe(Time,Symbol) :- state(Time,State), emit(Time,State,Symbol).
print([]) :- nl.
print(X) :- write(X), nl.
print(X,Y) :- write(X), write(' - '), write(Y), nl.
observe_sequence_aux(Time,State,[Symbol | Tail]) :- trans(Time,State,State1), Time1 is Time+1, emit(Time1,State1,Symbol), observe_sequence_aux(Time1,State1,Tail).
observe_sequence_aux(_,_,[]).
observe_sequence([First | Rest]) :- start(Start_state), emit(0,Start_state,First), observe_sequence_aux(0,Start_state,Rest).
state_sequence_aux(_,_,[]).
state_sequence_aux(Time,State,[State1 | Rest]) :- trans(Time,State,State1), Time1 is Time+1, state_sequence_aux(Time1,State1,Rest).
state_sequence([Start | Rest]) :- start(Start), state_sequence_aux(0,Start,Rest).
state(0,State) :- start(State).
state(Time,State) :- Time>0, Previous is Time-1, state(Previous,Previous_state), trans(Previous,Previous_state,State).
generate_sequence(L,N) :- length(L,N), observe_sequence(L).
1.0::start(0); 0.0::start(1); 0.0::start(2).
0.118387105349541::emit(Time,0,'cloudy-dry'); 0.328407206763031::emit(Time,0,'cloudy-rainy'); 0.370132853368278::emit(Time,0,'sunshine'); 0.130145775116385::emit(Time,0,'fog'); 0.052927059402765::emit(Time,0,'foggy-rainy'); 0.0::emit(Time,0,'sunshine+rain').
0.0::emit(Time,1,'cloudy-dry'); 0.88947358174175::emit(Time,1,'cloudy-rainy'); 0.11052641825825::emit(Time,1,'sunshine'); 0.0::emit(Time,1,'fog'); 0.0::emit(Time,1,'foggy-rainy'); 0.0::emit(Time,1,'sunshine+rain').
0.114542810285641::emit(Time,2,'cloudy-dry'); 0.272935085501586::emit(Time,2,'cloudy-rainy'); 0.243537423880776::emit(Time,2,'sunshine'); 0.130131027895731::emit(Time,2,'fog'); 0.043311140908377::emit(Time,2,'foggy-rainy'); 0.195542511527888::emit(Time,2,'sunshine+rain').
0.0::trans(Time,0,0); 0.0::trans(Time,0,1); 1.0::trans(Time,0,2).
0.268973676150893::trans(Time,1,0); 0.311844531331758::trans(Time,1,1); 0.41918179251735::trans(Time,1,2).
9.8999222024e-05::trans(Time,2,0); 0.075036773188437::trans(Time,2,1); 0.924864227589539::trans(Time,2,2).
