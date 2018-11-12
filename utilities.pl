clearScreen :-
	printBlank(4).
	
printBlank(A) :-
	A > 0,
	nl,
	A1 is A - 1,
	printBlank(A1).
	
printBlank(_).