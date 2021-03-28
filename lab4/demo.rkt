#lang racket

; legare statica - let
(define (f a b)
  (let ((a 6) (b 9))
    (+ a b))         ; context 2 - a are valoarea 6, b are valoarea 9 (in let)
  ; (+ a b)          ; context 3 - a are valoarea 4, b are valoarea 2 (in afara let-ului)
  )

(f 4 2)              ; context 1 - a are valoarea 4, b are valoarea 2

; legarea globala - definirea unei variabila cu define, nu se poate schimba valoarea unei variabile in Racket!
(define a 10)

; let
(let ((a 5)
      (b a))
  (+ a b)) ; 15 - a este vizibil doar in corp

; let*
(let* ((a 5)
      (b a))
  (+ a b)) ; 10 - a este vizibil si in urmatoarea legare

;letrec
;(letrec ((a (+ b 10)) ; se poate vedea variabila b, insa ea apare ca undefined, fiindca ea nu este evaluata
;         (b 1))
;  (+ a b))

(letrec
   ((even-length?
     (lambda (L)                    ; even-length? este o închidere funcțională  
       (if (null? L)                ; deci corpul funcției nu este evaluat la  
           #t                       ; momentul definirii ei  
           (odd-length? (cdr L))))) ; deci nu e o problemă că încă nu știm cine e odd-length?  
    (odd-length?   
     (lambda (L)   
       (if (null? L)  
           #f  
           (even-length? (cdr L))))))
  (even-length? '(1 2 3 4 5))) 


; named let - o functie intr-o alta functie
; utilizare - calcul pe un range de tip [min, max]
; utilizare - functii recursive pe coada
(define (sum-list L)
  (let sum-list-iter ((lst L) (acc 0))
    (if (null? lst)
        acc
        (sum-list-iter (cdr lst) (+ acc (car lst))))))
(sum-list '(1 2 3 4 5))

; inchidere functionala
(define (func x)
  (λ (y)
    (+ x y)))

(define kek (func 6)) ; inchidere functionala
(kek 9) ; evaluarea functiei ((func 6) 9)