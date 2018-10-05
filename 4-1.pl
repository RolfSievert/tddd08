% excersice 4.1

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

% Checks if two nodes are directly connected
connected(R1, Boat, R2):-


%connected([H|R1], [], [], R1Out, BoatOut, []):-
%    length(

% Retrieves all neighbours for one node
neighbours([], Node, []).
%neighbours([[Node, Node2]], Node, Out):-
    

% Calculates the shortest path between Start and Goal
%breadth_first(R1, Boat, R2, Start, Goal, Path):-
    



% Data = [c, c, c, m, m, m]
