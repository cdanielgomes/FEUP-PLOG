:- include('display.pl').
:- use_module(library(lists)).

getPiece(Board, X, Y, Piece) :-
    nth0(X, Board, Elem),
    nth0(Y, Elem, Piece).


setPiece(Board, 0, 0, Temp, NewBoard) :-
    append(Temp, Board, NewBoard).


setPiece([F|T], X, 0, Piece, Temp, NewBoard) :-
    X\=0,
    setRow(F, X, Piece, [], Row),
    append(Temp, [Row], List),
    setPiece(T, 0, 0, List, NewBoard).
    
setPiece([F|T], X, Y, Piece, Temp, NewBoard) :-
    Y1 is Y-1,
    append(Temp, [F], List1AndList2),
    setPiece(T, X, Y1, Piece, List1AndList2, NewBoard).


setRow([F|T], 0, Piece, TempRow, Row) :-
    F==0,
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

 reload :-
    reconsult('logic.pl').