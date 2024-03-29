% Task 2-4
% Returns the union of two lists
union([], [], U):-
    U=[].
union(S, [], U):-
    S\=[],
    U=S.
union([], S, U):-
    union(S, [], U).
union([H1|T1], [H2|T2], [UH|UT]):-
    H1@<H2,
    UH=H1,
    union(T1, [H2|T2], UT);
    H2@<H1,
    UH=H2,
    union([H1|T1], T2, UT);
    H2=H1,
    UH=H2,
    union(T1, T2, UT).
    
% Returns the intersection of two lists
intersection([], [], U):-
    U=[].
intersection(S, [], U) :-
    S\=[],
    U=[].
intersection([], S, U) :-
    S\=[],
    U=[].
intersection([H1|T1], [H2|T2], U):-
    H1=H2,
    U=[UH|UT],
    UH=H1,
    intersection(T1, T2, UT);
    (
        H1@<H2,
        intersection(T1, [H2|T2], U);
        H2@<H1,
        intersection([H1|T1], T2, U)
    ).

% Appends a list at the end of all existing lists within a list.
insert(X, [[]], Z):-
    Z=[[X]].
insert(X, [H|T], Z):-
    [H|T]\=[[]],
    append([X], H, L),
    append([L], L1, Z),
    insert(X, T, L1).

% Produces the powerset of a set
power([], [[]]).
power([H|T], U):-
    [H|T]\=[],
    power(T, X),
    insert(H, X, S),
    append(S, X, U).
