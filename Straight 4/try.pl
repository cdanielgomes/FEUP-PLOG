:- use_module(library(aggregate)).
:- use_module(library(lists)).

remove_longest(Pred, L, R):- aggregate(max(C, Xc/Yc), P^(append([Xc,P,Yc],L), maplist(Pred, P), length(P, C)), max(C,X/Y)),append(X,Y,R).

%remove_longest(=(2), [1,1,2,2,2,1,1,1], R).