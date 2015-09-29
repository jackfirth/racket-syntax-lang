#lang scribble/manual

@title{Language creation}

@defmodule[syntax/lang]

This module provides forms for creating new @hash-lang[] languages.
It abstracts over several language-creation components such as
@racket[syntax/module-reader], reader submodules, and @racket[#%module-begin].
This library makes it easy to create simple one-off languages driven by
a single macro.

@author[@author+email["Jack Firth" "jackhfirth@gmail.com"]]

@defform[(define-lang-syntax lang-collection-name module-body-syntax maybe-module-begin)
         #:grammar [(maybe-module-begin (code:line)
                                        #:module-begin base-module-begin)]]{
  Defines a reader submodule that implements a @hash-lang[] that is equivalent
  to @racketmodname[racket/base], except that @racket[module-body-syntax] wraps
  all forms in the module. This must be used in the @code{main.rkt} file of the
  collection directory @racket[lang-collection-name]. For example, assuming this
  is in the main file of a collection directory named @racket[display-syntax]:
  @racketblock[
    (define-syntax display-each-body-stx
      (syntax-parser
        [(_ body ...)
         #'(begin (displayln #'body) ...)]))
  ]
  Then the following creates a @hash-lang[] @code{display-syntax} that prints each
  syntax object of the language when run:
  @racketblock[
    (define-lang-syntax display-syntax display-each-body-stx)
  ]
  If @racket[base-module-begin] is provided, it is used as the
  @racket[#%module-begin] of the new language instead of the
  @racket[#%module-begin] from @racketmodname[racket/base].
}
