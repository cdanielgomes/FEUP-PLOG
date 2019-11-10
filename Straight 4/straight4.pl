reload:- reconsult('straight4.pl').

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
	startingPieces(N),
	play(S1, S2, black, Board, [N,N]).


play(Player1, Player2, black, Board, Pieces):-
	nth0(0, Pieces, Blacks),
	printBag(Blacks, black),
	call(Player1,1, Board, NewBoard, Pieces, NewPieces),	
	displayGameBoard(NewBoard),
	nextMove(Player1, Player2, black, NewBoard, NewPieces).

play(Player1, Player2, white, Board, Pieces):-
	nth0(1, Pieces, Whites),
	printBag(Whites, white),
	call(Player2, 2, Board, NewBoard, Pieces, NewPieces),
	displayGameBoard(NewBoard),
	nextMove(Player1, Player2, white, NewBoard, NewPieces).

% Human input piece (choosing row and column)
human(Piece, Board, NewBoard, Pieces, NewPieces):-
	inputPiece(Piece, Board, NewBoard),
	removeFromBag(Piece, Pieces, NewPieces).

nextMove(_Player1, _Player2, Side, Board, _):-
	convert(Side, S),
	winner(Board, S),
	victory(Side).

nextMove(Player1, Player2, Side, Board, Pieces):-
	changePlayer(Side, NewSide),
	play(Player1, Player2, NewSide, Board, Pieces).

nextMove(Player1, Player2, Side, Board, Pieces):-
	changePlayer(Side, NewSide),
	play(Player1, Player2, NewSide, Board, Pieces).

victory(Side):-
	printWin(Side),
	getEnter.


test:-
	getPiece([ [0, 0, 0, 2, 0],
                       [0, 1, 2, 0, 0],
                       [0, 2, 1, 0, 0],
                       [2, 0, 1, 0, 0],
                       [0, 0, 1, 0, 0]
                     ],0, 0, 1).