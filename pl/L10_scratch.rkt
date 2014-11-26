#lang racket
;<expr> ::= <symbol>
; | <number>
; | (+ <expr> <expr>)
; | (* <expr> <expr>)
; | (if0 <expr> <expr> <expr>)
; | (lambda (<symbol>) <expr>)
; | (<expr> <expr>)
(require racket/match)

(define (eval expr env)
  (cond
    [(symbol? expr) (second (assoc expr env))]
    [(number? expr) expr]
    [(list? expr)
     (match expr
       [(list '+ l r) (+ (eval l env) (eval r env))]
       [(list '* l r) (* (eval l env) (eval r env))]
       [(list 'if0 pred con alt)
        (if (eq? 0 (eval pred env))
            (eval con env)
            (eval alt env))]
       [(list 'lambda (list arg) body)
        (list 'closure arg body env)]
       [(list f arg)
        (match (eval f env)
          [(list 'closure f-param f-body f-env)
           (eval f-body
                 (cons (list f-param (eval arg env))
                       f-env))])])]))


(match '(1 2 3)
  [(list 1 a ...) a])