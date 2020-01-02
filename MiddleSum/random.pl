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

get_ordered_list(Size, List) :-
    length(List, Size),
    domain(List, 1, Size),
    all_distinct(List),
    labeling([], List).



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

fill_matrix(Counter, Size, [H|T], Indexes):-
    random_select(Index, Indexes, Rest),
    fill_line(1, Size, H, Index),
    Counter1 is Counter+1,
    fill_matrix(Counter1, Size, T, Rest).
    

fill_matrix(Size, M):-
    generate_matrix(Size, Size, M), 
    get_ordered_list(Size, List),
    fill_matrix(0, Size, M, List).
    


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