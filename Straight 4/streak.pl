%Combinations of streaks of 4
streak(4, [_,X,X,X,X], X, 610).
streak(4, [X,X,X,X,_], X, 610).
%for diagonals with 4 slots
streak(4, [X,X,X,X], X, 610).

%Combinations of streaks of 3
streak(3, [_,0,X,X,X], X, 89).
streak(3, [0,X,X,X,0], X, 233).
streak(3, [0,X,X,X,_], X, 89).
streak(3, [_,X,X,X,0], X, 89).
streak(3, [X,X,X,0,_], X, 89).
%for diagonals with 4 slots
streak(3, [X,X,X,0], X, 89).
streak(3, [0,X,X,X], X, 89).

%Combinations of streaks of 2
streak(2, [_,_,0,X,X], X, 13).
streak(2, [_,0,X,X,0], X, 34).
streak(2, [_,0,X,X,_], X, 13).
streak(2, [_,_,X,X,0], X, 13).
streak(2, [0,X,X,0,_], X, 34).
streak(2, [0,X,X,_,_], X, 13).
streak(2, [_,X,X,0,X], X, 55).
streak(2, [_,X,X,0,_], X, 13).
streak(2, [X,X,0,X,_], X, 55).
streak(2, [X,X,0,_,_], X, 13).

%for diagonals with 4 slots
streak(2, [X,X,0,_], X, 13).
streak(2, [0,X,X,0], X, 34).
streak(2, [0,X,X,_], X, 13).
streak(2, [_,0,X,X], X, 13).

	