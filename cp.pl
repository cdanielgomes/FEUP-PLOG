:- use_module(library(random)).
:- include('board.pl').



randomMove(Type, Board, NewBoard):-
	length(Board, N),
	N1 is N +1,
	random(1, N1, R),
	random(1, N1, C),
	insertOnPositon(R, C, Type, Board, NewBoard).


randomMove(Type, Board, NewBoard):-
	randomMove(Type, Board, NewBoard).

/*	
getPlays(_, L, L, Plays, AuxPlay):- Plays = AuxPlay.

getPlays(Board, Line, Column, Plays, AuxPlay):-
	getElemInPosition(Board, Line, Column, Type), 
	Type = 0,
	append(Plays, [Line, Column], Play),
	NL is Line +1, 		
	getIncremental(Board, NL, Column, Play, AuxPlay).

getPlays()


incLine(Line, Column, NL, NC):-
	NL is Line +1, Column = NC.
*/

%% a valid play is always valid doesnt matter who is playing
valid_moves(Board, Player, ListOfMoves):-
	findall([R,C],getElemInPosition(Board, R, C, 0), ListOfMoves). 

possibleSequences(N, Sequence):- Sequence = [0, N, N, N, N].
possibleSequences(N, Sequence):- Sequence = [N, N, N, N, 0]. 
possibleSequences(N, Sequence):- Sequence = [0, N, N, N].
possibleSequences(N, Sequence):- Sequence = [N, N, N, 0]. 
possibleSequences(N, Sequence):- Sequence = [0, N, N].
possibleSequences(N, Sequence):- Sequence = [N, N, 0]. 
possibleSequences(N, Sequence):- Sequence = [0, N].
possibleSequences(N, Sequence):- Sequence = [N, 0]. 

%bestMove:-