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
path(X,Y,Out):-
	path(X,Y),
	Out=[X,Y].

% Connects nodes recursivly
path(X,Y,Out) :-
	Out=[X|T],
	path(X,H),
	path(H,Y,T).

% Connects nodes recursivly and counts distance
npath(X,Y,Out) :-
	path(X,Y,L),
	length(L,Number),
	Out=[Number|L].
