;;; Find the last element of a list.
(defun last-elem (list)
  (cond ((null list) nil)
	((null (cdr list)) (car list))
	(t (last-elem (cdr list)))))
