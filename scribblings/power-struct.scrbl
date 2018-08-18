#lang scribble/manual
@require[@for-label[power-struct
                    racket/base]
	 scribble/example]

@title{power-struct}
@author{Kevin Robert Stravers}

@defmodule[power-struct]

Defines a struct form that implements default values and construction in an ergonomic manner.

@examples[
(require power-struct)

(power-struct X (#:a 10 #:b 20) #:prefab)
(make-X #:b 9)
(X-a (make-X #:b 9))
]

Otherwise functions as a completely regular struct. The only difference is that we use keywords instead of ids.

@defform[(power-struct name maybe-super (kw-default ...) rest ...)]{
	Defines a power-struct. The @racket[kw-default] takes a single keyword and a default value. If the keyword is missing during construction in @racket[make-name], then the default value is used.
	Normal struct accessors like @racket[name-id] are generated.
}
