% Lab 5-1

:- use_module(library(clpfd)).

% Define dynamic predicates
:- dynamic(on/2).
:- dynamic(container/3).

on(a,d).
on(b,c).
on(c,d).

container(a,2,2).
container(b,4,1).
container(c,2,2).
container(d,1,1).

create_task(Box, task(Start, Duration, _, Cost, Box)):-
    on(X, Box),
    container(X, _, _),
    container(Box, M, Duration),
    create_task(X, task(_, _, XE, _, X)),
    unload_box(Box),
    Cost#=M*Duration,
    Start #> XE.
create_task(Box, task(_, Duration, _, Resources, Box)):-
    \+on(_, Box),
    unload_box(Box),
    container(Box, Resources, Duration).

schedule(Tasks):-
    container(Box, _, _),
    findall(Task, create_task(Box, Task), Tasks),
    cumulative(Tasks, [limit(10)]).

unload_box(Box):-
    \+on(_, Box).
%retract(on(Box, _)).
    %retract(container(Box, _, _)).


