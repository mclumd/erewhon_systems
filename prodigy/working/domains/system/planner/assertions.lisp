;;; $Revision: 1.3 $
;;; $Date: 1994/05/30 20:55:33 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: assertions.lisp,v $
;;; Revision 1.3  1994/05/30  20:55:33  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:29:44  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(in-package "PRODIGY4")

(defvar *debug-assertion-print* nil
  "If non-nil, information about whether the literal is true, a goal,
or a negated goal is printed")

;; This is the basic structure for a literal.

;; The hash table structure should probably be re-written.  Since the
;; possible predicates are known before the problem solving even
;; starts.  They are a function of the problem-space.  There should
;; probably should be a table of hash tables, so that the second hash
;; function is only computed on the arguments.  This would allow the
;; first hash table to have an accurately computed size.

;; Often I will use the term consed literal.  A consed literal is a
;; little represened as a list of cons cells.  The first cell holds
;; the name of the literal and subsequent cells hold the arguments of
;; that literal.
(defstruct (literal (:print-function literal-print))
           (name nil)	
	   (arguments nil)
	   (abs-level nil)
	   (goal-p nil)		
	   (neg-goal-p nil)
	   (pending-goal-predecessor nil) ; goal before it in the list
					  ; of pending goals.
	   (state-p nil)
	   (plist nil))

(defun literal-print (lit stream z)
  (declare (ignore z)
	   (type literal lit)
	   (stream stream))
  (princ "#<" stream)
  (princ (literal-name lit) stream)
  (cond (*debug-assertion-print*
	 (if (literal-state-p lit)
	     (princ " T" stream)
	     (princ " F" stream))
	 (if (literal-goal-p lit)
	     (princ " G" stream)
	     (princ " F" stream))
	 (if (literal-neg-goal-p lit)
	     (princ " N" stream)
	     (princ " F" stream))
	 (map nil #'(lambda (x) (princ " " stream) (princ x stream))
	      (literal-arguments lit)))
	(t
	 (map nil
	      #'(lambda (x) (princ " " stream)
			(princ (if (prodigy-object-p x)
				   (prodigy-object-name x)
				   x)
			       stream))
	      (literal-arguments lit))))
  (princ ">" stream))

