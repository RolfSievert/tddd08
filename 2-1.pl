% Functions that recursivly checks if a list is ascending
issorted([]).
issorted([_]).
issorted([H1, H2|T]) :-
	H1 < H2,
	issorted([H2|T]).

% Retrieves smallest element in list as S
smallest([H], S) :-
	H = S.
smallest([H1, H2|T], S) :-
	H2 >= H1,
	smallest([H1|T], S);
	H1 > H2,
	smallest([H2|T], S).

% Remove element Rem from list and retuen list without Rem as Out
remElem(_, [], Out) :-
	Out = [].
remElem(Rem, [H|T], Out) :-
	H = Rem,
	Out = T;
	H \= Rem,
	Out = [H|O],
	remElem(Rem, T, O).

% Selection sort. Sorts list L and stores sorted list in LS
ssort([], LS) :-
	LS = [].
ssort(L, LS) :-
	smallest(L, S),
	remElem(S, L, T),
	LS = [S|TLS],
	ssort(T, TLS).

% Splits a list into two based on a pivot element.
split([], _, LEFT, RIGHT) :-
	LEFT = [],
	RIGHT = [].
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
