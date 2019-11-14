%Combinations of streaks of 4
streak(4, [_,X,X,X,X], X, 1000).
streak(4, [X,X,X,X,_], X, 1000).
%for diagonals with 4 slots
streak(4, [X,X,X,X], X, 1000).

%Combinations of streaks of 3
streak(3, [_,0,X,X,X], X, 144).
streak(3, [0,X,X,X,0], X, 377).
streak(3, [0,X,X,X,_], X, 144).
streak(3, [_,X,X,X,0], X, 144).
streak(3, [X,X,X,0,_], X, 144).
%for diagonals with 4 slots
streak(3, [X,X,X,0], X, 144).
streak(3, [0,X,X,X], X, 144).

%Combinations of streaks of 2
streak(2, [_,_,0,X,X], X, 8).
streak(2, [_,0,X,X,0], X, 21).
streak(2, [_,0,X,X,_], X, 8).
streak(2, [_,_,X,X,0], X, 8).
streak(2, [0,X,X,0,_], X, 21).
streak(2, [0,X,X,_,_], X, 8).
%streak(2, [_,X,X,0,X], X, 144).
streak(2, [_,X,X,0,_], X, 8).
%streak(2, [X,X,0,X,_], X, 144).
streak(2, [X,X,0,_,_], X, 8).

%for diagonals with 4 slots
streak(2, [X,X,0,_], X, 8).
streak(2, [0,X,X,0], X, 21).
streak(2, [0,X,X,_], X, 8).
streak(2, [_,0,X,X], X, 8).


test:- minimax1( [[2, 0, 0, 0, 2],
       		      [1, 1, 1, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 2, 2],
                  [1, 0, 0, 0, 0]
                ] , N, 2, 2), displayBoard(N,0).

v:-winner([[2, 0, 0, 0, 2],
           [1, 1, 1, 0, 0],
           [1, 0, 0, 0, 0],
           [0, 0, 0, 2, 0],
           [0, 0, 0, 0, 2]
          ], 1).