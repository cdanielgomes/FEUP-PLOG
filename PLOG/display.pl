

% Display game
% +[L|T] - current board game
%  +[H|C] - current result
display_board([L|T], [H|C]):-
	length(L,Size),
	write(' '),
	print_col_id(Size, 1),nl,
	put_code(9487),
	print_top_Board(Size),
	put_code(9491), nl,
	print_Lines([L|T], Size, 1),
	put_code(9495),
	print_bot_Board(Size),
	put_code(9499),
	jogador_1(H),
	jogador_2(C).


print_cell(0):- put_code(9547).	% symbol for intersection without piece
print_cell(2):- put_code(9675). % symbol for white piece
print_cell(1):- put_code(9679). % symbol for black piece


% Printing the columns indexes
%print the id of the columns
print_col_id(0, _).
print_col_id(Size, Counter):-
	Column is 0x0040 + Counter,
	put_code(Column),
	Counter1 is Counter + 1,
	Size1 is Size - 1,
	print_col_id(Size1, Counter1).




% Prints the top of the board
print_top_Board(0).
print_top_Board(Size):-
	put_code(9523),
	Size1 is Size-1,
	print_top_Board(Size1).

% Recursive call for printing lines
print_Lines([],_,_).
print_Lines([C|L], Size, Counter):-
	put_code(9507),
	print_line_Board(C, Size),
	put_code(9515), write(Counter),nl,
	Counter2 is Counter + 1,
	print_Lines(L, Size, Counter2).

% Print line
print_line_Board([],0).
print_line_Board([C|L],Size):-
	print_cell(C),
	Size1 is Size -1,
	print_line_Board(L,Size1).

%Prints the bot of the board
print_bot_Board(0).
print_bot_Board(Size):-
	put_code(9531),
	Size1 is Size-1,
	print_bot_Board(Size1).

% Both black and white captured pieces
jogador_1(L):- L<10,nl, write('Player '), print_cell(1), write(' already captured '), write(L), print_cell(2), write('\n'); nl,nl,L=:=10, write('Player '), print_cell(1) , write(' won\n').    
jogador_2([L|_]):-L<10, write('Player '), print_cell(2), write(' already captured '), write(L), print_cell(1), write('\n');nl,nl, L=:=10, write('Player '), print_cell(2) , write(' won\n').    





printPenteTitle:-
	clearScreen,
	write('       _______  _______  _       _________ _______ '), nl,
	write('      (  ____ )(  ____ \\( (    /|\\__   __/(  ____ \\'), nl,
	write('      | (    )|| (    \\/|  \\  ( |   ) (   | (    \\/'), nl,
	write('      | (____)|| (__    |   \\ | |   | |   | (__    '), nl,
	write('      |  _____)|  __)   | (\\ \\) |   | |   |  __)   '), nl,
	write('      | (      | (      | | \\   |   | |   | (      '), nl,
	write('      | )      | (____/\\| )  \\  |   | |   | (____/\\ '), nl,
	write('      |/       (_______/|/    )_)   )_(   (_______/'), nl,
	write('                                                   '), nl.

won(Type):-
	printWon(Type).

printWon(2):-
	nl, write('\t'), put_code(9711) , write('\tWON THE GAME !!!\n').

printWon(1):-
	nl, write('\t'), put_code(11044) , write('\tWON THE GAME !!!\n').







inicial:- display_board([
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,1,2,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	], [0, 0]).

mid:- display_board([
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,2,0,1,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0],
	[0,0,0,1,2,2,2,2,1,1,0,2,0,0,0,0,0,0,0],
	[0,0,1,0,0,1,1,0,1,2,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,2,0,0,2,2,1,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,1,0,1,2,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,2,2,2,1,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]	
	], [6, 8]).

end1:- display_board([
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,2,0,1,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0],
	[0,0,0,1,2,2,2,2,1,1,0,2,0,0,0,0,0,0,0],
	[0,0,1,0,0,1,1,0,1,2,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,2,0,0,2,2,1,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,1,0,1,2,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,2,2,2,1,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]	
	], [6, 8]).

end2:- display_board([
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,2,0,1,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0],
	[0,0,0,1,2,2,2,2,0,0,2,2,0,0,0,0,0,0,0],
	[0,0,1,0,0,1,1,0,1,2,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,2,0,0,2,2,1,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,1,0,1,2,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,2,2,2,1,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	], [6, 10]).