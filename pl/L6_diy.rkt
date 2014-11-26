#lang racket
(define (gauss-sum n)
  (define (gsum-aux n acc)
    (if (= n 0)
        acc
        (gsum-aux (- n 1) (+ acc n))))
  (gsum-aux n 0))