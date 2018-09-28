%%% Calculate arithmetic and boolean operations
% Return true if boolean is true
calc(_, tt, tt).
% return false if boolean is false
calc(_, ff, ff).
% Check if X has an assigned value in S0 and return that value
calc(S0, X, V):-
    memberchk(X=V, S0).
% Check if I has an assigned value in S0 and return that value
calc(S0, id(I), V):-
    memberchk(I=V, S0).
% Return number A if A is a number
calc(_, num(A), A).
% If boolean comparison is true return true
calc(S0, A < B, tt):-
    calc(S0, A, V1),
    calc(S0, B, V2),
    V1<V2.
% If boolean comparison is false, return false
calc(S0, A < B, ff):-
    calc(S0, A, V1),
    calc(S0, B, V2),
    V1>=V2.
% If boolean comparison is true return true
calc(S0, A > B, tt):-
    calc(S0, A, V1),
    calc(S0, B, V2),
    V1>V2.
% If boolean comparison is false, return false
calc(S0, A > B, ff):-
    calc(S0, A, V1),
    calc(S0, B, V2),
    V2>=V1.
% Calculate expression and assign value to V
calc(S0, A + B, V):-
    calc(S0, A, V1),
    calc(S0, B, V2),
    V is V1+V2.
% Calculate expression and assign value to V
calc(S0, A - B, V):-
    calc(S0, A, V1),
    calc(S0, B, V2),
    V is V1-V2.
% Calculate expression and assign value to V
calc(S0, A * B, V):-
    calc(S0, A, V1),
    calc(S0, B, V2),
    V is V1*V2.

% Does nothing
execute(S0, skip, S0).

% Set an already existing identifier to new value
execute(S0, set(I, E), Sn) :-
    memberchk(I=A, S0),
    delete(S0, I=A, S1),
    calc(S0, E, V),
    append([I=V], S1, Sn).
% Set a new variable that didn't exists before
execute(S0, set(I, E), Sn) :-
    \+memberchk(I=_, S0),
    calc(S0, E, V),
    append([I=V], S0, Sn).

% Executes C1 if B
execute(S0, if(B, C1, _C2), Sn):-
    calc(S0, B, tt),
    execute(S0, C1, Sn).
% Executes C2 if not B
execute(S0, if(B, _C1, C2), Sn):-
    calc(S0, B, ff),
    execute(S0, C2, Sn).

% Executes C while boolean B is true
execute(S0, while(B, C), Sn):-
    calc(S0, B, tt),
    execute(S0, C, S1),
    execute(S1, while(B, C), Sn).
% Ends execution when B is false
execute(S0, while(B, _), S0):-
    calc(S0, B, ff).

% Executes C1 and C2 in that order
execute(S0, seq(C1, C2), Sn):-
    execute(S0, C1, S1),
    execute(S1, C2, Sn).

% program
%execute([], seq(set(y, num(1)), while(x > num(1), seq(set(y, id(y) *id(x)), set(x, id(x) - num(1))))), Sn).
