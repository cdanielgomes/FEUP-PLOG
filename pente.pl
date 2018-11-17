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


%black player turn
game(P1, P2, Type, Board):-
	Type is 1,
	nl,print_cell(Type) , write(' Playing...\n'),
	call(P1, Type, Board, NewBoard),
	display_board(NewBoard, [0,0]),
	nextMove(P1, P2, Type, NewBoard).

%white player turn
game(P1, P2, Type, Board):-
	nl,print_cell(Type) , write(' Playing...\n'),
	call(P2, Type, Board, NewBoard),
	display_board(NewBoard, [0,0]),
	nextMove(P1, P2, Type, NewBoard).

playerMove(Type, Board, NewBoard):-
	inputPiece(Type, Board, NewBoard).


nextMove(_P1, _P2, Type, Board):-
	winGame(Board, Type), ! ,
	victory(Type).

nextMove(P1, P2, Type, Board):-
	changeType(Type, NewType), !,
	game(P1, P2, NewType, Board).


victory(Type):-
	won(Type),
	get_char(_),
	getContinue ,!,
	mainMenu.