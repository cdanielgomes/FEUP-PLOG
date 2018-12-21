:- dynamic film/4.

%filme(Title,Categories,Duration,AvgClassification)
film('Doctor Strange',[action, adventure, fantasy],115,7.6).
film('Hacksaw Ridge',[biography, drama, romance], 131, 8.7).
film('Inferno', [action, adventure, crime], 121, 6.4).
film('Arrival', [drama, mystery, scifi], 116, 8.5).
film('The Accountant', [action, crime, drama], 127, 7.6).
film('The Girl on the Train', [drama, mystery,thriller], 112, 6.7).

%user(Username, YearOfBirth, Country)
user(john, 1992, 'USA').
user(jack, 1989, 'UK').
user(peter, 1983, 'Portugal').
user(harry, 1993, 'USA').
user(richard, 1982, 'USA').

%vote(Username, List_of_Film-Rating)

vote(john, ['Inferno'-7, 'Doctor Strange'-9, 'The Accountant'-6]).
vote(jack, ['Inferno'-8, 'Doctor Strange'-8, 'The Accountant'-7]).
vote(peter, ['The Accountant'-4, 'Hacksaw Ridge'-7, 'The Girl on the Train'-3]).
vote(harry, ['Inferno'-7, 'The Accountant'-6]).
vote(richard, ['Inferno'-10, 'Hacksaw Ridge'-10, 'Arrival'-9]).



curto(Movie):-
    film(Movie,_,Duration,_),
    Duration < 125.
/*
nth1(1, [H|T], H).
nth1(N, [H|T], Elem):-
    nth1(OldN, T, Elem),
    N is OldN + 1.
*/
findVote(Films, Film, Vote):-
    nth1(Index, Films, Film-Vote).

diff(User1, User2, Difference, Film):-
    vote(User1, Films1),
    vote(User2, Films2),
    findVote(Films1, Film, Vote1),
    findVote(Films2, Film, Vote2),
    A is Vote1-Vote2,
    Difference is abs(A).


niceGuy(User):-
    vote(User, M),
    member(Film-Vote, M),
    member(Film1-Vote1, M),
    Vote >= 8, 
    Vote1 >= 8.


comum([], _, C,C).
comum([H|T], Lista2, Aux, Comum):-
    member(H, Lista2),
    append(Aux, [H], N),
    comum(T, Lista2, N, Comum).

comum([H|T], Lista2, N, Comum):-
    comum(T, Lista2, N, Comum).

elemsComuns(List1, Common,List2):-
    comum(List1, List2, [], Common),!.




printCategory(Category):-
    film(Name, Categories, Duration, Score),
    member(Category, Categories),
write(Name), write(' ('), write(Duration), write('min, '),
write(Score), write('/10'),write(')\n'), fail.
printCategory(Category).



total(Cat1, Cat2, Per):-
    elemsComuns(Cat1,Comum, Cat2),
    length(Cat1, Int),
    length(Comum, Int3),
    length(Cat2, Int2),
    Total is Int + Int2 - Int3,
    Per is Int3/Total * 100.

similarity(Film1, Film2, Similarity):-
    film(Film1, Cat1, Dur1, Class1),
    film(Film2, Cat2, Dur2, Class2),
    total(Cat1, Cat2, Per),
    DurDiffAux is Dur1-Dur2,
    DurDiff is abs(DurDiffAux),
    ScoreDiffAux is Class1-Class2,
    ScoreDiff is abs(ScoreDiffAux),
    Similarity is Per - (3*DurDiff) - (5*ScoreDiff).

:- use_module(library(lists)).

mostSimilar(Film, Similarity, Films):-
    findall(Similarity-Film2, (film(Film, _,_,_), film(Film2,_,_,_), Film\=Film2 , similarity(Film, Film2, Similarity)), FilmsAuxs),
    findall(Similarity, max_member(Similarity-F, FilmsAuxs), [Similarity|_]),
    findall(F, max_member(Similarity-F, FilmsAuxs), Films).


avg(Lista, Sum):-
    sumlist(Lista, Soma),
    length(Lista, N),
    Sum is Soma/N.
    
equal(A,B, C):-
    A = B, 
    C is 0.
equal(_, _, C):-
    C is 2.

distancia(User1, Distancia, User2):-
    user(User1, Year1, Country1),
    user(User2, Year2, Country2),
    vote(User1, List1),
    vote(User2, List2),
    findall(Diff, (member(Film-Vote1, List1), member(Film-Vote2, List2), Diff is abs(Vote1 - Vote2) ), Output),
    avg(Output, AvgDiff),
    AgeDiff is (Year1 - Year2)/3,
    equal(Country1, Country2, CountryDiff),
    Distancia is AvgDiff + AgeDiff + CountryDiff.


update(Film):-
    findall(Vote, (vote(_, Lista), member(Film-Vote, Lista)), Votes),
    avg(Votes, AVG),
    retract(film(Film, A,B,_)),
    assert(film(Film, A, B, AVG)).
    
    
behindBoard(R,C):-
    R>=1, R=<8,
    C>=1, C=<8.

possibleMoves(R, C, NR, NC):-
    NR is R + 2,
    NC is C + 1,
    behindBoard(NR, NC). 

possibleMoves(R, C, NR, NC):-
    NR is R + 2,
    NC is C - 1,
    behindBoard(NR, NC). 

possibleMoves(R, C, NR, NC):-
    NR is R - 2,
    NC is C + 1,
    behindBoard(NR, NC). 


possibleMoves(R, C, NR, NC):-
    NR is R - 2,
    NC is C - 1,
    behindBoard(NR, NC). 

move(Linha/Coluna, Celulas):-
    findall(NL/NC, possibleMoves(Linha, Coluna, NL, NC), Cell1),
    findall(NL/NC, possibleMoves(Coluna, Linha, NC, NL), Cell2),
    append(Cell2, Cell1, Celulas).

/*
podeMover(Move, N, C, Celulas):-
    N > 0,
    move(Move, Cell),
    append(C, Cell, A),
    N1 is N -1,
    podeMover(A, N1, A, Celulas).

append1([], _,A.
append1([A|B], Aux, C1):-
    append(Aux,A,C1),
    append1(B, C1, C1).

podeMover(_, 0, _ , Cell)
podeMover(Cells, N, _, C):-
    findall(Move, (member(Cells, M), move(M, Move)), [A|B]),
    N1 is N -1,
    findall(A, append(A, C, B), ),
    sort(B, Lista),
    podeMover(Lista, N1)    .

*/