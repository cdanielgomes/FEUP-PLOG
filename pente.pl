:-include('menus.pl').
:-include('display.pl').
:-include('utilities.pl').
:-include('board.pl').
:-include('input.pl').

pente:-
	mainMenu.


startGame(P1, P2):-
	createEmptyBoard(19, B),
	insertOnPositon(10, 10, 2, B, L),
	display_board(L,[0,0]),
	game(P1, P2, 1, L).


game(P1, P2, 1, Board):-
	call(playerMove, 1, Board, NewBoard),
	display_board(NewBoard, [0,0]),
	game(P1, P2, 2, NewBoard).

game(P1, P2, 2, Board):-
	call(playerMove, 2, Board, NewBoard),
	display_board(NewBoard, [0,0]),
	game(P1, P2, 1, NewBoard).


playerMove(Type, Board, NewBoard):-
	inputPiece(Type, Board, NewBoard).
