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


vert_win([B|T], Player) :-
    transpose([B|T], [M|N]),
    hor_win([M|N], Player). %nao se vai poder usar mas para ja fica



diagwin(Board, Player) :-
    length(Board, Length),
    (\+ diagAux1(Board, 0, 0, Length, Player),
    \+ diagAux2(Board, 0, 1, Length, Player),
    \+ diagAux3(Board, 0, 4, Length, Player),
    \+ diagAux4(Board, 0, 3, Length, Player)).
   
diagAux1(Board, X, Y, Length, Player) :-
    4=<Length-X,
    4=<Length-Y,
    diagADOWN(Board, X, Y, 0, Length, Player).

diagAux1(Board, X, Y, Length, Player) :-
    4=<Length-X,
    4=<Length-Y,
    X1 is X+1,
    diagAux1(Board, X1, Y, Length, Player).

diagAux2(Board, X, Y, Length, Player) :-
    4=<Length-X,
    4=<Length-Y,
    diagADOWN(Board, X, Y, 1, Length, Player).

diagAux2(Board, X, Y, Length, Player) :-
    4=<Length-X,
    4=<Length-Y,
    Y1 is Y+1,
    diagAux2(Board, X, Y1, Length, Player).

diagAux3(Board, X, Y, Length, Player) :-
    Y>=3,
    X=<1,
    diagBDOWN(Board, X, Y, 1, Length, Player).

diagAux3(Board, X, Y, Length, Player) :-
    Y>=3,
    X=<1,
    X1 is X+1,
    diagAux3(Board, X1, Y, Length, Player).

diagAux4(Board, X, Y, Length, Player) :-
    Y>=3,
    X=<1,
    diagBDOWN(Board, X, Y, 0, Length, Player).

diagAux4(Board, X, Y, Length, Player) :-
    Y>=3,
    X=<1,
    Y1 is Y-1,
    diagAux4(Board, X, Y1, Length, Player).



diagADOWN(_, _, _, 4, _, _).

diagADOWN(Board, X, Y, Counter, Length, Player) :-
    X<Length,
    Y<Length,
    nth0(X, Board, Row),
    nth0(Y, Row, Elem),
    Elem==Player,
    Counter2 is Counter+1,
    X1 is X+1,
    Y1 is Y+1,
    diagADOWN(Board, X1, Y1, Counter2, Length, Player).  

diagADOWN(Board, X, Y, _, Length, Player) :-
    X<Length,
    Y<Length,
    X1 is X+1,
    Y1 is Y+1,
    diagADOWN(Board, X1, Y1, 0, Length, Player).  


diagBDOWN(_, _, _, 4, _, _).

diagBDOWN(Board, X, Y, Counter, Length, Player) :-
    Y>=0,
    X<Length,
    nth0(X, Board, Row),
    nth0(Y, Row, Elem),
    Elem==Player,
    Counter2 is Counter+1,
    X1 is X+1,
    Y1 is Y-1,
    diagBDOWN(Board, X1, Y1, Counter2, Length, Player).  

diagBDOWN(Board, X, Y, _, Length, Player) :- 
    X < Length , 
    Y >= 0, 
    Y1 is Y - 1, 
    X1 is X + 1, 
    diagBDOWN(Board, X1, Y1, 0, Length,Player).  



seq4(_, F, 4, P).

seq4([F | T], F, Counter,_) :- F \= 0, Counter2 is Counter + 1, seq4(T, F, Counter2, F).  

seq4([F| T], _, _,_) :- Counter2 is 1, seq4(T, F, Counter2, F).  


 reload :- reconsult('logic.pl').