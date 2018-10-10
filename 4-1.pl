% excersice 4.1

%%%%% Functors for building graph
% Returns number of missionaries in list M
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

% Creates a list of neighbour states to a given state
get_neighbours([R1, Boat, R2, Side], Neighbours).

% Checks if an element is in list
in_graph([Elem|L], Elem).
in_graph([H|L], Elem):-
    H\=Elem,
    in_graph(L, Elem).

% Maybe pass condition that element cant already be in list? Insert unique only?
% Inserts all pairs of elements in list
insert(Elem, [H|T], L).

% Creates a graph for our problem with initial state R1, Boat, R2, Side
create_graph([R1, Boat, R2, Side], Graph):-
    get_neighbours([R1, Boat, R2, Side], Neighbours),
    insert([R1, Boat, R2, Side], Neighbours, G1),
    append(G1, G2, Graph),
    % Create graph for all neighbours
    create_graph(


%%%%%% Functors for search
% True if N1 and N2 are directly connected
connected(Graph, N1, N2).
% Returns all directly connected nodes to Node
neighbours(Graph, Node, Neighbours).
% Breadth first algorithm
breadth_first(Graph, Start, Goal, Path).

% Data = [c, c, c, m, m, m]
