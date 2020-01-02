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

displayB(Board):-
    length(Board, Size),    
    displayBoard(Board, Size, 1).

displayBoard([], _, _).

displayBoard(Board, Size, 1):-
    displaySeparator(Size), nl,
    displayBoard(Board, Size, 2).

displayBoard([H|T], Size, 2):-
    write('| '),
    displayLine(H), nl,
    displaySeparator(Size), nl,
    displayBoard(T,Size, 2).

displayLine([]).
displayLine([H | T]) :-
    write(H), write(' | '),
    displayLine(T).

displaySeparator(0).
displaySeparator(Size):-
    NewSize is Size - 1,
    write(' ---'),
    displaySeparator(NewSize).