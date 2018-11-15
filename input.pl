inputPiece(Type, Board, NewBoard):-
	selectPosition(Type, PieceRow, PieceCol),
	insertOnPositon(PieceRow, PieceCol, Type, Board, NewBoard).

selectPosition(Type, Row, Col):-
	getPieceRow(Type, Row),
	getPieceCol(Type, Col), !.

getPieceRow(Type, Row):-
	write('Select '), write(Type), write(' row:'), nl,
	getInt(R),
	Row is R.

getPieceCol(Type, Col):-
	write('Select '), write(Type), write(' collumn:'), nl,
	getInt(C),
	Col is C.


getInt(I):-
	read(I),
	integer(I),
	I > 0 , I < 20.

getInt(I):-
	write('Value is not between the board bounds :\n'),
	getInt(I).



