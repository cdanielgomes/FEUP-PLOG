convert(0, 11038).
convert(1, 9899).
convert(2, 9898).
convert(black, 1).
convert(white, 2).

startHorizontalIdent(Size):-
    write('\t   '),
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
    write('\t'),
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
    write('\t'),
    write(Line),
    write('  '),
    displayLine(Firstline, 0), nl,
    startRowDivider(5, Line),
    Line2 is Line+1,
    nl,
    displayBoard(Tail, Line2).


printBag(0, Side):-
    write('Player '), write(Side), write(' Bag: none'), nl.
printBag(NumPieces, Side):-
    write('Player '), write(Side), write(' Bag: '),
    convert(Side, Piece),
    convert(Piece, Code),
    printPieces(NumPieces, Code), nl.

printPieces(0, _).
printPieces(NumPieces, Piece):-
    put_code(Piece),
    write(' '),
    NumPieces1 is NumPieces - 1,
    printPieces(NumPieces1, Piece).




printGameTitle:-
    clearScreen,
    write('\t    ____ _____ ____     _    ___ ____ _   _ _____ _  _   '),nl,
    write('\t   / ___|_   _|  _ \\   / \\  |_ _/ ___| | | |_   _| || |  '),nl,
    write('\t   \\___ \\ | | | |_) | / _ \\  | | |  _| |_| | | | | || |_ '),nl,
    write('\t    ___) || | |  _ < / ___ \\ | | |_| |  _  | | | |__   _|'),nl,
    write('\t   |____/ |_| |_| \\_/_/   \\_|___\\____|_| |_| |_|    |_|  '),nl,
    write('\t                                                         '),nl,nl.


printWin(black):-
    clearScreen,
    write('\t   ____  _        _    ____ _  __ __        _____ _   _ '),nl,
    write('\t  | __ )| |      / \\  / ___| |/ / \\ \\      / |_ _| \\ | |'),nl,
    write('\t  |  _ \\| |     / _ \\| |   | \' /   \\ \\ /\\ / / | ||  \\| |'),nl,
    write('\t  | |_) | |___ / ___ | |___| . \\    \\ V  V /  | || |\\  |'),nl,
    write('\t  |____/|_____/_/   \\_\\____|_|\\_\\    \\_/\\_/  |___|_| \\_|'),nl,
    write('\t                                                        '),nl,nl.


printWin(white):-
    clearScreen,
    write('\t  __        ___   _ ___ _____ _____  __        _____ _   _ '),nl,
    write('\t  \\ \\      / | | | |_ _|_   _| ____| \\ \\      / |_ _| \\ | |'),nl,
    write('\t   \\ \\ /\\ / /| |_| || |  | | |  _|    \\ \\ /\\ / / | ||  \\| |'),nl,
    write('\t    \\ V  V / |  _  || |  | | | |___    \\ V  V /  | || |\\  |'),nl,
    write('\t     \\_/\\_/  |_| |_|___| |_| |_____|    \\_/\\_/  |___|_| \\_|'),nl,
    write('\t                                                           '),nl,nl.
















board(early) :-
    displayGameBoard(
                     [ [0, 0, 1, 0, 0],
                       [0, 1, 2, 2, 0],
                       [0, 2, 1, 0, 0],
                       [0, 0, 0, 0, 0],
                       [0, 0, 0, 0, 0]
                     ]).



board(mid):-
   displayGameBoard(
                     [ [0, 0, 1, 1, 0],
                       [0, 1, 2, 2, 0],
                       [0, 2, 1, 0, 0],
                       [0, 0, 0, 2, 0],
                       [0, 0, 0, 0, 0]
                     ]).

board(late):-
    displayGameBoard(
                     [ [0, 0, 0, 2, 0],
                       [0, 1, 2, 0, 0],
                       [0, 2, 1, 0, 0],
                       [2, 0, 1, 0, 0],
                       [0, 0, 1, 0, 0]
                     ]).



