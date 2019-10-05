:- include('display.pl').
:- use_module(library(lists)).


getPiece(Board, X, Y, Piece) :-
    nth0(X, Board, Elem),
    nth0(Y, Elem, Piece).


setPiece(Board, 0, 0, Temp, NewBoard) :-
    append(Temp, Board, NewBoard).


setPiece([F|T], X, 0, Piece, Temp, NewBoard) :-
    X \= 0, 
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

% setPiece([ [0, 0, 0, 0, 0],
%                        [0, 0, 0, 0, 0],
%                        [0, 0, 0, 0, 0],
%                        [0, 0, 0, 0, 0],
%                        [0, 0, 0, 0, 0]
%                      ], 1 , 1, 1, [], N).