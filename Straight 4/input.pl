getInput(X,Y) :- getPieceRow(X), getPieceCol(Y).

%waits for enter to continue
getContinue:-
	write('\nPress Enter to continue.\n'),
	get_char(_).
	

%read char for column
getCol(Col):-
	read(Col),
	integer(Col),
	Col >= 0 , Col < 5.

getCol(Col):-
	write('Value is not between the board bounds :\n'),
	getCol(Col).

%read integer for line
getInt(I):-
	read(I),
	integer(I),
	I >= 0 , I < 5.

getInt(I):-
	write('Value is not between the board bounds :\n'),
	getInt(I).

%gets row
getPieceRow(Row):-
	write('Select row:'), nl,
	getInt(R),
	Row is R.

%gets column
getPieceCol(Col):-
	write('Select collumn:'), nl,
	getInt(C), Col is C.