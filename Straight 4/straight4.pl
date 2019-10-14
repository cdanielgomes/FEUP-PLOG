:-include('menus.pl').
:-include('display.pl').
:-include('utilities.pl').
:-include('logic.pl').
:-include('input.pl').
%%:-include('cp.pl').


%%% start Game

startGame(player1, player2) :- 
    createEmptyBoard(5, Board),
    displayGameBoard(Board),
    game(Board, 1, 2, 4, 4).




game(Board, Payer1, Player2, Npieces1, Npieces2) :- 
    getInput(X,Y), 
    canInsert(Board, Player1).
