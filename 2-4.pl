% excersise 2-4
union([], [], U):-
    U=[].
union(S, [], U):-
    S\=[],
    U=S.
union([], S, U):-
    S\=[],
    U=S.
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
    
intersection([], [], U):-
    U=[].
intersection([H1|T1], [H2|T2], [UH|UT]):-
    H1=H2,
    UH=H1,
    intersection(T1, T2, UT);
    H1\=H2,
    (
        H1@<H2,
        intersection(T1, [H2|T2], [UH|UT]);
        H2@<H1,
        intersection([H1|T1], T2, [UH|UT])
    ).
insert(X, [], Z):-
    Z=[].
insert(X, [H|T], Z):-
    [H|T]\=[],
    append([X], H, L),
    append([L], L1, Z),
    insert(X, T, L1).
power([], U):-
    U=[[]].
power([H|T], U):-
    [H|T]\=[],
    insert(H, X, S),
    power(T, X),
    append(S, X, U).
