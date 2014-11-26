#lang plai

(define (between? x)
  (and (>= x 5) (<= x 95)))
(test (between? 3) false)
(test (between? 30) true)

; currying
; adder : number -> (number -> number)
(define adder (lambda (x) (lambda (y) (+ x y))))
; note:
; if defined as (define (adder x y) (+ x y)))
;    then it does not have the property of currying
((adder 3) 4) ; => 7

;(cdr null)
;  cdr: contract violation
;  expected: pair?
;  given: '()
;> (car null)
;  car: contract violation
;  expected: pair?
;  given: '()

(test (eq? null empty) true)

(define (count-up n)
  (local [(define (count-from-i i)
            (cond [(= n i) empty]
                  [else
                   (cons i (count-from-i (add1 i)))]))]
    (count-from-i 0)))

(define (quick-sort lst)
  (cond
    [(empty? lst) empty]
    (else (local [(define pivot (first lst))
                  (define less-than-pivot
                    (filter (lambda (x) (< x pivot))
                            lst))
                  (define more-than-pivot
                    (filter (lambda (x) (> x pivot))
                            lst))]
            (append (quick-sort less-than-pivot)
                    (list pivot)
                    (quick-sort more-than-pivot))))))

(test (equal? '(2 3) '(2 3)) true)
(test (eq? '(2 3) '(2 3)) false)

(define (fast-fib n)
  (local [(define (fibo-worker a b count)
            (if (= count 1)
                b
                (fibo-worker (+ a b) a (- count 1))))]
    (fibo-worker 1 1 n)))

(time (fast-fib 1000))

(define (fibt n)
  (if (< n 2)
      n
      (fibaux (- n 1) 1 0)))

(define (fibaux n curr prev)
  (if (= n 0)
      curr
      (fibaux (- n 1) (+ curr prev) curr)))

(time (fibt 999))

;(define ones-bad (lambda () (cons 1 (ones-bad))))
(define ones (lambda () (cons 1 ones)))