:- use_module(library(random)).


%random play for moving a piece
randomPlay(Piece, Board, NewBoard, [0,0], _NewPieces):-
  getPossibleMoves(Piece, Board, PossibleMoves),
  length(PossibleMoves, Len),
  Len1 is Len-1,
  random(0, Len1, Index),
  nth0(Index, PossibleMoves, [Xi,Yi,Xf,Yf]),
  forceSetPiece(0, Xi, Yi, Board, Board1),
  setPiece(Piece, Xf, Yf, Board1, NewBoard).
  
%random play for placing a piece
randomPlay(Piece, Board, NewBoard, Pieces, NewPieces):-
  getPossibleBoards(Piece, Board, PossibleBoards),
  length(PossibleBoards, Len),
  Len1 is Len - 1,
  random(0, Len1, Index),
  nth0(Index, PossibleBoards, NewBoard),
  removeFromBag(Piece, Pieces, NewPieces).

%smart play for moving a piece
smartPlay(Piece, Board, NewBoard, [0,0], _NewPieces):-
  minimax1(Board, NewBoard, 1, Piece),
  clearScreen.

%random play for placing a piece
smartPlay(Piece, Board, NewBoard, Pieces, NewPieces):-
  minimax(Board, NewBoard, 1, Piece),
  clearScreen,
  removeFromBag(Piece, Pieces, NewPieces).
  

%Fetches all the possible combinations of moves (from (Xi,Yi) to (Xf, Yf)) a player can make
getPossibleMoves(Piece, Board, PossibleMoves):-
  findall([Xi, Yi, Xf, Yf], (
                                nth0(Xi, Board, Row),
                                nth0(Yi, Row, Elemi),
                                Elemi=:=Piece,
                                nth0(Xf, Board, Row2),
                                nth0(Yf, Row2, Elemf),
                                Elemf=:=0,
                                type_move(Board, Xi, Yi, Xf, Yf)
                              ), PossibleMoves).


%Checks if the position in R(row) and C(column) is empty.
emptyPosition(Board, R, C):- getPiece(Board, R, C, 0).

%Computes all the possible boards
getPossibleBoards(Piece, Board, PossibleBoards):-
  findall([R,C], emptyPosition(Board, R, C), PossiblePositions),
  getPossibleBoards(Piece, Board, PossiblePositions, PossibleBoards).

%Auxiliar function to generate all boards
getPossibleBoards(_, _, [], []).
getPossibleBoards(Piece, Board, [[R,C]|T], PossibleBoards):-
  getPossibleBoards(Piece, Board, T, PBAux),
  setPiece(Piece, R, C, Board, Temp),
  append([Temp], PBAux, PossibleBoards).

getPossibleBoardsByMoves(_, _, [], []).
getPossibleBoardsByMoves(Piece, Board, [[Xi,Yi,Xf,Yf]|T], PossibleBoards):-
  getPossibleBoardsByMoves(Piece, Board, T, PBAux),
  forceSetPiece(0, Xi, Yi, Board, Board1),
  setPiece(Piece, Xf, Yf, Board1, Temp),
  append([Temp], PBAux, PossibleBoards).


%Counts how many sequences of N consecutive Piece the board has horizontally
findHorizontalStreak(Board, N, Piece, Count):-
  findall(V, (nth0(_, Board, R), streak(N, R, Piece, V)), Values),
  sumlist(Values,Count).

%Counts how many sequences of N consecutive Piece the board has vertically
findVerticalStreak(Board, N, Piece, Count):-
  transpose(Board, TR),
  findall(V, (nth0(_, TR, R), streak(N, R, Piece, V)), Values),
  sumlist(Values,Count).

%Counts how many sequences of N consecutive Piece the board has diagonally
findDiagonalStreak(Board, N, Piece, Count):-
  allDiagonals(Board, [], Diagonals),
  findall(V, (nth0(_, Diagonals, R), streak(N, R, Piece, V)), Values),
  sumlist(Values,Count).

%Finds matrix diagonal (negative scope) (S can be used to fetch smaller diagonals)
diag1(M,D,S):- findall(V,  (nth1(I,M,X), J is I-S, nth1(J,X,V)), D).

%Finds matrix diagonal (positive scope) (S can be used to fetch smaller diagonals)
diag2(M,G,S):- length(M,L1), L is L1-S , findall(V, (nth1(I,M,X),J is L-I+1,nth1(J,X,V)), G).

allDiagonals(Board, List, Diagonals):-
  diag1(Board, D1, 0),
  append(List, [D1], NewList),
  diag1(Board, D11, 1),
  append(NewList, [D11], NewList2),
  diag1(Board, D12, -1),
  append(NewList2, [D12], NewList3),
  diag2(Board, D2, 0),
  append(NewList3, [D2], NewList4),
  diag2(Board, D21, 1),
  append(NewList4, [D21], NewList5),
  diag2(Board, D22, -1),
  append(NewList5, [D22], Diagonals).

checkStreaks(Board, N, Piece, Count):-
  findHorizontalStreak(Board, N, Piece, Count1),
  findVerticalStreak(Board, N, Piece, Count2),
  findDiagonalStreak(Board, N, Piece, Count3),
  V is Count1+Count2,
  Count is V+Count3.

%Evaluates the board regarding the streaks of 4,3 and 2 consecutive Piece
value(Board, Piece, Value):-
  checkStreaks(Board, 4, Piece, Count1),
  checkStreaks(Board, 3, Piece, Count2),
  checkStreaks(Board, 2, Piece, Count3),
  changePlayer(Piece, NewPiece),
  checkStreaks(Board, 4, NewPiece, Count4),
  checkStreaks(Board, 3, NewPiece, Count5),
  checkStreaks(Board, 2, NewPiece, Count6),
  C is Count1 + Count2,
  C1 is C + Count3,
  C2 is C1 - Count4,
  C3 is C2 - Count5,
  Value is C3 - Count6.

%Computes the values of all the boards passed by a list
computeValues(_, [], []).
computeValues(Piece, [B|T], Values):-
  computeValues(Piece, T, Values1),
  value(B, Piece, Value),
  append([Value], Values1, Values).



