;;; $Revision: 1.3 $
;;; $Date: 1994/05/30 20:56:24 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: psstuff.lisp,v $
;;; Revision 1.3  1994/05/30  20:56:24  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:36  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(in-package "PRODIGY4")

;; This is a specialized print function for nodes.  It returns a list
;; of strings, each list has two strings, one with the name (number)
;; of the node plus a descriptive letter and the other is a special
;; printing of the node information.

(defun number-and-name (node)
  (typecase node
    (goal-node (list
		(format nil "~D G" (nexus-name node))
		(princ-literal-to-string
		 (goal-node-goal node))))
    (operator-node (list
		    (if (and (operator-node-operator node)
			     (inference-rule-p (operator-node-operator node)))
			(format nil "~D I" (nexus-name node))
			(format nil "~D O" (nexus-name node)))
		    (princ-to-string
		     (if
		      (operator-node-operator node)
		      (operator-name
		       (operator-node-operator node))
		      "no name"))))
    (binding-node
     (append
      (list
       (format nil "~D B" (nexus-name node))
       (princ-list-of-bindings-to-string
	(if (binding-node-instantiated-op node)
	    (instantiated-op-values
	     (binding-node-instantiated-op node))
	    "No Name")))
      (mapcar #'(lambda (app)
		  (princ-to-string
		   (operator-name
		    (instantiated-op-op
		     (op-application-instantiated-op app)))))
	      (reverse (binding-node-applied node)))))
    (applied-op-node
     (let* ((instop (applied-op-node-instantiated-op node))
	    (back-ptr (if instop
			  (instantiated-op-binding-node-back-pointer instop)))
	    (name (if back-ptr (nexus-name back-ptr))))
       (cons (format nil "~D A (~D)" (nexus-name node) name)
	     (mapcar #'(lambda (app)
			 (princ-to-string
			  (operator-name
			   (instantiated-op-op
			    (op-application-instantiated-op app)))))
		     (reverse (applied-op-node-applied node))))))))

(defun princ-literal-to-string (lit)
  (if (stringp lit)
      lit
      (format nil "~A~{ ~A~}" (literal-name lit)
	      (map 'list #'prodigy-object-name
		   (literal-arguments lit)))))

(defun princ-list-of-bindings-to-string (list)
  (if (stringp list)
      list
      (format nil "~{ ~A~}" (process-bindings list))))

(defun process-bindings (bindings)
  (cond ((null bindings) nil)
	((prodigy-object-p (car bindings))
	 (cons (prodigy-object-name (car bindings))
	       (process-bindings (cdr bindings))))
	((listp (car bindings))
	 (if (every #'listp (cdr bindings))
	     '("..")
	     (cons "(..)" (process-bindings (cdr bindings)))))))
