
:-include('utilities.pl').

printTitle:-
	clearScreen,
write('\t _____  _______  _____             _____  _____  _    _  _______   _  _    '),nl,    
write('\t/ ____||__   __||  __ \\     /\\    |_   _|/ ____|| |  | ||__   __| | || |   '),nl,      
write('\t| (___    | |   | |__) |   /  \\     | | | |  __ | |__| |   | |    | || |_  '),nl,    
write('\t\\___ \\    | |   |  _  /   / /\\ \\    | | | | |_ ||  __  |   | |    |__   _| '),nl,    
write('\t____) |   | |   | | \\ \\  / ____ \\  _| |_| |__| || |  | |   | |       | |   '),nl,    
write('\t|_____/   |_|   |_|  \\_\\/_/    \\_\\|_____|\\_____||_|  |_|   |_|       |_|   '),nl.

%Main menu
mainMenu :-
	clearScreen,
	printTitle,
	printMainMenu,	
    read(In),
    integer(In),
    skip_line,
    choose_option(In).

choose_option(1):-  write('START GAME\n'), playMenu.
choose_option(2):-  write('INFO\n'), info, mainMenu.
choose_option(3):-  write('RULES\n'), rules, mainMenu.
choose_option(4):-  write('EXIT\n').

choose_option(_):- write('Bad Pick bro'), mainMenu.

%Info
info:- 
    clearScreen,
	printTitle,
	write('---------------------------------------------------------------\n'),
	write('---------------------------------------------------------------\n'),
	write('-----                  PLOG  -  2019/2020                 -----\n'),
	write('-----                                                     -----\n'),
	write('-----                                                     -----\n'),
	write('-----       Joao Carlos Alves - up201605236               -----\n'),
	write('-----       Daniel Gomes      - up201603404               -----\n'),
	write('---------------------------------------------------------------\n'),
	getContinue.
 
	
%Play Menu
playMenu:- 
	clearScreen,
	printTitle, 
	printPlayMenu,
    read(In),
    integer(In),
    skip_line,
    choose_type(In).


choose_type(1):-  write('Chose to play Human vs Human\n').
choose_type(2):-  write('Chose to play Human vs Computer\n').
choose_type(3):-  write('Chose to play Computer vs Computer\n').
choose_type(4):-  write('Chose to Go back\n'), mainMenu.

choose_type(_):- write('Bad Pick bro'), playMenu.

printBlackWhite:-
	write('---------------------------------------------------------------\n'),
	write('---------------------------------------------------------------\n'),
	write('-----                    1 - Black                        -----\n'),
	write('-----                    2 - White                        -----\n'),
	write('---------------------------------------------------------------\n').

% prints playMenu
printPlayMenu:- 
	write('---------------------------------------------------------------\n'),
	write('---------------------------------------------------------------\n'),
	write('-----                    1 - MultiPlayer                  -----\n'),
	write('-----                    2 - SinglePlayer                 -----\n'),
	write('-----                    3 - Cp vs Cp                     -----\n'),
	write('-----                    4 - Back                         -----\n'),
	write('---------------------------------------------------------------\n').

%prints mainmenu
printMainMenu:- 
	write('---------------------------------------------------------------\n'),
	write('---------------------------------------------------------------\n'),
	write('-----                    1 - PLAY                         -----\n'),
	write('-----                    2 - INFO                         -----\n'),
	write('-----                    3 - RULES                        -----\n'),
	write('-----                    4 - BACK                         -----\n'),
	write('---------------------------------------------------------------\n').


%Rules --- NEED TO CHANGE RULES
rules:-
	clearScreen,
	printTitle, nl,
	write('\tPente is played on a 19x19 board and the pieces are placed at the intersections of the lines, not the squares.'), nl,
	write('\tThe objective of the game is to place 5 or more pieces consecutively on a vertical, horizontal or diagonal line, or capture at least 5 pairs of opponent\'s pieces.'), nl,
	write('\tEach player can place one piece at any empty intersection per move.'), nl,
	write('\tThe first move of the white has to be in the center of the board - the intersection J10.'), nl,
	write('\tThe second white play must be made at least three intersections away from the J10 center in any direction.'), nl,
	write('\tA player captures the opponent\'s pieces by cornering a vertical, horizontal or diagonal line of two and only two opposing pieces. The captured pieces are immediately removed from the board.\n'), nl,
	getContinue.


reload :- consult('menus.pl').
                                                                           
                                            