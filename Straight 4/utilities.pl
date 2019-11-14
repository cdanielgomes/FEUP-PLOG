% new lines to simulate console clear
clearScreen:-
	clearScreen(10).
clearScreen(0).

% print new lines
clearScreen(A) :-
	nl,
	A1 is A - 1,
	clearScreen(A1).

%changes player
changePlayer(black, white).
changePlayer(white, black).
changePlayer(1, 2).
changePlayer(2, 1).
%Number of pieces each player start with
startingPieces(4).



%% Size = Size of the Board 
%% Board - return of the board  
createEmptyBoard(Size, Board):-  
    create_line(0, Size, A), 
    length(Board, Size), 
    maplist(=(A), Board). 

create_line(X, N, List)  :- 
    length(List, N), 
    maplist(=(X), List).


removeFromBag(2, [_,0], [_,0]).
removeFromBag(1, [0,_], [0,_]).
removeFromBag(1 , [Blacks, _Whites], R):-
	NewBlacks is Blacks - 1,
	append([NewBlacks], [_Whites], R).

removeFromBag(2 , [_Blacks, Whites], R):-
	NewWhites is Whites - 1,
	append([_Blacks], [NewWhites], R).