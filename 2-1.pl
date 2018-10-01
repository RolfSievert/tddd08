% Lab 2

% Functions that recursivly checks if a list is ascending
% Halting conditions
issorted([]).
issorted([_]).
% Checks if first two elements and checks if rest of list is sorted
issorted([H1, H2|T]) :-
	H1 < H2,
	issorted([H2|T]).

% Retrieves smallest element in list as S
% Halting condition
smallest([H], S) :-
	H = S.
% Either removes H1 or H2 depending on which is the biggest, in the end only the smallest will be left
smallest([H1, H2|T], S) :-
	H2 >= H1,
	smallest([H1|T], S);
	H1 > H2,
	smallest([H2|T], S).

% Remove element Rem from list and retuen list without Rem as Out
% Halting condition
remElem(_, [], Out) :-
	Out = [].
% If H is equal to Rem, it is removed from list, otherwise check rest of list
remElem(Rem, [H|T], Out) :-
	H = Rem,
	Out = T;
	H \= Rem,
	Out = [H|O],
	remElem(Rem, T, O).

% Selection sort. Sorts list L and stores sorted list in LS
% Halting case
ssort([], LS) :-
	LS = [].
% Gets smallest element of list L, removes that element from L which results in T, continue to sort T and build TLS
ssort(L, [S|TLS]) :-
	smallest(L, S),
	remElem(S, L, T),
	ssort(T, TLS).

% Splits a list into two based on a pivot element.
% Halting condition
split([], _, LEFT, RIGHT) :-
	LEFT = [],
	RIGHT = [].
% Checks if front of list is less or equal or greater than pivot, and puts in left or right list respectively. Calls the rest of list afterwards
split([H|T], PIVOT, LEFT, RIGHT) :-
	H < PIVOT,
	LEFT = [H|LL],
	split(T, PIVOT, LL, RIGHT);
	H >= PIVOT,
	RIGHT = [H|RR],
	split(T, PIVOT, LEFT, RR).

% Quick sort. Sorts a list by using pivot elements and sorting in accordance to them.
qsort([],SORTED) :-
	SORTED = [].
qsort([H],SORTED) :-
	SORTED = [H].
qsort([H|T],SORTED) :-
	PIVOT = H,
	T \= [],
	split(T,PIVOT,LEFT,RIGHT),
	qsort(LEFT,SORTEDLEFT),
	qsort(RIGHT,SORTEDRIGHT),
	append(SORTEDLEFT,[PIVOT|SORTEDRIGHT],SORTED).