(defmacro do-daemon (daemon literal)
  "Call whatever user deamon there may be demonically daemoning away."
  `(let ((daemon (problem-space-property ,daemon)))
    (if daemon (funcall daemon ,literal *current-problem-space*))))

(defun create-literal (name arguments)
  (declare (special *current-problem-space*))
  "Creates a literal with instantiated arguments.  The arguments must be
the values of the variables in a list.  It will be stored as a list.
It is assumed that a literal for name and arguments does not exist."

  (let ((p-space *current-problem-space*)
	(lit (make-literal :name name
			   :arguments (coerce arguments 'vector))))

    (do-daemon :add-lit-daemon lit)
    (if (static-pred-p name)
	(add-static-pred-new name p-space)
	(add-non-static-pred-new name p-space))
    (setf (gethash
	   arguments
	   (gethash name (problem-space-assertion-hash p-space)))
	  lit)
    lit))

;; This is a little inefficient because the mapcar creates a new list
;; even if every element of (cdr cons-lit) is in fact a valid prodigy
;; 4.0 object under the current problem space.  (i.e if there is a
;; prodigy-object structure for blockA then it is that structure that
;; is the valid object and the symbol BLOCKA.

(defun instantiate-consed-literal (cons-lit)
  (declare (special *current-problem-space*))
  "Takes a list of the form (ON A B) and generates the proper
instantiation for it.  It returns the instantiated literal."

  (let ((objects (mapcar #'(lambda (x)
			     (make-real-object x *current-problem-space*))
			      (cdr cons-lit))))
    (instantiate-literal (car cons-lit) objects)))

;; Some callers that already have objects might prefer to call the
;; function instantiate-literal rather then instantiate-consed-literal.

(defun instantiate-literal (pred objects)
  (declare (special *current-problem-space*))
  (if (notevery #'(lambda (ob)
		    (or (prodigy-object-p ob)
			(infinite-type-object-p ob *current-problem-space*)))
		objects)
      (error "~&There is a non-prodigy-object in ~S.~%" objects))
  (or (instantiated-literal pred objects)
      (create-literal pred objects)))

(defun create-done-assertion ()
   (instantiate-consed-literal '(done)))
	
(defun add-to-state (consed-literal)
  "Sets the state-p field to true in the literal.  If literal? is not a
literal but a lisp representation of one then one is created."
  (setf (literal-state-p (instantiated-literal (car consed-literal)
					      (cdr consed-literal))) t))


;; If instantiated literal for pred returns nil then there are no
;; instantiated literals for the arguments defined yet (of course, in
;; the case of static predicates they will never be defined).  Every
;; element of objects must be a valid prodigy 4.0 object under the
;; current problem space. 

(defun instantiated-literal (predicate objects)
  (declare (symbol predicate)
	   (sequence objects)
	   (special *current-problem-space*))

  (let ((all-lits-for-pred (gethash predicate
				    (problem-space-assertion-hash
				     *current-problem-space*)
				    :not-there)))
    ;; I put the default argument back in as a symbol because
    ;; otherwise if it wasn't there the listp clause might be
    ;; satisfied, although really the first clause should fire in that
    ;; situation. 
    (cond ((not (or (member predicate (problem-space-static-preds
				       *current-problem-space*))
		    (member predicate (problem-space-all-preds
				       *current-problem-space*))))

	   ;; here we have a pred that's not in any of the operators,
	   ;; but that appears in the initial state description of a
	   ;; problem.  It has to be a static pred, because it can't
	   ;; be add/deleted-ed by an operator or inference rule.
	   ;; This can happen if some of the functions in the domain
	   ;; may need the predicate.  But I don't understand why
	   ;; can't we just put them in the preconds if we need it.
	   (push predicate (problem-space-static-preds
			    *current-problem-space*))
	   (push predicate (problem-space-all-preds
			    *current-problem-space*))
	   ;; I think this function is always called at "run" time, so
	   ;; I can use "output" here. - Jim
	   (output 2 t "~%Predicate ~S is a new static predicate" predicate)
	   nil);; return nil to 
		
	  ((listp all-lits-for-pred)
	   (find (coerce objects 'vector) all-lits-for-pred
		 :test #'equalp
		 :key #'literal-arguments))
	  ((hash-table-p all-lits-for-pred)
	   (gethash objects all-lits-for-pred))
	  (t nil))))



#|

Something wrong with this vertion.
;;; this is the old version, it doesn't take care of the situation in
;;; which we see a predicate in the state of a problem, but not in any
;;; operators.


(defun instantiated-literal (predicate objects)
  (declare (symbol predicate)
	   (sequence objects)
	   (special *current-problem-space*))
  (let ((all-lits-for-pred (gethash predicate
				    (problem-space-assertion-hash
				     *current-problem-space*)
				    :warn-and-create)))
    
    (cond ((listp all-lits-for-pred)
	   (find (coerce objects 'vector) all-lits-for-pred
		 :test #'equalp
		 :key #'literal-arguments))
	  ((hash-table-p all-lits-for-pred)
	   (gethash objects all-lits-for-pred))
#|
	  ((eq :warn-and-create all-lits-for-pred)
	   (warn "Predicate ~S does not appear in an operator and is~
being added as a static predicate." predicate)
	   (setf (gethash (problem-space-assertion-hash
			   *current-problem-space*)
			  predicate) nil)
	   nil)  |#
	  (t nil))))
|#

;; These functions set the slots in the given literal.  They also call
;; a daemon that is in the current problem space.



(defun set-state-p (literal value)
  (declare (special *current-problem-space*)
	   (list justification))

  (setf (literal-state-p literal) value)
  (do-daemon :state-daemon literal))

(defun push-goal (literal value)
  (declare (special *current-problem-space*))
  (push value (literal-goal-p literal))
  (do-daemon :push-goal-daemon literal))

(defun delete-goal (literal value)
  (declare (special *current-problem-space*))
  (setf (literal-goal-p literal)
	(delete value (literal-goal-p literal)))
  (do-daemon :delete-goal-daemon literal))
  
(defun push-neg-goal (literal value)
  (declare (special *current-problem-space*))
  (push value (literal-neg-goal-p literal))
  (do-daemon :push-neg-goal-daemon literal))

(defun delete-neg-goal (literal value)
  (declare (special *current-problem-space*))
  (setf (literal-neg-goal-p literal)
	(delete value (literal-neg-goal-p literal)))
  (do-daemon :delete-neg-goal-daemon literal))


(defun literal-lessp (lit1 lit2)
  (declare (type literal lit1 lit2))
  (cond ((string-lessp (literal-name lit1)
		       (literal-name lit2))
	 t)
	((string-equal (literal-name lit1)
		       (literal-name lit2))
	 (argument-lessp (literal-arguments lit1)
			 (literal-arguments lit2)
			 0))

	(t nil)))

(defun argument-lessp (args1 args2 index)
  (declare (fixnum index))
   (cond ((string-lessp (prodigy-object-name (svref args1 index))
			(prodigy-object-name (svref args2 index)))
	  t)
	 ((and (< index (length args1) (length args2))
	       (string-equal (prodigy-object-name (svref args1 index))
			     (prodigy-object-name (svref args2 index))))
	  (argument-lessp args1 args2 (1+ index)))
	 (t nil)))
	 

	 
					  