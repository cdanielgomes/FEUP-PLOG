/**
 * Menus
 * 	
 */

:- include('middle_sum.pl').

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
 	write('\t\t2- Write Board'), nl, nl,
    write('\t\t0- Exit'), nl,
    footer,
    user_input(Input),
    handle_input(Input).



handle_input(1).
handle_input(2):- !, write('Board: '), nl, read(Board), middle_sum(Board).
handle_input(0):- write('Exit').



user_input(Input):-
	write('> Option: '), nl,
	read(Input).