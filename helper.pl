:- use_module(library(random)).
:- use_module(library(lists)).
:- include('display.pl').
	

%% Size = Size of the Board
%% Board - return of the board
createEmptyBoard(Size, Board):- 
    create_line(0, Size, A),
    length(Board, Size),
    maplist(=(A), Board).

%%% X - Symbol to be insert in every position of List
%%% N - Size of a line 
%%% List - Return of a line
create_line(X, N, List)  :- 
    length(List, N), 
    maplist(=(X), List).


insertOnPositon(Line, Column, Symbol, Board, List1):-
    RealLine is Line - 1,
    nth1(Line, Board, Change),
    changeElem(Column, Symbol, Change, Changed),
    nth0(0,[H|T], Changed),
    copy(Board, TempList, RealLine), 
    copy2(Board, HalfBoard, Line, 0), 
    append(TempList, [H|T], FH),
    append(FH, HalfBoard, List1).

changeElem(_ , _, [], _). 
changeElem(Index, X, [H|T], [N|L]):-
    Index = 1 -> N = X, Index1 is Index - 1, changeElem(Index1, X, T, L);
    Index1 is Index - 1, N = H, changeElem(Index1, X, T, L).

copy(_, _, 0).
copy([H|T], [A|B], X):-
    A = H,
    X1 is X - 1,
    copy(T, B, X1).

copy2([], _, _).
copy2([H|T], [A|B], X, Contador):-
    X > Contador -> Contador1 is Contador + 1, copy2(T, [A|B], X, Contador1);
    length([H|T], N),copy([H|T], [A|B],N).