:-use_module(library(clpfd)).

ms3:- Vars=[A1,A2,A3,B1,B2,B3,C1,C2,C3], domain(Vars, 1,9),
	A1+A2+A3 #= S,
	B1 +B2 + B3 #= S,
	C1 +C2+C3 #= S,
	A1 + B1 + C1 #= S,
	A2 +B2 + C2 #= S,
	A3 + B3 + C3 #= S,
	A1 + B2 + C3 #= S,
	A3 + B2 + C1 #= S,
	all_distinct(Vars),
	labeling([], Vars), write(Vars).