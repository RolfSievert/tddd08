% Exercise 5-1
:- use_module(library(clpfd)).

% The world representing the containers
% Containers with a time and amount of workers needed to unload them
container(a, 2, 2).
container(b, 4, 1).
container(c, 2, 2).
container(d, 1, 1).

% Which containers are on top of eachother
on(a, d).
on(b, c).
on(c, d).

% Returns the maximum duration needed
max_duration([[_, _, D]], D).
max_duration([[_, _, D]|Containers], Max) :-
	Max #= D + Tot, 
    max_duration(Containers, Tot).

% Returns the minimum number of workers needed
min_workers([[_, W, _]], W).
min_workers([[_, W1, _], [_, W2, _]|Containers], Min) :-
	W1 #=< W2, 
    min_workers([[_, W2, _]|Containers], Min).
min_workers([[_, W1, _], [_, W2, _]|Containers], Min) :-
	W1 #> W2, 
    min_workers([[_, W1, _]|Containers], Min).

% Returns the maximum number of workers needed
max_workers([[_, W, _]], W).
max_workers([[_, W, _]|Containers], Max) :-
	Max #= W + Tot,
    max_workers(Containers, Tot).

% Returns the final time cost
time_cost([E], E).
time_cost([E|Ends], E) :-
    E #>= Cost, 
    time_cost(Ends, Cost).
time_cost([E|Ends], Cost) :-
	E #< Cost,
    time_cost(Ends, Cost).

% Iterates through all the containers 
iterate([], [], []).
iterate([S|Starts], [E|Ends], [[B, _, _]|Containers]) :-
	apply_constraint([S|Starts], [E|Ends], [B|Containers]),
	iterate(Starts, Ends, Containers).

% Applies contraints between a container and all the other containers
apply_constraint([_], [_], [_]).
apply_constraint([S1, S2|Starts], [E1, E2|Ends], [B1, [B2, _, _]|Containers]):-
	constraint(S1, S2, E1, E2, B1, B2),
	apply_constraint([S1|Starts], [E1|Ends], [B1|Containers]).

% Makes sure that a box cannot be unloaded before the box on top of it 
constraint(S1, S2, E1, E2, B1, B2) :-
	on(B1, B2),
	S2 #>= E1;
    on(B2, B1),
    S1 #>= E2;
	\+(on(B1, B2)),
	\+(on(B2, B1)).

% Returns all the containers but parsed as taskes
make_tasks(_, _, [], []).
make_tasks([S|Starts], [E|Ends], [[_, W, D]|Containers], [T|Tasks]) :-
	T = task(S, D, E, W, 0),
	make_tasks(Starts, Ends, Containers, Tasks).

% Schedules all the tasks and returns total cost, number of workers and cost in time
schedule(TotCost, Workers, TimeCost, Starts, Ends) :-
	findall([C, W, D], container(C, W, D), Containers),
	
    % Makes lists for starting times and ending times
    length(Containers, N),
	length(Starts, N),
	length(Ends, N),
	
    % Sets limits for starting times, ending times and number of workers to decrease solution space
	max_duration(Containers, MaxD),
	domain(Starts, 0, MaxD),
	domain(Ends, 0, MaxD),
	time_cost(Ends, TimeCost),
    min_workers(Containers, MinW),
	max_workers(Containers, MaxW),
	Workers in MinW..MaxW,	
	TotCost #= Workers * TimeCost,

    % Constrains task variables so that they follow the rules of unloading
    iterate(Starts, Ends, Containers),
	
	% Parses the containers into tasks and feeds them to the cumulative function to minimize based on TotCost.
	make_tasks(Starts, Ends, Containers, Tasks),
	cumulative(Tasks, [limit(Workers)]),
	labeling([minimize(TotCost)], [TotCost|Starts]).
