:- use_module(library(lists)).

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

%gets row
getPieceRow(Row):-
	write('Select row:'), nl,
	getInt(R),
	Row is R.

%gets column
getPieceCol(Col):-
	write('Select collumn:'), nl,
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

	
	