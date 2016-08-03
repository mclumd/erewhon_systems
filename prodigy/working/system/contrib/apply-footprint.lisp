;;;
;;; Routines for applying operators and inference rules, initially
;;; culled from the file search.lisp when it got too large.
;;;
;;; Authors: Jim Blythe, Dan Kahn, Mei Wang
;;; File Created: July 91
;;; Last Modified: Feb 93, added on-the-fly storing of preconditions
;;;                by Karen Haigh
;;;
;;; Notes:
;;;
;;; The following files need to be loaded for this to work.
;;; (load "/../gs92/usr/khaigh/prodigy/src/print-rules.lisp")
;;; (load "/../gs92/usr/khaigh/prodigy/src/preconds.lisp")
;;; 
;;; If you want more information on the preconditions stuff, read
;;;    /../gs92/usr/khaigh/Papers/footprint-talk-93-9-7/points.ps
;;; or look at the comments by function (process-effects) in
;;;    /../gs92/usr/khaigh/prodigy/src/preconds.lisp

(defvar *footprintdata* t)


(in-package "PRODIGY4")
;; Daniel. I don't know what it is, but..
(defvar *this-literal-deps*)


;;; Apply-op changes the state, and makes a note of the literals that
;;; actually changed so changes can be undone for state-loop-p. Note
;;; that we don't need to keep separate add and del deltas from the
;;; point of view of required information, but I thought splitting the
;;; list in two might make the set-difference operations slightly faster.
;;; It also maintains a list of justifications that change. A
;;; literal's justification may change even though its value does not,
;;; for instance if it was inferred and is now set by an action.

