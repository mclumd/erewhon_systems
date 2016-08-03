
;;; Temporary redefinition of the macro get-operator
;;; so get-operator will also return the pointer to the inference rule.
;;; get-operator is defined in macros.lisp in the prodigy4.0 code.

(in-package p4)

(eval-when (eval load compile)

  (defmacro get-operator (oper-name)
    `(or (find ',oper-name (problem-space-operators *current-problem-space*)
	       :key #'operator-name)
	 (find ',oper-name (problem-space-lazy-inference-rules *current-problem-space*)
	       :key #'operator-name)))
  )

(in-package user)




