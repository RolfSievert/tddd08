% Task 1-5
beautiful('Ulrika').
beautiful('Nisse').
beautiful('Peter').

rich('Nisse').
rich('Anne').

strong('Anne').
strong('Peter').
strong('Bosse').

kind('Bosse').

woman('Ulrika').
woman('Bettan').

man('Nisse').
man('Bosse').
man('Peter').

% Task 6
likes(X, Y) :-
	man(X),
	woman(Y),
	beautiful(Y).

% Task 7
happy(X) :-
	rich(X).

% Task 8
happy(X) :-
	man(X),
	woman(Y),
	likes(Y,X),
	likes(X,Y).

% Task 9
happy(X) :-
	woman(X),
	man(Y),
	likes(Y,X),
	likes(X,Y).

% Task 10
likes('Nisse',X) :-
	woman(X),
	likes(X,'Nisse').

% Task 11
likes('Peter', X) :-
	kind(X).

% Task 12
likes('Ulrika', X) :-
	man(X),      	
	(
		rich(X),kind(X);
		beautiful(X),strong(X)
	),
	likes(X,'Ulrika').
