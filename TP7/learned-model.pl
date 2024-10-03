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
0.699653338855099::start(0); 1.4463149676e-05::start(1); 0.300332197995225::start(2).
0.135481650617744::emit(Time,0,'cloudy-dry'); 0.260694825192423::emit(Time,0,'cloudy-rainy'); 0.240702982612623::emit(Time,0,'sunshine'); 0.150041967547727::emit(Time,0,'fog'); 0.058777248491096::emit(Time,0,'foggy-rainy'); 0.154301325538387::emit(Time,0,'sunshine+rain').
0.0::emit(Time,1,'cloudy-dry'); 0.844249337442011::emit(Time,1,'cloudy-rainy'); 0.155750662557989::emit(Time,1,'sunshine'); 0.0::emit(Time,1,'fog'); 0.0::emit(Time,1,'foggy-rainy'); 0.0::emit(Time,1,'sunshine+rain').
0.002574673614212::emit(Time,2,'cloudy-dry'); 0.490581125500239::emit(Time,2,'cloudy-rainy'); 0.503172001012481::emit(Time,2,'sunshine'); 0.003656180862757::emit(Time,2,'fog'); 1.601901031e-05::emit(Time,2,'foggy-rainy'); 0.0::emit(Time,2,'sunshine+rain').
0.969676091779135::trans(Time,0,0); 0.024510065260064::trans(Time,0,1); 0.005813842960801::trans(Time,0,2).
0.71718369067536::trans(Time,1,0); 0.046817305516286::trans(Time,1,1); 0.235999003808354::trans(Time,1,2).
0.949453733551167::trans(Time,2,0); 0.011136360737668::trans(Time,2,1); 0.039409905711165::trans(Time,2,2).
