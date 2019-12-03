:- use_module(library(lists)).
:- include('list.pl').

reload:- reconsult('display.pl').



printBoard([]).
printBoard([Row|Rows]):-
	printRow(Row),
	nl,
	printBoard(Rows).


printRow([]).
printRow([Element|Tail]):-
	write(Element), write(' '),
	printRow(Tail).

