;;; Functions to output the plan as a list of numbered operators,
;;; without showing the inference rules. Also, inference rules are
;;; omitted when comparing solutions. 

;;; This file redefines announce-plan and same-sol-p (defined in
;;; search.lisp)

(in-package 'prodigy4)

(defvar *print-also-inf-rules-p* nil)

(defun announce-plan (plan)
  (announce-ops-only (cdr plan)))

;;similar to announce-plan from treeprint.lisp
(defun announce-ops-only (plan)
  (declare (list plan)
	   (special *eval-function* *print-also-inf-rules-p*))

  (let ((plevel (or (problem-space-property :*output-level*) 2)))
    (when (> plevel 0)
      (format t "~%~%Solution:~%")
      (let ((*print-case* :downcase)(counter 0))
	(dolist (op plan)
	  (cond 
	    ((and (inference-rule-p (instantiated-op-op op))
		  (not *print-also-inf-rules-p*)))
	    (t 
	     ;;(princ #\Tab)
	     (format t "  ~A. " (incf counter))
	     (brief-print-inst-op op)
	     (terpri)))))
      (terpri)
      (if (and (boundp '*eval-function*) *eval-function*)
	  (let ((cost (funcall *eval-function* plan)))
	    (setf (getf (user::prodigy-result-plist *prodigy-result*) :lastcost)
		  cost)
	    (format t "compute-cost = ~A~%" cost))))))
           ;;(funcall *eval-function* plan)

#|
(defun same-sol-p (plan1 plan2)
  (every #'same-op-p (cdr plan1) (cdr plan2)))
|#

;;changed to check only operators (and not inference rules)
(defun same-sol-p (plan1 plan2)
  (same-sol-rec (cdr plan1)(cdr plan2)))

(defun same-sol-rec (plan1 plan2)
  ;;if any of them is an inference rule, go to next element. When both
  ;;are operators but are different, terminate
  (cond
    ((and (null plan1)(null plan2))
     t)	  
    ((null plan1)
     (every #'instop-is-inf-rule-p plan2))
    ((null plan2)
     (every #'instop-is-inf-rule-p plan2))
    ((same-op-p (car plan1)(car plan2))
     (same-sol-rec (cdr plan1)(cdr plan2)))
    ((instop-is-inf-rule-p (car plan1))
     (same-sol-rec
      (cdr plan1)
      (if (instop-is-inf-rule-p (car plan2))(cdr plan2) plan2)))
    ((instop-is-inf-rule-p (car plan2)) ;;(car plan1) is an operator
     (same-sol-rec plan1 (cdr plan2)))
    (t nil))) ;;both car's are operators

(defun instop-is-inf-rule-p (instop)
  (declare (type instantiated-op instop))
  (inference-rule-p (instantiated-op-op instop)))
  
