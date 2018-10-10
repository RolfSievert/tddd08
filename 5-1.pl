% Lab 5-1

:- use_module(library(clpfd)).

on(a,d).
on(b,c).
on(c,d).

schedule(Starts) :-
        Starts = [S1,S2,S3,S4],
        Tasks = [task(S1,2,_,2,_),
                 task(S2,1,_,4,_),
                 task(S3,2,_,2,_),
                 task(S4,1,_,1,_)],
        %Starts ins 0..10,
        cumulative(Tasks,_),
        label(Starts).
    


%problem(1, ([container(a,2,2),
%             container(b,4,1),
%             container(c,2,2),
%             container(d,1,1)]).




%moveBox(OldFact, NewFact) :-
%    call(OldFact),
%    retract(OldFact),
%    assertz(NewFact).


