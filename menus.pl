clearScreen :-
	printBlank(4).
	
printBlank(A) :-
	A > 0,
	nl,
	A1 is A - 1,
	printBlank(A1).
	
printBlank(_).

mainMenu :-
	clearScreen,
	printMainMenu,
	get_char(In),
	(
		In = '1' -> write('Chose to play\n'), playMenu;
		In = '2' -> write('Chose Info\n'), infoMenu;
		In = '3' -> write('Rules\n'), rules;
		In = '4' -> write('Chose Exit\n');
	
		mainMenu
	).

	infoMenu:- clearScreen, printMenuInfo, get_char(_) , get_char(_), mainMenu.
	playMenu:- clearScreen, printPlayMenu, get_char(In), get_char(_),
	(
		In = '1' -> write('Chose to play Human vs Human\n'), hxh, mainMenu;
		In = '2' -> write('Chose to play Human vs Computer\n'), mainMenu;
		In = '3' -> write('Chose to play Computer vs Computer\n'), mainMenu;
		In = '4' -> write('Chose to Go back\n'), mainMenu;
		
		playMenu
	).


	printPlayMenu:- 
	write('---------------------------------------------------------------\n'),
	write('------------------------   PENTE   ----------------------------\n'),
	write('---------------------------------------------------------------\n'),
	write('-----                    1 - HXH                          -----\n'),
	write('-----                    2 - HxC                          -----\n'),
	write('-----                    3 - CxC                          -----\n'),
	write('-----                    4 - Back                         -----\n'),
	write('---------------------------------------------------------------\n').

printMainMenu:- 
	write('---------------------------------------------------------------\n'),
	write('------------------------   PENTE   ----------------------------\n'),
	write('---------------------------------------------------------------\n'),
	write('-----                    1 - PLAY                         -----\n'),
	write('-----                    2 - INFO                         -----\n'),
	write('-----                    3 - RULES                        -----\n'),
	write('-----                    4 - Back                         -----\n'),
	write('---------------------------------------------------------------\n').

printMenuInfo:- write('one day\n').
rules:- write('another day\n').