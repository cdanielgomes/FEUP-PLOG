		
reload:-
	reconsult('QCas.pl').

%% pessoa(nome, id, [proxNoivo|proxNoiva], [lista de intereresses]).
%% [[pessoas que ficam juntas]]
%% niveis de proximidade: 
/**
 *  1 - familia;
 *  2 - amigosProximos;
 *  3 - conhecidos;
 *  4 - desconhecidos;
 * 
*/
:- use_module(library(clpfd)).
:- use_module(library(random)).
:- use_module(library(lists)).

pessoa("joao", 1, [1,0], [jogos]).
pessoa("mae noivo",2, [1,0], [revistas,trabalho]).
pessoa("pai noivo", 3, [1,0], [futebol]).
pessoa("irmao noivo", 4, [1,0], [jogos]).
pessoa("irmao mais novo", 5, [1, 0], [eucaristia]).
pessoa("tio joao", 6, [1,0], [pornografia]).
pessoa("tia maria", 7, [1,0], [cozinhar]).
pessoa("primo antonio", 8, [1,0], []).
pessoa("primo Acacio", 9, [1,0], [praxe]).
pessoa("tia Daniela", 10, [1,0], [trabalho]).
pessoa("tio Daniel", 11, [1,0], []).
pessoa("tio Gaspar", 12, [1,0], [loica]).
pessoa("tia Lice", 13, [1,0], [trabalho]).
pessoa("tia andreia", 14, [1,0], [cusquice]).
pessoa("tio lino", 15, [1,0], [publicacoes]).
pessoa("primo cavalo", 16, [1,0], []).
pessoa("Pintinho", 17, [2,0], []).
pessoa("Padeilinha", 18, [2,0],[]).
pessoa("ROtundas", 19, [2,0], [praxe]).
pessoa("Mamacio", 20, [2,0],[]).
pessoa("Rute", 21, [2,0], [comer]).
pessoa("imdb", 22, [2,0], [lolada]).
pessoa("sima", 23, [2,0], [store]).
pessoa("gajo a serio", 24, [2,0], [whiskey]).
pessoa("chupa chupa", 25, [2,0], [whiskey]).
pessoa("ines", 26, [2,0], [whiskey]).
pessoa("Mae noiva", 27,[0,1], [whiskey]).
pessoa("Pai noivo", 28,  [0,1], [cola]).
pessoa("irmao noiva", 29, [0,1], [olq]).
pessoa("irma noiva", 30, [0,1], [olq]).
pessoa("cunhado1", 31, [0,1], [talvez]).
pessoa("tia1", 32, [0,1], [lol]).
pessoa("tio1", 33, [0,1], [ok]).
pessoa("tio2", 34, [0,1], [okapa]).
pessoa("tia2", 35, [0,1], [revistas]).
pessoa("tia3", 36, [0,1], [maybe]).
pessoa("tio3", 37, [0,1], [ams]).
pessoa("tia4", 38, [0,1], [ok]).
pessoa("tio4", 39, [0,1], [okoksdo]).
pessoa("tio5", 40, [0,1], []).
pessoa("tia5", 41, [0,1], []).
pessoa("Nuno", 42, [0,2], []).
pessoa("Nuna", 43, [0,2], []).
pessoa("solteirao", 44,[0,2],[]).
pessoa("amigo1", 45, [0,2],[]).
pessoa("amigo2", 46,[0,2],[]).
pessoa("amigos3", 47, [0,2],[]).
pessoa("amigos4", 48, [0,2],[]).
pessoa("amigos5", 49, [0,2],[]).
pessoa("amigos6", 50, [0,2],[]).
pessoa("amigos7", 51, [0,2],[]).
pessoa("amigo8", 52, [0,2], []).
pessoa("amigo9", 53, [0,2], []).
pessoa("amigo10", 54, [0,2], []).
pessoa("amigo11", 55, [0,2], []).
pessoa("amigo13", 56, [0,2], []).
pessoa("amigo14", 57, [0,2],[]).

amizade(1,2).
amizade(1,3).
amizade(1,6).
amizade(2,5).
amizade(2,6).
amizade(2,4).
amizade(2,5).
amizade(3,1).
amizade(3,4).
amizade(4,3).
amizade(4,5).
amizade(6,1).
amizade(6,2).
amizade(5,4).

generateRandomList(0, OutputList).
generateRandomList(NConvidados, [H|T]):-
    NConvidados > 0,
    random(1,5,A), 
    H = A,
    N is NConvidados - 1,
    generateRandomList(N, T).


casado(2,3).
casado(3,2).
casado(6,7).

quintinha(Table):-
		length(Table, 5),
		domain(Table, 1, 10),
		all_distinct(Table),
		findall(N, countFriends(_ , Table, N), All),
		maximize(sum(All, #=, Total),Total), write(Total),
		labeling([], Table).


countFriendsForAll([],[_], Final, Final).
countFriendsForAll([H|T],L, Result, Final):-
	countFriends(H, L, R),
	Result1 is Result + R,
	countFriendsForAll(T, L, Result1, Final).

countFriends(_, [], 0).
countFriends(E, [H|T], N):-
	(( amizade(E,H) , I is 1) ;
		(\+ amizade(E,H) ,I is 0)),
	 I #= 1 #<=> B,
	countFriends(E, T, M),
	N #= M+B.

teste:- countFriends(1, [1,2,3,4,5,6,7,8,9,10], R),
		write(R).


entrypoint(NG):-
    Range in 8..12, generateRandomList(NG, ListOfIds),
    mesas(NG, Range, Mesas), length(Mesas,A), solve(Mesas, ListOfIdsm, A), flattenList(Mesas, R), all_distinct(R), labeling([], R), write(R).
	 


mesas(NG, Range, Mesas) :- 
   NMesas #= NG / Range,
   createList(NMesas, Mesas, Range).
    
solve(_,_,0).
solve(Mesas, ListOfIds, Count):-
	Count > 0,
	nth1(Count, Mesas, Mesa),
	perlist(Mesa, ListOfIds),
	Count1 is Count -1,
	solve(Mesas, ListOfIds, Count1).

perlist(Mesa, ListOfIds):-
	length(Mesa, A), Chair in 1..A,
	Chair2 in 1..A,
	element(Chair, Mesa, Person),
	element(Chair2, Mesa, Person2),
	length(ListOfIds, B), IndexID1 in 1..B, IndexID2 in 1..B,
	element(IndexID1, ListOfIds, Pr),
	element(IndexID2, ListOfIds, Pr1),
	IndexID1 #\= IndexID2,
	Pr #= Pr1, Person #= IndexID1, Person2 = IndexID2.

createList(0, List, _).
createList(N, [A|B], Range):-
    length(C, Range),
    A = C, 
    N1 is N -1,
    createList(N1, B, Range).

flattenList([], []).
flattenList([Line | List], Result):-
	is_list(Line), flattenList(Line, Result2), append(Result2, Tmp, Result), flattenList(List, Tmp).
flattenList([Line | List], [Line | Result]):-
	\+is_list(Line), flattenList(List, Result).