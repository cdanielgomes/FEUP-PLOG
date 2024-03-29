:- use_module(library(lists)).

%Fetch piece from board
getPiece(Board, X, Y, Piece) :-
    nth0(X, Board, Elem),
    nth0(Y, Elem, Piece).

%Insert piece on Board , Board[Row][Col]
%only it it is a valid position
setPiece(Piece, Row, Col, Board, NewBoard) :-
    isValidPosition(Row, Col, Board),
    nth0(Row, Board, RowLine, TmpBoard),
    nth0(Col, RowLine, _, TmpRowLine),
    nth0(Col, NewRowLine, Piece, TmpRowLine),
    nth0(Row, NewBoard, NewRowLine, TmpBoard).

%Insert piece on Board, Board[Row][Col]
%Even is its not an empty position
forceSetPiece(Piece, Row, Col, Board, NewBoard) :-
    nth0(Row, Board, RowLine, TmpBoard),
    nth0(Col, RowLine, _, TmpRowLine),
    nth0(Col, NewRowLine, Piece, TmpRowLine),
    nth0(Row, NewBoard, NewRowLine, TmpBoard).


%Checks if position is valid in current board and if is empty
isValidPosition(Row, Col, Board):- !,
  length(Board, L),
  Row >= 0 , Col >= 0,
  Row < L, Col < L,
  getPiece(Board, Row, Col, 0).



%%%%% find if the player Player win by horizontal line
winner(Board, Player) :-
    horizontal_win(Board, Player).

%%%%% find if the player Player win by vertical line
winner(Board, Player) :-
    vertical_win(Board, Player).

%%%%% find if the player Player win by diagonal line
winner(Board, Player) :-
    \+ diagonal_win(Board, Player).

horizontal_win([B|_], Player) :-
    checkHorizontal(B, Player).

horizontal_win([_|T], Player) :-
    horizontal_win(T, Player).

checkHorizontal([X, X, X, X, _], X).
checkHorizontal([_, X, X, X, X], X).

%transpose matrix
tp([[]|_], []).
tp(Board, [Row|Tail]) :-
    transposeCol(Board, Row, RestBoard),
    tp(RestBoard, Tail).

transposeCol([], [], []).
transposeCol([[H|T]|Rows], [H|Hs], [T|Ts]) :-
    transposeCol(Rows, Hs, Ts).


vertical_win([B|T], Player) :-
    tp([B|T], [M|N]),
    horizontal_win([M|N], Player). %nao se vai poder usar mas para ja fica

%% search in each diagonal of the board for a sequence of 4 equal pieces
diagonal_win(Board, Player) :-
    length(Board, Length),
    \+ diagAux1(Board, 0, 0, Length, Player),
    \+ diagAux2(Board, 0, 1, Length, Player),
    \+ diagAux3(Board, 0, 4, Length, Player),
    \+ diagAux4(Board, 0, 3, Length, Player).
   
%% diagonal Left to Right UpBoard
diagAux1(Board, X, Y, Length, Player) :-
    4=<Length-X,
    4=<Length-Y,
    check_seq4_left_right_up_down(Board,
                                  X,
                                  Y,
                                  0,
                                  Length,
                                  Player).

diagAux1(Board, X, Y, Length, Player) :-
    4=<Length-X,
    4=<Length-Y,
    X1 is X+1,
    diagAux1(Board, X1, Y, Length, Player).

%% diagonal Left to Right Down Board
diagAux2(Board, X, Y, Length, Player) :-
    4=<Length-X,
    4=<Length-Y,
    check_seq4_left_right_up_down(Board,
                                  X,
                                  Y,
                                  0,
                                  Length,
                                  Player).

diagAux2(Board, X, Y, Length, Player) :-
    4=<Length-X,
    4=<Length-Y,
    Y1 is Y+1,
    diagAux2(Board, X, Y1, Length, Player).

%% diagonal Left to Right, Down to Up UpBoard
diagAux3(Board, X, Y, Length, Player) :-
    Y>=3,
    X=<1,
    check_seq4_left_right_down_up(Board,
                                  X,
                                  Y,
                                  0,
                                  Length,
                                  Player).

diagAux3(Board, X, Y, Length, Player) :-
    Y>=3,
    X=<1,
    X1 is X+1,
    diagAux3(Board, X1, Y, Length, Player).


%% diagonal Left to Right, Down to UP  DownBoard
diagAux4(Board, X, Y, Length, Player) :-
    Y>=3,
    X=<1,
    check_seq4_left_right_down_up(Board,
                                  X,
                                  Y,
                                  0,
                                  Length,
                                  Player).

diagAux4(Board, X, Y, Length, Player) :-
    Y>=3,
    X=<1,
    Y1 is Y-1,
    diagAux4(Board, X, Y1, Length, Player).



