% exec 3.1

% Load functors and predicates
:-initialization([scanner, '2-3']).

% Set value
%parse([num(1), <, num(2)], Res).
%parse([A, :=, B], set(A, B)).

%%% Parse calculations
%parse([A, <, B], A<B).
%parse([A, >, B], A>B).
%parse([A, *, B], A*B).
%parse([A, -, B], A-B).
%parse([A, +, B], A+B).
%parse([A], A).
% Remove ; if needed
% Comparators
comp(<).
comp(>).
parse([;|T], Out):-
    parse(T, Out).

% term
parse([id(X)], id(X)).
parse([num(X)], num(X)).

% Factor
parse(F, Out):-
    append(T1, Fac, F),
    append(Term, [+], T1),
    parse(Term, PTerm),
    parse(Fac, PFac).

% Expr
parse(E, Out):-
    append(T, Expr, E),
    append(Fac, [*], T),
    parse(Fac, PFac),
    parse(Term, PTerm).

% Bool
parse(Bool, P1<P2):-
    append(T, Expr2, Bool),
    append(Expr1, [<], T),
    parse(Expr1, P1),
    parse(Expr2, P2).
parse(Bool, P1>P2):-
    append(T, Expr2, Bool),
    append(Expr1, [>], T),
    parse(Expr1, P1),
    parse(Expr2, P2).

% cmd
parse([skip], skip).
parse(Set, set(PId, PErxpr)):-
    append(T, Expr, Set),
    append(Id, [:=], T),
    parse(Id, PId),
    parse(Expr, PExpr).
parse([if|T], if(PBool, PPgmTrue, PPgmFalse)):-
    append(T4, fi, T),
    append(T3, PgmFalse, T4),
    append(T2, [else], T3),
    append(T1, PgmTrue, T2),
    append(Bool, [then], T1),
    parse(Bool, PBool),
    parse(PgmTrue, PPgmTrue),
    parse(PgmFalse, PPgmFalse).
% pgm
parse(P, seq(PCmd, PPgm)):-
    append(T, Pgm, P),
    append(Cmd, [;], T),
    parse(Cmd, PCmd),
    parse(Pgm, PPgm).


run(_In, String, Out) :-
    scan(String, Tokens),
    write(Tokens),
    parse(Tokens, Out).
%   execute(In, AbstStx, Out).
% Tests
%:-run([x=3], "y:=1; z:=0; while x>z do z:=z+1; y:=y*z od", Res).
% Parser test
%parse([num(1), <, num(2)], Res).
