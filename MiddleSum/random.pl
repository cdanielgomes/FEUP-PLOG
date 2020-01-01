:- include('list.pl').
:- include('matrix.pl').
:- include('display.pl').
:- use_module(library(random)).



randomNumber(N, R) :-
    N1 is N+1,
    random(1, N1, R).


randomNumber(L, N, R) :-
    N1 is N+1,
    random(L, N1, R).


generate_random_indexes(Size, Size, TmpIndex, TmpIndex).

generate_random_indexes(Size, Counter, TmpIndex, Final) :-
    randomNumber(Size, Index),
    \+ member(Index, TmpIndex),
    Counter1 is Counter+1,
    append(TmpIndex, [Index], NewTmp),
    generate_random_indexes(Size, Counter1, NewTmp, Final).

generate_random_indexes(Size, Counter, TmpIndex, Final) :-
    generate_random_indexes(Size, Counter, TmpIndex, Final).



complete_with_zero([]).
complete_with_zero([H|T]) :-
    H=0,
    complete_with_zero(T).


fill_line(Counter, _, [M|K], Index) :-
    Index=Counter,
    randomNumber(9, Number),
    M=Number,
    complete_with_zero(K).

fill_line(Counter, Size, [M|K], Index) :-
    M=0,
    Counter1 is Counter+1,
    fill_line(Counter1, Size, K, Index).


fill_matrix(S, S, _, []).

fill_matrix(Counter, Size, [H|T], [F|N]) :-
    fill_line(1, Size, H, F),
    Counter1 is Counter+1,
    fill_matrix(Counter1, Size, T, N).

fill_matrix(Size, M) :-
    generate_matrix(Size, Size, M),
    generate_random_indexes(Size, 0, [], Final),
    fill_matrix(0, Size, M, Final).

generate_random_puzzle(Board, Solved) :-
    randomNumber(4, 15, N),
    nl,
    write('Board Size: '),
    write(N),nl,
    fill_matrix(N, Board),
    middle_sum_matrix(Board, Vars), 
    list2matrix(Vars, N, Solved). 


generate_random_puzzle(Size, Board, Solved) :-
    fill_matrix(Size, Board),
    middle_sum_matrix(Board, Vars), 
    list2matrix(Vars, Size, Solved). 