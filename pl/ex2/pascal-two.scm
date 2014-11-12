;;;----------------------------------------------------------------------
;;; author: Rui Duan (0561866)
;;; date: November 12, 2014
;;;
;;; Pascal Triangle Solution 2 (Excercise 2, problem 3)
;;;----------------------------------------------------------------------

(define (pascal-row n)
  (if (= n 0)
      '(1)
      (let ((lst (pascal-row (- n 1))))
	(add-list (shift-left lst) (shift-right lst)))))

(define (shift-left lst)
  (if (null? lst)
      '(0)
      (cons (car lst) (shift-left (cdr lst)))))

(define (shift-right lst)
  (cons 0 lst))

(define (add-list a b)
  (if (null? a)
      '()
      (if (null? b)
	  '()
	  (cons (+ (car a) (car b)) (add-list (cdr a) (cdr b))))))

;;; generate pascal triangle upto n-th row, n begins from 0
(define (pascal-triangle n)
  (define (build-triangle i)   
    (if (> i n)
	'()
	(cons (pascal-row i) (build-triangle (+ i 1)))))
  (build-triangle 0))
