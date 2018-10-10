% exec 3.1

% Load functors and predicates
:-initialization([scanner, '2-3']).

% Term parser
term([id(X)], id(X)).
term([num(X)], num(X)).

% Factor parser
fact(F, PTerm+PFac):-
    append(T1, Fac, F),
    append(Term, [+], T1),
    term(Term, PTerm),
    fact(Fac, PFac).
fact(F, Out):-
    term(F, Out).

% Expression parser
expr(E, PFac*PExpr):-
    append(T, Expr, E),
    append(Fac, [*], T),
    fact(Fac, PFac),
    expr(Expr, PExpr).
expr(E, Out):-
    fact(E, Out).

% Boolean parser
bool(Bool, P1<P2):-
    append(T, Expr2, Bool),
    append(Expr1, [<], T),
    expr(Expr1, P1),
    expr(Expr2, P2).
bool(Bool, P1>P2):-
    append(T, Expr2, Bool),
    append(Expr1, [>], T),
    expr(Expr1, P1),
    expr(Expr2, P2).

% Parse id of setter
set([id(X)], X).

% Command parser
cmd([skip], skip).
cmd(Set, set(PId, PExpr)):-
    append(T, Expr, Set),
    append(Id, [:=], T),
    set(Id, PId),
    expr(Expr, PExpr).
cmd([if|T], if(PBool, PPgmTrue, PPgmFalse)):-
    append(T4, [fi], T),
    append(T3, PgmFalse, T4),
    append(T2, [else], T3),
    append(T1, PgmTrue, T2),
    append(Bool, [then], T1),
    bool(Bool, PBool),
    pgm(PgmTrue, PPgmTrue),
    pgm(PgmFalse, PPgmFalse).
cmd([while|T], while(PBool, PPgm)):-
    append(T2, [od], T),
    append(T1, Pgm, T2),
    append(Bool, [do], T1),
    bool(Bool, PBool),
    pgm(Pgm, PPgm).

% Program parser
pgm(P, seq(PCmd, PPgm)):-
    append(T, Pgm, P),
    append(Cmd, [;], T),
    cmd(Cmd, PCmd),
    pgm(Pgm, PPgm).
pgm(P, Out):-
    cmd(P, Out).

% Token parser
parse(Tokens, AbstStx):-
    pgm(Tokens, AbstStx).

% Reads the input and splits it into tokens
run(In, String, Out) :-
    scan(String, Tokens),
    parse(Tokens, AbstStx),
    execute(In, AbstStx, Out).
% Tests
%:-run([x=3], "y:=1; z:=0; while x>z do z:=z+1; y:=y*z od", Res).
% Parser test
%parse([num(1), <, num(2)], Res).

