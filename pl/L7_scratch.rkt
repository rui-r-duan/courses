#lang racket
(require racket/trace)

(when (> 5 0)
  (begin (display "hi ")
         (display "there")))

(unless (> -5 0)
  (begin (display "hi ")
         (display "there\n")))

; in choice, either symbols (without quotes) or numbers
(let [(x 5)
      (y 'a)]
  (case x
    ((5 6 7) 'hi)
    ((3 4 5) 'there)))

(let [(x 5)
      (y 'a)]
  (case x
    ((3 4 5) 'there)
    ((5 6 7) 'hi)))

(match 3
  [1 'one]
  [2 'two]
  (3 'three))

; . is not allowed in advanced student lang
(match '(1 2 3 4)
  [(list-rest a b c d) d]) ; => '(4)
(match '(1 2 3 . 4)
  [(list-rest a b c d) d]) ; => 4
(match '(1 2 3 4)
  [(list a b c d) d]) ; => 4

(for ([i (in-range 1 4)])
  (display i))

(in-range 1 4 2) ; => #<stream>

(newline)
(for ([i (in-range 1 4)]
      [chapter '("Intro" "Details" "Conclusion")])
  (printf "Chapter ~a. ~a\n" i chapter))

(newline)
(for* ([book '("Guide" "Reference")]
       [chapter '("Intro" "Details" "Conclusion")]
       #:when (not (equal? chapter "Details")))
  (printf "~a ~a\n" book chapter))

(newline)
(for ([book '("Guide" "Story" "Reference")]
      #:unless (equal? book "Story")
      [chapter '("Intro" "Details" "Conclusion")])
  (printf "~a ~a\n" book chapter))
; equivalence
(newline)
(for ([book '("Guide" "Story" "Reference")])
  (unless (equal? book "Story")
    (for ([chapter '("Intro" "Details" "Conclusion")])
      (printf "~a ~a\n" book chapter))))

(newline)
(for ([book '("Guide" "Story" "Reference")]
      [chapter '("Intro" "Details" "Conclusion")]
      #:unless (equal? book "Story"))
  (printf "~a ~a\n" book chapter))

(newline)
(for* ([i '(1 2)]
       [j "ab"])
  (display (list i j)))
(newline)
(for ([i '(1 2)]
      [j "ab"])
  (display (list i j)))

(newline)
(for/list ([i '(1 2 3)])
  (* i i))

(for/and ([chapter '("Intro" "Details" "Conclusion")])
  (equal? chapter "Intro"))

(for/or ([chapter '("Intro" "Details" "Conclusion")])
  (equal? chapter "Intro"))

(newline)
(for/and ([i '()])
  (error "doesn't get here"))
(for/and ([i '(1 2)])
  (printf "get here ~a\n" i))
(for/or ([i '()])
  (error "doesn't get here"))
(for/or ([i '(1 2)])
  (printf "get here ~a\n" i))

(newline)
(map sqrt (list 1 4 9 16))
(andmap string? (list "a" "b" "c"))
(andmap string? (list "a" "b" 6))
(ormap number? (list "a" "b" 6))
(filter string? (list "a" "b" 6))
(filter positive? (list 1 -2 6 7 0))

(define (foo x)
  (define (bar y)
    (+ x y))
  (+ x (bar 5)))

(foo 1) ;=> 7

(define (remove-dups l)
  (cond
    [(empty? l) empty]
    [(empty? (rest l)) l]
    [else
     (let ([i (first l)])
       (if (equal? i (first (rest l)))
           (remove-dups (rest l))
           (cons i (remove-dups (rest l)))))]))
(trace remove-dups)

(define (make-bin-tree-leaf E)
  (list E)
  )

(define (make-bin-tree-node E B1 B2)
  (list E B1 B2)
  )

(define treeA
  (make-bin-tree-node '*
                      (make-bin-tree-node '+
                                          (make-bin-tree-leaf 2)
                                          (make-bin-tree-leaf 3))
                      (make-bin-tree-node '-
                                          (make-bin-tree-leaf 7)
                                          (make-bin-tree-leaf 8))))

(define-struct binary-tree
  (root left right))

(define (insert x t)
  (cond ((not (number? x))
         (display "1st arg must be numeric")
         t)
        ((null? t)
         (make-binary-tree x null null))
        ((not (binary-tree? t))
         (display "2nd arg must be ")
         (display "a binary tree")
         t)
        ((< x (binary-tree-root t))
         (make-binary-tree
          (binary-tree-root t)
          (insert x
                  (binary-tree-left t))
          (binary-tree-right t)))
        (else
         (make-binary-tree
          (binary-tree-root t)
          (binary-tree-left t)
          (insert x
                  (binary-tree-right t))))))

(define (print-in-inorder t)
  (define (visit x)
    (display " ") (display x) (display " "))
  (cond ((null? t) 'ok)
        (else
         (print-in-inorder (binary-tree-left t))
         (visit (binary-tree-root t))
         (print-in-inorder (binary-tree-right t)))))

(define test-cases
  '((define t (insert 5 null))
    (define u (insert 7 t))
    (define v (insert 6 u))
    (define w (insert 8 v))
    w
    (print-in-inorder w)
    (equal? t (insert 5 null))))

(define (test)
  (for-each
   (lambda (test-case)
     (write test-case) (newline)
     (write (eval test-case)) (newline))
   test-cases))

(eq? 'a 'a)
(eqv? '(a b) '(a b))
(equal? '(a b (c)) '(a b (c)))