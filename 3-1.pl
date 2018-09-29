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
parse([id(X)], id(X)).
parse([num(X)], num(X)).
parse(Bool, P1<P2):-
    append(T, Expr2, Bool),
    append(Expr1, [<], T),
    parse(Expr1, P1),
    parse(Expr2, P2).

%parse([], skip).
%parse([;|T], Out):-
%    parse(T, Out).
%parse([if|T], seq(if(PBool, PPgmTrue, PPgmFalse), PRest)):-
%    append(Bool, [then], T1),
%    append(T1, PgmTrue, T2),
%    append(T2, [else], T3),
%    append(T3, PgmFalse, T4),
%    append(T4, fi, T5),
%    append(T5, Rest, T),
%    parse(Bool, PBool),
%    parse(PgmTrue, PPgmTrue),
%    parse(PgmFalse, PPgmFalse),
%    parse(Rest, PRest).
%parse([while|T], seq(while(PBool, PPgm), PRest)):-
%    append(Bool, [do], T1),
%    append(T1, Pgm, T2),
%    append(T2, [od], T3),
%    append(T3, Rest, T),
%    parse(Bool, PBool),
%    parse(Pgm, PPgm),
%    parse(Rest, PRest).
        

run(_In, String, Out) :-
    scan(String, Tokens),
    write(Tokens),
    parse(Tokens, Out).
%   execute(In, AbstStx, Out).
% Tests
%:-run([x=3], "y:=1; z:=0; while x>z do z:=z+1; y:=y*z od", Res).
% Parser test
%parse([num(1), <, num(2)], Res).
