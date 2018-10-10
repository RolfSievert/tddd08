% excersice 4.1

%%%%% Functors for building graph
% Returns all missionaries in list M
missionaries([], []).
missionaries([m|T], [m|C]):-
    missionaries(T, C).
missionaries([c|T], C):-
    missionaries(T, C).

% Count number of missionaries on river bank
number_of_missionaries(River, Num):-
    missionaries(River, M),
    length(M, Num).

% Checks that missionaries are not outnumbered on a river bank
not_outnumbered(R):-
    number_of_missionaries(R, 0).
not_outnumbered(R):-
    number_of_missionaries(R, M),
    length(R, L),
    2*M>=L.

% Checks if an element is in set
in_graph([Elem|L], Elem).
in_graph([H|L], Elem):-
    in_graph(L, Elem).

% Maybe pass condition that element cant already be in list? Insert unique only?
% Inserts all pairs of elements in list
insert(Elem, [H|T], L).

% Creates a graph for our problem with initial state R1, Boat, R2, Side
create_graph([R1, Boat, R2, Side], Graph):-
    get_neighbours([R1, Boat, R2, Side], Neighbours),
    insert([R1, Boat, R2, Side], Neighbours, G1),
    append(G1, G2, Graph).
    % Create graph for all neighbours


% New test
contains_cannibal([c|T]).
contains_cannibal([m|T]):-
    contains_cannibal(T).
contains_missionary([m|T]).
contains_missionary([c|T]):-
    contains_cannibal(T).
remove_cannibal([c|T], T).
remove_cannibal([m|T], [m|Out]):-
    remove_cannibal(T, Out).
remove_missionary([m|T], T).
remove_missionary([c|T], [c|Out]):-
    remove_missionary(T, Out).
add_cannibal(L, [c|L]).
add_missionary(L, [m|L]).
boat_full(Boat):-
    length(Boat, 2).

load_boat([R1, Boat, R2, l], [R1Out, BoatOut, R2Out, l]):-
    \+boat_full(Boat),
    contains_cannibal(R1),
    remove_cannibal(R1, R1Out),
    add_cannibal(Boat, BoatOut).
load_boat([R1, Boat, R2, l], [R1Out, BoatOut, R2Out, l]):-
    \+boat_full(Boat),
    contains_missionary(R1),
    remove_missionary(R1, R1Out),
    add_missionary(Boat, BoatOut).

move_boat([R1, Boat, R2, l], [R1, Boat, R2, r]):-
    \+length(Boat, 0).
move_boat([R1, Boat, R2, r], [R1, Boat, R2, l]):-
    \+length(Boat, 0).
move_people([R1, Boat, R2, l], State):-


ok_state([R1, Boat, R2, Side]):-
    not_outnumbered(R1),
    not_outnumbered(R2).

%%%%%% Functors for search
% True if N1 and N2 are directly connected
connected(Graph, N1, N2):-
    in_graph(Graph, [N1, N2]).
% Returns all directly connected nodes to Node
neighbours(Graph, Node, Neighbours):-
    findall([Node, X], in_graph(Graph, [Node, X]), Neighbours).
% Breadth first algorithm
% TODO: add visited list
depth_first(Graph, Goal, Goal, [Goal]).
depth_first(Graph, Start, Goal, [Start|Path]):-
    connected(Graph, Start, X),
    depth_first(Graph, X, Goal, Path).

% Data = [c, c, c, m, m, m]
