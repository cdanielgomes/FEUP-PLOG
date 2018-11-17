clearScreen :-
	printBlank(7).
	
printBlank(A) :-
	A > 0,
	nl,
	A1 is A - 1,
	printBlank(A1).
	
printBlank(_).

changeType(1, 2).
changeType(2, 1).

reload:- reconsult('pente.pl').