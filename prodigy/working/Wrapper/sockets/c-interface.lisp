;;; -*- Mode: LISP; Syntax: Common-lisp; Package: user -*- ;;;

;;; copyright goes here
(in-package :user)
(defvar c-interface-rcsid "$Header: /tmp_mnt/net/panda/u14/plum/rcs/lib/c-interface.lisp,v 1.6 1996/09/05 15:15:05 sboisen Exp $")

;;; PURPOSE: interface support for loading C code.
;;; Everything in here should be as generic as possible, with minimal
;;; PLUM dependencies, so this can be loaded by applications that
;;; don't load major parts of PLUM.


;;; -------------------------- EXTERNAL SYMBOLS --------------------------
;;; DEF-C-FUNCTION (lisp-name &key (return-type :integer)               [MACRO]
;;;                 (entry-point
;;;                 (foreign-functions:convert-to-lang lisp-name
;;;                 :language :c)) (arguments))
;;;    Vendor-independent (sort of) definition for foreign C functions: no
;;;    args are evaluated.
;;;    :ENTRY-POINT should be a string with the same name as the C source
;;;    file: details of whether _ should be prepended are handled inside
;;;    here. :ARGUMENTS is a list of pairs of argument name and arg type,
;;;    for example ((arg1 :fixnum))
;;;
;;; TEST-C-RETURN (expr &key (zero-is-bad nil))                         [MACRO]
;;;    Complain if EXPR, presumed to be a call to some C function, returns
;;;    a 'bad' value. Normally bad means -1, with :zero-is-bad also 0. This
;;;    is probably a bad thing to put in inner loop code because its
;;;    efficiency isn't guaranteed. Returns the result of EXPR, but doesn't
;;;    handle multiple values correctly,but who should care. 
;;; ----------------------------------------------------------------------

;; this is only set to handle ALLEGRO, LUCID, and ACLPC (Allegro's
;; Windows product)
;; WARNING: if you make changes here, you'll have to delete other
;; systems' uses of this macro (at least hspurt)
(defmacro def-c-function (lisp-name &key
				    (return-type
				     #+ACLPC :long
				     #-ACLPC :integer)
				    (entry-point
				     ;; this is a bad hack
				     #-ALLEGRO (string-downcase
						(symbol-name lisp-name)))
				    (arguments)
				    ;; only used by ACLPC
				    (library-name)
				    ;; only used by ALLEGRO
				    (arg-checking t)
				    (call-direct nil))
  "Vendor-independent (sort of) definition for foreign C functions: no
args are evaluated.
:ENTRY-POINT should be a string with the same name as the C source
file: details of whether _ should be prepended are handled inside
here. :ARGUMENTS is a list of pairs of argument name and arg type, for
example ((arg1 :fixnum))"
  (declare (ignore
	    #-ACLPC library-name
	    #-ALLEGRO arg-checking
	    #-ALLEGRO call-direct))
  #+ALLEGRO (require :foreign)
  (let* (#+ALLEGRO
	 (arg-alist '((:integer . integer)
		       (:fixnum . fixnum)
		       (:single-float . single-float)
		       (:double-float . double-float)
		       (:character . character)
		       (:string . string)
		       (:simple-string . simple-string)
		       ;; lucidisms
		       ((:pointer :character) . string)
		       (t . t)))
	 (native-args
	  #+ALLEGRO(mapcar
		    #'(lambda (x) (or (cdr (assoc (cadr x) arg-alist
						  :test #'equal))
				      (cadr x)))
		    `,arguments)
	  #-ALLEGRO `,arguments))
    #+ALLEGRO
    `(ff:defforeign ',lisp-name
		    :arguments ',native-args
		    :return-type ,(if (null return-type)
				      :void
				      return-type)
		    :entry-point ,(ff:convert-to-lang (or entry-point
							  lisp-name)
						      :language :c)
		    :arg-checking ,arg-checking
		    :call-direct ,call-direct)
    ;; this could do more error-checking: the library should have the
    ;; extension dll, the arg and return types are different from Unix
    #+ACLPC
    `(ct:defun-dll ,lisp-name ,native-args
		   :entry-name ,entry-point
		   :return-type ,return-type
		   :libary-name ,library-name)
    #+LUCID
    (let (
	  ;; rather a bad hack: add leading "_" if not MIPS
	  (lucid-ff-entry
	   #+MIPS `,entry-point
	   #-MIPS `,(format nil "_~a" entry-point)))
      `(def-foreign-function (,lisp-name
			      (:language :c)
			      (:return-type ,return-type)
			      (:name ,lucid-ff-entry))
	 ,@native-args))
    #-(:or ALLEGRO ACLPC LUCID)
    (warn "def-c-function: not conditionalized for this lisp.")))


;;; utilities

(defmacro test-c-return (expr &key (zero-is-bad nil))
  "Complain if EXPR, presumed to be a call to some C function, returns
a 'bad' value. Normally bad means -1, with :zero-is-bad also 0. This
is probably a bad thing to put in inner loop code because its
efficiency isn't guaranteed. Returns the result of EXPR, but doesn't
handle multiple values correctly,but who should care. "
  `(let ((returnval ,expr))
     (typecase returnval
	       (number
		(when (< returnval ,(if zero-is-bad 1 0))
		  (format t "TEST-C-RETURN: Calling ~a returned ~d!~%"
			  (quote ,expr) returnval)))
	       ;; don't know what to do if it doesn't return a number
	       (t nil))
     returnval))


(defun get-environment-variable (var-string)
  (system:getenv var-string)
  )
