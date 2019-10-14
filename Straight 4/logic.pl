:- include('display.pl').
:- use_module(library(lists)).

setPiece(Board, 0, 0, Temp, NewBoard) :-
    append(Temp, Board, NewBoard).


setPiece([F|T], X, 0, Piece, Temp, NewBoard) :-
    setRow(F, X, Piece, [], Row),
    append(Temp, [Row], List),
    setPiece(T, 0, 0, List, NewBoard).
    
setPiece([F|T], X, Y, Piece, Temp, NewBoard) :-
    Y1 is Y-1,
    append(Temp, [F], List1AndList2),
    setPiece(T, X, Y1, Piece, List1AndList2, NewBoard).


setRow([_|T], 0, Piece, TempRow, Row) :-
    append(TempRow, [Piece], Row1),
    append(Row1, T, Row).

setRow([F|T], X, Piece, TempRow, Row) :-
    append(TempRow, [F], List),
    X1 is X-1,
    setRow(T, X1, Piece, List, Row).



%%%%% find a winner
winner(Board, Player) :-
    horizontal_win(Board, Player).

winner(Board, Player) :-
    vertical_win(Board, Player).

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
                                  1,
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
                                  1,
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



move(Board, Xi, Yi, Xf, Yf, Player, NewBoard) :-
    nth0(Yi, Board, Row),
    nth0(Xi, Row, Elemi),
    Elemi=Player,
    nth0(Yf, Board, Row2),
    nth0(Xf, Row2, Elemf),
    Elemf=0,
    type_move(Board, Xi, Yi, Xf, Yf),
    setPiece(Board, Xi, Yi, 0, [], Board1),
    setPiece(Board1, Xf, Yf, Player, [], NewBoard).


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


can_move(_, 0, 0, _, _, _, _, _) :-
    fail.

can_move(Board, 0, _, Xi, Yi, _, Yf) :-
    move_vertically(Board, Xi, Yi, Yf).

can_move(Board, _, 0, Xi, Yi, Xf, _) :-
    move_horizontally(Board, Yi, Xi, Xf).

can_move(Board, _, _, Xi, Yi, Xf, Yf) :-
    Xf-Xi=:=Yf-Yi,
    move_diagonally(Board, Xi, Yi, Xf, Yf).


move_vertically(_, _, Yf, Yf).

move_vertically(Board, X, Yi, Yf) :-
    Sum is (Yf-Yi)div abs(Yf-Yi),
    Y1 is Yi+Sum,
    nth0(Y1, Board, Row),
    nth0(X, Row, Elem),
    Elem=0,
    move_vertically(Board, X, Y1, Yf). 
     

move_horizontally(_, _, Xf, Xf).

move_horizontally(Board, Y, Xi, Xf) :-
    Sum is (Xf-Xi)div abs(Xf-Xi),
    X1 is Xi+Sum,
    nth0(X1, Board, Row),
    nth0(Y, Row, Elem),
    Elem=0,
    move_horizontally(Board, Y, X1, Xf). 
     


% ends when Xi = Xf and Yf = Yi
%move_diagonally(_, Xi, Xf, Yi, Yf) :- (Xi-Yi) = (Xf-Yf).
move_diagonally(_, Xi, Yi, Xi, Yi).


move_diagonally(Board, Xi, Yi, Xf, Yf) :-
    SumX is (Xf-Xi)div abs(Xf-Xi),
    SumY is (Yf-Yi)div abs(Yf-Yi),
    X1 is Xi+SumX,
    Y1 is Yi+SumY,
    nth0(X1, Board, Row),
    nth0(Y1, Row, Elem),
    Elem=0,
    move_diagonally(Board, X1, Y1, Xf, Yf). 
     



canInsert(Board, X,Y):-
    nth0(Y, Board, P), nth0(X,P,Piece), Piece = 0.




 reload :-
    reconsult('logic.pl').