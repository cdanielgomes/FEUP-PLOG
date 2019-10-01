printHorizontalCount(Count, Size) :-
    write(Count),
    Count2 is Count+1,
    Size>Count,
    printHorizontalCount(Count2, Size).

printHorizontalCount(_, _).

displayGameBoard(Board) :-
    length(Board, Size),
    printHorizontalCount(0, Size),
    nl,
    displayBoard(Board, 0). 


displayLine([], _).
displayLine([FirstElem|Tail], Line) :-
    write(FirstElem),
    Line2 is Line+1,
    displayLine(Tail, Line2). 

displayBoard([], _). 
displayBoard([Firstline|Tail], Line) :-
    write(Line),
    displayLine(Firstline, Line),
    Line2 is Line+1,
    nl,
    displayBoard(Tail, Line2).




board :-
    displayGameBoard(
                     [ [0, 0, 0, 0, 0],
                       [0, 0, 0, 0, 0],
                       [0, 0, 0, 0, 0],
                       [0, 0, 0, 0, 0],
                       [0, 0, 0, 0, 0]
                     ]).


