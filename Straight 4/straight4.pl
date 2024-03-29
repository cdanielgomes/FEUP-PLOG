:-include('menus.pl').
:-include('display.pl').
:-include('utilities.pl').
:-include('logic.pl').
:-include('input.pl').
:-include('ai.pl').
:-include('minimax.pl').
:-include('streak.pl').

%Init game Menu
straight4:-
	homeMenuHandler.

%Inits Game Loop
startGame(S1, S2):-
	createEmptyBoard(5, Board),
	displayGameBoard(Board),
	startingPieces(N),
	play(S1, S2, black, Board, [N,N]).

%Player1 Turn
play(Player1, Player2, black, Board, Pieces):-
	nth0(0, Pieces, Blacks),
	printBag(Blacks, black),
	call(Player1,1, Board, NewBoard, Pieces, NewPieces),	
	displayGameBoard(NewBoard),
	nextMove(Player1, Player2, black, NewBoard, NewPieces).

%Player2 Turn
play(Player1, Player2, white, Board, Pieces):-
	nth0(1, Pieces, Whites),
	printBag(Whites, white),
	call(Player2, 2, Board, NewBoard, Pieces, NewPieces),
	displayGameBoard(NewBoard),
	nextMove(Player1, Player2, white, NewBoard, NewPieces).

%Human input piece (choosing row and column)
human(Piece,Board, NewBoard, [0,0], _NewPieces):-
	movePiece(Piece, Board, NewBoard).
human(Piece, Board, NewBoard, Pieces, NewPieces):-
	inputPiece(Piece, Board, NewBoard),
	removeFromBag(Piece, Pieces, NewPieces).


% Checks for vitory before advance
nextMove(_Player1, _Player2, Side, Board, _):-
	convert(Side, S),
	winner(Board, S),
	victory(Side).

% Changes player turn
nextMove(Player1, Player2, Side, Board, Pieces):-
	changePlayer(Side, NewSide),
	play(Player1, Player2, NewSide, Board, Pieces).


%Prints winner
victory(Side):-
	printWin(Side),
	getEnter.
