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

parinte(norin, mihaitza).
parinte(costinel, florinel).
parinte(norin, bobitza).

parinte(irina, mihaitza).
parinte(anca, florinel).
parinte(andreea, bobitza).

parinte(gherghina, anca).
parinte(vasilica, andreea).

parinte(irina, florinel, bobitza).

ceva_predicat(69).

carte(autor(marinPreda), titlu(morometii)).
carte(autor(marinPreda), titlu(delirul)).
carte(autor(emilCioran), titlu(sfartecare)).
carte(autor(emilCioran), titlu(peCulmileDisperarii)).

mama(X, Y) :- femeie(X), parinte(X, Y).
tata(X, Y) :- barbat(X), parinte(X, Y).

bunici(X, Y) :- parinte(X, Z), parinte(Z, Y). % X -> Z -> Y

bunic1(X, Y) :- tata(X, Z), parinte(Z, Y).
bunic2(X, Y) :- barbat(X), parinte(X, Z), parinte(Z, Y).

%list_length(+Lista, -Lungime)
list_length([], 0). % mai intai facem cazul de baza pentru backtracking / recursivitate
list_length([_ | Tail], N) :- list_length(Tail, N1), N is N1 + 1. % continuam cautarea
% de ce nu punem Head in loc de _? vom avea warning cu Singleton variables, pt ca Head nu este folosit aici => folosim _, la caz general

sum_list([], 0).
sum_list([H|T], S) :- sum_list(T, S1), S is S1 + H;

is_member(X, [X | _]). % caz de baza
is_member(X, [_ | Tail]) :- is_member(X, Tail). % continuam cautarea

% is_same_list [] [] = True
% is_same_list (h:t1) (h:t2) = is_same_list t1 t2

same_list([], []). % caz de baza
same_list([Head | Rest1], [Head | Rest2]) :- same_list(Rest1, Rest2). % daca H1 == H2, continuam
same_list([Head1 | _], [Head2 | _]) :- Head1 \= Head2. % daca H1 != H2, ne oprim

is_same_list_2([], []).
is_same_list_2([H1|T1], [H2|T2]) :- H1 == H2, is_same_list_2(T1, T2).

% in Prolog putem sa avem overload la functii (predicate mai bine zis)
arataBine(andreea).
arataBine(anca).
arataBine(irina).
three_some(X, Y, Z) :- arataBine(X), arataBine(Y), arataBine(Z).
two_some(X, Y) :- arataBine(X), arataBine(Y), X \= Y.
three_some(X, Y) :- three_some(X, Y, andreea), X \= Y, !.