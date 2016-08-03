(DECLAIM (OPTIMIZE (SPEED 2) (SAFETY 1) (DEBUG 0))) 

;;; Time-stamp: <Mon Jan 20 14:48:30 EST 1997 ferguson>
;;;
;;; Things ripped from cl-lib for use in TRAINS-96 v2.2
;;;
;;; Please see ftp://ftp.cs.rochester.edu/pub/packages/knowledge-tools
;;; for the real cl-lib, and/or contact miller@cs.rochester.edu for more
;;; information.
;;;

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

(when (not (find-package :cl-lib))
  (load "trains-cl-lib-def"))
(in-package :cl-lib)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; From cl-lib-version
;;;
(defvar *cl-lib-version* "4.11 for TRAINS-96 2.2"
  "Version of CL-LIB that is loaded")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; From cl-extensions.lisp
;;;

(DEFMACRO DEFCLASS-X (TYPE SUPERTYPES SLOTS . STUFF)
  "Extended defclass, also creates a TYPE-P function and MAKE-TYPE function, like defstuct did."
  `(eval-when (compile load eval)
     (DEFCLASS ,TYPE ,SUPERTYPES ,SLOTS ,@STUFF)
     (DEFUN ,(INTERN (CONCATENATE 'STRING (STRING TYPE) "-P")) (TERM)
       (TYPEP TERM ',TYPE))
     (DEFUN ,(INTERN (CONCATENATE 'STRING "MAKE-" (STRING TYPE))) (&REST ARGS)
       (APPLY 'MAKE-INSTANCE ',TYPE ARGS))))

;; this is to support a field in a clos structrure called "flags", which is bit encoded. The testname can be used to see if the
;; bit (defined by flagname - a constant) is set. It can also be setf to set or clear it. The type is the type of structure this
;; test will handle, allowing multiple encodings of the flags field for different structures.
(DEFMACRO DEFFLAG (TESTNAME (TYPE FLAGNAME))
  `(PROGN (DEFMETHOD ,TESTNAME ((TERM ,TYPE))
	    (LOGTEST ,FLAGNAME (FLAGS TERM)))
	  (DEFMETHOD (SETF ,TESTNAME) (NEW-FLAG (TERM ,TYPE))
	    (SETF (FLAGS TERM) (IF NEW-FLAG
				   (LOGIOR (FLAGS TERM) ,FLAGNAME)
				   (LOGAND (FLAGS TERM) (LOGNOT ,FLAGNAME)))))))

;; similar to above, but for defstruct type thingos; we assume the accessor is "typename"-flags

