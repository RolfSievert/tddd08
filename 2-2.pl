% Order 1
middle1(X,[X]).
middle1(X,[_First|Xs]) :-
	append(Middle,[_Last],Xs),
	middle1(X,Middle).

% Order 2
middle2(X,[X]).
middle2(X,[_First|Xs]) :-
	middle2(X,Middle),
	append(Middle,[_Last],Xs).

% Order 3
middle3(X,[_First|Xs]) :-
	append(Middle,[_Last],Xs),
	middle3(X,Middle).
middle3(X,[X]).

% Order 4
middle4(X,[_First|Xs]) :-
	middle4(X,Middle),
	append(Middle,[_Last],Xs).
middle4(X,[X]).
