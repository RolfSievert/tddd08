% Order 1
middle(X,[X]).
middle(X,[_|Xs]) :-
	append(Middle,[_],Xs),
	middle(X,Middle).

% Order 2
%middle(X,[X]).
%middle(X,[_|Xs]) :-
%	middle(X,Middle),
%	append(Middle,[_],Xs).

% Order 3
%middle(X,[_|Xs]) :-
%	append(Middle,[_],Xs),
%	middle(X,Middle).
%middle(X,[X]).

% Order 4
%middle(X,[_|Xs]) :-
%	middle(X,Middle),
%	append(Middle,[_],Xs).
%middle(X,[X]).
