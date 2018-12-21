 
:- use_module(library(clpfd)).

ex2:- length(Vars, 10), domain(Vars, 1,10),
        element(10, Vars, 6),
        all_distinct(Vars),
        dist(Vars, Dist),
        labeling([maximize(Dist)], Vars), write(Vars), nl, write(Dist).

    dist([_],0).
    dist([A,B|T], D):-
        dist([B|T], D1),
        Da #= abs(A-B),
        D #= Da + D1.
        