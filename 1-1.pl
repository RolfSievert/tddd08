% Lab 1.1

% beautiful/1
% ...
%:-discontiguous(beautiful/1).
%:-discontiguous(strong/1).


woman('Ulrika').
woman('Anne').

man('Nisse').
man('Peter').
man('Bosse').

beautiful('Ulrika').
beautiful('Nisse').
beautiful('Peter').

rich('Nisse').
rich('Anne').

strong('Anne').
strong('Peter').
strong('Bosse').

kind('Bosse').

likes(X, Y):-
    % all men likes beautiful women
    man(X),
    woman(Y),
    beautiful(Y);

    X='Nisse',
    woman(Y),
    likes(Y, X);

    X='Peter',
    kind(Y);

    X='Ulrika',
    man(Y),
    (
        rich(Y), kind(Y);
        beautiful(Y), strong(Y)
    ),
    likes(Y, X).

% Rich people are happy
happy(X):-
    rich(X);

    (
        man(X),
        woman(Y);

        woman(X),
        man(Y)
    ),
    likes(X, Y),
    likes(Y, X).
