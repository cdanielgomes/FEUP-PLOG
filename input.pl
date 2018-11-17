inputPiece(Type, Board, NewBoard):-
	selectPosition(PieceRow, PieceCol),
	insertOnPositon(PieceRow, PieceCol, Type, Board, NewBoard).
	

inputPiece(Type, Board, NewBoard):-

	write('\n--Imposible to make current play. Try Again!--'), nl, nl,
	inputPiece(Type, Board, NewBoard).


selectPosition(Row, Col):-
	getPieceRow(Row),
	getPieceCol(Col), !.

getPieceRow(Row):-
	write('Select row:'), nl,
	getInt(R),
	Row is R.

getPieceCol(Col):-
	write('Select collumn:'), nl,
	getCol(C),
	Col is C.


getInt(I):-
	read(I),
	integer(I),
	I > 0 , I < 20.

getInt(I):-
	write('Value is not between the board bounds :\n'),
	getInt(I).

getCol(Col):-
	skip_line,
	get_char(Aux),
	conversion(Aux, Caux),
	Caux > 0, Caux < 20,
	Col is Caux.

getCol(Col):-
	write('Value is not between the board bounds :\n'),
	getCol(Col).


getContinue:-
	write('\nPress Enter to continue.\n'),
	get_char(_input).
	



