:- include('list.pl').
:- include('matrix.pl').
:- include('display.pl').
:- use_module(library(random)).


%% randomNumber(+L, +N, -R)
%%
%% generate a random number between [L, N] 
%% and returns it on R

randomNumber(L, N, R) :-
    N1 is N+1,
    random(L, N1, R).


%% get_ordered_list(+Size, -List)
%%
%% Create a list with numbers ordered from 1 to Size
%% and returns it on List

get_ordered_list(Size, List) :-
    length(List, Size),
    domain(List, 1, Size),
    all_distinct(List),
    labeling([], List).



%% complete_with_zero(-List)
%% 
%% fill List with 0's

complete_with_zero([]).
complete_with_zero([H|T]) :-
    H=0,
    complete_with_zero(T).


%% fill_line(+Counter, +Size, -Line, +Index)
%%
%% fill Line with 0's and a random number between [1,9]
%% in the position of Index

fill_line(Counter, _, [M|K], Index) :-
    Index=Counter,
    randomNumber(1, 9, Number),
    M=Number,
    complete_with_zero(K).

fill_line(Counter, Size, [M|K], Index) :-
    M=0,
    Counter1 is Counter+1,
    fill_line(Counter1, Size, K, Index).

%%% fill_matrix(+Counter, +Size, -Matrix, +Indexes)
%%
%%% Returns Matrix with 1 random value in each column and row
%%% It selects a random Index from Indexes to put the random number

fill_matrix(S, S, _, []).

fill_matrix(Counter, Size, [H|T], Indexes):-
    random_select(Index, Indexes, Rest),
    fill_line(1, Size, H, Index),
    Counter1 is Counter+1,
    fill_matrix(Counter1, Size, T, Rest).
    
    
%% fill_matrix(+Size, -M)
%% 
%% Generates a random Matrix with size Size

fill_matrix(Size, M):-
    generate_matrix(Size, Size, M), 
    get_ordered_list(Size, List),
    fill_matrix(0, Size, M, List).
    


%% generate_random_puzzle(-Board, -Solved)
%% 
%% Generate random boards with random size (between 4 and 15) and try to solve them, returning the board unsolved (Board)
%% and this board solved (Solved)

generate_random_puzzle(Board, Solved) :-
    randomNumber(4, 15, N),
    nl,
    write('Board Size: '),
    write(N),nl,
    fill_matrix(N, Board), 
    middle_sum_matrix(Board, Vars),
    list2matrix(Vars, N, Solved). 



%% generate_random_puzzle(+Size, -Board, -Solved)
%% 
%% Generate random boards with size Size and try to solve them, returning the board unsolved (Board)
%% and this board solved (Solved)

generate_random_puzzle(Size, Board, Solved) :-
    fill_matrix(Size, Board),
    middle_sum_matrix(Board, Vars), 
    list2matrix(Vars, Size, Solved). 