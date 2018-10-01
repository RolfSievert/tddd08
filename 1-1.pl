% LAB 1

% Task 5
% Define the beautiful people
beautiful('Ulrika').
beautiful('Nisse').
beautiful('Peter').

% Define who is rich
rich('Nisse').
rich('Anne').

% Define who is strong
strong('Anne').
strong('Peter').
strong('Bosse').

% Define who is kind
kind('Bosse').

% Define who is woman
woman('Ulrika').
woman('Bettan').

% Define who is man
man('Nisse').
man('Bosse').
man('Peter').

% Task 6
% If X is man and Y is woman and woman is beautiful, X likes Y
likes(X, Y) :-
	man(X),
	woman(Y),
	beautiful(Y).

% Task 7
% If X is rich, X is happy
happy(X) :-
	rich(X).

% Task 8
% If X is man and Y is woman and both likes eachother, X is happy
happy(X) :-
	man(X),
	woman(Y),
	likes(Y,X),
	likes(X,Y).

% Task 9
% Much like task 8, but X is woman and Y is male
happy(X) :-
	woman(X),
	man(Y),
	likes(Y,X),
	likes(X,Y).

% Task 10
% Nisse likes X if X is woman and X likes Nisse
likes('Nisse',X) :-
	woman(X),
	likes(X,'Nisse').

% Task 11
% Peter likes X if X is kind
likes('Peter', X) :-
	kind(X).

% Task 12
% Ulrika likes X if X is man and X likes Ulrika, if X is either rich and kind, or beautiful and strong
likes('Ulrika', X) :-
	man(X),      	
	(
		rich(X),kind(X);
		beautiful(X),strong(X)
	),
	likes(X,'Ulrika').
