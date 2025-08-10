(defun node-name (tree) (car tree))
(defun children (tree) (cadr tree))
(defun make-tree (node children)
  (list node children))
