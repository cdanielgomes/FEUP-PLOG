homeMenu:-
	printGameTitle,
	write('\t\t+-------------------------------------+'),nl,
	write('\t\t|                MENU                 |'),nl,
	write('\t\t+-------------------------------------+'),nl,
	write('\t\t|           1) PLAY                   |'),nl,
	write('\t\t|           2) RULES                  |'),nl,
	write('\t\t|           3) EXIT                   |'),nl,
	write('\t\t+-------------------------------------+'),nl,nl,
	write('Choose your prefered option : ').

gameMenu:-
	printGameTitle,
	write('\t\t+-------------------------------------+'),nl,
	write('\t\t|               GAME MENU             |'),nl,
	write('\t\t+-------------------------------------+'),nl,
	write('\t\t|           1) MULTIPLAYER            |'),nl,
	write('\t\t|           2) SINGLEPLAYER           |'),nl,
	write('\t\t|           3) CP vs CP               |'),nl,
	write('\t\t|           4) BACK                   |'),nl,
	write('\t\t+-------------------------------------+'),nl,nl,
	write('Choose your prefered option : ').

cpMenu:-
	printGameTitle,
	write('\t\t+-------------------------------------+'),nl,
	write('\t\t|               CP MENU               |'),nl,
	write('\t\t+-------------------------------------+'),nl,
	write('\t\t|           1) EASY                   |'),nl,
	write('\t\t|           2) HARD                   |'),nl,
	write('\t\t|           3) BACK                   |'),nl,
	write('\t\t+-------------------------------------+'),nl,nl,
	write('Choose your prefered option : ').


%----main menu handler
homeMenuHandler:-
	homeMenu,
	getInt(Option),
	homeMenuOption(Option), !.

homeMenuOption(1):-
	gameMenuHandler.
/*homeMenuOption(2):-
	gameMenu.*/
homeMenuOption(3).
homeMenuOption(_):-
	invalidInput,
	homeMenuHandler, !.

%----game menu handler -> user choose game mode							
gameMenuHandler:-                   
	gameMenu,                       
	getInt(Option),
	gameMenuOption(Option).

gameMenuOption(1):-
	clearScreen,
	startGame(human, human), !,
	homeMenuHandler.

gameMenuOption(2):-
	singleMenuHandler.

gameMenuOption(3):-
	cpMenuHandler.

gameMenuOption(4):-
	homeMenuHandler.

gameMenuOption(_):-
	invalidInput,
	homeMenuHandler, !.

%---ai menu handler -> user choose ai mode

singleMenuHandler:-
	cpMenu,
	getInt(Option),
	singleMenuOption(Option).

singleMenuOption(1):-
	clearScreen,
	startGame(human, randomPlay), !,
	homeMenuHandler.

singleMenuOption(2):-
	clearScreen,
	startGame(human, smartPlay), !,
	homeMenuHandler.

singleMenuOption(3):-
	gameMenuHandler.

singleMenuOption(_):-
	invalidInput,
	singleMenuHandler, !.


%--- ai vs ai menu handler 
cpMenuHandler:-
	cpMenu,
	getInt(Option),
	cpMenuOption(Option).

cpMenuOption(1):-
	clearScreen,
	startGame(randomPlay, randomPlay), !,
	homeMenuHandler.

cpMenuOption(2):-
	clearScreen,
	startGame(smartPlay, smartPlay), !,
	homeMenuHandler.

cpMenuOption(3):-
	gameMenuHandler.

cpMenuOption(_):-
	invalidInput,
	cpMenuHandler, !.
