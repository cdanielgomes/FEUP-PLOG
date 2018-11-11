:- use_module(library(random)).
:- use_module(library(lists)).
:- include('display.pl').
	
createEmptyBoard(Size, Board):-
    create_line(0, Size, A),
    length(Board, Size),
    maplist(=(A), Board).

create_line(X, N, List)  :- 
    length(List, N), 
    maplist(=(X), List).

?- createEmptyBoard(13, Board), display_board(Board, [0,0]).