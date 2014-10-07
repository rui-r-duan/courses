;;; Find the last element of a list.
;;;
;;; Note:
;;;    (car '()) and (cdr '()) will result in the following runtime exception:
;;;
;;;   car (or cdr): contract violation
;;    expected: pair?
;;    given: '()
;;    context...:
;;     c:\Program Files\Racket\collects\racket\private\misc.rkt:87:7

(define (last-elem xs)
  (cond ((null? xs) '())
	((null? (cdr xs)) (car xs))
	(else (last-elem (cdr xs)))))
