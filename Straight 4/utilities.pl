%fast reconsult
reload:- reconsult('pente.pl').

% new lines to simulate console clear
clearScreen:-
	clearScreen(10).
clearScreen(0).

% print new lines
clearScreen(A) :-
	nl,
	A1 is A - 1,
	clearScreen(A1).