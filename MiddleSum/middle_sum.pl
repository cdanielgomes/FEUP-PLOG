:- include('list.pl'). 
:- include('display.pl').

middle_sum(Board):-
	printBoard(Board),
	write('Solving....'), nl, nl,
	middle_sum_matrix(Board, Vars),
	length(Board, L),
	list2matrix(Vars, L, Solved),
	printBoard(Solved),
	main_menu.

middle_sum_test(Board):-
	printBoard(Board),
	write('Solving....'), nl, nl,
	middle_sum_matrix(Board, Vars),
	length(Board, L),
	list2matrix(Vars, L, Solved),
	printBoard(Solved).