check_seq4_left_right_up_down(_, _, _, 4, _, _).

check_seq4_left_right_up_down(Board, X, Y, Counter, Length, Player) :-
    X<Length,
    Y<Length,
    nth0(X, Board, Row),
    nth0(Y, Row, Elem),
    Elem==Player,
    Counter2 is Counter+1,
    X1 is X+1,
    Y1 is Y+1,
    check_seq4_left_right_up_down(Board,
                                  X1,
                                  Y1,
                                  Counter2,
                                  Length,
                                  Player).  

check_seq4_left_right_up_down(Board, X, Y, _, Length, Player) :-
    X<Length,
    Y<Length,
    X1 is X+1,
    Y1 is Y+1,
    check_seq4_left_right_up_down(Board,
                                  X1,
                                  Y1,
                                  0,
                                  Length,
                                  Player).  


check_seq4_left_right_down_up(_, _, _, 4, _, _).

check_seq4_left_right_down_up(Board, X, Y, Counter, Length, Player) :-
    Y>=0,
    X<Length,
    nth0(X, Board, Row),
    nth0(Y, Row, Elem),
    Elem==Player,
    Counter2 is Counter+1,
    X1 is X+1,
    Y1 is Y-1,
    check_seq4_left_right_down_up(Board,
                                  X1,
                                  Y1,
                                  Counter2,
                                  Length,
                                  Player).  

check_seq4_left_right_down_up(Board, X, Y, _, Length, Player) :-
    X<Length,
    Y>=0,
    Y1 is Y-1,
    X1 is X+1,
    check_seq4_left_right_down_up(Board,
                                  X1,
                                  Y1,
                                  0,
                                  Length,
                                  Player).  


%% validate and moves a piece
move(Board, Xi, Yi, Xf, Yf, Player, NewBoard) :-
    nth0(Xi, Board, Row),
    nth0(Yi, Row, Elemi),
    Elemi=Player,
    nth0(Xf, Board, Row2),
    nth0(Yf, Row2, Elemf),
    Elemf=0,
    type_move(Board, Xi, Yi, Xf, Yf),
    forceSetPiece(0, Xi, Yi, Board, Board1),
    setPiece(Player, Xf, Yf, Board1, NewBoard).


%% will find the direction of the movement
%% and will select what can_move will selected
%% based on the direction
type_move(Board, Xi, Yi, Xf, Yf) :-
    VectorX is Xf-Xi,
    VectorY is Yf-Yi,
    can_move(Board,
             VectorX,
             VectorY,
             Xi,
             Yi,
             Xf,
             Yf).

%%  can_move will select directions to be analysed
can_move(_, 0, 0, _, _, _, _, _) :-
    fail.

can_move(Board, _, 0, Xi, Yi, Xf, _) :-
    move_vertically(Board, Yi, Xi, Xf).

can_move(Board, 0, _, Xi, Yi, _, Yf) :-
    move_horizontally(Board, Xi, Yi, Yf).

can_move(Board, _, _, Xi, Yi, Xf, Yf) :-
    abs(Xf-Xi)=:=abs(Yf-Yi),
    move_diagonally(Board, Xi, Yi, Xf, Yf).


%% check for each direction if there are no pieces 
%% between the given positions

move_vertically(_, _, Xi, Xf):- Xi =:= Xf, !.

move_vertically(Board, Y, Xi, Xf) :-
    Sum is (Xf-Xi)div abs(Xf-Xi),
    X1 is Xi+Sum,
    nth0(X1, Board, Row),
    nth0(Y, Row, Elem),
    Elem=0,
    move_vertically(Board, Y, X1, Xf). 
     

move_horizontally(_, _, Yi, Yf):- Yi =:= Yf, !.

move_horizontally(Board, X, Yi, Yf) :-
    Sum is (Yf-Yi)div abs(Yf-Yi),
    Y1 is Yi+Sum,
    nth0(X, Board, Row),
    nth0(Y1, Row, Elem),
    Elem=0,
    move_horizontally(Board, X, Y1, Yf). 
     


% ends when Xi = Xf and Yf = Yi
move_diagonally(_, Xi, Yi, Xf, Yf):- Xi =:= Xf, Yi =:= Yf, !.


move_diagonally(Board, Xi, Yi, Xf, Yf) :-
    SumX is (Xf-Xi)div abs(Xf-Xi),
    SumY is (Yf-Yi)div abs(Yf-Yi),
    X1 is Xi+SumX,
    Y1 is Yi+SumY,
    nth0(X1, Board, Row),
    nth0(Y1, Row, Elem),
    Elem=0,
    move_diagonally(Board, X1, Y1, Xf, Yf). 
     
