% Exercise 4

% Checks if an Element is not in a list
not_member(_, []).
not_member(Elem, [H|T]) :-
	dif(Elem, H),
	not_member(Elem, T).

% Checks if the current state is allowed
valid_state([ML, CL, MR, CR, _]) :-
	valid_shore(ML, CL),
    !,
	valid_shore(MR, CR).

% Checks if the number of missionaries are equal or more to the number of cannibals
valid_shore(0, _).
valid_shore(M, C) :-
	0 =< M,
	0 =< C,
	C =< M.

% Different combinations of passengers
boat(1, 0).
boat(0, 1).
boat(2, 0).
boat(0, 2).
boat(1, 1).

% Finds all states that can be reached from the current state
% If the boat is currently on the left side
next([ML, CL, MR, CR, left], Visited, NextState) :-
    boat(CtoBoat, MtoBoat),
    MLNext is ML - MtoBoat,
    CLNext is CL - CtoBoat,
	MRNext is MR + MtoBoat,
	CRNext is CR + CtoBoat,
	NextState = [MLNext, CLNext, MRNext, CRNext, right],
    valid_state(NextState),
    not_member(NextState, Visited).

% If the boat is currently on the right side
next([ML, CL, MR, CR, right], Visited, NextState) :-
    boat(CtoBoat, MtoBoat),
	MLNext is ML + MtoBoat,
	CLNext is CL + CtoBoat,
    MRNext is MR - MtoBoat,
    CRNext is CR - CtoBoat,
	NextState = [MLNext, CLNext, MRNext, CRNext, left],
	valid_state(NextState),
	not_member(NextState, Visited).

% DFS, depth first search
% Start
dfs(Goal) :-
    dfs([[3, 3, 0, 0, left]], Goal).

% Depth traversal
dfs([[0, 0, 3, 3, right]|Visited], [[0, 0, 3, 3, right]|Visited]).
dfs([Curr|Visited], Goal):-
    next(Curr, [Curr|Visited], Next),
    dfs([Next, Curr|Visited], Goal).

% BFS, breadth first search
% Start
bfs(Path) :-
    bfs([[3, 3, 0, 0, left]], Path).

% Breadth traversal
%bfs(Visited, [[0, 0, 3, 3, right]|_],  [[0, 0, 3, 3, right]|Visited]).
%bfs(Visited, [CurrState|CurrFrontier], Path):-
%    findall(Neighbour, next(CurrState, [CurrState|Visited], Neighbour), Neighbours),
%    append(CurrFrontier, Neighbours, NextFrontier),
%    bfs([CurrState|Visited], NextFrontier, Path).
bfs([[[0, 0, 3, 3, right]|Path]|_], [[0, 0, 3, 3, right]|Path]).
bfs([[Curr|Visited]|Paths], FinalPath):-
    findall(Neighbour, next(Curr, [Curr|Visited], Neighbour), Neighbours),
    expand([Curr|Visited], Neighbours, NewPaths),
    append(Paths, NewPaths, NextFrontier),
    bfs(NextFrontier, FinalPath).

% Adds all members of L2 to first of L1 and puts these lists in L3.
expand(L1, L2, L3):-
    findall([X|L1], member(X, L2), L3).
