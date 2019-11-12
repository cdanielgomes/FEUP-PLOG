:- use_module(library(random)).

randomPlay(Piece, Board, NewBoard, Pieces, NewPieces):-
  getPossibleBoards(Piece, Board, PossibleBoards),
  length(PossibleBoards, Len),
  Len1 is Len - 1,
  random(0, Len1, Index),
  nth0(Index, PossibleBoards, NewBoard),
  removeFromBag(Piece, Pieces, NewPieces).

%randomPlayMoving(Piece, Board, NewBoard, [0,0], _NewPieces):-
  




getPossibleMoves(Piece, Board, PossibleBoards):-
  findall([Xi, Yi, Yi, Yf], (
                                nth0(Xi, Board, Row),
                                nth0(Yi, Row, Elemi),
                                Elemi=:=Piece,
                                nth0(Xf, Board, Row2),
                                nth0(Yf, Row2, Elemf),
                                Elemf=:=0,
                                type_move(Board, Xi, Yi, Xf, Yf)
                              ), PossibleBoards).


emptyPosition(Board, R, C):- getPiece(Board, R, C, 0).

getPossibleBoards(Piece, Board, PossibleBoards):-
  findall([R,C], emptyPosition(Board, R, C), PossiblePositions),
  getPossibleBoards(Piece, Board, PossiblePositions, PossibleBoards).

getPossibleBoards(_, _, [], []).
getPossibleBoards(Piece, Board, [[R,C]|T], PossibleBoards):-
  getPossibleBoards(Piece, Board, T, PBAux),
  setPiece(Piece, R, C, Board, Temp),
  append([Temp], PBAux, PossibleBoards).