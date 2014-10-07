;;; Find the last but one element of a list.
(defun last-but-one (list)
  (cond ((null list) list)
	((null (cdr list)) nil)
	((null (cddr list)) (car list))
	(t (last-but-one (cdr list)))))
