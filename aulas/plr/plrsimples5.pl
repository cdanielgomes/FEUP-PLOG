
:- use_module(library(clpfd)).
ex5 :- length(Cores, 4), domain(Cores, 1, 4), all_distinct(Cores),
    length(Tam, 4), domain(Tam, 1, 4), all_distinct(Tam),
    element(IdxAz, Cores, 1),
    IdxAntAz #= IdxAz -1, IdxDepAz #= IdxAz +1,
    element(IdxAntAz, Tam, TAA), element(IdxDepAz, Tam, TDA), TAA #< TDA,
    element(IdxV, Cores, 4), element(IdxV, Tam, 1),
    IdxV #> IdxAz, element(IdxAm, Cores, 3), element(IdxP, Cores, 2), IdxAm #> IdxP,
    append(Cores, Tam, AllVars), labeling([], AllVars), write(Cores), nl, write(Tam), nl.
    
% azul -> 1; amarelo .-> 2 ; verdes -> 3; vermelho -> 4
ex6 :- 
    length(Cores, 12), domain(Cores, 1,4), global_cardinality(Cores, [1-3,2-4,3-2,4-3]),
    element(1, Cores, Cor), element(12, Cores, Cor),
    element(2, Cores, Cor2), element(11, Cores, Cor2),
    element(5, Cores, 1),  tres(Cores), seq4(Cores, 1),labeling([], Cores), write(Cores).


tres([_,_]).
tres([A,B,C|T]):-
    all_distinct([A,B,C]),
    tres([B,C|T]).

seq4([_,_,_], 0).
seq4([A,B,C,D|T], Cnt):-
    (A#=2#/\B#=3#/\C#=4#/\ D#=1)#<=> Bin,
    seq4([B,C,D|T], C2),
    Cnt #=C2+Bin.