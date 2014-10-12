;;; 2.1
(define (make-counter initval)
  (define (increment amount)
    (begin (set! initval (+ initval amount))
	   initval))
  (define (decrement amount)
    (begin (set! initval (- initval amount))
	   initval))
  (define (zero)
    (begin (set! initval 0)
	   initval))
  (define (dispatch m)
    (cond ((eq? m 'increment) increment)
	  ((eq? m 'decrement) decrement)
	  ((eq? m 'zero) zero)
	  (else (error "Unknown request -- MAKE-COUNTER" m))))
  dispatch)
;;; test 2.1
;; (define counter (make-counter 0)) => #<procedure:dispatch>
;; ((counter 'increment) 5) => 5
;; ((counter 'increment) 10) => 15
;; ((counter 'zero)) => 0
;; ((counter 'decrement) 3) => -3
;; ((counter 'increment) 4) => 1


;;; 2.2
(define (treefringe tree)
  (cond ((null? tree) null)
	((not (pair? tree)) (list tree))
	(else (append (treefringe (car tree))
		      (treefringe (cdr tree))))))
;; test 2.2
;; (define x (list (list 1 2) (list 3 4)))
;; (treefringe x) => '(1 2 3 4)
;; (treefringe (list x x)) => '(1 2 3 4 1 2 3 4)
;; (treefringe '((1 2) 3)) => '(1 2 3)
;; (treefringe '(1 (2 3))) => '(1 2 3)
;; (treefringe '()) => '()
;; (treefringe '(1)) => '(1)
;; (treefringe '(() 1)) => '(1)
;; (treefringe '(() (1))) => '(1)


;;; 2.3
;;; row index and col index both begin from 0
(define (pascal row col)
  (cond ((< row col) #f)		; exceed boundary
	((or (= 0 col) (= row col)) 1)	; edge element
	(else (+ (pascal (- row 1) col)
		 (pascal (- row 1) (- col 1))))))
;; test 2.3
;; (pascal 0 0) => 1
;; (pascal 4 2) => 6


;;; 2.4
(define (s-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (next test-divisor)
  (if (= test-divisor 2)
      3
      (+ test-divisor 2)))

(define (square x)
  (* x x))

(define (prime? n)
  (= n (s-divisor n)))


;;; 2.5
(define (selection-sort lst)
  (if (null? lst)
      null
      (selection-sort-helper (smallest lst) lst)))

(define (selection-sort-helper smallest-value lst)
  (cons smallest-value
	(selection-sort (list-remove lst smallest-value))))

(define (smallest lst)
  (if (null? (cdr lst))
      (car lst)
      (smaller (car lst) (smallest (cdr lst)))))

(define (smaller val1 val2)
  (if (< val1 val2) val1 val2))

(define (list-remove lst val)
  (if (eq? val (car lst))
      (cdr lst)
      (cons (car lst) (list-remove (cdr lst) val))))

;;; test 2.5
;; (display '-)(newline)
;; (display 'selection-sort)(newline)
;; (selection-sort '(4 2 4 6 7 2 1 4 5))
;; (selection-sort '(13 8 5 3 2 1 1))
;; (selection-sort '(7 6 4 2 1 3 4 5 8))
