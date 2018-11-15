clearScreen :-
	printBlank(7).
	
printBlank(A) :-
	A > 0,
	nl,
	A1 is A - 1,
	printBlank(A1).
	
printBlank(_).

reload:- reconsult('pente.pl').