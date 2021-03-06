#lang racket

; operatii de baza
(+ 6 9) ; 6 + 9
(max 6 9)
(+ (* 5 10) (/ 100 2)) ; (5 * 10) + (100 / 2)

; conditionale
(if (= 6 9)
    420
    (max (+ 3 4) (* 10 8)))

(if (= 6 9)
    100
    (if (> 6 9)
        420
        (if (< 6 9)
            1000
            69)))

(cond
  ((= 6 9) 100)
  ((> 6 9) 420)
  ((< 6 9) 1000)
  (else 69))

(cond
  [(= 6 9) 100]
  [(> 6 9) 420]
  [(< 6 9) 1000]
  [else 69])

; define - legarea valorilor la variabile
(define n 100)
(define p (+ n 320))

(define (inc nr) (+ 1 nr))
(define (dec nr) (- nr 1))
(define (add x y) (+ x y))

; perechi - tuplu format din 2 elemente, de forma (x, y)
(define pair (cons 1 2))
(car pair) ; primul element din pereche
(cdr pair) ; al doilea element din pereche

; liste - generalizare a perechilor, o lista (nevida) fiind o pereche formata din primul element si din restul listei
(list 1 2 3 4 5 6)
'(1 2 3 4 5 6)

(list (+ 1 2) 3 4) ; '(3 3 4)
'((+ 1 2) 3 4) ; '((+ 1 2) 3 4)

'() ; lista goala
null ; lista goala

; adaugarea unui element in fata unei liste
(cons 5 (list 1 2 3 4)) ; '(5 1 2 3 4)

; concatenarea dintre 2 liste
(append (list 1 2 3) (list 3 4 5)) ; '(1 2 3 3 4 5)

; construirea unei liste cu cons
(cons 1 (cons 2 (cons 3 (cons 4 null)))) ; '(1 2 3 4)

; verificarea daca un element e lista
(list? '(1 2 3 4 5)) ; #t
(list? (list 1 2 3 4 5)) ; #t
(list? 100) ; #f



; exemple de functii

(define (factorial n)
  (if (= 0 n)
      1
      (* n (factorial (- n 1)))))

(factorial 0)
(factorial 4)
(factorial 6)

(define (factorial2 n)
  (if (zero? n)
      1
      (* n (factorial2 (sub1 n)))))

(factorial2 0)
(factorial2 4)
(factorial2 6)

; suma unei liste
(define (sum-list l)
  (if (null? l)
      0
      (+ (car l) (sum-list (cdr l)))))

(sum-list '())
(sum-list (list 1 2 3 4 5 6))

; lungimea unei liste
(define (len-list l)
  (if (null? l)
      0
      (add1 (len-list (cdr l)))))

(len-list '())
(len-list '(1 2 3 4 5 6))

; daca un element apartine unei liste
(define (elem-list-if l e)
  (if (null? l)
      #f
      (if (equal? (car l) e)
          #t
          (elem-list-if (cdr l) e))))

(elem-list-if '(1 2 3 4) 1)
(elem-list-if '(1 2 3 4) 2)
(elem-list-if '(1 2 3 4) 3)
(elem-list-if '(1 2 3 4) 4)
(elem-list-if '(1 2 3 4) 5)
(elem-list-if '() 0)

(define (elem-list-cond l e)
  (cond
    ((null? l) #f)
    ((equal? (car l) e) #t)
    (else (elem-list-cond (cdr l) e))))

(elem-list-cond '(1 2 3 4) 1)
(elem-list-cond '(1 2 3 4) 2)
(elem-list-cond '(1 2 3 4) 3)
(elem-list-cond '(1 2 3 4) 4)
(elem-list-cond '(1 2 3 4) 5)
(elem-list-cond '() 0)

; adaugarea unui element la finalul listei
(define (anti-cons l e)
  (append l (list e)))