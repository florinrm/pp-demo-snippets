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

mama(X, Y) :- femeie(X), parinte(X, Y).
tata(X, Y) :- barbat(X), parinte(X, Y).

bunic(X, Y) :- parinte(X, Z), parinte(Z, Y).

%list_length(+Lista, -Lungime)
list_length([], 0). % mai intai facem cazul de baza pentru backtracking / recursivitate
list_length([_ | Tail], N) :- list_length(Tail, N1), N is N1 + 1. % continuam cautarea
% de ce nu punem Head in loc de _? vom avea warning cu Singleton variables, pt ca Head nu este folosit aici => folosim _, la caz general

sum_list([], 0).
sum_list([H|T], S) :- sum_list(T, S1), S is S1 + H;

is_member(X, [X | _]). % caz de baza
is_member(X, [_ | Tail]) :- is_member(X, Tail). % continuam cautarea

same_list([], []). % caz de baza
same_list([Head | Rest1], [Head | Rest2]) :- same_list(Rest1, Rest2). % daca H1 == H2, continuam
same_list([Head1 | _], [Head2 | _]) :- Head1 \= Head2. % daca H1 != H2, ne oprim

% in Prolog putem sa avem overload la functii (predicate mai bine zis)
arataBine(andreea).
arataBine(anca).
arataBine(irina).
three_some(X, Y, Z) :- arataBine(X), arataBine(Y), arataBine(Z).
two_some(X, Y) :- arataBine(X), arataBine(Y), X \= Y.
three_some(X, Y) :- three_some(X, Y, andreea), X \= Y, !.