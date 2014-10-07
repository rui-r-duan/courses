;;; Find the last but one element of a list.
(define (last-but-one xs)
  (cond ((null? xs) xs)
	((null? (cdr xs)) null)
	((null? (cddr xs)) (car xs))
	(else (last-but-one (cdr xs)))))
