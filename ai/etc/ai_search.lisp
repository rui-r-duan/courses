(defparameter *open* nil)
(defparameter *closed* nil)

(defun general_search (goal insert kb)
  (loop while (not (null *open*))
       do
       (let ((current (car *open*)))
	 (setf *closed* (cons current *closed*))
	 (if (funcall goal current)
	     (get-path current kb)
	     (let ((successors (expand current kb)))
	       (setf successors (remove-visited successors *closed*))
	       (setf *open* (funcall insert successors *open*))))))
  'fail)
