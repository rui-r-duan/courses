;;; Find the K'th element of a list.
;;; The first element in the list is number 1 (index begins from 1).

;;; Note: (nth n list) is predefined but index begins from 0.

(defun element-at (n list)
  (assert (and (integerp n) (> n 0)) (n)
	  "~A is not a integer that is greater than 0" n)
  (if (= n 1)
      (car list)
      (element-at (- n 1) (cdr list))))
