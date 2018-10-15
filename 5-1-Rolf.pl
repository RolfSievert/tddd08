% Lab 5-1

:- use_module(library(clpfd)).

% Define dynamic predicates
:- dynamic(on/2).
:- dynamic(container/3).

on(a,d).
on(b,c).
on(c,d).

% B, M, D
container(a,2,2).
container(b,4,1).
container(c,2,2).
container(d,1,1).

create_tasks([], [], _, []).
create_tasks([Box|Boxes], Starts, End, Tasks):-
    create_tasks(Boxes, S2, End, T2),
    create_task(Box, S1, End, T1),
    append(T1, T2, Tasks),
    append(S1, S2, Starts).

create_task(Box, [], _, []):-
    container(Box, _, _),
    on(_, Box).
create_task(Box, [Start|Starts], E, [task(Start, Duration, End, Resources, Box)|Tasks]):-
    container(Box, Resources, Duration),
    \+on(_, Box),
    Start #>= E,
    findall(X, on(Box, X), Boxes),
    unload_box(Box),
    create_tasks(Boxes, Starts, End, Tasks).
    
on_top(Box):-
    container(Box, _, _),
    \+on(_, Box).

schedule(Tasks):-
    % Unloadable boxes
    findall(X, on_top(X), Boxes),
    Starts ins 0..100,
    create_tasks(Boxes, Starts, 0, Tasks),
    cumulative(Tasks, [limit(10)]),
    label(Starts).

unload_box(Box):-
    \+on(Box, _).
unload_box(Box):-
    on(Box, _),
    retract(on(Box, _)).
%retract(container(Box, _, _)).


