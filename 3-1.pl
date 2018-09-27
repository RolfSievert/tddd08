% exec 3.1

% Load functors and predicates
:-initialization([scanner, '2-4']).

%parse(Tokens, AbstStx):-


run(In, String, Out) :-
    scan(String, Tokens),
    write(Tokens).
%    parse(Tokens, AbstStx),
%   execute(In, AbstStx, Out).


% Test
%:-run([x=3], "y:=1; z:=0; while x>z do z:=z+1; y:=y*z od", Res).