;; fix to make sure we use typename in constant to avoid name collisions 7/30/92 bwm
(DEFMACRO DEFFLAGS (TYPENAME &BODY FLAGNAMES)
  (LET ((ACCESSOR (INTERN (FORMAT NIL "~A-FLAGS" TYPENAME)))
	(VARNAME1 (GENSYM))
	(VARNAME2 (GENSYM)))
    (DO* ((FLAG FLAGNAMES (CDR FLAG))
	  (FUNNAME (INTERN (FORMAT NIL "~A-~A-P" TYPENAME (CAR FLAG))) (INTERN (FORMAT NIL "~A-~A-P" TYPENAME (CAR FLAG))))
          (CONSTNAME (INTERN (FORMAT NIL "+~A-~A+" TYPENAME (CAR FLAG))) (INTERN (FORMAT NIL "+~A-~A+" TYPENAME (CAR FLAG))))
	  (COUNT 1 (* COUNT 2))
	  (CODE))
	((NULL FLAG) `(PROGN ,@CODE))
      (PUSH `(DEFSETF ,FUNNAME (,VARNAME1) (,VARNAME2)
	       `(SETF (,',ACCESSOR ,,VARNAME1) (IF ,,VARNAME2
						(LOGIOR (,',ACCESSOR ,,VARNAME1) ,',constname)
						(LOGAND (,',ACCESSOR ,,VARNAME1) (LOGNOT ,',constname)))))
	    CODE)
      (PUSH `(DEFUN ,FUNNAME (,VARNAME1)
	       (LOGTEST ,constname (,ACCESSOR ,VARNAME1)))
	    CODE)
      (PUSH `(DEFCONSTANT ,constname ,COUNT) CODE))))

;; fix to not use "declare" options in non-let clause - 3/14/91 bwm
;; fix for optimized expansion when condition is already known (constant) nil or non-nil.
(DEFMACRO LET-MAYBE (CONDITION BINDINGS &BODY BODY)
  "Binds let arguments only if condition is non-nil, and evaluates body in any case."
  (cond
   ((null condition)
    `(PROGN ,@(IF (EQ (CAAR BODY) 'DECLARE) (CDR BODY) BODY)))
   ((eq condition t)
    `(let ,bindings ,@body))
   (t                                   ;defer to runtime
    `(IF ,CONDITION
         (LET ,BINDINGS
           ,@BODY)
       (PROGN ,@(IF (EQ (CAAR BODY) 'DECLARE) (CDR BODY) BODY))))))

(DEFUN ROUND-TO (NUMBER &OPTIONAL (DIVISOR 1))
  "Like Round, but returns the resulting number"
  (* (ROUND NUMBER DIVISOR) DIVISOR))
	  
;;; The #'eql has to be quoted, since this is a macro. Also, when
;;; binding variables in a macro, use gensym to be safe.
(defmacro update-alist (item value alist &key (test '#'eql) (key '#'identity))
  "If alist already has a value for Key, it is updated to be Value. 
   Otherwise the passed alist is updated with key-value added as a new pair."
  (let ((entry (gensym))
        (itemv (gensym))
        (valuev (gensym)))              ; to assure proper evaluation order and single expansion
    `(let* ((,itemv ,item)
            (,valuev ,value)
            (,entry (assoc ,itemv ,alist :test ,test :key ,key)))
       (if ,entry
	   (progn (setf (cdr ,entry) ,valuev)
		  ,alist)
	   (setf ,alist (acons ,itemv ,valuev ,alist))))))

(defmacro msetq (vars value)
#+lispm  (declare (compiler:do-not-record-macroexpansions)
                  (zwei:indentation 1 1))
 `(multiple-value-setq ,vars ,value))

(defun force-list (foo)
  (if (listp foo)
      foo
    (list foo)))

(defmacro cond-binding-predicate-to (symbol &rest clauses)
  "(cond-binding-predicate-to symbol . clauses)                      [macro]
a COND-like macro.  The clauses are exactly as in COND.  In the body
of a clause, the SYMBOL is lexically bound to the value returned by the
test.  Example: 
  (cond-binding-predicate-to others
    ((member 'x '(a b c x y z))
     (reverse others)))
evaluates to
  (x y z)"
#+lispm  (declare (zwei:indentation 0 3 1 1))
  (check-type symbol symbol)
  `(let (,symbol)
     (cond ,@(mapcar #'(lambda (clause)
                         `((setf ,symbol ,(first clause))
                           ,@(rest clause)))
                     clauses))))

(defun process-let-entry (entry)
  "if it isn't a list, it's getting a nil binding, so generate a return. Otherwise, wrap with test."
  (declare (optimize (speed 3) (safety 0)))
  (if (atom entry)
      `(,entry (return-from lnn nil))
      `(,(car entry) (or ,@(cdr entry) (return-from lnn nil)))))

(defmacro mlet (vars value &body body)
#+lispm  (declare (compiler:do-not-record-macroexpansions)
                  (zwei:indentation 1 3 2 1))
   `(multiple-value-bind ,vars ,value ,@body))

(defun Flatten (L)
  "Flattens list L, i.e., returns a single list containing the
same atoms as L but with any internal lists 'dissolved'. For example,
(flatten '(a (b c) d))  ==>  (a b c d)
Recursively flattens components of L, according to the following rules:
 - an atom is already flattened.
 - a list whose CAR is also a list is flattened by appending the
   flattened CAR to the flattened CDR (this is what dissolves internal
   lists).
 - a list whose CAR is an atom is flattened by just flattening the CDR
   and CONSing the original CAR onto the result.
These rules were chosen with some attention to minimizing CONSing."
  (cond
    ((null L )   '() )
    ((atom L)    L)
    ((consp L)
     (if (consp (car L))
	 (append (Flatten (car L)) (Flatten (cdr L)))
	 (cons (car L) (Flatten (cdr L)))))
    (t   L)))

(deftype alist () 'list)

;; Think of it as a PROG1 with the value being bound to FOO inside its extent
;; (lexically, of course).
(defmacro progfoo (special-term &body body)
  `(let ((foo ,special-term))
     ,@body
     foo))

;;; any benefit of the position's :from-end is lost by the calls to length,
;;; so use member.
(defun extract-keyword (key arglist 
			    &optional (default nil) &key (no-value nil))
  "Searches the arglist for keyword key, and returns the following mark,
   or the default if supplied. If no-value is non-nil, then if nothing follows
   the key it is returned."
  (declare (type list arglist)
	   (type t default)
	   (type keyword key)
	   (optimize (speed 3) (safety 0)))
  (let ((binding (member key arglist)))
    (cond ((and (null binding) no-value)
	   no-value)
	  ((cdr binding)
	   (cadr binding))
	  (t
	   default))))

;;; Explicit tagbody, with end-test at the end, to be nice to poor
;;; compilers.
(defmacro while (test &body body)
  "Keeps invoking the body while the test is true;
   test is tested before each loop."
  (let ((end-test (gensym))
	(loop (gensym)))
    `(block nil
       (tagbody (go ,end-test) 
		,loop
		,@body
		,end-test
		(unless (null ,test) (go ,loop))
		(return)))))

(defmacro while-not (test &body body)
  "Keeps invoking the body while the test is false;
   test is tested before each loop."
  (let ((end-test (gensym))
	(loop (gensym)))
    `(block nil
       (tagbody (go ,end-test)
		,loop
		,@body
		,end-test
		(unless ,test (go ,loop))
		(return)))))

(defmacro let*-non-null (bindings &body body)
  "like let*, but if any binding is made to NIL, the let*-non-null immediately returns NIL."
#+symbolics  (declare lt:(arg-template ((repeat let)) declare . body))

  `(block lnn (let* ,(mapcar #'process-let-entry bindings)
                    ,@body)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; From more-extensions.lisp
;;;

(defun eqmemb (item list &key (test #'equal))
  "Checks whether ITEM is either equal to or a member of LIST."
  (if (listp list)
      (member item list :test test)
      (funcall test item list)))

#-LISPM
(defun neq (x y)
  "not eq"
  (not (eq x y)))

#-EXCL (defvar *keyword-package* (find-package 'keyword))
(defun make-keyword (symbol)
  (intern (IF (SYMBOLP SYMBOL)
	      (symbol-name symbol)
	      SYMBOL)
	  #-excl *keyword-package* #+excl excl:*keyword-package*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; From cl-sets.lisp
;;;
(defun cross-product (&rest lists)
  "Returns the cross product of a set of lists."
  (labels ((cross-product-internal (lists)
	     (if (null (cdr lists))
		 (mapcar #'list (car lists))
		 (let ((cross-product (cross-product-internal (cdr lists)))
		       (result '()))
		   (dolist (elt-1 (car lists))
		     (dolist (elt-2 cross-product)
		       (push (cons elt-1 elt-2) result)))
		   result))))
    (cross-product-internal lists)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Based on initializations.lisp but grossly over-simplified
;;;

(defun add-initialization (name form &optional keywords list-name)
  (declare (ignore name keywords))
  (when (not (boundp list-name))
	(set list-name nil))
  (push (cons form nil) (symbol-value list-name)))

(defun reset-initializations (list-name)
  (when (boundp list-name)
	(mapc #'(lambda (x)
		  (setf (cdr x) nil)) (symbol-value list-name))))

(defun initializations (list-name)
  (when (boundp list-name)
	(mapc #'(lambda (x)
		  (when (not (cdr x))
			(eval (car x)))
		  (setf (cdr x) t)) (symbol-value list-name))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; From clos-extensions.lisp (actually, it's all of clos-extensions.lisp)
;;;

;; Mostly, useful tools out of the Art of the MOP, or modifications.
(defun make-load-form-with-all-slots (object &optional environment)
  (declare (ignore environment))
  (let ((new-instance (gensym)))
    `(let ((,new-instance (make-instance ',(type-of object)
                            ,@(generate-inherited-slot-definer object))))
       ,@(generate-inherited-slot-writer new-instance object)
       ,new-instance)))

(defun generate-inherited-slot-definer (object)
  (let ((class (class-of object)))
    (mapcan #'(lambda (slot)
                (if (clos:slot-definition-initargs slot)
                    `(,(car (clos:slot-definition-initargs slot)) 
                      ',(funcall (car (determine-slot-readers class (clos:slot-definition-name slot))) object))))
            (clos:class-slots class))))

(defun generate-inherited-slot-writer (instance object)
  (let ((class (class-of object)))
    (mapcan #'(lambda (slot)
                (if (not (clos:slot-definition-initargs slot))
                    `((setf (,(car (determine-slot-writers class (clos:slot-definition-name slot))) ,instance)
                        ',(funcall (car (determine-slot-readers class (clos:slot-definition-name slot))) object)))))
            (clos:class-slots class))))

;; thanks to Steve Haflich (smh@franz.com) for the following tidbit.
(defmethod determine-slot-readers ((class standard-class) (slot-name symbol))
  (unless (clos:class-finalized-p class)
    (clos:finalize-inheritance class))
  (loop for c in (clos:class-precedence-list class)
      as dsd = (find slot-name (clos:class-direct-slots c)
		     :key #'clos:slot-definition-name)
      when dsd
      append (clos:slot-definition-readers dsd)))

(defmethod determine-slot-writers ((class standard-class) (slot-name symbol))
  (unless (clos:class-finalized-p class)
    (clos:finalize-inheritance class))
  (loop for c in (clos:class-precedence-list class)
      as dsd = (find slot-name (clos:class-direct-slots c)
		     :key #'clos:slot-definition-name)
      when dsd
      append (clos:slot-definition-writers dsd)))

(defmethod determine-slot-initializers ((class standard-class) (slot-name symbol))
  (unless (clos:class-finalized-p class)
    (clos:finalize-inheritance class))
  (loop for c in (clos:class-precedence-list class)
      as dsd = (find slot-name (clos:class-direct-slots c)
		     :key #'clos:slot-definition-name)
      when dsd
      append (clos:slot-definition-initargs dsd)))

(defun generate-legal-slot-initargs (class)
  (unless (clos:class-finalized-p class)
    (clos:finalize-inheritance class))
  (mapcan #'(lambda (x) (copy-list (clos:slot-definition-initargs x))) (clos:class-slots class)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; From syntax.lisp (again, this is actually all of syntax.lisp)
;;;

(defvar *syntax-alist* nil "Alist of declared syntaxes (readtables) as name . readtable-name")

;; we quote the readtable-symbol so the readtable can change independantly of this database.
(defun add-syntax (name readtable-symbol)
  "Associate the name with the readtable-symbol, a quoted variable containing the readtable."
  (update-alist name readtable-symbol *syntax-alist*))

(defun set-syntax (syntax-name)
  (let ((readtable-name (cdr (assoc syntax-name *syntax-alist*))))
    (setq *readtable* (if readtable-name
                          (symbol-value readtable-name)
                        (copy-readtable nil))))) ; use the common-lisp readtable

(defmacro with-syntax (syntax-name &body body)
  `(let ((*readtable* *readtable*))      ; establish a binding
     (set-syntax ,syntax-name)
     ,@body))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; From better-errors.lisp
;;;

(defmacro parser-error (stream format-string &rest format-args)
  "Process an error within the parse process, e.g. reader macros. On some systems (e.g. lisp machines) this will invoke
the rubout handler, and let you fix up your input."
  #+symbolics
  `(zl:::sys:read-error ,stream ,format-string ,@format-args)
  #+explorer
  (declare (ignore stream))
  #+explorer
  `(cerror :no-action nil 'sys:read-error-1 ,format-string ,@format-args)
  #+clim
  `(cond
    ((clim::input-editing-stream-p stream)
     (clim::simple-parse-error ,format-string ,@format-args))
    (t ;; either a file, or maybe just not running under clim.
     (error (concatenate 'string "Parse error: " ,format-string "~@[ at file position ~D~]") 
          ,@format-args
          (and (typep ,stream 'file-stream)
               (file-position ,stream)))))
  #-(or symbolics explorer clim)
  `(error (concatenate 'string "Parse error: " ,format-string "~@[ at file position ~D~]") 
          ,@format-args
          (and (typep ,stream 'file-stream)
               (file-position ,stream))))
