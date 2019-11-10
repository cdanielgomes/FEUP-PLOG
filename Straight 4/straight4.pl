:-include('menus.pl').
:-include('display.pl').
:-include('utilities.pl').
:-include('logic.pl').
:-include('input.pl').

straight4:-
	homeMenuHandler.

startGame(S1, S2):-
	createEmptyBoard(5, Board),
	displayGameBoard(Board),
	play(S1, S2, black, Board).


play(Player1, Player2, black, Board):-
	call(Player1, black, Board, NewBoard),
	displayGameBoard(NewBoard),
	nextMove(Player1, Player2, black, newBoard).

play(Player1, Player2, white, Board):-
	call(Player2, white, Board, NewBoard),
	displayGameBoard(NewBoard),
	nextMove(Player1, Player2, white, newBoard).


%TODO
%human(Piece, Board, NewBoard):-
