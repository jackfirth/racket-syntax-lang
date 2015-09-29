#lang racket/base

(provide define-lang-syntax)


(define-syntax-rule (define-lang-syntax lang-collection-name module-syntax)
  (begin
    (define-syntax-rule (new-module-begin module-body (... ...))
      (#%module-begin (module-syntax module-body (... ...))))
    (module reader syntax/module-reader lang-collection-name)
    (provide (rename-out [new-module-begin #%module-begin]))))
