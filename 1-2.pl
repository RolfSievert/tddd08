% Connects two adjacent nodes
path(a,b).
path(a,c).
path(b,c).
path(c,d).
path(c,e).
path(d,f).
path(d,h).
path(e,f).
path(e,g).
path(f,g).

% Halting condition, if end node is reached
path(X,Y, [X, Y]):-
	path(X,Y).

% Connects nodes recursivly
% If X is connected to H and a path between H and Y exists, X is connected to H
path(X,Y,[X|T]) :-
	path(X,H),
	path(H,Y,T).

% Connects nodes recursivly and counts distance
% Gets path L from X to Y, and a number Number which is length of L
npath(X,Y,[Number|L]) :-
	path(X,Y,L),
	length(L,Number).
