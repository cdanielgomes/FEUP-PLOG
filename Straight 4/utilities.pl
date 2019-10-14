:- use_module(library(random)).
:- use_module(library(lists)).
% new lines to simulate clearscreen
clearScreen :-
	printBlank(7).

% print new lines
printBlank(A) :-
	A > 0,
	nl,
	A1 is A - 1,
	printBlank(A1).
	
printBlank(_).


%waits for enter to continue
getContinue:-
	write('\nPress Enter to continue.\n'),
	get_char(_).
	

%change type (player)
changeType(1, 2).
changeType(2, 1).


%% Size = Size of the Board
%% Board - return of the board

createEmptyBoard(Size, Board):- 
    create_line(0, Size, A),
    length(Board, Size),
    maplist(=(A), Board).

%%% X - Symbol to be insert in every position of List
%%% N - Size of a line 
%%% List - Return of a line

create_line(X, N, List)  :- 
    length(List, N), 
    maplist(=(X), List).


%fast reconsult
%%reload:- reconsult('straight4.pl').