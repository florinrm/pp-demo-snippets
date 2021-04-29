# Evaluarea expresiilor aritmetice

```prolog
1 ?- X = 1 + 2.
X = 1+2.

2 ?- 1 + 2 = 2 + 1.
false.

3 ?- 1 + 2 = 1 + 2.
true.

4 ?- 1 + 2 == 1 + 2.
true.

5 ?- 1 + 2 == 2 + 1.
false.

6 ?- 1 + 2 /= 2 + 1.
ERROR: Syntax error: Operator expected
ERROR: 1 + 2
ERROR: ** here **
ERROR:  /= 2 + 1 .
6 ?- 1 + 2 \= 2 + 1.
true.

7 ?- 1 + 2 \= 1 + 2.
false.

8 ?- 1 + 2 == 1 + 2.
true.

9 ?- 1 + 2 =:= 1 + 2.
true.

10 ?- 1 + 2 =:= 3.
true.

11 ?- 1 + 2 =:= 4.
false.

12 ?- 1 + 2 \== 4.
true.

13 ?- 1 + 2 \== 3.
true.

14 ?- 1 + 2 \== 1 + 2.
false.

15 ?- 1 + 2 \== 2 + 1.
true.

16 ?- 1 + 2 =\= 3.
false.

17 ?- 1 + 2 =\= 1 + 2.
false.

18 ?- 1 + 2 =\= 2.
true.
```
