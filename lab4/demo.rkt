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

(define (curry->uncurry f)
  (lambda (x y)
    ((f x) y)))

(define (uncurry->curry f)
  (lambda (x)
    (lambda (y)
      (f x y))))

; (map ((uncurry->curry (λ (x y) (+ 3 x y))) 5) (list 1 2 3 4 5))

(((uncurry->curry uncurry) 1) 2)
((curry->uncurry curry) 1 2)


(define (celsius-to-kelvin-uncurry x)
  (uncurry 273.15 x))
(define (celsius-to-kelvin-curry x)
  ((curry 273.15) x))

(celsius-to-kelvin-uncurry 0)
(celsius-to-kelvin-curry 0)

(define (celsius-to-kelvin l)
  (if (null? l)
      null
      (cons (+ (car l) 273.15) (celsius-to-kelvin (cdr l)))))

(define (kelvin-to-celsius l)
  (if (null? l)
      null
      (cons (- (car l) 273.15) (kelvin-to-celsius (cdr l)))))

; observam un pattern, ca putem generaliza totul printr-o functie generala / template, unde difera functia aplicata
(define (apply-function f l)
  (if (null? l)
      null
      (cons (f (car l)) (apply-function f (cdr l)))))

(define (apply-function-tail-helper f l acc)
  (if (null? l)
      acc
      (apply-function-tail-helper f (cdr l) (append acc (list (f (car l)))))))

(define (apply-function-tail f l) (apply-function-tail-helper f l null))

(define (apply-celsius-to-kelvin l) (apply-function celsius-to-kelvin-curry l))
(define (apply-kelvin-to-celsius l) (apply-function (λ (x) (- x 273.15)) l))

(celsius-to-kelvin '(1 2 3 4 5))
(kelvin-to-celsius '(1 2 3 4 5))

(apply-celsius-to-kelvin '(1 2 3 4 5))
(apply-kelvin-to-celsius '(1 2 3 4 5))

; functionale
(define l (list 1 2 3 4 5 6 7 8 9 10))

; map
(map (λ (x) (+ x 1)) l)
(map add1 l)

(map list l)
(map list l l) ; '((1 1) (2 2) (3 3) (4 4) (5 5) (6 6) (7 7) (8 8) (9 9) (10 10))

(map (λ (x y) (+ x y)) l l) ; '(2 4 6 8 10 12 14 16 18 20)
(map + l l) ; '(2 4 6 8 10 12 14 16 18 20)
(map + l l l) ; '(3 6 9 12 15 18 21 24 27 30)

; filter
(filter (λ (x) (> x 5)) l)
(filter odd? l)
(filter (λ (x) (not (zero? x))) l)


; foldl
(foldl (λ (x acc) (+ acc x)) 0 l) 
(foldl + 0 l)
(foldl + 0 l l)
(foldl (λ (x y acc) (+ acc x y)) 0 l l)

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