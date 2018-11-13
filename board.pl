:- use_module(library(random)).
:- use_module(library(lists)).

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


%% Insert in a position (Line, Column) the Symbol
%% Line - Number of the Line
%% Column - Number of the Column
%% Symbol - Symbol to be Insert
%% Board - Board to be Changed,
%% List1 - Return the Board changed

insertOnPositon(Line, Column, Symbol, Board, List1):-
    RealLine is Line - 1,
    nth1(Line, Board, Change),
    changeElem(Column, Symbol, Change, Changed),
    nth0(0,[H|T], Changed),
    copy(Board, TempList, RealLine), 
    copy2(Board, HalfBoard, Line, 0), 
    append(TempList, [H|T], FH),
    append(FH, HalfBoard, List1).

%% caso base
changeElem(_ , _, [], _). 

%% Change an element in the List [H|T]
%% Index - Index of the element to be changed, between [1, size of the board]
%% X - Symbol to be insert
%% [H|T] - List to be changed
%% [N|L] - List changed

changeElem(Index, X, [H|T], [N|L]):-
    Index = 1 -> N = X, Index1 is Index - 1, changeElem(Index1, X, T, L);
    Index1 is Index - 1, N = H, changeElem(Index1, X, T, L).


%% copy the board until index = X
%% [H|T] - Board to be copied
%% [A|B] - Copy of the board until index X
%% X - Index until [H|T] should be copied

copy(_, _, 0).
copy([H|T], [A|B], X):-
    A = H,
    X1 is X - 1,
    copy(T, B, X1).

%% copy the board from index X until the end
%% [H|T] - Board to be copied
%% [A|B] - Copy of the board starting in index X
%% X - Index where the copy may start 

copy2([H|T], [A|B], X, Contador):-
    X > Contador -> Contador1 is Contador + 1, copy2(T, [A|B], X, Contador1);
    length([H|T], N),copy([H|T], [A|B],N).
