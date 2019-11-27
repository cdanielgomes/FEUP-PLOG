:- use_module(library(lists)).


/**
 *	matrix_lists(+Matrix, -Lists).
 * 		Fetches all the rows and columns of the given Matrix
 * 		combining them in a list.
 */
matrix_to_lists(Matrix, Lists):-
	transpose(Matrix, Transpose),
	append([Matrix, Transpose], Lists).

/**
 * matrix_lists(+Matrix, -Rows, -Cols)
 * 	Gets all rows and all columns in lists (Rows and Cols)
 */
matrix_to_lists(Matrix, Rows, Cols):-
	transpose(Matrix, Transpose),
	append([Matrix], Rows),
	append([Transpose], Cols).

/**
 *
 *	matrix_map/3
 *	Like map/3 but for a matrix
 * 
 */
matrix_map(P, MatrixA, MatrixB):-
	(	foreach(ARow, MatrixA),
		foreach(BRow, MatrixB),
		param(P)

	do (	foreach(A, ARow),
			foreach(B, BRow),
			param(P)
		do call(P, A, B)

		)

	).


/**
 * 	matrix_select_row/3
 * 	Select Row from Matrix (using nth1 convention)
 */
matrix_select_row(R, Matrix, Row):-
	nth1(R, Matrix, Row), !.


/**
 * 	matrix_select_col/3
 * 	Select Col from Matrix (using nth1 convention)
 */
matrix_select_col(C, Matrix, Col):-
	transpose(Matrix, Transpose),
	nth1(C, Transpose, Col), !.