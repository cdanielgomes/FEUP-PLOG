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


%% Size = Size of the Board 
%% Board - return of the board  
createEmptyBoard(Size, Board):-  
    create_line(0, Size, A), 
    length(Board, Size), 
    maplist(=(A), Board). 

create_line(X, N, List)  :- 
    length(List, N), 
    maplist(=(X), List).