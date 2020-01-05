/**
 * Menus
 * 	
 */

:- include('middle_sum.pl').
:- include('random.pl').
:- include('boards.pl').

title:- 
	write('================================================================'),nl,
	write('=                          Middle Sum                          ='),nl,
	write('================================================================'),nl.

footer:-
	write('================================================================'),nl,
	write('= Joao Alves                                      Daniel Gomes ='),nl,
	write('================================================================'),nl, nl.


main_menu:-
	title,
	write('\t\t1- Generate Random Board'), nl,
	write('\t\t2- Write Board'), nl,
 	write('\t\t3- Choose a Board'), nl, nl,
    write('\t\t0- Exit'), nl,
    footer,
    user_input(Input),
    handle_input(Input).

random_menu:-
	title,
	write('\t\t1- Random Size'), nl,
	write('\t\t2- Write Board Size'), nl,nl,
    write('\t\t0- back'), nl,
	footer,
	user_input(Input),reset_timer,
	handle_input_random_menu(Input),print_time.

showAllBoards:- 
nl,nl,
write('0- Back'), nl,nl,
write('1- ') , nl, board4(A), displayB(A),nl,
write('2- ') , nl, board5(B), displayB(B),nl,
write('3- ') , nl, board6(C), displayB(C),nl,
write('4- ') , nl, board7(D), displayB(D),nl,
write('5- ') , nl, board8(E), displayB(E),nl,
write('6- ') , nl, board9(F), displayB(F),nl,
write('7- ') , nl, board10(G), displayB(G),nl.


pickBoard:- 
	showAllBoards,
	user_input(Input),
	reset_timer, handle_input_boarder_menu(Input), print_time, main_menu.



handle_input_boarder_menu(1):- nl, write('Chosen Board: '), nl, board4(B), middle_sum(B).
handle_input_boarder_menu(2):- nl, write('Chosen Board: '), nl, board5(B), middle_sum(B).
handle_input_boarder_menu(3):- nl, write('Chosen Board: '), nl, board6(B), middle_sum(B).
handle_input_boarder_menu(4):- nl, write('Chosen Board: '), nl, board7(B), middle_sum(B).
handle_input_boarder_menu(5):- nl, write('Chosen Board: '), nl, board8(B), middle_sum(B).
handle_input_boarder_menu(6):- nl, write('Chosen Board: '), nl, board9(B), middle_sum(B).
handle_input_boarder_menu(7):- nl, write('Chosen Board: '), nl, board10(B), middle_sum(B).
handle_input_boarder_menu(0):- main_menu.
handle_input_boarder_menu(_):- nl, write('ATTENTION!!\nChoose a number between 0 and 5'),nl,nl, pickBoard.



handle_input(1):- random_menu.
handle_input(2):- !, write('Board: '), nl, read(Board), reset_timer, middle_sum(Board), print_time.
handle_input(3):- nl, write('Choose a Board'), pickBoard.
handle_input(0):- write('Exit').
handle_input(_):- nl, write('ATTENTION!!\nChoose a number between 0 and 3'),nl,nl, main_menu.


handle_input_random_menu(1):- !,reset_timer, generate_random_puzzle(Board, Solved),print_time, nl, print_board(Board), nl, printSolution(Solved), random_menu.
handle_input_random_menu(2):- !, selectBoardSize(Number), reset_timer,generate_random_puzzle(Number, Board, Solved), print_time,nl, print_board(Board), nl, printSolution(Solved),random_menu.
handle_input_random_menu(0):- main_menu.
handle_input_random_menu(_):-  nl, write('ATTENTION!!\nChoose a number between 0 and 2'),nl,nl, random_menu.


selectBoardSize(Number):-
	insertInteger(Number),nl,nl, write('Board Size: ') , write(Number), nl,nl. 

print_board(Board):-
	write('> Puzzle: '),nl,nl,
	displayB(Board).

printSolution(Board):- 
write('> Solution: '), nl,nl,
displayB(Board).

user_input(Input):-
	write('> Option: '), nl,
	read(Tmp),
	integer(Tmp), 
	Tmp > -1,
	Input is Tmp.

user_input(Input):-
	write('Choose a valid option'), nl,
	user_input(Input).

insertInteger(Input):-
	write('> Board Size: '), nl,
	read(N),
	integer(N),
	N > -1,
	Input is N.

insertInteger(Input):-
	nl, write('Write a valid number higher than 3'), nl,
	insertInteger(Input).

reload:-consult('menus.pl').
