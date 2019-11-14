:- use_module(library(random)).


%Returns NewBoard after making a rondomly selected Move(Xi,Yi,Xf,Yf)
%from the PossibleMoves ---> This happens when there are more available pieces in the bag.
randomPlay(Piece, Board, NewBoard, [0,0], _NewPieces):-
  getPossibleMoves(Piece, Board, PossibleMoves),
  length(PossibleMoves, Len),
  Len1 is Len-1,
  random(0, Len1, Index),
  nth0(Index, PossibleMoves, [Xi,Yi,Xf,Yf]),
  forceSetPiece(0, Xi, Yi, Board, Board1),
  setPiece(Piece, Xf, Yf, Board1, NewBoard).
  
%Randomly selects a NewBoard from the PossibleBoards computed.
randomPlay(Piece, Board, NewBoard, Pieces, NewPieces):-
  getPossibleBoards(Piece, Board, PossibleBoards),
  length(PossibleBoards, Len),
  Len1 is Len - 1,
  random(0, Len1, Index),
  nth0(Index, PossibleBoards, NewBoard),
  removeFromBag(Piece, Pieces, NewPieces).

%Returns the best move computed by the minimax algorithm  --> NewBoard implies a move of a piece
%Current Depth is 1 (hardcoded)                            % Happens when there are no more available pieces
smartPlay(Piece, Board, NewBoard, [0,0], _NewPieces):-       
  minimax1(Board, NewBoard, 1, Piece),
  clearScreen.

%Returns the best move computed by the minimax algorithm
%Current Depth is 1 (hardcoded)                            
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

%Auxiliar function to generate all possible boards
getPossibleBoards(_, _, [], []).
getPossibleBoards(Piece, Board, [[R,C]|T], PossibleBoards):-
  getPossibleBoards(Piece, Board, T, PBAux),
  setPiece(Piece, R, C, Board, Temp),
  append([Temp], PBAux, PossibleBoards).

%Auxiliar function to generate all possible boards --> PossibleBoards result from piece movements
getPossibleBoardsByMoves(_, _, [], []).
getPossibleBoardsByMoves(Piece, Board, [[Xi,Yi,Xf,Yf]|T], PossibleBoards):-
  getPossibleBoardsByMoves(Piece, Board, T, PBAux),
  forceSetPiece(0, Xi, Yi, Board, Board1),
  setPiece(Piece, Xf, Yf, Board1, Temp),
  append([Temp], PBAux, PossibleBoards).


%Evaluates the total streaks of N consecutive Piece the board has horizontally
findHorizontalStreak(Board, N, Piece, Count):-
  findall(V, (nth0(_, Board, R), streak(N, R, Piece, V)), Values),
  sumlist(Values,Count).

%Evaluates the total streaks of N consecutive Piece the board has vertically
findVerticalStreak(Board, N, Piece, Count):-
  transpose(Board, TR),
  findall(V, (nth0(_, TR, R), streak(N, R, Piece, V)), Values),
  sumlist(Values,Count).

%Evaluates the total streaks of N consecutive Piece the board has diagonally
findDiagonalStreak(Board, N, Piece, Count):-
  allDiagonals(Board, [], Diagonals),
  findall(V, (nth0(_, Diagonals, R), streak(N, R, Piece, V)), Values),
  sumlist(Values,Count).
 
%Finds matrix diagonal (negative scope) (S can be used to fetch smaller diagonals) (eg. 4 slots)
diag1(M,D,S):- findall(V,  (nth1(I,M,X), J is I-S, nth1(J,X,V)), D).

%Finds matrix diagonal (positive scope) (S can be used to fetch smaller diagonals) (eg. 4 slots)
diag2(M,G,S):- length(M,L1), L is L1-S , findall(V, (nth1(I,M,X),J is L-I+1,nth1(J,X,V)), G).

%Gets all the important diagonals from the board
% a diagonal is considered important when having 4/5 slots (so it possible to win the game).
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

%Returns the total value of the streaks of N in current Board for Piece.
checkStreaks(Board, N, Piece, Count):-
  findHorizontalStreak(Board, N, Piece, Count1),
  findVerticalStreak(Board, N, Piece, Count2),
  findDiagonalStreak(Board, N, Piece, Count3),
  V is Count1+Count2,
  Count is V+Count3.

%Evaluates the Board regarding the streaks of 4,3 and 2 consecutive Pieces 
%of type Piece(player) and of type NewPiece(opponent).
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

%Joins all the Values
computeValues(_, [], []).
computeValues(Piece, [B|T], Values):-
  computeValues(Piece, T, Values1),
  value(B, Piece, Value),
  append([Value], Values1, Values).



