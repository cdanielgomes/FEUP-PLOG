:- include('list.pl').
:- include('matrix.pl').
:- include('display.pl').

:- use_module(library(random)).
t :-
    middle_sum_list2(L, 4),
    write(L).


t1 :-
    generate_matrix(4, 4, M),
    write(M).


check_lists([]).
check_lists([R|T]) :-
    middle_sum_list(R),
    check_lists(T).

generate_middle_sum_list([], _).
generate_middle_sum_list([R|T], N) :-
    middle_sum_list(R, N),
    generate_middle_sum_list(T, N).


generate_random_board :-
    generate_matrix(6, 6, M),
    check_lists(M),
    transpose(M, M1),
    check_lists(M1),
    flatten(M, Vars),
    domain(Vars, 0, 9),
    labeling([ff], Vars),
    list2matrix(Vars, 6, Solved),
    printBoard(Solved).



randomNumber(N, R) :-
	N1 is N +1,
    random(1, N1, R).


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
complete_with_zero([H|T]):-
	H=0,
	complete_with_zero(T).


fill_line(Counter, _, [M|K], Index):-
	Index = Counter, 
	randomNumber(9, Number),
	M = Number, 
	complete_with_zero(K).

fill_line(Counter, Size, [M|K], Index):-
	M=0,
	Counter1 is Counter + 1,
	fill_line(Counter1, Size, K, Index).


fill_matrix(S, S, _, []).

fill_matrix(Counter, Size, [H|T], [F|N]):-
	fill_line(1, Size, H, F), 
	Counter1 is Counter +1,
	fill_matrix(Counter1, Size, T, N).

fill_matrix(Size, M):- 
	generate_matrix(Size, Size, M),
	generate_random_indexes(Size, 0, [], Final),
	fill_matrix(0, Size, M, Final).



test(Size):- fill_matrix(Size, M), write('fui'), middle_sum_matrix(M, V),  list2matrix(V, Size, Solved), printBoard(Solved).

