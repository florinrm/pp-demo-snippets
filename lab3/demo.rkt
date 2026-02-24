#lang racket

; templates
; recursivitate pe stiva -> (operatie (car l) (func (cdr l)))
; recursivitate pe coada -> (func-tail-helper (cdr l) (operatie acc (car l)))

; transformare recursivitate pe stiva -> recursivitate pe coada

(define (factorial n)
  (if (= 0 n)
      1
      (* n (factorial (- n 1)))))

(factorial 0)
(factorial 4)
(factorial 6)

(define (factorial-tail-helper n acc)
  (if (zero? n)
      acc
      (factorial-tail-helper (- n 1) (* acc n))))

(define (factorial-tail n) (factorial-tail-helper n 1))

(factorial-tail 0)
(factorial-tail 4)
(factorial-tail 6)

; suma unei liste
(define (sum-list l)
  (if (null? l)
      0
      (+ (car l) (sum-list (cdr l)))))

(sum-list '())
(sum-list (list 1 2 3 4 5 6))

(define (sum-list-tail-helper l acc)
  (if (null? l)
      acc
      (sum-list-tail-helper (cdr l) (+ acc (car l)))))

(define (sum-list-tail l) (sum-list-tail-helper l 0))

(sum-list-tail '())
(sum-list-tail (list 1 2 3 4 5 6))


; lungimea unei liste
(define (len-list l)
  (if (null? l)
      0
      (add1 (len-list (cdr l)))))

(len-list '())
(len-list '(1 2 3 4 5 6))

(define (len-list-tail-helper l acc)
  (if (null? l)
      acc
      (len-list-tail-helper (cdr l) (+ 1 acc))))

(define (len-list-tail l) (len-list-tail-helper l 0))

(len-list-tail '())
(len-list-tail '(1 2 3 4 5 6))

; copierea unei liste
(define (copy-list L)
  (if (null? L)
      null
      (cons (car L) (copy-list (cdr L)))))

(copy-list '(1 2 3 4 5))

(define (copy-list-tail-helper L acc)
  (if (null? L)
      acc
      (copy-list-tail-helper (cdr L) (append acc (list (car L))))))

(define (copy-list-tail L)
  (copy-list-tail-helper L null))

(copy-list-tail '(1 2 3 4 5))
; sa fiti atent la cum se obtine rezultatul
; posibil ca, atunci cand transformati din recursiva pe stiva
; in recursiva pe coada, rezultatul sa fie inversat


; functie recursiva pe coada, care nu are acumulator
(define (is-member l e)
  (cond
    ((null? l) #f)
    ((equal? e (car l)) #t)
    (else (is-member (cdr l) e))))

(is-member (list 1 2 3 4) 3)
(is-member (list 1 2 3 4) 5)


; recursivitate arborescenta - subtip al recursivitatii pe stiva
; pentru ca se pastreaza apelurile pe stiva pentru a construi rezultatul
; incepand cu frunzele arborelui de recurenta pana la radacina
(define (fibo n)
  (if (<= n 1)
      n
      (+ (fibo (- n 1)) (fibo (- n 2)))))

(fibo 2)
(fibo 5)
(fibo 6)

; fibo - tail recursion
(define (fib-tail-helper n a b)
  (if (zero? n)
      a
      (fib-tail-helper (sub1 n) b (+ a b))))

(define (fib-tail n)
  (fib-tail-helper n 0 1))

(fib-tail 2)
(fib-tail 5)
(fib-tail 6)