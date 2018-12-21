%player(Name, UserName, Age).
:- dynamic played/4.
player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A Player', 16).

%game(Name, Categories, MinAge).
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

%played(Player, Game, HoursPlayed, PercentUnlocked)
played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).



achievedLittle(Player):-
played(Player, _, _, A),
A < 10.

isAgeAppropriate(Name, Game):-
player(Name, _, Age),
game(Game, _, AP),
Age >= AP.

sumList(Lista, Soma):-
    sumList(Lista, 0, Soma).

sumList([], Counter, Soma):- Counter = Soma.

sumList([H|T], Counter, Soma):-
    Soma1 is Counter + H,
    sumList(T, Soma1, Soma).

timePlay(_,[],[]).
timePlay(Player, [H|T], [Hours|Kapa]):-
    played(Player, H, Hours, _),
    timePlay(Player, T, Kapa).


timePlayingGames(Player, Games, ListOfTimes, SumTimes):-
   timePlay(Player, Games, ListOfTimes),!,
   ListOfTimes \= [],
   sumList(ListOfTimes, 0, SumTimes).


timePlayingGames(_, _, ListOfTimes, SumTimes):-
ListOfTimes = [0],
sumList(ListOfTimes, 0, SumTimes).




listGamesOfCategory(Cat):-
game(Game, List, Age),
member(Cat, List),
write(Game), write(' ('), write(Age), write(')'), nl, fail.

listGamesOfCategory(_).

updatePlayer(Player, Game, Hours, Percentage):-
    played(Player, Game, Hour, Per),
    Nhour is Hour + Hours, 
    Nper is Per + Percentage, 
    retract(played(Player, Game, Hour, Per)),
    assert(played(Player, Game, Nhour, Nper)).
    



littleAchievement(Player, Games):-
    littleAchievement(Player, Games, []).

littleAchievement(Player, Games, Aux):-
    played(Player, Game, _, Percentage),
    Percentage < 20,
    \+ member(Game, Aux),
    littleAchievement(Player, Games, [Game|Aux]),!.

littleAchievement(_, Games, Games).

ageRange(MinAge, MaxAge, Players):-
    findall(Name,(player(Name, _,Age), Age >= MinAge, Age =< MaxAge),Players).


media(Lista, Media):-
    sumList(Lista, A),
    length(Lista, B),
    Media is A/B.

averageAge(Game, AverageAge):-
    findall(Age, (player(_, A, Age), played(A, Game,_,_)), List),
    media(List, AverageAge).


mostEffectivePlayers(Game, Players):-
    findall(Id,(played(Id, Game, Hour, Per), played(Id2, Game, Hour2, Per2), Per/Hour >= Per2/Hour2, Id\=Id2), Players).
    