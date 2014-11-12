;;;----------------------------------------------------------------------
;;; author: Rui Duan (0561866)
;;; date: November 12, 2014
;;;
;;; Pascal Triangle Solution 1 (Excercise 2, problem 3)
;;;----------------------------------------------------------------------

;;; row index and col index both begin from 0
(define (pascal-term row col)
  (cond ((< row col) #f)		; exceed boundary
	((or (= 0 col) (= row col)) 1)	; edge element
	(else (+ (pascal-term (- row 1) col)
		 (pascal-term (- row 1) (- col 1))))))

;;; n begins from 0
(define (pascal-row n)
  (define (build-row col)
    (if (> col n)
	'()
	(cons (pascal-term n col) (build-row (+ col 1)))))
  (build-row 0))

;;; generate pascal triangle upto n-th row, n begins from 0
(define (pascal-triangle n)
  (define (build-triangle i)   
    (if (> i n)
	'()
	(cons (pascal-row i) (build-triangle (+ i 1)))))
  (build-triangle 0))
