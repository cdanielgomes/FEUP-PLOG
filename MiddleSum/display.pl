:- use_module(library(lists)). 
:- include('list.pl'). 
/**
 * printBoard(+Matrix)
 *
 * Prints the given board
 * 
 */
printBoard([]).
printBoard([Row|Rows]):-
	printRow(Row),
	nl,
	printBoard(Rows).

/**
 * printRow(+List)
 *
 * Helper function for printing the board
 * 
 */
printRow([]).
printRow([Element|Tail]):-
	write(Element), write(' '),
	printRow(Tail).

