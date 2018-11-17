:- use_module(library(random)).




randomMove(Type, Board, NewBoard):-
	random(1, 20, R),
	random(1, 20, C),
	insertOnPositon(R, C, Type, Board, NewBoard).


randomMove(Type, Board, NewBoard):-
	randomMove(Type, Board, NewBoard).

	




%bestMove:-