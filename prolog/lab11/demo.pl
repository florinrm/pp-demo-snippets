barbat(mihaitza).
barbat(florinel).
barbat(bobitza).
barbat(norin).
barbat(costinel).

femeie(anca).
femeie(andreea).
femeie(irina).

femeie(gherghina).
femeie(vasilica).

%% parinte(+Parinte, +Copil)
parinte(norin, mihaitza).
parinte(costinel, florinel).
parinte(norin, bobitza).

parinte(andreea, mihaitza).
parinte(irina, mihaitza).
parinte(anca, florinel).
parinte(andreea, bobitza).

parinte(gherghina, anca).
parinte(vasilica, andreea).

mama(X, Y) :- femeie(X), parinte(X, Y).
tata(X, Y) :- barbat(X), parinte(X, Y).

bunici(X, Y) :- parinte(X, Z), parinte(Z, Y). % X -> Z -> Y

bunic1(X, Y) :- tata(X, Z), parinte(Z, Y).
bunic2(X, Y) :- barbat(X), parinte(X, Z), parinte(Z, Y).

couple(X/Y) :- X @=< Y, !; X =< Y, !;

% lungime(+Lista,-Lungime) 
lungime([],0).
lungime([_ | R], N) :- lungime(R, N1), N is N1 + 1.
% lungime([1,2,3],N).

% membru(?Elem,+Lista)
membru(Elem, [Elem | _]).
membru(Elem, [_ | Rest]) :- membru(Elem, Rest).
% membru(N, [1, 2, 3]).

% remove(+Elem, +Lista, -ListaNoua) 
remove(E, [E | R], R). 
remove(E, [F | R], [F | L]) :- remove(E, R, L).
% remove(3, L, [1, 1, 1]).

% perm(+Lista, -Permutare) 
perm([], []). 
perm([F | R], P) :- perm(R, P1), remove(F, P, P1).
% perm([1, 2, 3], Perm).

% negatia

student(andrei). student(marius). lazy(marius).

p1(X) :- student(X), \+ lazy(X).
% pentru X = andrei, o sa returneze X = andrei (se va unifica X cu andrei la student(X)), \+ lazy(andrei) va returna true
% cand X = marius, predicatul va esua la \+ lazy(X), deoarece \+ lazy(marius) va returna false

p2(X) :- \+ lazy(X), student(X).
% pentru X = andrei, va returna false, nu se poate genera solutie pentru \+ lazy(X)

% la interogare ne va returna false, deoarece negarea este folosita pentru esec
% negarea nu poate fi folosita pentru generarea de solutii
esteBarbat(X) :- \+ femeie(X).

% predicatul false
my_reverse(List, Acc, _) :- format('List:~w, Acc:~w~n', [List, Acc]), false.
my_reverse([], Sol, Sol).
my_reverse([Head | Tail], Acc, Sol):-my_reverse(Tail, [Head | Acc], Sol).
% my_reverse([1,2,3,4],[],Rev).

% operatorul cut

auCopil(X, Y) :- parinte(X, Z), parinte(Y, Z), !.
auCopil1(X, Y, Z) :- parinte(X, Z), parinte(Y, Z).
auCopil2(X, Y, Z) :- parinte(X, Z), parinte(Y, Z), !.

% auCopil1(norin, andreea, X)
% auCopil2(norin, andreea, X)

p(a). 
p(b). 
p(A/B) :- q(A), !, t(A/B). % dacă s-a generat deja o soluție pentru ce este înainte de !, nu se mai generează alte soluții
% în cazul de față, dacă s-a generat o soluție pentru q, atunci restul condițiilor merg normal, dar nu se vor mai genera
% alte soluții pentru predicatul q
p(d).

q(a). 
q(b). 
q(c).

t(a/a). 
t(a/b). 
t(b/c). 
t(b/d). 

min(X, Y, Min) :- X < Y, X = Min. % regula 1
min(X, Y, Min) :- X >= Y, Y = Min. % regula 2

% green cut
min2(X, Y, Min) :- X < Y, !, X = Min. % regula 1
min2(X, Y, Min) :- X >= Y, Y = Min. % regula 2

% red cut
min3(X, Y, Min) :- X < Y, !, X = Min. 
min3(_, Y, Min) :- Y = Min.