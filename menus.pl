
mainMenu :-
	clearScreen,
	printPenteTitle,
	printMainMenu,
	get_char(In),
	(
		In = '1' -> write('START GAME\n'), playMenu;
		In = '2' -> write('INFO\n'), infoMenu;
		In = '3' -> write('RULES\n'), rules;
		In = '4' -> write('EXIT\n');
	
		mainMenu
	).



infoMenu:- 
		clearScreen,
		printPenteTitle, 
		printMenuInfo, 
		get_char(_), 
		get_char(_), 
		mainMenu.

playMenu:- 
	clearScreen,
	printPenteTitle, 
	printPlayMenu,
	get_char(_),  	
	get_char(In), 
	(
		In = '1' -> write('Chose to play Human vs Human\n'), startGame(playerMove, playerMove) ;
		In = '2' -> write('Chose to play Human vs Computer\n'), playMenu;
		In = '3' -> write('Chose to play Computer vs Computer\n'), playMenu;
		In = '4' -> write('Chose to Go back\n'), mainMenu;
		
		playMenu
	).


printPlayMenu:- 
	write('---------------------------------------------------------------\n'),
	write('---------------------------------------------------------------\n'),
	write('-----                    1 - MultiPlayer                  -----\n'),
	write('-----                    2 - SinglePlayer                 -----\n'),
	write('-----                    3 - Cp vs Cp                     -----\n'),
	write('-----                    4 - Back                         -----\n'),
	write('---------------------------------------------------------------\n').

printMainMenu:- 
	write('---------------------------------------------------------------\n'),
	write('---------------------------------------------------------------\n'),
	write('-----                    1 - PLAY                         -----\n'),
	write('-----                    2 - INFO                         -----\n'),
	write('-----                    3 - RULES                        -----\n'),
	write('-----                    4 - BACK                         -----\n'),
	write('---------------------------------------------------------------\n').

printMenuInfo:- write('one day\n').
rules:- write('another day\n').