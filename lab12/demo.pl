% findall

% map folosind findall - map (+ 1) list
mapAddWithOne(List1, List2) :- findall(Z, (member(X, List1), Z is X + 1), List2).

% filter folosind findall - filter even list
filterEvenNumbers(List1, List2) :- findall(X, (member(X, List1), X mod 2 =:= 0), List2).

% findall se comporta precum list comprehensions din Haskell

% produs cartezian
cartesian(L1, L2, L3) :- findall((X, Y), (member(X, L1), member(Y, L2)), L3).

% intersectie
intersect(L1, L2, L3) :- findall(X, (member(X, L1), member(X, L2)), L3).


% bagof
are(andrei, laptop, 1). 
are(andrei, pix, 5). 
are(andrei, ghiozdan, 2).
are(andrei, pix, 10).
are(radu, papagal, 1). 
are(radu, ghiozdan, 1). 
are(radu, laptop, 2).
are(radu, papagal, 6). 
are(ana, telefon, 3). 
are(ana, masina, 1).

% bagof(X, are(andrei, X, _), Bag).
% bagof(X, C^are(C, X, _), Bag).
% bagof(X, P^C^are(C, X, P), Bag).
% bagof(X, are(C, X, _), Bag).
% bagof(X, are(C, X, P), Bag).
% bagof(X, P^are(C, X, P), Bag).

% setof

% setof(X, are(andrei, X, _), Bag).
% setof(X, C^are(C, X, _), Bag).
% setof(X, P^C^are(C, X, P), Bag).
% setof(X, are(C, X, _), Bag).
% setof(X, are(C, X, P), Bag).
% setof(X, P^are(C, X, P), Bag).

% forall

% predicat prin care verificam daca toate numerele dintr-o lista sunt numere pare
areAllNumbersEven(List) :- forall(member(X, List), X mod 2 =:= 0).

% predicat prin care verificam daca toate numerele dintr-o lista sunt diferite de zero
areAllNumbersNotZero(List) :- forall(member(X, List), X =\= 0).