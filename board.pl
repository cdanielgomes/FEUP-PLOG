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

%% Get the Symbol in the position (Line, Column)
%% Line - Number of the Line
%% Column - Number of the Column
%% Board - Board to be Changed
%% Symbol - Return the symbol in the position(Line, Column)
getElemInPosition(Board, Line, Column,Type):-
    nth1(Line, Board, A),
    nth1(Column, A, Type). 


%% win 

checkFiveInLine(Line, Type):-
    length(N, 5),
    maplist(=(Type), N),
    segment(Line, N).

checkLines([], _).
checkLines([H|T], Type):-
    \+ checkFiveInLine(H, Type), %% false if found a five sequence
    checkLines(T, Type).
    


%% Win Game
winGame(Board, Type):-
    winVertical(Board, Type).

winGame(Board, Type):-
    winHorizontal(Board, Type).

winGame(Board, Type):-
    winDiagonal(Board, Type).
%%Win Vertical
winVertical(Board, Type):-
    transpose(Board, Vertical),
    checkLines(Vertical,Type).

%%win Horizontal
winHorizontal(Board, Type):-
    checkLines(Board, Type).

winDiagonal(Board, Type):-
    length(Board, BoardSize),
    computeLRUp(Board, 1, 1, BoardSize, AuxListLRUp, DiagonalLRUp),    
    computeLRDown(Board, 2, 1, BoardSize, AuxListLRDown, DiagonalLRDown),
    computeRLUp(Board, 1, BoardSize, BoardSize, AuxListRLUp, DiagonalRLUp),
    computeRLDown(Board, 2, BoardSize, BoardSize, AuxListRLDown, DiagonalRLDown),
    checkLines(DiagonalLRUp, Type),!,
    checkLines(DiagonalLRDown, Type),!,
    checkLines(DiagonalRLUp, Type),!,
    checkLines(DiagonalRLDown, Type),!.

%%Increment Lines Left to Right
computeLRDown(_, Line, _, BoardSize,List2, AllDiag):- Line = BoardSize, AllDiag = List2.
computeLRDown(Board, L, C, BoardSize, AllDiagTemp, AllDiag):-
    lrInc(Board, L, C, BoardSize, List, Diag),
    L1 is L + 1,   
    append(AllDiagTemp, [Diag], List1),
    computeLRDown(Board, L1, C, BoardSize, List1, AllDiag).


%%Increment Columns Left to Right
computeLRUp(_, _, Column, BoardSize,List2, AllDiag):- Column = BoardSize, AllDiag = List2.
computeLRUp(Board, L, C, BoardSize, AllDiagTemp, AllDiag):-
    lrInc(Board, L, C, BoardSize, List, Diag),
    C1 is C + 1,   
    append(AllDiagTemp, [Diag], List1),
    computeLRUp(Board, L, C1, BoardSize, List1, AllDiag).

lrInc(_, _, Column, BoardSize, List2, FinalDiagonal):- C1 is Column - 1, BoardSize = C1, FinalDiagonal=List2.
lrInc(_, Line, _, BoardSize, List2, FinalDiagonal):- L1 is Line - 1, BoardSize = L1, FinalDiagonal=List2.
lrInc(Board,Line, Column, BoardSize, Diagonal, FinalDiagonal):-
    getElemInPosition(Board, Line, Column, Type),
    append(Diagonal, [Type], List1),
    NewLine is Line + 1,
    NewColumn is Column  + 1,
    lrInc(Board, NewLine, NewColumn, BoardSize, List1, FinalDiagonal).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Increment Lines Right to Left
computeRLDown(_, Line, _, BoardSize,List2, AllDiag):- Line = BoardSize, AllDiag = List2.
computeRLDown(Board, L, C, BoardSize, AllDiagTemp, AllDiag):-
    rlInc(Board, L, C, BoardSize, List, Diag),
    L1 is L + 1,   
    append(AllDiagTemp, [Diag], List1),
    computeRLDown(Board, L1, C, BoardSize, List1, AllDiag).

%%Increment Columns Right to Left
computeRLUp(_, _, Column, BoardSize,List2, AllDiag):- Column = 0, AllDiag = List2.
computeRLUp(Board, L, C, BoardSize, AllDiagTemp, AllDiag):-
    rlInc(Board, L, C, BoardSize, List, Diag),
    C1 is C - 1,   
    append(AllDiagTemp, [Diag], List1),
    computeRLUp(Board, L, C1, BoardSize, List1, AllDiag).

rlInc(_, _, Column, _, List2, FinalDiagonal):- 0 = Column, FinalDiagonal=List2.
rlInc(_, Line, _, BoardSize, List2, FinalDiagonal):- L1 is Line - 1, BoardSize = L1, FinalDiagonal=List2.
rlInc(Board,Line, Column, BoardSize, Diagonal, FinalDiagonal):-
    getElemInPosition(Board, Line, Column, Type),
    append(Diagonal, [Type], List1),
    NewLine is Line + 1,
    NewColumn is Column  - 1,
    rlInc(Board, NewLine, NewColumn, BoardSize, List1, FinalDiagonal).
/*
winDiagonal(Board, Type):-
    length(Board, BoardSize),
    diagWinAux(Board, 1, Type, BoardSize).

%Lef to rigth
diagWinAux(Board, Column, Type, _BoardSize):-
    diagLineWin(Board, Column, 1, 1, 1, Type, 0).

%right to left
diagWinAux(Board, Column, Type, _BoardSize):-
    diagLineWin(Board, Column, 1, 1, -1, Type, 0).
%Recursive Call
diagWinAux(Board, Column, Type, BoardSize):-
    NewColumn is (Column + 1),
    NewColumn =< BoardSize,
    diagWinAux(Board, NewColumn, Type, BoardSize).


diagLineWin(_, _, _, _, _, _, Count):-
    Count >= 5.

diagLineWin(Board, Line, Column, LineInc, ColumnInc, Type, Count):-
    getElemInPosition(Board, Line, Column, Elem),
    Elem = Type,
    NewLine is (Line + LineInc), NewColumn is (Column + ColumnInc),
    NewCount is (Count + 1),
    diagLineWin(Board, NewLine, NewColumn, LineInc, ColumnInc, Type,  NewCount).


diagLineWin(Type, Board, Line, Column, LineInc, ColumnInc, _):-
    getElemInPosition(Board, Line, Column, Elem),
    NewLine is (Line + LineInc), NewColumn is (Column + ColumnInc),
    Elem \= Type,
    diagLineWin(Type, Board, NewLine, NewColumn, LineInc, ColumnInc, 0).

*/


print_board([]).
print_board([H|T]):-
    print_line(H),
    write('\n'),
    print_board(T).
    
print_line([]).
print_line([H|T]):-
    write(H),
    print_line(T).

conversion('A', 1).
conversion('B', 2).
conversion('C', 3).
conversion('D', 4).
conversion('E', 5).
conversion('F', 6).
conversion('G', 7).
conversion('H', 8).
conversion('I', 9).
conversion('J', 10).
conversion('K', 11).
conversion('L', 12).
conversion('M', 13).
conversion('N', 14).
conversion('O', 15).
conversion('P', 16).
conversion('Q', 17).
conversion('R', 18).
conversion('S', 19).
conversion('T', 20).
conversion('U', 21).
conversion('V', 22).
conversion('W', 23).
conversion('X', 24).
conversion('Y', 25).
conversion('Z', 26).


