%Minimax algorithm to compute the best NewBoard of current Player(Piece)
%Args - Board(current state), NewBoard(next best state), Depth, Piece('max' player)
minimax(Board, NewBoard, Depth, Piece):- minimax(Depth, Board, 1, _, NewBoard, Piece).


%Minimax algorithm to compute the best NewBoard of current Player(Piece)
%Args - Depth, Board(current state), Player(max->1/min->-1), Value(value of Board), NewBoard(next best state), Piece('max' player)
minimax(0, Board, Player, Value, Board, Piece):-
  value(Board, Piece, V),
  %displayBoard(Board, 0), nl, write(V), nl,
  Value is V*Player.
minimax(D, Board, Player, Value, NewBoard, Piece):-
  D > 0,
  D1 is D-1,
  getPossibleBoards(Piece, Board, PossibleBoards),
  changePlayer(Piece, Piece1),
  Opponent is -Player,
  findall(V-B, (member(B, PossibleBoards), minimax(D1, B, Opponent, V, _, Piece1) ), Values),
  sort(Values, NewValues),
  last(NewValues, Value-NewBoard).



%Minimax algorithm to compute the best NewBoard of current Player(Piece)
%Args - Board(current state), NewBoard(next best state), Depth, Piece('max' player)
%This version is used to differentiate the phase of moving pieces
minimax1(Board, NewBoard, Depth, Piece):- minimax1(Depth, Board, 1, _, NewBoard, Piece).


%Minimax algorithm to compute the best NewBoard of current Player(Piece)
%Args - Depth, Board(current state), Player(max->1/min->-1), Value(value of Board), NewBoard(next best state), Piece('max' player)  
minimax1(0, Board, Player, Value, Board, Piece):-
  value(Board, Piece, V),
  %displayBoard(Board, 0), nl, write(V), nl,
  Value is V*Player.
minimax1(D, Board, Player, Value, NewBoard, Piece):-
  D > 0,
  D1 is D-1,
  getPossibleMoves(Piece, Board, PossibleMoves),
  getPossibleBoardsByMoves(Piece, Board, PossibleMoves, PossibleBoards),
  changePlayer(Piece, Piece1),
  Opponent is -Player,
  findall(V-B, (member(B, PossibleBoards), minimax1(D1, B, Opponent, V, _, Piece1) ), Values),
  sort(Values, NewValues),
  last(NewValues, Value-NewBoard).