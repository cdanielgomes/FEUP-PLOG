:- include('list.pl'). 
:- include('display.pl').

middle_sum(Board):-
	displayB(Board),nl,
	write('Solving....'), nl, nl,
	middle_sum_matrix(Board, Vars),
	length(Board, L),
	list2matrix(Vars, L, Solved),
	displayB(Solved),nl,nl,
	main_menu.

middle_sum_test(Board):-
	displayB(Board),
	write('Solving....'), nl, nl,
	middle_sum_matrix(Board, Vars),
	length(Board, L),
	list2matrix(Vars, L, Solved),
	displayB(Solved).
