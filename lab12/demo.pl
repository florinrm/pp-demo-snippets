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

% reuniune

% bagof

% setof

% forall

% predicat prin care verificam daca toate numerele dintr-o lista sunt numere pare
areAllNumbersEven(List) :- forall(member(X, List), X mod 2 =:= 0).