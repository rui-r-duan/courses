;;; Solution one
;;;     List and symbolic computation without inheritance
;;;
;;; If the system need to get the relationship of inheritance, it must process
;;; 'FORM-OF, 'MADE-OF and 'INSTANCE-OF, and track the relationship of them in
;;; the program.
;;;
;;; Author: Rui Duan <rduan@lakeheadu.ca>
;;; Date: Sep 16, 2014

(defpackage :ai.bonus
  (:use :common-lisp)
  (:export :prop-query :reverse-prop-query :property-values))

(in-package :ai.bonus)

(defun prop-query (prop item kb)
  (let ((rule (assoc item kb)))
    (when rule
      (cadr (assoc prop (cdr rule))))))

(defun reverse-prop-query (prop val kb)
  (if (null kb)
      nil
      (let ((rule (car kb)))
	(assert (consp rule)
		(rule) "(CAR KB) is ~A which is not a rule." rule)
	(let ((item (car rule))
	      (prop-alist (cdr rule)))
	    (if (find-if #'(lambda (pair)
			     (and (eq prop (car pair))
				  (eq val (cadr pair))))
			 prop-alist)
		(cons item (reverse-prop-query prop val (cdr kb)))
		(reverse-prop-query prop val (cdr kb)))))))

(defun flatten-prop-alist (kb)
  (if (null kb)
      nil
      (append (cdr (car kb)) (flatten-prop-alist (cdr kb)))))

(defun traverse-alist (prop lst)
  (if (null lst)
      nil
      (let ((target-list (member prop lst :key #'car)))
	(if target-list
	    (cons (cadr (car target-list))
		  (traverse-alist prop (cdr target-list)))
	    (traverse-alist prop (cdr lst))))))

;;; Assumes in one rule, no duplicate property, for example:
;;;     '(a (color blue) (color white))
;;; has duplicated colors, only the first one is collected, the second one is
;;; omitted.
(defun property-values (prop kb)
  (let ((flat-alist (flatten-prop-alist kb)))
      (traverse-alist prop flat-alist)))