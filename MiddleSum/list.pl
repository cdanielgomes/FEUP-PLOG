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
	middle_sum_list(NewList).
	%labeling([], NewList).

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
 * middle_sum_matrix(+Matrix, Vars)
 *  Solves the given puzzle(Matrix) according to the middle sum rules
 *    and returns the solution matrix (flatten).
 */
middle_sum_matrix(Matrix, Vars):-
	%length(Matrix, Length),
	middle_sum_lists(Matrix, A),
	transpose(Matrix, AuxMatrix1),
	middle_sum_lists(AuxMatrix1,B),
	transpose(A,B),
	flatten(A, Vars),
	domain(Vars, 0, 9),
	labeling([], Vars).




/** 
 *  length_/2
 */
length_(Length, List) :- length(List, Length).

/**
 *  list2matrix(+List, +RowSize, -Matrix)
 * 
 *  Creates a matrix with:
 *   - number rows = length(List)/RowSize
 *   - number cols = RowSize
 */
list2matrix(List, RowSize, Matrix) :-
    length(List, L),
    HowManyRows is L div RowSize,
    length(Matrix, HowManyRows),
    maplist(length_(RowSize), Matrix),
    append(Matrix, List).





b:- write([[0,0,0,0,0,2,0],
	       [0,0,0,9,0,0,0],
	       [5,0,0,0,0,0,0],
	       [0,0,4,0,0,0,0],
	       [0,0,0,0,0,0,8],
	       [0,4,0,0,0,0,0],
	       [0,0,0,0,4,0,0]]).



a:- middle_sum_matrix([[0,0,0,2],
	       [0,9,0,0],
	       [7,0,0,0],
	       [0,0,3,0]], L), list2matrix(L, 4, M), write(M).

t:- middle_sum_matrix([[0,0,0,2],
	       [0,9,0,0],
	       [7,0,0,0],
	       [0,0,3,0]], N), write(N).

e:- middle_sum_list([0,0,0,2], L), write(L).


reload:- reconsult('list.pl').


