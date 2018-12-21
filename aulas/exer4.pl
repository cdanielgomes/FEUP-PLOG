:-use_module(library(clpfd)).


puzzle1:- 
	Vars=[D,O,N,A,L,G,E,R,B,T],
	Cs = [C1, C2, C3, C4, C5, C6],
	domain(Vars, 0,9),
	domain(Cs, 1, 0),
	all_different(Vars),
	D + D #= T + 10*C1,
	L + L + C1 #= R+ 10*C2,
	A + A + C2 #= C3*10 + E,
	N + R + C3 #= C4*10 + B,
	O + E + C4 #= C5*10 + O,
	D + G + C5 #= C6*10 + R,  
	labeling([], Vars), write(Vars).


puzzle(1,[D,O,N,A,L,D],
		 [G,E,R,A,L,D],
		 [R,O,B,E,R,T]).