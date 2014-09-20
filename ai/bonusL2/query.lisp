;;; Solution one
;;;     List and symbolic computation
;;;
;;; The system understand 'FORM-OF, 'MADE-OF, 'IS-A and 'INSTANCE-OF,
;;; and then can do some inference based on the understanding.
;;;
;;; Main functions are:
;;;     prop-query         : can handle inheritance (single inheritance)
;;;     reverse-prop-query : cannot handle inheritance
;;;     property-values    : collect all the items that has the property with
;;;                          that value
;;;
;;; Author: Rui Duan <rduan@lakeheadu.ca>
;;; Date: Sep 16, 2014

(defun first-node (kb)
  (assert (consp kb) (kb) "~A is not a cons" kb)
  (car kb))

(defun rest-kb (kb)
  (assert (consp kb) (kb) "~A is not a cons" kb)
  (cdr kb))

(defun find-node (item kb)
  (assoc item kb))

(defun get-item (node)
  (assert (not (atom node)) (node)
	  "~A is not in the form of '(a (prop1 val1) (prop2 val2) ...)" node)
  (car node))

(defun get-prop-alist (node)
  (assert (not (atom node)) (node)
	  "~A is not in the form of '(a (prop1 val1) (prop2 val2) ...)" node)
  (cdr node))

(defun get-prop (prop node)
  (assoc prop (get-prop-alist node)))

(defun prop-value (prop)
  (cadr prop))

;;; Build an inheritance precedence list.
;;; !!! cannot handle multiple inheritance and diamond inheritance !!!
(defun track-recursive (node kb)
  (labels ((helperf (prop-symb-lst)
	     (let ((c (get-prop (car prop-symb-lst) node)))
	       (if c
		   (let* ((val (prop-value c))
			  (n (find-node val kb)))
		     (if (eq n nil)
			 (list (list val))
			 (cons n (track-recursive n kb))))
		   (helperf (cdr prop-symb-lst))))))
    (helperf '(instance-of is-a form-of made-of))))
  ;; (let ((class (get-prop 'instance-of node)))
  ;;   (if class
  ;; 	(let* ((val (prop-value class))
  ;; 	       (n (find-node val kb)))
  ;; 	  (if (eq n nil)
  ;; 	      (list (list val))
  ;; 	      (cons n (track-recursive n kb))))
  ;; 	(let ((superclass (get-prop 'is-a node)))
  ;; 	  (if superclass
  ;; 	      (let* ((val (prop-value superclass))
  ;; 		     (n (find-node val kb)))
  ;; 		(if (eq n nil)
  ;; 		    (list (list val))
  ;; 		    (cons n (track-recursive n kb))))
  ;; 	      (let ((superform (get-prop 'form-of node)))
  ;; 		(if superform
  ;; 		    (let* ((val (prop-value superform))
  ;; 			   (n (find-node val kb)))
  ;; 		      (if (eq n nil)
  ;; 			  (list (list val))
  ;; 			  (cons n (track-recursive n kb))))
  ;; 		    (let ((madeof (get-prop 'made-of node)))
  ;; 		      (if madeof
  ;; 			  (let* ((val (prop-value madeof))
  ;; 				 (n (find-node val kb)))
  ;; 			    (if (eq n nil)
  ;; 				(list (list val))
  ;; 				(cons n (track-recursive n kb))))
  ;; 			  nil)))))))))
(defun track (item kb)
  (let ((node (find-node item kb)))
    (when node
      (cons node (track-recursive node kb)))))

;;; Value Inheritance Procedure
(defun prop-query-r (prop tracked-kb)
  (let ((node (first-node tracked-kb))
	(restkb (rest-kb tracked-kb)))
    (let ((p (get-prop prop node)))
      (if p
	  (prop-value p)
	  (prop-query-r prop restkb)))))
(defun prop-query (prop item kb)
  (let ((tkb (track item kb)))
    (prop-query-r prop tkb)))

(defun reverse-prop-query (prop val kb)
  (if (null kb)
      nil
      (let ((node (car kb)))
	(assert (consp node)
		(node) "(CAR KB) is ~A which is not a node." node)
	(let ((item (get-item node))
	      (prop-alist (get-prop-alist node)))
	    (if (find-if #'(lambda (pair)
			     (and (eq prop (car pair))
				  (equal val (cadr pair))))
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

;;; Assumes in one node, no duplicate property, for example:
;;;     '(a (color blue) (color white))
;;; has duplicated colors, only the first one is collected, the second one is
;;; omitted.
(defun property-values (prop kb)
  (let ((flat-alist (flatten-prop-alist kb)))
      (traverse-alist prop flat-alist)))
