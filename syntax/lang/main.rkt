#lang racket/base

(provide define-lang-syntax)

(require (for-syntax racket/base
                     syntax/parse))


(define-syntax define-lang-syntax
  (syntax-parser
    [(_ lang-collection-name module-syntax
        #:module-begin base-module-begin)
     #'(begin
         (define-syntax-rule (new-module-begin module-body (... ...))
           (base-module-begin (module-syntax module-body (... ...))))
         (module reader syntax/module-reader lang-collection-name)
         (provide (rename-out [new-module-begin #%module-begin])))]
    [(_ lang-collection-name module-syntax)
     #'(define-lang-syntax lang-collection-name module-syntax
         #:module-begin #%module-begin)]))
