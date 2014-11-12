;;;----------------------------------------------------------------------------
;;; author: Rui Duan (0561866)
;;;
;;; Pascal Triangle Solution 3 (memoization of solution 1)
;;; (Exercise 2, problem 3)
;;;----------------------------------------------------------------------------

;;; code of memoizer is from SICP
(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
	(cdr record)
	#f)))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
	(set-cdr! record value)
	(set-cdr! table
		  (cons (cons key value) (cdr table)))))
  'ok)

(define (make-table)
  (list '*table*))

;;; sequence index of the term in pascal triangle, begins from 0
;;; row and col begin from 0
(define (seq-index row col)
  (+ (sum-from-one-to-n row) col))
(define (sum-from-one-to-n n)
  (define (helper i acc)
    (if (> i n)
	acc
	(helper (+ i 1) (+ i acc))))
  (helper 1 0))

(define (memoize f)
  (let ((table (make-table)))
    (lambda (row col)
      (let* ((x (seq-index row col))
	     (previously-computed-result (lookup x table)))
	(or previously-computed-result
	    (let ((result (f row col)))
	      (insert! x result table)
	      result))))))

;;;------------------------------------------------------------
;;; Following are my code

;;; row index and col index both begin from 0
(define memo-pascal-term
  (memoize (lambda (row col)
	     (cond ((< row col) #f)	; exceed boundary
		   ((or (= 0 col) (= row col)) 1) ; edge element
		   (else (+ (memo-pascal-term (- row 1) col)
			    (memo-pascal-term (- row 1) (- col 1))))))))

;;; n begins from 0
(define (pascal-row n)
  (define (build-row col)
    (if (> col n)
	'()
	(cons (memo-pascal-term n col) (build-row (+ col 1)))))
  (build-row 0))

;;; generate pascal triangle upto n-th row, n begins from 0
(define (pascal-triangle n)
  (define (build-triangle i)   
    (if (> i n)
	'()
	(cons (pascal-row i) (build-triangle (+ i 1)))))
  (build-triangle 0))