(defun apply-op (node inst-op &optional (justn nil))
  (declare (type a-or-b-node node)
	   (type instantiated-op inst-op))
  "Change the state and record the actual changes in the delta-assertions slot"

  (let* ((op (instantiated-op-op inst-op))
	 (application (make-op-application :instantiated-op inst-op))
	 (vars (rule-vars op))
	 (values (instantiated-op-values inst-op))
	 (justification
	  (if (inference-rule-p op)
	      (or justn
		  (preconds-to-list
		   (instantiated-op-binding-node-back-pointer inst-op)))))
	 (precond-bindings
	  (precond-bindings vars values)))

    ;; The application structure will record this application at this node.
    (push application (a-or-b-node-applied node))

    ;; calculate and store which preconditions were true and made the rule fire
    (if (and (boundp 'user::*footprintdata*)
	     'user::*footprintdata*)
	(let* ((exp (third (operator-precond-exp op)))
	       (preconds (user::process-all-precond-list
			  (substitute-binding exp precond-bindings) inst-op))
	       (sat-preconds (user::create-satisfy-list preconds
							(user::true-literals nil))))
	  (store-satisfying-preconditions inst-op sat-preconds)))

    ;; Iterate over the del-list and add-list of the operator. For each
    ;; one, find the associated literal in the state and do the dirty.
    ;; We have to work out what literals to fire first, in case there
    ;; are bindings, and firing off one lot alters the bindings of the
    ;; other. If that is the case, it matters what order the adds and
    ;; dels are in, but we don't preserve that order. I do the del's
    ;; first so that if a literal is in both lists, it stays around.
    (let ((adds-and-deletes (compute-effects op precond-bindings node inst-op)))
      (dolist (dellit (first adds-and-deletes))
	(apply-for-one-literal dellit justification application nil node))
      (dolist (addlit (second adds-and-deletes))
	(apply-for-one-literal addlit justification application t node)))
    
    ;; Not sure this is the right thing to do..
    (unless justn (delete-instantiated-op-from-literals inst-op))))

;; Takes the complex list of format :CONDITIONAL-PRECONDITIONS
;; and turns it into a list of format:
;;    (  (del-effects) (add-effects) )
;; Strips all the conditional-preconditions. Note that any
;; conditional-preconditions that were in the list were TRUE
;; when the rule was fired.
(defun get-effects-from-conditional-preconditions (effects-list)
  (let ((adds nil) (dels nil))
    (dolist (delpair (car effects-list))
      (push (cdr delpair) dels))
    (dolist (addpair (second effects-list))
      (push (cdr addpair) adds))
    (list dels adds)
  )
)

;; Looks into the plist of the instantiated-operator to find the
;; :CONDITIONAL-PRECONDITIONS if there are any. Returns them
;; with no modification
(defun get-conditional-preconditions (instop)
  (getf (instantiated-op-plist instop) :conditional-preconditions)
)

(defun store-conditional-preconditions (instop del-effects add-effects)
  (push (cons del-effects add-effects)
	(instantiated-op-plist instop))
  (push ':CONDITIONAL-PRECONDITIONS
	(instantiated-op-plist instop))
)

;; takes an instantiated operator, and returns the list of preconditions
;; which made the rule fire.
(defun get-satisfying-preconditions (instop)
  (getf (instantiated-op-plist instop) :satisfying-preconds)
)
(defun store-satisfying-preconditions (inst-op sat-preconds)
  (push sat-preconds (p4::instantiated-op-plist inst-op))
  (push ':SATISFYING-PRECONDS (p4::instantiated-op-plist inst-op)))

;;; ************************************************************
;;; The following describes how effects are executed when applying an operator.
;;;
;;; for each effect in the effects list, 
;;; if it is a conditional effect,
;;; then:  the bindings for variables in the effect come from both the
;;; bindings generated by function (generate-bindings ...) and matching
;;; the conditional against the state;;;
;;; else: it just comes from the original bindings.
;;; If there are still unbound variables, generate bindings for each
;;; variable and form the cross product of these variables.
;;; (form-all-bindings ...)
;;; for each binding, push the result of instantiating the effect into res.
;;; ************************************************************

;;; compute-effects takes an operator and bindings, and returns two lists
;;; - the instantiated literals to be deleted and added.

(defun compute-effects (op orig-binds node inst-op)
  (declare (special *current-problem-space*)
	   (ignore node))

  (let ((effects (get-conditional-preconditions inst-op)))
    (if effects
      ; then each effect was calculated before
      (get-effects-from-conditional-preconditions effects)

      ; else we have to go and recalculate

      ;; I create a cache for calls to descend-match to avoid calling it twice.
      (let ((*cached-matches* nil))
	(declare (special *cached-matches*))
	(let ((add-effects (process-list-for-one op (rule-add-list op) orig-binds op))
	      (del-effects (process-list-for-one op (rule-del-list op) orig-binds op)))
	  (if (and (boundp 'user::*footprintdata*)
		   'user::*footprintdata*)
	      ;; then, calls return (list stuff-to-store regular-stuff)
	      (progn
		(store-conditional-preconditions
		 inst-op
		 (car del-effects)
		 (list (car add-effects)))

		(list (cdr del-effects)
		      (cdr add-effects))
		)
	      ;; else nothing complicated
	      (list del-effects add-effects))
	)
      )
  )
 )
)

(defun cache-and-match-for-footprint
    (expr conditional node partial-bindings type-declarations)
  (declare (special *cached-matches*))
  (let ((instantiated-preconds nil)
	(all-bindings (cdr (assoc conditional *cached-matches*))))
    (if (eq all-bindings nil)
	;; something went wrong up in cache-and-match
	(progn
	  (setf all-bindings
		(descend-match expr node partial-bindings
			       type-declarations))
	  (push (cons conditional all-bindings)
		*cached-matches*)))
    (dolist (bindings all-bindings)
      (push (list (user::process-all-precond-list
		     (substitute-binding expr bindings)
		     node)
		  bindings)
	    instantiated-preconds))
    instantiated-preconds)
)



(defun process-list-for-one (op effects orig-binds node)
  (let* ((res nil)
	 (effect-decs (second (rule-effects op)))
	 (reduced-bindings
	    (set-difference orig-binds effect-decs :key #'car))
	 (res-for-store nil))
  (dolist (conditional-group effects)
    ;; First work out the bindings for this whole group.
    (let* ((conditional (effect-cond-conditional (car conditional-group)))
	   (bindings
	    (cond ((eq (car conditional) 'user::if)
		   (cache-and-match (second conditional) conditional
				    node reduced-bindings effect-decs))
		  ;; Take out any bindings for universally
		  ;; quantified variables so the matcher will match
		  ;; them every possible way.
		  ((eq (car conditional) 'user::forall)
		   (cache-and-match (third conditional) conditional node
				    (set-difference reduced-bindings
						    (second conditional)
						    :key #'car)
				    effect-decs))
		  ;; If a variable is declared in the effects, then
		  ;; quantify universally even if there is no conditional.
		  (t (list reduced-bindings))))
	   (bound-precond
	    (if (and (boundp 'user::*footprintdata*)
		     'user::*footprintdata*)
		(cond ((eq (car conditional) 'user::if)
		       (cache-and-match-for-footprint
			(second conditional) conditional
		        node reduced-bindings effect-decs))
		      ((eq (car conditional) 'user::forall)
		       (cache-and-match-for-footprint
			(third conditional) conditional node
			(set-difference reduced-bindings
					(second conditional)
					:key #'car)
			effect-decs))
		      (t (list (list nil reduced-bindings))))
		nil)))
	    
      ;; Second build literals for each effect in the group.
      (when bindings
	(dolist (effect-cond conditional-group)
	  (let* ((orig-consed-lit (effect-cond-effect effect-cond))
		 (pred-head (car orig-consed-lit))
		 (pred-body
		  (mapcar #'(lambda (x)
			      (if (or (strong-is-var-p x)
				      ;;aperez: this is needed when
				      ;;the effect contains a number
				      ;;(it is neither a var nor has
				      ;;a prodigy object associated
				      ;;with it)  
				      (numberp x))  
				  x
				  (object-name-to-object
				   x *current-problem-space*)))
			  (cdr orig-consed-lit)))
		 (bound-vars (mapcar #'(lambda (x) (car x))
				     (first bindings)))
		 (used-vars (mapcan #'(lambda (x)
					(if (strong-is-var-p x)
					    (list x)))
				    pred-body))
		 (relevant-vars (if used-vars
				    (get-depending-vars used-vars op)))
		 (augmented-bindings 
		  (form-all-bindings
		   bound-vars relevant-vars op bindings)))

	    ;; add the literal from every possible binding into
	    ;; "res", which is the set of literals changed by this
	    ;; application.
	    (dolist (final-binding augmented-bindings)
	      (let ((literal (instantiate-literal
			      pred-head
			      (sublis final-binding pred-body))))
		(if (and (boundp 'user::*footprintdata*)
			 'user::*footprintdata*)
		    (push (cons (caar bound-precond) literal) res-for-store))
		(push literal res))
	      )

	    ) ; let
	  ) ; dolist effect-cond
	) ; when bindings
      );let
    );dolist conditional-group
  (if (and (boundp 'user::*footprintdata*)
	   'user::*footprintdata*)
      (cons res-for-store  res)
      res)
  ))

