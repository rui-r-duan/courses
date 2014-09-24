(defpackage :ex1.pl.ryan
  (:use :common-lisp)
  (:export :prod-from-to :sum-from-to
	   :ryan-count :ryan-count-2
	   :ryan-list-length :ryan-list-length-2
	   :p
	   :flat
	   :bubble-sort-vector :bubble-sort-list
	   :ryan-sqrt))

(in-package :ex1.pl.ryan)

;; tail recursion optimized
(defun calc-recursive (op low high accumulator)
  (cond ((= low high) (funcall op low accumulator))
	((> low high) accumulator)
	(t (calc-recursive op (+ low 1) (- high 1)
			   (funcall op low high accumulator)))))

(defun prod-from-to (i j)
  (assert (and (integerp i) (integerp j)) (i j)
	  "~A and ~A are not both integers." i j)
  (if (<= i j)
      (calc-recursive #'* i j 1)
      (calc-recursive #'* j i 1)))

(defun sum-from-to (i j)
  (assert (and (integerp i) (integerp j)) (i j)
	  "~A and ~A are not both integers." i j)
  (if (<= i j)
      (calc-recursive #'+ i j 0)
      (calc-recursive #'+ j i 0)))

;; pre: (> n 0)
(defun ryan-count (n)
  (assert (and (integerp n) (> n 0)) (n)
	  "N must be a positive integer, but now N=~A" n)
  (labels ((reverse-count (low n)
	     (if (= low n)
		 (cons low nil)
		 (cons low (reverse-count (+ low 1) n)))))
    (reverse-count 1 n)))

;; tail recursion optimized
;; pre: (>= n 0)
(defun ryan-count-2 (n)
  (assert (and (integerp n) (>= n 0)) (n)
	  "N must be a non-negative integer, but now N=~A" n)
  (labels ((count-recursive (n accumulator)
	     (if (= n 0)
		 accumulator
		 (count-recursive (- n 1) (cons n accumulator)))))
    (count-recursive n nil)))

(defun ryan-list-length (lst)
  (if (null lst)
      0
      (+ 1 (ryan-list-length (cdr lst)))))

;; tail recursion optimized
(defun ryan-list-length-2 (lst)
  (labels ((list-len (lst length)
	     (if (null lst)
		 length
		 (list-len (cdr lst) (+ length 1)))))
    (list-len lst 0)))

(defun p (lst)
  (labels ((p-recur (lst accumulator)
	     (if (null lst)
		 accumulator
		 (p-recur (cdr lst) (* (car lst) accumulator)))))
    (p-recur lst 1)))

(defun flat (lst)
  (cond ((null lst) nil)
	((atom (car lst)) (cons (car lst) (flat (cdr lst)))) ; first elem is an atom
	(t (append (flat (car lst)) (flat (cdr lst)))))) ; first elem is a cons

;;; Bubble sort
(defun swap (array i j)
  (rotatef (aref array i) (aref array j)))
;; Only worked for array
(defun bubble-sort-vector (a)
  (let ((n (length a)))
    (do ((swapped t)) ; initial to be true only to pass the end-test-form for the first time
	((not swapped) a)	    ; loop until swapped is false, and return a
      (setf swapped nil)	    ; before every loop set 
      (loop for i from 1 to (- n 1)
	 when (> (aref a (- i 1)) (aref a i)) do
	   (swap a (- i 1) i)
	   (setf swapped t)))))

(defun bubble-sort-recursive (lst swapped)
  (labels ((one-pass-sink (lst)
	     (if (null lst)
		 nil
		 (let ((a (first lst))
		       (b (second lst)))
		   (cond ((eq b nil) lst)
			 ((> a b)
			  (setf swapped t)
			  (cons b (one-pass-sink (cons a (cddr lst)))))
			 (t (cons a (one-pass-sink (cdr lst)))))))))
      (let ((result (one-pass-sink lst)))
	(if swapped
	    (bubble-sort-recursive result nil)
	    lst))))
(defun bubble-sort-list (lst)
  (bubble-sort-recursive lst nil))

(defun sink (a lst)
  (if (null lst)
      (cons a nil)
      (if (> a (car lst))
	  (cons (car lst) (sink a (cdr lst)))
	  (cons a lst))))

;;; Newton's Square Root Approximation
(defun sqrt-iter (guess x)
  (if (good-enough-p guess x)
      guess
      (sqrt-iter (improve guess x)
		 x)))

(defun improve (guess x)
  (average guess (/ x guess)))

(defun average (x y)
  (/ (+ x y) 2))

(defun good-enough-p (guess x)
  (< (abs (- (square guess) x)) 0.0001))

(defun square (x)
  (* x x))

(defun ryan-sqrt (x)
  (sqrt-iter 1.0 x))