:-include('list.pl').
:-include('matrix.pl').
:-include('display.pl').


t:- middle_sum_list2(L, 4), write(L).


t1:- generate_matrix(4,4,M), write(M).


check_lists([]).
check_lists([R|T]):-
	middle_sum_list(R),
	check_lists(T).

generate_middle_sum_list([], _).
generate_middle_sum_list([R|T], N):-
	middle_sum_list(R,N),
	generate_middle_sum_list(T, N).


generate_random_board:-
	generate_matrix(6,6,M),
	check_lists(M),
	transpose(M, M1),
	check_lists(M1),
	flatten(M, Vars),
	domain(Vars, 0, 9),
	labeling([], Vars),
	list2matrix(Vars, 6, Solved),
	printBoard(Solved).