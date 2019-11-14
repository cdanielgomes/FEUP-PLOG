:- use_module(library(lists)).


% Fetches piece position and updates board with new piece
inputPiece(Piece, Board, NewBoard):-
	getPosition(Row, Col),
	setPiece(Piece, Row, Col, Board, NewBoard), clearScreen.
inputPiece(Piece, Board, NewBoard):-
	nl, write('Invalid Play. Try again.'), nl,nl,
	inputPiece(Piece,Board,NewBoard).

%Moves Piece in Board regarding the user input for (Xi, Yi, Xf, Yf),
%returning the NewBoard (after piece movement).
movePiece(Piece, Board, NewBoard):-
	nl,
	write('MAKE A MOVE!'),nl,nl,
	write('Select piece'), nl, nl,
	getPosition(Rowi, Coli),nl,
	clearScreen,
	displayGameBoard(Board), nl,
	write('Move piece to'), nl, nl,
	getPosition(Rowf, Colf), 
	move(Board, Rowi, Coli, Rowf, Colf, Piece, NewBoard).
movePiece(Piece, Board, NewBoard):-
	nl, write('Invalid Play. Try again.'), nl,nl,
	movePiece(Piece, Board, NewBoard).

%Asks user to select a position.
getPosition(Row, Col):-
	getPieceRow(Row),
	getPieceCol(Col), !.

%Fetches user input for Row and Column
getInput(X,Y) :- getPieceRow(X), getPieceCol(Y).

%waits for enter to continue
getContinue:-
	write('\nPress Enter to continue.\n'),
	get_char(_).

%gets row
getPieceRow(Row):-
	write('Select row:'), nl,
	getInt(R),
	Row is R.

%gets column
getPieceCol(Col):-
	write('Select column:'), nl,
	getInt(C), Col is C.


%------get user Input
getInt(Input):-
	getNextCodeLoop([], Characters),
	concactNumbers(Characters, Input).

getNextCodeLoop(PreviousInput, Input):-
	get_code(StreamInput),
	evaluateCode(StreamInput, PreviousInput, Input).

%NL line feed -> code = 10
evaluateCode(10, _, _):- !.
evaluateCode(Code, PreviousInput, Input):-
	Numb is (Code-48),
	getNextCodeLoop(PreviousInput, AuxInput),
	append([Numb], AuxInput, Input).

concactNumbers(List, Final):-
	reverse(List, Reverse),
	concactNumbersHelper(Reverse, 1, Final).

concactNumbersHelper([],_,0).
concactNumbersHelper([H|T], Multiplier, Final):-
	MultiplierAux is Multiplier*10,
	concactNumbersHelper(T, MultiplierAux, FinalAux),
	Final is (Multiplier * H + FinalAux).


%'Press enter to continue'
getEnter:-
        write('Press enter to continue.'), nl,
        getChar(_Input).

getChar(Input):-
	get_char(KbInput),
	enter(KbInput, Input).
enter('\n', ''):-!.
/*enter(_, Input):-
	getChar(Input).*/
	
invalidInput:-
    write('Invalid option.'), nl,
    getEnter.