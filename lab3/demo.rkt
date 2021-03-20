#lang racket

; curry + uncurry

; uncurry - functie apelata cu toti parametrii
(define uncurry
  (λ (x y) (+ x y)))

(define (uncurry2 x y) (+ x y))

(uncurry 6 9)

; curry - nu se pun toti parametrii
(define curry
  (λ (x)
    (λ (y)
      (+ x y))))

((curry 6) 9) ; 15
; (curry 6 9) ; eroare
(curry 6) ; procedure

(define l (list 1 2 3 4 5 6 7 8 9 10))

; map
(map (λ (x) (+ x 1)) l)
(map add1 l)

(map list l)
(map list l l)

(map (λ (x y) (+ x y)) l l) ; '(2 4 6 8 10 12 14 16 18 20)
(map + l l) ; '((1 1) (2 2) (3 3) (4 4) (5 5) (6 6) (7 7) (8 8) (9 9) (10 10))
(map + l l l) ; '((1 1 1) (2 2 2) (3 3 3) (4 4 4) (5 5 5) (6 6 6) (7 7 7) (8 8 8) (9 9 9) (10 10 10))

; filter
(filter (λ (x) (> x 5)) l)
(filter odd? l)


; foldl
(foldl (λ (x acc) (+ acc x)) 0 l) 
(foldl + 0 l)

(foldl (λ (x acc) (cons x acc)) '() l) ; reverse list
(foldl cons '() l) ; reverse list

(foldl (λ (x acc) (append acc (list x))) '() l) ; copy list

; foldr
(foldr (λ (x acc) (+ acc x)) 0 l)
(foldr + 0 l)

(foldr (λ (x acc) (cons x acc)) '() l) ; copy list
(foldr cons '() l) ; copy list

(foldr (λ (x acc) (append acc (list x))) '() l) ; reverse list


(define (my-filter f l)
  (foldr (λ (x acc)
           (if (f x)
               (cons x acc)
               acc)) null l))
(my-filter odd? l)

(define (my-map f l)
  (foldr (λ (x acc) (cons (f x) acc)) '() l))

; apply
(define l2 (list 1 2 3 4))

(apply + l2) ; (+ 1 2 3 4)
(apply + 1 2 3 l2) ; (+ 1 2 3 1 2 3 4)
(apply cons (list 1 2)) ; (cons 1 2)
(apply list l2) ; (list 1 2 3 4)
(apply list (list 5 6 7) l2) ; (list '(5 6 7) 1 2 3 4)

(define matrix (list (list 1 2 3) (list 4 5 6) (list 7 8 9))) ; '((1 2 3) (4 5 6) (7 8 9))
(map list matrix) ; '(((1 2 3)) ((4 5 6)) ((7 8 9)))
(apply map list matrix) ; (map list '(1 2 3) '(4 5 6) '(7 8 9))
