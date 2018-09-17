% 2.1

% True if list is sorted, false if not.
issorted([]).
issorted([_]).
issorted([H1, H2|T]):-
    H1<H2,
    issorted([H2|T]).

% Retrieves smallest element in list as S.
smallest([H], S):-
    H=S.
smallest([H1, H2|T], S):-
    H2>=H1,
    smallest([H1|T], S);
    H1>H2,
    smallest([H2|T], S).
    
% Remove element Rem from list and return list without Rem as Out.
remElem(_, [], Out):-
    Out=[].
remElem(Rem, [H|T], Out):-
   H=Rem,
   Out=T;
   H\=Rem,
   Out=[H|O],
   remElem(Rem, T, O).

% Selection sort. Sorts list L and stores sorted list in LS.
ssort([], LS):-
    LS=[].
ssort(L, LS):-
    smallest(L, S),
    remElem(S, L, T),
    LS=[S|TLS],
    ssort(T, TLS).

% Separates list into two lists where all elements less than N
% is in left list and all greater or equal in right list.
split([], _, Left, Right):-
    Left=[],
    Right=[].
split([H|T], N, Left, Right):-
    H<N,
    Left=[H|LL],
    split(T, N, LL, Right);
    H>=N,
    Right=[H|RR],
    split(T, N, Left, RR).

% Quick sort
qsort([], LS):-
    LS=[].
qsort([H], LS):-
    LS=[H].
qsort([H|T], LS):-
    T\=[],
    split(T, H, Left, Right),
    qsort(Left, LeftS),
    qsort(Right, RightS),
    append(LeftS, [H|RightS], LS).
