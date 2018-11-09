clearScreen :-
	printBlank(65).
	
printBlank(A) :-
	A > 0,
	nl,
	A1 is A - 1,
	printBlank(A1).
	
printBlank(_).

mainMenu :-
	clearScreen,
	printMainMenu,
	getChar(In),
	(
		In = '1' -> write('Chose to play\n'), playMenu;
		In = '2' -> write('Chose Info\n'), infoMenu;
		In = '3' -> write('Rules'), rules;
		In = '4' -> write('Chose Exit\n');
	
		mainMenu
	).

	infoMenu:- clearScreen, printMenuInfo, get_char(_), mainMenu.
	playMenu:- clearScreen, printPlayMeny, getChar(In),
	(
		In = '1' -> write('Chose to play Human vs Human\n'), startHumanVsHuman, playMenu;
		In = '2' -> write('Chose to play Human vs PC\n'), playMenu;
		In = '3' -> write('Chose to play PC vs PC\n'), playMenu;
		In = '4' -> write('Chose to Go back\n'), mainMenu;
		
		playMenu
	).