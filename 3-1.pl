% exec 3.1

% Load functors and predicates
:-initialization([scanner, '2-3']).

% Set value
parse([A, :=, B], set(A, B)).
% Parse while loops
parse([while|T], Out):-
    append(Statement, do, T1),
    append(T1, Task),
    parse(Statement, Out1),
    parse(Task, Out2),
    append(Out1, Out2, Out).
% Separate arguments by splitting lists on ';', 
% execute both arguments sequentially
parse(Tokens, seq(Out1, Out2)):-
    append(A, [;|B], Tokens),
    parse(A, Out1),
    parse(B, Out2).


run(In, String, Out) :-
    scan(String, Tokens),
    write(Tokens).
%    parse(Tokens, AbstStx),
%   execute(In, AbstStx, Out).


% Test
%:-run([x=3], "y:=1; z:=0; while x>z do z:=z+1; y:=y*z od", Res).
