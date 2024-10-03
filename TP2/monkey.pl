/*---------------------------------------------------------------*/
/* Telecom Paris- Nils Hozenberger - J-L. Dessalles        2024  */
/* Logic and knowledge representation                            */
/*            http://ia206.simplicitytheory.science              */
/*---------------------------------------------------------------*/


% adapted from I. Bratko - "Prolog - Programming for Artificial Intelligence"
%              Addison Wesley 1990

% A monkey is expected to form a plan to grasp a hanging banana using a box.
% Possible actions are 'walk', 'climb (on the box)', 'push (the box)',
% 'grasp (the banana)'

% description of actions - The current state is stored using a functor 'state'
% with 4 arguments:
%	- horizontal position of the monkey
%	- vertical position of the monkey
%	- position of the box
%	- status of the banana
% 'action' has three arguments:
% 	- Initial state
%	- Final state
%	- act

action(
    state(middle,on_box,X,not_holding),
    grasp,
    state(middle,on_box,X,holding)
).
action(state(X,floor,X,Y), climb, state(X,on_box,X,Y)).
action(state(X,floor,X,Z), push(X,Y), state(Y,floor,Y,Z)).
action(state(X,floor,T,Z), walk(X,Y), state(Y,floor,T,Z)).


success(state(_,_, _, holding)).

success(State1) :-
	action(State1, _Act, State2),
	success(State2).

go :-
	success(state(door, floor, window, not_holding)).
