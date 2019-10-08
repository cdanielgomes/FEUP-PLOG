convert(0, 11038).
convert(1, 9899).
convert(2, 9898).

startHorizontalIdent(Size):-
    write('   '),
    printHorizontalIdent(1, Size).

printHorizontalIdent(Count, Size) :-
    Ind is Count-1,
    write(Ind),
    write('   '),
    Count2 is Count+1,
    Size>Count,
    printHorizontalIdent(Count2, Size).
printHorizontalIdent(_, _).

displayGameBoard(Board) :-
    length(Board, Size),
    startHorizontalIdent(Size),
    nl,
    displayBoard(Board, 0). 


displayLine([], _).
displayLine([Head|Tail], 4):-
    convert(Head, Code),
    put_code(Code),
    displayLine(Tail, _).
displayLine([Head|Tail], Acc) :-
    convert(Head, Code),
    put_code(Code),
    write(' '),
    put_code(9472),
    write(' '),
    Acc2 is Acc+1,
    displayLine(Tail, Acc2).

startRowDivider(Acc, Line):-
    printRowDivider(Acc, Line).

printRowDivider(0, _).
printRowDivider(_, 4).
printRowDivider(Acc, Line):-
    write('   '),
    put_code(9474),
    Acc2 is Acc-1,
    printRowDivider(Acc2, Line).


displayBoard([], _). 
displayBoard([Firstline|Tail], Line) :-
    write(Line),
    write('  '),
    displayLine(Firstline, 0), nl,
    startRowDivider(5, Line),
    Line2 is Line+1,
    nl,
    displayBoard(Tail, Line2).




board :-
    displayGameBoard(
                     [ [0, 1, 2, 0, 0],
                       [0, 0, 0, 0, 1],
                       [0, 0, 1, 1, 0],
                       [2, 0, 0, 0, 0],
                       [0, 0, 2, 0, 0]
                     ]).


