#lang racket
; evaluare lenesa in Racket

; varianta 1 - inchideri functionale
(define sum (λ (x y) (λ () (+ x y))))
(sum 1 2) ; promisiune (procedura)
((sum 1 2)) ; se forteaza promisiunea

; varianta 2 - delay si force
(define sum2 (λ (x y) (delay (+ x y))))
(sum2 1 2) ; promisiune
(force (sum2 1 2))

; cu ajutorul evaluarii lenesa, putem construi structuri de date infinite (liste infinite), adica streams / fluxuri
(define ones-stream (cons 1 (λ () ones-stream)))
ones-stream

; este definit in laborator - exista unul in Racket deja, dar il folositi pe cel din laborator
(define (stream-take s n)
  (cond ((zero? n) '())
        ((stream-empty? s) '())
        (else (cons (stream-first s)
                    (stream-take (stream-rest s) (- n 1))))))

(define ones-stream-2 (stream-cons 1 ones-stream-2))
(stream-take ones-stream-2 10)

; suma a doua liste, element cu element
(define list-add
  (λ (l1 l2)
    (if (or (null? l1) (null? l2))
        null ; nu apare la stream-uri pentru ca sunt infinite
        (cons (+ (car l1) (car l2))
              (list-add (cdr l1) (cdr l2))))))
(list-add (list 1 2 3 4) (list 5 6 7 8))
(list-add (list 1 2 3) (list 5 6 7 8))
(list-add (list 1 2 3 4) (list 5 6 7))

; suma a doua fluxuri
(define add
  (λ (a b)
    (stream-cons
     (+ (stream-first a) (stream-first b))
     (add (stream-rest a) (stream-rest b)))))

(stream-take (add ones-stream-2 ones-stream-2) 10)

(define (make-naturals k)
  (stream-cons k (make-naturals (add1 k))))


(define naturals-stream (make-naturals 0))

; varianta 1 - liste
(define naturals
  (λ (n)
    (cons n (λ () (naturals (add1 n))))))

; varianta 2 - stream
(define naturals-streams
  (λ (n)
    (stream-cons n (naturals-streams (add1 n)))))

(stream-take (naturals-streams 0) 10)

(define fibo-stream
  (stream-cons 0
     (stream-cons 1
        (add fibo-stream (stream-rest fibo-stream)))))