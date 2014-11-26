#lang racket
(require test-engine/racket-tests)

(define-struct edge (orig dest))

(define (successors node graph)
  (cond [(empty? graph) empty]
        [else
         (let [(an-edge (first graph))]
           (cond [(symbol=? node (edge-orig an-edge))
                  (cons (edge-dest an-edge)
                        (successors node (rest graph)))]
                 [else
                  (successors node (rest graph))]))]))

(define (route-exists0? orig dest graph)
  (cond [(symbol=? orig dest) true]
        [else (route-exists/nodes0? (successors orig graph)
                                    dest graph)]))

(define (route-exists/nodes0? origins dest graph)
  (cond [(empty? origins) false]
        [else
         (or (route-exists0? (first origins) dest graph)
             (route-exists/nodes0? (rest origins) dest graph))]))

(define G2
  (list
   (make-edge 'c 'a)
   (make-edge 'c 'b)
   (make-edge 'd 'c)
   (make-edge 'e 'c)
   (make-edge 'f 'c)
   (make-edge 'g 'd) ; cycle
   (make-edge 'd 'g) ; cycle
   (make-edge 'g 'e)
   (make-edge 'h 'g)
   (make-edge 'h 'f)))

(check-expect (successors 'g G2) '(d e))

(require racket/trace)
; g's successors are '(d e)
; d's successsors are '(c g) !!! g cycle!!!
;(trace route-exists0? route-exists/nodes0?) ; infinite recursion

(define (route-exists? orig dest graph)
  (local [;; Node Node Graph (Listof Node) -> Boolean
          ;; uses accumulator to keep track of nodes visited so far
          (define (route-exists-aux? orig dest graph nodes-so-far)
            (cond [(symbol=? orig dest) true]
                  [(member orig nodes-so-far) false]
                  [else
                   (route-exists/nodes? (successors orig graph)
                                        dest
                                        graph
                                        (cons orig nodes-so-far))]))
          ;; (Listof Node) Node Graph (Listof Node) -> Boolean
          ;; uses accumulator to keep track of nodes visited so far
          (define (route-exists/nodes? origins dest graph nodes-so-far)
            (cond [(empty? origins) false]
                  [else
                   (or (route-exists-aux? (first origins)
                                          dest graph nodes-so-far)
                       (route-exists/nodes? (rest origins) dest graph
                                            nodes-so-far))]))]
    (route-exists-aux? orig dest graph empty)))

(route-exists? 'g 'f G2)
(route-exists? 'b 'a G2)
(route-exists? 'h 'b G2)

(if '() 5 3)
