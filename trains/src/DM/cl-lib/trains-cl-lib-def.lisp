;;; Time-stamp: <Tue Jan 14 10:10:09 EST 1997 ferguson>
;;;
;;; Things ripped from cl-lib for use in TRAINS-96 v2.1
;;;
;;; Please see ftp://ftp.cs.rochester.edu/pub/packages/knowledge-tools
;;; for the real cl-lib, and/or contact miller@cs.rochester.edu for more
;;; information.
;;;

(in-package :cl-user)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Copyright (C) 1996, 1995, 1994, 1993, 1992 by Bradford W. Miller, miller@cs.rochester.edu
;;;                                and the Trustees of the University of Rochester
;;; Unlimited non-commercial use is granted to the end user, other rights to
;;; the non-commercial user are as granted by the GNU LIBRARY GENERAL PUBLIC LICENCE
;;; version 2 which is incorporated here by reference. (if you don't think you can
;;; incorporate these things by reference, then you have no other rights, so go away
;;; and stop bothering me).

;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU Library General Public License as published by
;;; the Free Software Foundation; version 2.

;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU Library General Public License for more details.

;;; You should have received a copy of the GNU Library General Public License
;;; along with this program; if not, write to the Free Software
;;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; From defsystem.lisp
;;;

(defpackage cl-lib
  (:use common-lisp)
  (:export #:*cl-lib-version*
           #:force-list  #:flatten #:alist
           #:force-string
	   #:round-to 
	   #:extract-keyword
	   #:update-alist #:msetq #:mlet #:while #:while-not #:let*-non-null
	   #:cond-binding-predicate-to 
	   #:defclass-x #:defflag #:defflags #:let-maybe
	   #:eqmemb #:neq
	   #:make-keyword
           #:progfoo #:foo
	   ;; cl-sets
           #:cross-product 
	   ;; initializations
	   #:add-initialization #:initializations #:reset-initializations
           ;; clos-extensions
           #:make-load-form-with-all-slots #:determine-slot-readers #:determine-slot-writers #:determine-slot-initializers
           #:generate-legal-slot-initargs
           ;; syntax
           #:add-syntax #:with-syntax #:set-syntax
	   ;; better-errors
	   #:parser-error
           ))
