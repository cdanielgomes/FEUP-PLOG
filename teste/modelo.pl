reload:- reconsult('/home/daniel/Desktop/PLOG/teste/modelo.pl').

%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).


madeItThrough(Participant):-
    performance(Participant, Times),
    member(120,Times).


getOneElem([H|T], 0, Elem):- 
    Counter = Member, Elem = H.

getOneElem([H|T],  Member, Elem):-
    Member2 is Member -1,
    getOneElem(T,  Member2, Elem).    

makeList([], _, _).
makeList([H|T], [C|R], Member):-
    Member2 is Member - 1, 
    performance(H, X),
    getOneElem(X, Member2, Elem), 
    C = Elem,
    makeList(T, R, Member).

sum_list([], Counter, Total):- Counter = Total.
sum_list([H|T], Counter,Total):-
 Counter1 is Counter + H,
 sum_list(T, Counter1, Total). 

% juriTimes(+Participants, +JuriMember, -Times, -Total)
juriTimes(Participants, JuriMember, Times, Total):-
    makeList(Participants, Times, JuriMember),
    sum_list(Times, 0,Total).

patientJuri(JuriMember):-
    JuriMember1 is JuriMember - 1, 
    performance(ID1, L1),
    performance(ID2, L2), 
    ID1 \= ID2,
    getOneElem(L1, JuriMember1, Elem1), 
    getOneElem(L2, JuriMember1, Elem2),
    Elem1 == 120, 
    Elem2 == 120.
    

    
bestParticipant(P1, P2, P):-
    performance(P1, X), 
    performance(P2, Y),
    sum_list(X, 0, TP1),
    sum_list(Y, 0, TP2),
    TP1 < TP2,
    P = P2.

bestParticipant(P1, P2, P):-
    performance(P1, X), 
    performance(P2, Y),
    sum_list(X, 0, TP1),
    sum_list(Y, 0, TP2),
    TP1 > TP2,
    P = P2.


getTimes(Participant, Times, Age, Performance):-
    participant(Participant, Age, Performance),
    performance(Participant, Times).

printList(Participant, Performance, Times):-    
    getTimes(Participant, Times, Age, Performance),
    write(Participant), write(':'), write(Performance), write(':'), write(Times), write('\n'), false ; true. 

allPerfs:-  printList(Participant, Performance, Times).
    

all120([]).
all120([H|T]):-
H =:= 120,
all120(T).

    
counter([], C, R):- C = R.

counter([P|T], Count, R):-
    all120(P),
    Count1 is Count+1,!,
    counter(T, Count1, R).

counter([P|T], Count, R):-
    counter(T, Count, R).

nSuccessfulParticipants(T):-
    findall(B, performance(_, B), List),
    counter(List, 0, T).
/*
nth1(1, [H|T], H).
nth1(N, [H|T], Elem):-
    nth1(OldN, T, Elem),
    N is OldN +1.
*/

index(Times, ListaJuri):-
    findall(Index, nth1(Index, Times, 120), ListaJuri).


juriFans(L):-
    findall(B-Index,(performance(B, Times), index(Times, Index)), L).

:- use_module(library(lists)).

eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).

firstN(0, _, []).
firstN(N, [H|T], [H|F]):-
    N1 is N - 1,
    firstN(N1, T, F).

nextPhase(N, Participants):-
    setof(TT-Id-Per, eligibleOutcome(Id, Per, TT), Ret),
    length(Ret, N2),
    N2 >= N,
    sort(Ret, NL),
    reverse(NL, NLL),
    firstN(N, NLL, Participants).


