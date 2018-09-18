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
    H1<H2,
    UH=H1,
    union(T1, [H2|T2], UT);
    H2<H1,
    UH=H2,
    union([H1|T1], T2, UT);
    H2=H1,
    UH=H2,
    union(T1, T2, UT).
    
