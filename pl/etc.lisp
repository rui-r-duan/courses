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

(defun swap-first-two (lst)
  (cons (cadr lst) (cons (car lst) (cddr lst))))

(defun one-pass-sink (lst)
  (let ((a (first lst))
	(b (second lst)))
    (if (eq b nil)
	lst
	(if (> a b)
	    (one-pass-sink (cdr (cons b (cons a (cddr lst)))))
	    (one-pass-sink (cdr lst))))))
