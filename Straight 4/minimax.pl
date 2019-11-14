minimax(Board, NewBoard, Depth, Piece):- minimax(Depth, Board, 1, _, NewBoard, Piece).

minimax(0, Board, Player, Value, _, Piece):-
  value(Board, Piece, V),
  %displayBoard(Board, 0), nl, write(V), nl,
  Value is V*Player.
minimax(D, Board, Player, Value, NewBoard, Piece):-
  D > 0,
  D1 is D-1,
  getPossibleBoards(Piece, Board, PossibleBoards),
  minimax(PossibleBoards, Board, D1, Player, 1000000, [], Value, NewBoard, Piece).


minimax([], _, _, _, Value, Best, Value, Best, _).
minimax([Move|Moves],Board,D,Player, Value0,Move0,BestValue,BestMove, Piece):-
      Opponent is -Player,
      changePlayer(Piece, Piece1),
      minimax(D, Move, Opponent, OppValue, _OppMove, Piece1), 
      Value is -OppValue,
      ( Value =< Value0 ->        
        minimax(Moves,Board,D,Player, Value ,Move ,BestValue,BestMove, Piece)
      ; minimax(Moves,Board,D,Player, Value0,Move0,BestValue,BestMove, Piece)
      ).


minimax1(Board, NewBoard, Depth, Piece):- minimax1(Depth, Board, 1, _, NewBoard, Piece).

minimax1(0, Board, Player, Value, _, Piece):-
  value(Board, Piece, V),
  %displayBoard(Board, 0), nl, write(V), nl,
  Value is V*Player.
minimax1(D, Board, Player, Value, NewBoard, Piece):-
  D > 0,
  D1 is D-1,
  getPossibleMoves(Piece, Board, PossibleMoves),
  getPossibleBoardsByMoves(Piece, Board, PossibleMoves, PossibleBoards),
  minimax1(PossibleBoards, Board, D1, Player, 1000000, [], Value, NewBoard, Piece).


minimax1([], _, _, _, Value, Best, Value, Best, _).
minimax1([Move|Moves],Board,D,Player, Value0,Move0,BestValue,BestMove, Piece):-
      Opponent is -Player,
      changePlayer(Piece, Piece1),
      minimax1(D, Move, Opponent, OppValue, _OppMove, Piece1), 
      Value is -OppValue,
      ( Value =< Value0 ->        
        minimax1(Moves,Board,D,Player, Value ,Move ,BestValue,BestMove, Piece)
      ; minimax1(Moves,Board,D,Player, Value0,Move0,BestValue,BestMove, Piece)
      ). 
