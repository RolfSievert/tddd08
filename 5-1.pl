% Lab 5-1

:- use_module(library(clpfd)).

% Define dynamic predicates
dynamic on/2.
dynamic container/3.

on(a,d).
on(b,c).
on(c,d).

container(a,2,2).
container(b,4,1).
container(c,2,2).
container(d,1,1).

earliest_start(Box, Time):-
    \+on(_, Box),
    container(Box, _, Time).
earliest_start(Box, Time):-
    on(X, Box),
    container(X, _, D),
    Time #= D + T,
    earliest_start(X, T).

schedule(Starts) :-
        Starts = [S1,S2,S3,S4],
        Tasks = [task(S1,2,_,2,a),
                 task(S2,1,_,4,b),
                 task(S3,2,_,2,c),
                 task(S4,1,_,1,d)],
        %Starts ins 0..10,
        cumulative(Tasks, [limit(4)]),
        label(Starts).
    


%problem(1, ([container(a,2,2),
%             container(b,4,1),
%             container(c,2,2),
%             container(d,1,1)]).




unload_box(Box) :-
    \+on(_, Box),
    retract(on(Box, _),
    retract(container(Box, _, _)).


