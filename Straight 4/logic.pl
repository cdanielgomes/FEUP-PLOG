:- include('display.pl').
:- use_module(library(lists)).
:- use_module(library(clpfd)).

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



hor_win([B|_], Player) :-
    checkHorizontal(B, Player).

hor_win([_|T], Player) :-
    hor_win(T, Player).

checkHorizontal([X, X, X, X, _], X).
checkHorizontal([_, X, X, X, X], X).


vert_win([B|T], Player) :- transpose([B|T], [M|N]), hor_win([M|N], Player). %nao se vai poder usar mas para ja fica


diagWin([B|T]).

diagWinLR(Board, X, Y, Temp) :- nth0(Y, Board, Row), nth0(X, Row, Elem), X1 is X + 1, Y1 is Y + 1, append(Temp, [Elem], Temp2), diagWinLR(Board, X1, Y1, Temp2).

diagWinLR(Board, X, Y, Temp) :- length(Temp, Int), Int >= 4.


seq4(_, _, 4, P) :- write(P).

seq4([F | T], F, Counter, _) :- F \= 0, Counter2 is Counter + 1, seq4(T, F, Counter2, F).  

seq4([F| T], _, Counter, _) :- Counter \= 4, Counter2 is 1, seq4(T, F, Counter2, F).  





% setPiece([ [0, 0, 0, 0, 0],
%                        [0, 0, 0, 0, 0],
%                        [0, 0, 0, 0, 0],
%                        [0, 0, 0, 0, 0],
%                        [0, 0, 0, 0, 0]
%                      ], 1 , 1, 1, [], N).
% seq4([0,1,1,1,1,2,3,2,3],-1, 0, P).