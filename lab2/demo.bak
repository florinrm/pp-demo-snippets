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

; sa fiti atent la cum se obtine rezultatul
; posibil ca, atunci cand transformati din recursiva pe stiva
; in recursiva pe coada, rezultatul sa fie inversat

(define (rev l)
  (if (null? l)
      null
      (append (rev (cdr l)) (list (car l)))))

(rev '(1 2 3 4 5 6 7 8))

(define (rev-tail-helper l acc)
  (if (null? l)
      acc
      (rev-tail-helper (cdr l) (cons (car l) acc))))

(define (rev-tail l) (rev-tail-helper l null))

(rev-tail '(1 2 3 4 5 6 7 8))


; recursivitate arborescenta - TODO