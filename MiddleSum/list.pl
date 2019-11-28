:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- include('matrix.pl').


/**
 * flatten(+L, -Flat)
 *   Fails if L is not a list of lists
 */
flatten([], []).
flatten([HList|TList], Flat) :- 
	flatten(TList, Rest),
    append(HList, Rest, Flat), !.

/**
 *	middle_sum_list(-List, +L).
 * 	Generates List of length L that conforms to the rules of the puzzle
 */
middle_sum_list2(List, L):-
	length(List, L),
	domain(List, 0, 9),
	L1 #= L-3,
	count(0,List,#=,L1),
	A #\= 0,
	B #\= 0,
	C #\= 0,
	element(I, List, A),
	I1 #>I,
	I2 #<I,
	element(I1, List, B),
	element(I2, List, C),
	A #= B+C,
	labeling([], List).

/**
 * middle_sum_list(+List).
 *  Checks if List contains exactly 3 digits, 
 *  with the middle number being the sum of the other two
 * 
 */
middle_sum_list(List):-
	length(List, L),
	domain(List, 0, 9),
	L1 #= L-3,
	count(0,List,#=,L1),
	A #\= 0,
	B #\= 0,
	C #\= 0,
	element(I, List, A),
	I1 #>I,
	I2 #<I,
	element(I1, List, B),
	element(I2, List, C),
	A #= B+C.

/**
 *	middle_sum_list2(+List, -NewList).
 * 	Computes puzzle(middleSum) rules in given List and returns the output in NewList.
 */
middle_sum_list(List, NewList):-
	length(List, L),
	length(NewList, L),
	domain(NewList, 0, 9),
	L1 #= L-3,
	count(0,NewList,#=,L1),
	element(I, List, A),
	A #\= 0,
	element(I, NewList, A),
	middle_sum_list(NewList),
	labeling([], NewList).

/**
 * middle_sum_lists(List, NewList)
 * 		Both List and NewList are a list of lists
 * 	 Computes puzzle rules in the lists of given List and returns output in NewList.
 */
middle_sum_lists([], []).
middle_sum_lists([List|T], NewList):-
	middle_sum_lists(T, Extra),
	middle_sum_list(List, N),
	append([N], Extra, NewList).



/**
 *
 * 
 */
middle_sum_matrix(Matrix, Vars):-
	%length(Matrix, Length),
	AuxMatrix = Matrix,
	flatten(AuxMatrix, Vars),
	middle_sum_lists(AuxMatrix, A),
	transpose(AuxMatrix, AuxMatrix1),
	middle_sum_lists(AuxMatrix1,B),
	transpose(A,B),
	domain(Vars, 0, 9),
	labeling([], Vars).

	/*middle_sum_lists(AuxMatrix, M),
	transpose(AuxMatrix, AuxMatrix1),
	transpose(M, M1),
	middle_sum_lists(AuxMatrix1, M1),
	flatten(M, NewMatrix),
	write(M), nl, nl, write(NewMatrix),
	domain(NewMatrix, 0, 9),
	labeling([ffc], NewMatrix).*/





b:- write([[0,0,0,2],
	       [0,9,0,0],
	       [7,0,0,0],
	       [0,0,3,0]]).

a:- middle_sum_matrix([[0,0,0,2],
	       [0,9,0,0],
	       [7,0,0,0],
	       [0,0,3,0]], L), write(L).

t:- middle_sum_matrix([[0,0,0,2],
	       [0,9,0,0],
	       [7,0,0,0],
	       [0,0,3,0]], N), write(N).
reload:- reconsult('list.pl').


%%%%%%%%%%%%%%%%%%%%%%%%%%


create_mat(0, _, []).
create_mat(N0, N, [Zeile|Matrix]) :-
	N0 > 0,
	N1 is N0 - 1,
	length(Zeile, N),
	create_mat(N1, N, Matrix).

sum_row([], _).
sum_row([Row|Matrix], SumDim) :-
	sum(Row, #=, SumDim),
	sum_row(Matrix, SumDim).

diag1([], _, _, []).
diag1([Row|Matrix], Idx, P, [X|ListeDiag]) :-
	nth1(Idx, Row, X),
	Idx1 is Idx+P,
	diag1(Matrix, Idx1, P, ListeDiag).

magic_square_v2(N, Matrix) :-
	Nmax is N * N,
	SumDim is N * (N * N + 1) // 2,
	create_mat(N, N, Matrix),
	flatten(Matrix, Vars),
	domain(Vars,1,Nmax),
	sum_row(Matrix, SumDim),
	transpose(Matrix, TransMat),
	sum_row(TransMat, SumDim),
	diag1(Matrix, N, -1, D1),
	sum(D1, #=, SumDim),
	diag1(Matrix, 1, +1, D2),
	sum(D2, #=, SumDim),
	all_different(Vars).