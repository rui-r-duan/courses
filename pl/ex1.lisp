(defpackage :ex1.pl.ryan
  (:use :common-lisp)
  (:export :prod-from-to :sum-from-to
	   :ryan-count :ryan-count-2
	   :ryan-list-length :ryan-list-length-2
	   :p
	   :flat))

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

;; n >= 0
(defun n-cdr (lst n)
  (if (= n 0)
      lst
      (n-cdr (cdr lst) (- n 1))))

;; first n elements
;; n >= 0
(defun first-n-elem (lst n)
  (cond ((null lst) nil)
	((= n 0) nil)
	(t (cons (car lst)
		 (first-n-elem (cdr lst) (- n 1))))))

;; zero-based index
;; i <= j
(defun ryan-subseq (lst i j)
  (first-n-elem (n-cdr lst i) (+ 1 (- j i))))
