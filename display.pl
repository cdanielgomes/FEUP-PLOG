display_board([L|T], [H|C]):-
	length(L,Size),
	print_horizontal_numbers(Size, 1), nl,
	print_tab([L|T],Size,1),
	print_barras(Size),
	jogador_1(H),
	jogador_2(C).


print_tab([], _, _).
print_tab([L|T],Size, Counter):-
	print_barras(Size), nl,
	print_line(L,0), 
	write('- '), 
	write(Counter), nl,
	Counter1 is Counter + 1,
	print_tab(T, Size, Counter1).

print_line([],_).
print_line([C|L], Counter):-
	write('- '),
	print_cell(C),
	Counter1 is (Counter+1),
	print_line(L,Counter1).

print_cell(0):- write(' ').
print_cell(2):- put_code(9675). 
print_cell(1):- put_code(9679). %! white


print_barras(0).
print_barras(Size):-
	write('  |'),
	Size1 is Size-1,
	print_barras(Size1).

print_horizontal_numbers(0, _).
print_horizontal_numbers(Size, Counter):-
	write('  '),
	Column is 0x0040 + Counter,
	put_code(Column),
	Counter1 is Counter + 1,
	Size1 is Size - 1,
	print_horizontal_numbers(Size1, Counter1).

jogador_1(L):- L<10,nl,nl, write('Player '), print_cell(1), write(' already captured '), write(L), print_cell(2), write('\n'); nl,nl,L=:=10, write('Player '), print_cell(1) , write(' won\n').    
jogador_2([L|_]):-L<10, nl,nl, write('Player '), print_cell(2), write(' already captured '), write(L), print_cell(1), write('\n');nl,nl, L=:=10, write('Player '), print_cell(2) , write(' won\n').    



inicial:- display_board([
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
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