% exec 3.1

% Load functors and predicates
:-['scanner.pl]'].
:-['3-1.pl'].

parse(Tokens, AbstStx):-


run(In, String, Out) :-
    scan(String, Tokens),
    write(Tokens).
    parse(Tokens, AbstStx),
%   execute(In, AbstStx, Out).
