% Order 1
%middle(X,[X]).
%middle(X,[_First|Xs]) :-
%	append(Middle,[_Last],Xs),
%	middle(X,Middle).

% Order 2
%middle(X,[X]).
%middle(X,[_First|Xs]) :-
%	middle(X,Middle),
%	append(Middle,[_Last],Xs).

% Order 3
%middle(X,[_First|Xs]) :-
%	append(Middle,[_Last],Xs),
%	middle(X,Middle).
%middle(X,[X]).

% Order 4
middle(X,[_First|Xs]) :-
	middle(X,Middle),
	append(Middle,[_Last],Xs).
middle(X,[X]).
