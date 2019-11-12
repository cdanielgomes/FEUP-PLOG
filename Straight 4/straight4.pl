reload:- reconsult('straight4.pl').

:-include('menus.pl').
:-include('display.pl').
:-include('utilities.pl').
:-include('logic.pl').
:-include('input.pl').

straight4:-
	homeMenuHandler.

%Inits Game Loop
startGame(S1, S2):-
	createEmptyBoard(5, Board),
	displayGameBoard(Board),
	startingPieces(N),
	play(S1, S2, black, Board, [N,N]).

%Player1 plays
play(Player1, Player2, black, Board, Pieces):-
	nth0(0, Pieces, Blacks),
	printBag(Blacks, black),
	call(Player1,1, Board, NewBoard, Pieces, NewPieces),	
	displayGameBoard(NewBoard),
	nextMove(Player1, Player2, black, NewBoard, NewPieces).

%Player2 plays
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

human_moving(Piece, Board, NewBoard, _Pieces, _NewPieces):-
	movePiece(Piece, Board, NewBoard).

% Checks for vitory before advance
nextMove(_Player1, _Player2, Side, Board, _):-
	convert(Side, S),
	winner(Board, S),
	victory(Side).

% Changes player turn
nextMove(Player1, Player2, Side, Board, Pieces):-
	checkGamePhase(Player1, Player2, Pieces, Npl1, Npl2),
	changePlayer(Side, NewSide),
	play(Npl1, Npl2, NewSide, Board, Pieces).

checkGamePhase(_Pl1, _Pl2, Pieces, Npl1, Npl2):-
	sumlist(Pieces, 0),
	Npl1 = human_moving, Npl2 = human_moving.
checkGamePhase(Pl1, Pl2, _, Pl1, Pl2).

victory(Side):-
	printWin(Side),
	getEnter.

test:- move([ [0, 0, 0, 0, 0],
       		  [1, 0, 0, 0, 0],
              [2, 0, 0, 0, 2],
              [0, 0, 0, 0, 0],
              [0, 0, 0, 0, 0]
            ], 2, 4, 2, 1, 2, NewBoard), write(NewBoard).

test1:- getPiece([ [0, 0, 0, 2, 0],
               		 [0, 1, 2, 0, 0],
               		 [0, 2, 1, 0, 0],
                     [0, 0, 1, 0, 0],
                     [0, 0, 1, 0, 0]
                   ], 1, 2, P), write(P).