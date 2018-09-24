% Calculate arithmetic and boolean operations
calc(_, tt, tt).
calc(_, ff, ff).
calc(S0, id(I), V):-
    memberchk(I=V, S0).
calc(_, num(A), A).
calc(_, num(A) < num(B), tt):-
    calc(_, A, V1),
    calc(_, B, V2),
    V1<V2.
calc(_, num(A) < num(B), ff):-
    calc(_, A, V1),
    calc(_, B, V2),
    V1>=V2.
calc(_, num(A) > num(B), tt):-
    calc(_, A, V1),
    calc(_, B, V2),
    V1>V2.
calc(_, num(A) > num(B), ff):-
    calc(_, A, V1),
    calc(_, B, V2),
    V2>=V1.
calc(_, A + B, V1+V2):-
    calc(_, A, V1),
    calc(_, B, V2).
calc(_, A - B, V1-V2):-
    calc(_, A, V1),
    calc(_, B, V2).
calc(_, A * B, V1*V2):-
    calc(_, A, V1),
    calc(_, B, V2).


% Does nothing
execute(S0, skip, S0).

% Assumes E is a Number to begin with
execute(S0, set(I, E), Sn) :-
    % If identifier already exists in S0
    memberchk(I=A, S0),
    delete(S0, I=A, S1),
    sublist(S1, Sn),
    memberchk(I=E, Sn);
    % If it doesn't exist in S0
    \+memberchk(I=_, S0),
    sublist(S0, Sn),
    memberchk(I=E, Sn).

% Executes C1 if B, else C2
execute(S0, if(B, C1, C2), Sn):-
    % if B is true
    B,
    execute(S0, C1, Sn);
    % if B is false
    \+B,
    execute(S0, C2, Sn).

% Executes C while boolean B is true
execute(S0, while(B, C), Sn):-
    B,
    execute(S0, C, S1),
    execute(S1, while(B, C), Sn).

% Executes C1 and C2 in that order
execute(S0, seq(C1, C2), Sn):-
    execute(S0, C1, S1),
    execute(S1, C2, Sn).

%execute([x=3],
%seq(set(y,num(1)),
%    while(x > num(1),
%        seq(set(y, id(y) * id(x)),
%            set(x, id(x) - num(1)))))
%,Sn)
