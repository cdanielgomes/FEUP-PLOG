%Prints Menu
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

%Prints Game Options
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

%Prints Ai Difficulty
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


%Prints Game Rules
rules:- printGameTitle,
	write('RULES: '), nl,
	write('\tThe game uses a board like GoRoGo board where the players'), nl, 
	write('\tcan put their pieces on the intersections.'), nl,
	write('\tThe game has very very simple rules with 2 phases: Positioning'),nl,
	write('\tand Moving.'), nl,
	write('    Positioning:'), nl,
	write('\tEach player starts with 4 pieces and they have to put them all'), nl,
	write('\talternately in the intersections of the board before advance to'), nl,
	write('\tthe next phase.'),nl,
	write('    Moving:'), nl,
	write('\tHaving each player placed 4 pieces on the board. They can now move them,'),nl,
	write('\tone piece per round, in order to get a straight line of 4 pieces.'),nl,
	write('    Win:'), nl,
	write('\tThere is only one way to win, same for White and Black: form an unbroken'),nl,
	write('\tchain of 4 consecutive friendly stones - vertically, horizontally'),nl,
	write('\tor diagonally.'), nl,nl,
	getEnter.


%----main menu handler
homeMenuHandler:-
	homeMenu,
	getInt(Option),
	homeMenuOption(Option), !.

homeMenuOption(1):-
	gameMenuHandler.

homeMenuOption(2):-
	rules,
	homeMenuHandler,!.

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
	gameMenuHandler, !.

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
