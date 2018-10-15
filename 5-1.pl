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

create_tasks([], _, []).
create_tasks([Box|Boxes], End, Tasks):-
    create_tasks(Boxes, End, T2),
    create_task(Box, End, T1),
    append(T1, T2, Tasks).

create_task(Box, _, []):-
    on(_, Box).
create_task(Box, E, [task(Start, Duration, End, Resources, Box)|Tasks]):-
    \+on(_, Box),
    container(Box, Resources, Duration),
    Start #>= E,
    findall(X, on(Box, X), Boxes),
    unload_box(Box),
    create_tasks(Boxes, End, Tasks).
    
schedule(Tasks):-
    % Unloadable boxes
    findall(X, \+on(_, X), Boxes),
    create_tasks(Boxes, 0, Tasks).
%cumulative(Tasks, [limit(10)]).

unload_box(Box):-
    \+on(Box, _).
unload_box(Box):-
    on(Box, _),
    retract(on(Box, _)).
%retract(container(Box, _, _)).


