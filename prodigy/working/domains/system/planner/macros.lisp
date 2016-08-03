;;; $Revision: 1.3 $
;;; $Date: 1994/05/30 20:56:06 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: macros.lisp,v $
;;; Revision 1.3  1994/05/30  20:56:06  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:17  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


;;;
;;; Macros for the search routines.
;;; These include access for assertions (literals) and operators, to
;;; provide some abstraction.
;;;
;;; Author: Jim Blythe
;;; File Created: Feb 3 91
;;; Last Modified: Feb 3 91
;;;
;;; Notes:

(in-package "PRODIGY4")

(eval-when (eval load compile)

  (defmacro get-operator (oper-name)
    `(find ',oper-name (problem-space-operators *current-problem-space*)
           :key #'operator-name))

  ;;; cache returns the value of slot of obj, unless it is the symbol
  ;;; :not-computed. In this case, it calculates expr, stores it in
  ;;; slot of obj and returns that.
  (defmacro cache (slot obj expr)
    `(if (eq (,slot ,obj) :not-computed)
	 (setf (,slot ,obj) ,expr)
         (,slot ,obj)))

;;; Macros for global variables - Dan can you provide the
;;; problem-space dependent versions of these?

  (defmacro flag-true-p (flag)
    "Returns t if the flag is true and nil otherwise"

    ;;; Currently used flags are
    ;;; linear-ps       controls when to apply applicable operators
    ;;; apply-order     whether applicable operators should be applied
    ;;;                 in order
    ;;; forward-chaining   whether we consider any applicable operator
    ;;;                    or just those we subgoaled with

    ;;; Simple-minded version is to evaluate the symbol with stars on
    ;;; it.  Since it's going to be replaced I'm not too bothered
    ;;; that it doesn't work.

    (intern (format nil "*~S*" flag))
    )

  (defmacro set-flag (flag value)
    "Sets the flag to the given value"

    `(setf (intern (format nil "*~S*" ,flag)) ,value)
    )
    
  )
