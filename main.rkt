#lang racket/base

(provide power-struct)

(require syntax/parse/define (for-syntax racket/base racket/list racket/syntax))
(begin-for-syntax
  (define-splicing-syntax-class kwid
    (pattern (~seq kw:keyword default:expr)
             #:attr id*          (format-id #'kw "~a" (keyword->string (syntax-e #'kw)))
             #:attr (formals 1)  (list #'kw #'(id* default)))))
(define-syntax-parser power-struct
  ([_ name:id maybe-super:id (kw-id:kwid ...) rest ...]
   #:with constructor    (format-id #'name "make-~a" #'name)
   #'(begin
       (struct name maybe-super (kw-id.id* ...) rest ...)
       (define (constructor kw-id.formals ... ...)
         (name kw-id.id* ...))))
  ([_ name:id (kw-id:kwid ...) rest ...]
   #:with constructor    (format-id #'name "make-~a" #'name)
   #'(begin
       (struct name (kw-id.id* ...) rest ...)
       (define (constructor kw-id.formals ... ...)
         (name kw-id.id* ...))
   )))

(module+ test
  (power-struct X (#:a 1 #:b 2) #:prefab)
  (make-X #:a 10)
  (X-b (make-X #:b 10)))

