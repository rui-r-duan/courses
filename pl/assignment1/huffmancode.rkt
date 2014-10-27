;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname huffmancode) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ())))
;;; Huffman Code
;;; (encode-symbol symbol tree) defined by
;;;   Rui Duan (0561866)

;;;---------------------------------------------------------------------
;;; Leaves
;;; Leaves are represented by a list consisting of three items:
;;; the symbol 'leaf, the symbol to be represented, and the weight.

(define make-leaf
  (lambda (symbol weight)
    (list 'leaf symbol weight)))

(define leaf?
  (lambda (object)
    (eq? (car object) 'leaf)))

(define symbol-leaf
  (lambda (leaf)
    (cadr leaf)))

(define weight-leaf
  (lambda (leaf)
    (caddr leaf)))

;;;---------------------------------------------------------------------
;;; Huffman trees
;;; Huffman trees are represented by a list consisting of four items:
;;; a left branch, a right branch, a list of symbols, and a weight.

(define make-code-tree
  (lambda (left right)
    (list left 
          right 
          (append (symbols left) (symbols right))
          (+ (weight left) (weight right)))))

(define left-branch
  (lambda (tree)
    (car tree)))

(define right-branch
  (lambda (tree)
    (cadr tree)))

(define symbols
  (lambda (tree)
    (if (leaf? tree)
        (list (symbol-leaf tree))
        (caddr tree))))

(define weight
  (lambda (tree)
    (if (leaf? tree)
        (weight-leaf tree)
        (cadddr tree))))

;;;------------------------------------------------------------------------
;;; Decoding
;;; Given a list of bits it will return the appropriate list of symbols.
;;; The helper decode-1 handles one traversal down the tree to a leaf.

(define decode
  (lambda (bits tree)
    (local [(define decode-1
             (lambda (bits current-branch)
               (cond
                 ((null? bits) '())
                 (else
                  (let ((next-branch (choose-branch (car bits) current-branch)))
                    (cond
                      ((leaf? next-branch)
                       (cons (symbol-leaf next-branch)
                             (decode-1 (cdr bits) tree)))
                      (else
                       (decode-1 (cdr bits) next-branch))))))))]
      (decode-1 bits tree))))

(define choose-branch
  (lambda (bit branch)
    (cond
      ((= bit 0) (left-branch branch))
      ((= bit 1) (right-branch branch))
      (else (error "bad bit in choose-branch:" bit)))))

;;;------------------------------------------------------------------------
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree (make-leaf 'B 2)
                                  (make-code-tree (make-leaf 'C 1)
                                                  (make-leaf 'D 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

;; test
(check-expect (decode sample-message sample-tree)
              '(A C A B B D A))

;;;------------------------------------------------------------------------
(define encode
  (lambda (message tree)
    (cond
      ((null? message) '())
      (else
       (append (encode-symbol (car message) tree)
               (encode (cdr message) tree))))))

;;;-------------------------------------------------------------------------
;;; Defined by Rui Duan

(define (encode-symbol symbol tree)
  (cond ((empty? tree) empty)
        ((leaf? tree) empty)
        ((symbol-in-left? symbol tree)
         (append (list 0) (encode-symbol symbol (left-branch tree))))
        ((symbol-in-right? symbol tree)
         (append (list 1) (encode-symbol symbol (right-branch tree))))
        (else (error "this symbol is not in the tree: " symbol))))

(define (symbol-in-left? symbol tree)
  (member? symbol (symbols (left-branch tree))))

(define (symbol-in-right? symbol tree)
  (member? symbol (symbols (right-branch tree))))

;; test
(check-expect (encode '(A C A B B D A) sample-tree)
              sample-message)
              
(check-error (encode '(A C F B B D A) sample-tree)
             "this symbol is not in the tree: 'F")
