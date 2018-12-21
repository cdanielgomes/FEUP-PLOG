:-use_module(library(clpfd)).

peru:- Vars=[A,B],
		domain(Vars, 0, 9),
		
		A * 1000 #= S,
		S + 600 + 70 + B #= N,
		K * 72 #= N,
		labeling([], Vars), write(Vars), nl, write(K).