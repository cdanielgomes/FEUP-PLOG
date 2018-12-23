
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
:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(random)).
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
pessoa("amigo14", 57, [0,2], []).
number(57).
together([[1,2,3,4],[6,7], [10,11], [12,13], [14,15], [17,21], [23,24], [25,26],[27,28,29,30,31],[30,31],[32,33],[34,35],[36,37],[38,39],[40,41],[42,43]]).


generateRandomList(0, OutputList).
generateRandomList(NConvidados, [H|T]):-
    NConvidados > 0,
    random(0,3,A), 
    random(0,1,Noivo),
    C = Noivo-A,
    H = [NConvidados, C, []],
    N is NConvidados - 1,
    generateRandomList(N, T).



entrypoint:-
    findall(ID, pessoa(A, ID, [1,_], ListOfInt), FamNoivo), write(FamNoivo), nl,
    findall(ID2, pessoa(B, ID2, [_,1] , Loi), FamNoiva), write(FamNoiva),nl,
    findall(ID3, pessoa(C, ID3,[2,_], AmigosNoivoLI), AmgNoivo), write(AmgNoivo),nl,
    findall(ID4, pessoa(D, ID4,[_,2], AmigosNoivaLI), AmgNoiva), write(AmgNoiva),nl,
    domain(Range, 8, 12), mesas(Range, Mesas), makeAllDistinct(Mesas), famTogether(FamNoivo, FamNoiva, Mesas), flattenList(Mesas, NestedMesas),
    labeling([], NestedMesas).
    


/* 
famTogether(FamNoivo, FamNoiva, Mesas):-
    length(Mesas, A),
    domain(Index, 1, A),
    element(Index, Mesas, Mesa),
    length(Mesa, B), domain(Index2, 1, B),
    element(Index2, Mesa, Guest),
    element(,FamNoiva, Guest)
 */
    
%famTogether(FamNoivo, FamNoiva, Mesas, Range):-
        

mesas(Range, ListaMesas):-
    number(A), NMesas #= ceiling(A / Range),
    createLists(NMesas, ListaMesas).


createLists(0, R, _).
createLists(NMesas, List, Range):-
    length(A, Range),
    append(List, A),
    N is NMesas - 1,
    createLists(N, List, Range).


makeAllDistinct([]).
makeAllDistinct([H|T]):-
all_distinct(H),
makeAllDistinct(T).


flattenList([], []).
flattenList([Line | List], Result):-
	is_list(Line), flattenList(Line, Result2), append(Result2, Tmp, Result), flattenList(List, Tmp).
flattenList([Line | List], [Line | Result]):-
	\+is_list(Line), flattenList(List, Result).
    
    
    

