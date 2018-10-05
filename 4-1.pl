% excersice 4.1


% Checks if two nodes are directly connected

connected([[N1, N2]|T], N1, N2).
connected([H|T], N1, N2):-
    connected(T, N1, N2).
    

% Calculates the shortest path between Start and Goal
breadth_first(Data, Start, Goal, Path):-
    

