% 1-2
path(a, b).
path(a, c).
path(b, c).
path(c, d).
path(c, e).
path(d, f).
path(d, h).
path(e, g).
path(e, f).
path(f, g).

% finds path between nodes
path(X, Y, Out):-
    Out=[X,Y],
    path(X, Y).

path(X, Y, Out):-
    Out=[X|T],
    path(X, H),
    path(H, Y, T).

npath(X, Y, Out):-
    path(X, Y, L),
    length(L, N),
    Out = [N|L].
