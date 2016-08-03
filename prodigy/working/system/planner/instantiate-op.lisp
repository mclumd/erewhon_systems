;;; $Revision: 1.7 $
;;; $Date: 1995/11/12 22:08:18 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: instantiate-op.lisp,v $
;;; Revision 1.7  1995/11/12  22:08:18  jblythe
;;; Main change is to fix some parts of apply and instantiate-op that assumed all
;;; infinite type objects were numbers. Now other sorts of objects can be used.
;;; Also removed some dead code for a general clean-up.
;;;
;;; Revision 1.6  1995/04/05  16:39:20  jblythe
;;; Included some layers of changes to dealing with forall and exists
;;; goals that had been languishing in a separate file. Also added code to
;;; allow arbitrary slots of operators, that are added to the property
;;; list, and fixed a problem with optionally compiling the matching
;;; functions.
;;;
;;; Revision 1.5  1995/03/14  17:17:48  khaigh
;;; Integrated SABA into main version of prodigy.
;;; Call (set-running-mode 'saba) and
;;;      (set-running-mode 'savta)
;;;
;;; Also integrated apply-op control rules:
;;; ;;    (control-rule RULE
;;; ;;         (if...)
;;; ;;         (then select/reject applied-op <a>))
;;; ;; OR:
;;; ;;    (control-rule RULE
;;; ;;         (if (and (candidate-applicable-op (NAME <v1> <v2>...) )
;;; ;;                  (candidate-applicable-op (NAME <v1-prime> <v2-prime>...) )
;;; ;;                  (somehow-better <v1> <v1-prime>)))
;;; ;;         (then select/reject applied-op (NAME <v1> <v2> ...)))
;;; (candidate-applicable-op is in meta-predicates.lisp)
;;;
;;; Revision 1.4  1994/05/30  20:55:55  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.3  1994/05/30  20:30:05  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(in-package "PRODIGY4")
;; matches bindings and operators against the state.  


;; The instantiated-op structure has two slots. The OP slot points to
;; the operator structure, or operator schema.  The values slot points
;; to a sequence of prodigy objects that match VARS sequence of the
;; rule.  

;;; Well, these days it has a few more slots than that. The
;;; conditional slot records whether the operator is making use of a
;;; conditional effect, the precond stores the instantiated
;;; preconditions, and the binding-node-back-pointer connects the
;;; instantiated operator to its node.
(defstruct (instantiated-op (:print-function instantiated-op-print))
           op
	   values
	   (conditional nil)
	   precond
	   binding-node-back-pointer
	   (conspiracy 0)
	   (plist nil))            ; Added by Jim at Alicia's request 2/13/93

(defun instantiated-op-print (op stream z)
  (declare (type instantiated-op op)
	   (stream stream)
	   (ignore z))
  (let ((*standard-output* stream))
    (princ "#<")
    (princ (operator-name (instantiated-op-op op)))
    (map nil #'(lambda (x y)
		 (princ " [")
		 (princ x)
		 (princ " ")
		 (cond ((typep y 'prodigy-object)
			(princ (prodigy-object-name y)))
		       ((null y) (princ "()"))
		       ((listp y) (princ "(..)"))
		       (t (princ y)))
		 (princ "]"))
	 (operator-vars (instantiated-op-op op))
	 (instantiated-op-values op))
    (princ ">")))
   
  
;; The extended assertion is a typed, named structure which means it
;; will be an ordinary lisp LIST object.  The first cons will hold the
;; type, the second the parity and the third the assertion, but we
;; won't have to worry about this because we'll have the automatic
;; accessor functions that are built for us.
	
(defstruct (extended-assertion (:type list) :named)
           (parity nil)
	   (literal nil)) ;; this will always be of type assertion

(defun generate-applicable-ops (node)
  (cond ((or user::*analogical-replay*
	     (and (eq *running-mode* 'saba)
		  *smart-apply-p*))
	 (let* ((all-in-path-applicable-ops
		 (gen-all-applicable-ops node nil)))
	   all-in-path-applicable-ops))
	((and (binding-node-p node)
	      (not (inference-rule-a-or-b-node-p node))
	      (applicable-op-p node))
	 (list (binding-node-instantiated-op node)))
	((getf (problem-space-plist *current-problem-space*)
	       :permute-application-order)
	 (old-gen-apps-r node nil))
	(t
	 (gen-apps-r node nil))))

(defun old-gen-apps-r (node applied-inst-ops)
  (cond ((null (nexus-parent node)) nil)

	((and (binding-node-p node)
	     (not (inference-rule-a-or-b-node-p node))
	     (applicable-op-p node)
	     (not (member node applied-inst-ops)))
	 (list (binding-node-instantiated-op node)))

	#| ;; This used to be done, but isn't needed for completeness.
	 (cons (binding-node-instantiated-op node)
	       (old-gen-apps-r (nexus-parent node) (cons node applied-inst-ops))))
|#
	;;; If this op could be applied earlier in some other branch, leading
	;;; to the same application sequence, don't do it here.
	((and (typep node 'goal-node)
	      (null applied-inst-ops)
	      (something-should-be-applied-here-p (nexus-parent node)))
	 nil)

	((and (typep node 'applied-op-node)
	      (not (inference-rule-a-or-b-node-p node)))
	 (old-gen-apps-r (nexus-parent node)
		     (cons (instantiated-op-binding-node-back-pointer
			    (applied-op-node-instantiated-op node))
			   applied-inst-ops)))

	(t (old-gen-apps-r (nexus-parent node) applied-inst-ops))))

(defun gen-apps-r (node applied-inst-ops)
  (cond ((null (nexus-parent node)) nil)

	((and (binding-node-p node)
	      (not (inference-rule-a-or-b-node-p node))
	      (not (member node applied-inst-ops)))
	 (if (applicable-op-p node)
	     (list (binding-node-instantiated-op node))))

	;; If this op could be applied earlier in some other branch, leading
	;; to the same application sequence, don't do it here.
	((and (typep node 'goal-node)
	      (null applied-inst-ops)
	      (something-should-be-applied-here-p (nexus-parent node)))
	 nil)

	((and (typep node 'applied-op-node)
	      (not (inference-rule-a-or-b-node-p node)))
	 (gen-apps-r (nexus-parent node)
		     (cons (instantiated-op-binding-node-back-pointer
			    (applied-op-node-instantiated-op node))
			   applied-inst-ops)))

	(t (gen-apps-r (nexus-parent node) applied-inst-ops))))

(defun something-should-be-applied-here-p (node)

  ;; This is the parent of a goal node.
  (or (a-or-b-node-applicable-ops-left node)
      (some #'(lambda (child) (typep child 'applied-op-node))
	    (nexus-children node))))


#|

;; An operator schema is combined with a particular binding to form
;; and instantiated precond.  Applicable-op-p maps over each precond
;; looking for one of which good-instantiation is true. 

(defun applicable-op-p (binding-node)
  (declare (type binding-node binding-node))
  (some #'good-instantiation-p
	(binding-node-instantiated-preconds binding-node)))

;;

;; Good-instatiation-p maps over each extended assertion making sure
;; that it is true.  This is similar to checking each assertion in a
;; conjunct.  For this mechanism anything more complicated than a
;; conjuct in the precond of an operator would have to be converted
;; into a set (possible of size 1) of instantiated preconditions in
;; another part of the program.  (I believe that NoLimit works this
;; way.)  The alternative is to have a structure here more complicated
;; than a call to EVERY.

(defun good-instantiation-p (instantiated-precond)
  (declare (list operator-instantiation))
  (every #'true-extended-assertion-p instantiated-precond))

(defun true-extended-assertion-p (ext-assertion)
  (cond ((null ext-assertion) t)
	(t  (case (extended-assertion-parity ext-assertion)
	      (:true
	       (literal-state-p (extended-assertion-literal ext-assertion)))
	      (:false
	       (not (literal-state-p (extended-assertion-literal ext-assertion))))
	      (otherwise
	       (error "~&Invalid extended assertion ~S.~%" ext-assertion))))))
|#

;;; I will replace all these binding lists and the use of sublis for something
;;; that does less consing later.
(defun applicable-op-p (binding-node)
  (declare (type binding-node binding-node))
  ;; Don't bother with disjunction path here.
  (let* ((expr (binding-node-instantiated-preconds binding-node))
	 (instop (binding-node-instantiated-op binding-node))
	 (values (instantiated-op-values instop))
	 (op (instantiated-op-op instop)))
    (cond ((and *no-danglers*
		(dangling-goal-node?
		 (nexus-parent (nexus-parent binding-node))))
	   nil)
	  ((null expr) t)
	  (t
	   (check-applicable-r
	    expr values op t
	    (mapcar #'(lambda (varspec val)
			(cons (first varspec) val))
		    (second (rule-precond-exp op)) values))))))

;;; I need the parity to work out where to find the bindings for the
;;; variables involved and for no other reason.
(defun check-applicable-r (expr values op parity bindings)
  (cond ((typep expr 'literal)
	 (literal-state-p expr))
	((eq (car expr) 'user::~)
	 (not (check-applicable-r (second expr) values op (not parity) bindings)))
	((eq (car expr) 'user::and)
	 (every #'(lambda (piece)
		    (check-applicable-r piece values op parity bindings))
		(cdr expr)))
	((eq (car expr) 'user::or)
	 (some #'(lambda (piece)
		   (check-applicable-r piece values op parity bindings))
	       (cdr expr)))
	((eq (car expr) 'user::exists)
	 (if parity
	     (check-applicable-exists expr values op bindings parity)
	     (check-applicable-forall expr values op bindings parity)))
	((eq (car expr) 'user::forall)
	 (if parity
	     (check-applicable-forall expr values op bindings parity)
	     (check-applicable-exists expr values op bindings parity)))
	(t
	 (let ((literal (instantiate-consed-literal (sublis bindings expr))))
	   (literal-state-p literal)))))

(defun check-applicable-exists (expr values op bindings parity)
  (check-applicable-r (third expr) values op parity bindings))
#|
(defun check-applicable-forall (expr values op bindings parity)
  "Cycle through possible values of the quantified variables"
  (do* ((generator (cdr (assoc (second expr)
			       (getf (rule-plist op) :quantifier-generators))))
	(data (if generator (funcall generator nil)))
	(choice (make-list (length data) :initial-element 0)
		(increment-choice choice data))
	(sat (satisfy-quant expr values op bindings choice data parity)
	     (satisfy-quant expr values op bindings choice data parity)))
       ((or (null choice)
	    (case (car expr)
	      (user::exists sat)
	      (user::forall (not sat))))
	(if (null choice)
	    (eq (car expr) 'user::forall)
	    (eq (car expr) 'user::exists)))))
|#

;; adding a hack so that it is much faster in a forall case such as:
;; (forall ((<x> path) (<b> path)) (~ (pred <a> <b>)))
(defun check-applicable-forall (exp values op bindings parity)
  (let ((expr (third exp)))
    (if (or (and parity (eq (car expr) 'user::~))
	    (and (not parity) (not (eq (car expr) 'user::~))))
	(let* ((real-expr (if parity (second expr) expr))
	       (forall-bindings (descend-match real-expr nil bindings))
	       (res (and forall-bindings
			 (notevery #'(lambda (x)
				       (not (runtime-check-type-and-function-forall x exp)))
				   forall-bindings))))
	  (if parity (not res) res))

	(old-check-applicable-forall exp values op bindings parity))))

(defun old-check-applicable-forall (expr vals op bindings parity)
  "Cycle through possible values of the quantified variables"
  (do* ((generator (cdr (assoc (second expr)
			       (getf (rule-plist op)
				     :quantifier-generators))))
	(static-data (if generator (funcall generator nil)))
	(vars (mapcar #'car (second expr)))
	(running-data
	 (first-valid-choice static-data vars bindings (second expr))
	 (next-valid-choice
	  static-data (first running-data) (second running-data)
	  0 vars bindings (second expr)))
	(choice (first running-data) (first running-data))
	(data (second running-data) (second running-data))
	;;aperez dec 11 93 put back true-bindings-p
	;;       may 28 94 removed again (works for processp)
	;;(fcs (get-all-functions-forall expr))
	(sat
	 ;(or (not (true-bindings-p expr data choice bindings fcs)))
  	      (satisfy-quant expr vals op bindings choice data parity)
	 ;(or (not (true-bindings-p expr data choice bindings fcs)))
	     (satisfy-quant expr vals op bindings choice data parity)))
       ((or (null choice)
	    (case (car expr)
	      (user::exists sat)
	      (user::forall (not sat))))
	(if (null choice)
	    (eq (car expr) 'user::forall)
	    (eq (car expr) 'user::exists)))))


(defun increment-choice (choice data)
  "Increment the last possible one and set later ones to zero."
  (do ((n (1- (length choice)) (1- n)))
      ((or (= n -1)
	   (< (elt choice n) (1- (length (elt data n)))))
       (unless (= n -1)
	 (incf (elt choice n))
	 (do ((m (1+ n) (1+ m)))
	     ((>= m (length choice)))
	   (setf (elt choice m) 0))
	 choice))))

(defun satisfy-quant (expr values op bindings choice data parity)
  "Add in the new bindings and see if the expression is applicable."
  (if choice
  (check-applicable-r (third expr) values op parity
		      (nconc (choice-bindings expr data choice)
			     bindings))))

(defun choice-bindings (expr data choice)
  (mapcar #'(lambda (varspec datum one-choice)
	      (cons (first varspec)
		    (elt datum one-choice)))
	  (second expr) data choice))
  
     
;; Named to avoid conflict with mei's slightly different version.
(defun dans-substitute-bindings (var-args vars vals)
  "Returns a copy of the var-args where every car in the list
structure that is a variable is replaced by its corresponding value
and every car that is a non variable symbol is replaced by its
associated prodigy object.  Thus *current-problem-space* must be set
correctly, as described in the implemenation notes."
  (if (and (not (prodigy-object-p (car vals)))
	   vals)
      (progn
	(format t "~&Fixing up: ~S.~%" vals)
	(setf vals (car vals))))

  (do-substitution var-args vars vals))

(defun do-substitution (var-args vars vals)
  "Substitute and copy routine.  Should have been written using the
labels macro"
  (declare (special *current-problem-space*))
  (flet ((find-correct-val (var)
	   (nth (position var vars) vals)))
    (cond ((null var-args)  ;; Bounce back, end of list
	   nil)
	  ((symbolp var-args) ;; found a symbol do correct replace
	   (if (strong-is-var-p var-args)
	       (find-correct-val var-args)
	       (or (object-name-to-object var-args *current-problem-space*)
		   (error "~&No object of name ~S." var-args))))
	  (t ;; CONStruct copy of list structure.
	   (cons (do-substitution (car var-args) vars vals)
		 (do-substitution (cdr var-args) vars vals))))))
  

;;=================================================================
;; UNINSTANTIATE OPERATOR
;; After an operator has been applied the assertions which were pre-
;; conditions of the operator must be altered so as not to be
;; preconditions of that operator (we are talking instantiated
;; operators here).  To do this we take a binding-node, iterate over
;; the lists in instantiated-preconds and delete the instantiated-op
;; structure from the goal-p or neg-goal-p slots.

#|
(defun delete-instantiated-op-from-literals (inst-op)
  (declare (type instantiated-op inst-op))
  (let ((binding-node (instantiated-op-binding-node-back-pointer inst-op)))
  (map nil #'(lambda (x) (remove-op-from-inst-preconds x inst-op))
	  (binding-node-instantiated-preconds binding-node))))

(defun remove-op-from-inst-preconds (inst-precond inst-op)
  (declare (type instantiated-op inst-op))
  (dolist (extended-assertion inst-precond)
      (case (extended-assertion-parity extended-assertion)
	(:TRUE
	 (delete-goal (extended-assertion-literal extended-assertion) inst-op)
	 )
	(:FALSE
	 (delete-neg-goal (extended-assertion-literal extended-assertion) inst-op)
	))))
|#

(defun delete-instantiated-op-from-literals (inst-op)
  (declare (type instantiated-op inst-op))

  (let ((binding-node (instantiated-op-binding-node-back-pointer inst-op)))
    (remove-op-from-goals
     (binding-node-instantiated-preconds binding-node)
     (binding-node-disjunction-path binding-node) inst-op t
     (mapcar #'cons
	     (rule-vars (instantiated-op-op inst-op))
	     (instantiated-op-values inst-op)))))

(defun remove-op-from-goals (expr disj instop parity bindings)
  (declare (type instantiated-op instop))

  (cond ((typep expr 'literal)
	 (if parity (delete-goal expr instop)
	     (delete-neg-goal expr instop)))
	((eq (car expr) (if parity 'user::or 'user::and))
	 (remove-op-from-goals (elt expr (car disj)) (cdr disj)
			       instop parity bindings))
	((eq (car expr) (if parity 'user::and 'user::or))
	 (mapc #'(lambda (bit disj-bit)
		   (remove-op-from-goals bit disj-bit instop parity
					 bindings))
	       (cdr expr) disj))
	((eq (car expr) 'user::~)
	 (remove-op-from-goals (second expr) disj instop (not parity)
			       bindings))
	((eq (car expr) (if parity 'user::forall 'user::exists))
	 (remove-forall-from-goals expr disj instop parity bindings))
	((member (car expr) '(user::exists user::forall))
	 (remove-op-from-goals (third expr) disj instop parity bindings))
	(t
	 (let ((lit (instantiate-consed-literal (sublis bindings expr))))
	   (if parity (delete-goal lit instop)
	       (delete-neg-goal lit instop))))))
#|
(defun remove-forall-from-goals (expr disj instop parity bindings)
  (do* ((gen (cdr (assoc (second expr)
			 (getf (rule-plist (instantiated-op-op instop))
			       :quantifier-generators))))
	(data (if gen (funcall gen nil)))
	(choice (make-list (length data) :initial-element 0)
		(increment-choice choice data)))
       ((null choice))
    (remove-op-from-goals (third expr) disj instop parity
			  (nconc (choice-bindings expr data choice)
				 bindings))))
|#
(defun remove-forall-from-goals (exp disj instop parity bindings)
  (let ((expr (third exp)))
    (if (or (and parity (eq (car expr) 'user::~))
	    (and (not parity) (not (eq (car expr) 'user::~))))
	(let* ((real-expr (if parity (second expr) expr))
	       (forall-bindings (descend-match real-expr nil bindings)))
	  (dolist (bind forall-bindings)
	    (if (runtime-check-type-and-function-forall bind exp)
		(remove-op-from-goals (third exp) disj instop parity bind))))
	(old-remove-forall-from-goals exp disj instop parity bindings))))


(defun old-remove-forall-from-goals (expr disj instop parity bindings)
  (do* ((gen (cdr (assoc (second expr)
			 (getf (rule-plist (instantiated-op-op instop))
			       :quantifier-generators))))
	(static-data (if gen (funcall gen nil)))
	(vars (mapcar #'car (second expr)))
	(dynamic-data
	 (first-valid-choice static-data vars bindings (second expr))
	 (next-valid-choice static-data (first dynamic-data)
			    (second dynamic-data) 0 vars bindings
			    (second expr)))
	(choice (first dynamic-data) (first dynamic-data))
	(data (second dynamic-data) (second dynamic-data)))
       ((null choice))
    (remove-op-from-goals (third expr) disj instop parity
			  (nconc (choice-bindings expr data choice)
				 bindings))))


;;;=============================================================
;;; BUILD INSTANTIATED PRECONDS
;;; When an instantiated operator is selected its precond is merged
;;; with its bindings and expanded into a set of lists of extended
;;; literals (or assertions).  The extended literal is a literal that
;;; carries with it the information about which sense of the literal
;;; the operator wants (either in the state or not).

;;; BEGIN OLD STUFF
;;; The following code will instantiate the operator by building a list
;;; of lists of extended assertions.  An extended assertion is a list.
;;; The first element is :TRUE or :FALSE, indicating that the assertion
;;; must be in the state or not in the state respectively for the
;;; instantiation to be true.

;;; If the values slot of the instantiated-op structure is nil, then
;;; the operator has no variables, and so the operator "schema" fully
;;; describes all the instantiated operators derived from it.
;;; END OLD STUFF

;;; I'd like to do the following, but I can't quite because you have
;;; to pick a list of goals when you subgoal. Jim. Hmm, but maybe if I
;;; do it this way, I can be opportunistic if another disjunct fires..
;;; Re-writing this to deal with internal disjunction. I think the
;;; list-of-lists thing is a bad idea, because you duplicate lots of
;;; stuff and then you check it maybe lots of times, so I'm going with
;;; a scheme that mirrors the whole structure and then I'll change the
;;; function applicable-op-p to give me a list of literals as a
;;; justification, and maybe indicate which disjunct(s) fired, but
;;; probably not.

(defun build-instantiated-precond (binding abslevel)
  (declare (type instantiated-op binding))
  "Build the fully instantiated preconditions for this binding."
  (let* ((op (instantiated-op-op binding))
	 (rule-plist (rule-plist op))
	 (precond-exp (getf rule-plist :annotated-preconds))
	 (declarations (second (rule-precond-exp op)))
	 (values (instantiated-op-values binding))
	 (vars (rule-vars op))
	 (conditional
	  (cdr (assoc (instantiated-op-conditional binding)
		      (getf rule-plist :annotated-conditional-effects)))))
    ;; If there is a conditional, combine it with the preconditions.
    ;; The order they are combined is used when we consider subgoals,
    ;; so be careful if you change it.
    (or 
     (build-instantiated-rec
      (if conditional
	  (list (max (car conditional) (car precond-exp))
		'user::and conditional precond-exp)
	  precond-exp)
      values vars (list declarations) t abslevel)
     ;; This is wasteful, but otherwise I think there's more than
     ;; one place needs changed.
     (list 'user::and))))


;;; This function is modified to build a smaller precondition
;;; expression based on the abstraction level.
#|
(defun build-instantiated-rec (exp values vars)
  (declare (list exp values vars))
  
  (case (car exp)
    ((user::and user::or)
     (cons (car exp)
	       (mapcar #'(lambda (bit)
			   (build-instantiated-rec bit values vars))
		       (cdr exp))))
    (user::~
     (list 'user::~
	   (build-instantiated-rec (second exp) values vars)))
    ((user::exists user::forall)
     (list (first exp) (second exp)	; important not to alter second.
	   (build-instantiated-rec (third exp) values vars)))
    (t (or (try-to-instantiate exp values vars) exp))))
|#

;;; see annotate-preconds-rec to see how the representation of the
;;; preconditions with abstraction levels looks.
(defun build-instantiated-rec (exp values vars decs parity al)
  (declare (list exp values vars decs))
  (cond
    ((eq (second exp) (if parity 'user::and 'user::or))
     ;; For an and, we drop every clause that should not be at this
     ;; abstraction level. If there are no clauses left return nil.
     (let ((args (mapcan #'(lambda (bit)
			     (let ((piece
				    (build-instantiated-rec
				     bit values vars decs parity al)))
			       (if piece (list piece))))
			 (cddr exp))))
       (if args (cons (second exp) args))))
    ((eq (second exp) (if parity 'user::or 'user::and))
     ;; For an or, if any clause is below the current abstraction
     ;; level we drop the whole thing. This is pre-computed, but can
     ;; be wrong.
     (let ((args (catch 'drop-the-whole-thing
		   (mapcan #'(lambda (bit)
			       (let ((piece
				      (build-instantiated-rec
				       bit values vars decs parity al)))
				 (if piece (list piece)
				     (throw 'drop-the-whole-thing nil))))
			   (cddr exp)))))
       (if args (cons (second exp) args))))
    ((eq (second exp) 'user::~)
     (let ((negation (build-instantiated-rec (third exp) values vars
					     decs (not parity) al)))
       (if negation (list 'user::~ negation))))
    ((member (second exp) '(user::exists user::forall))
     ;; If the thing inside the existential disappears, drop it. This
     ;; means that currently I keep declarations for objects that may
     ;; have disappeared - this may cause a bug, I'm going to run it
     ;; to see.
     (let ((bit (build-instantiated-rec (fourth exp) values vars
					(cons (third exp) decs) parity al)))
       (if bit (list (second exp) (third exp) bit))))
    (t
     ;; Only attempt to instantiate a literal if its abstraction level
     ;; is at least as great as that of the current problem space.
     (if;; (>= (car exp) al)
      (>= (car (annotate-preconds-rec (cdr exp) (true-decs decs vars values)
				      parity)) al)
      (or (try-to-instantiate (cdr exp) values vars) (cdr exp))))))

(defun true-decs (decs vars values)
  "More accurate variable types based on the instantiation."
  (mapcar
   #'(lambda (dec)
       (mapcar
	#'(lambda (obj-type)
	    ;; We may or may not have values for objects, depending 
	    ;; on whether this one was quantified or not.
	    (let ((varpos (position (car obj-type) vars)))
	      (if (and varpos (prodigy-object-p (elt values varpos)))
		  (list (car obj-type)
			(type-name
			 (prodigy-object-type (elt values varpos))))
		  dec)))
	dec))
   decs))

;;; This function returns an instantiated literal if every variable
;;; mentioned in the variablised literal given as input actually has a
;;; value. Otherwise it returns nil.
(defun try-to-instantiate (pred values vars)
  (declare (special *current-problem-space*))
  (catch 'one-got-away
    (instantiate-literal
     (car pred)
     (mapcar #'(lambda (symbol)
		 (cond ((strong-is-var-p symbol)
			(let ((index (position symbol vars)))
			  (if (and index
				   (not (listp (elt values index))))
			      (elt values index)
			      (throw 'one-got-away nil))))
		       (t (make-real-object symbol *current-problem-space*))))
	     (cdr pred)))))

;;===== Peter's SABA code


;**Documentation chiefly to remind me (Peter) what I did:
;**Currently the heuristic is as follows:  if an operator is free to go,
;**take it.
;***Otherwise, if there are any operators hanging around on the global
;***operator list, check to see if they are still good choices. 
;**If not, find the operator with the fewest conflicts that
;**deletes a precondition of another applicable operator.  If this 
;**other operator is less-constrained, then take it
;***and put all other such operators on the global list.  
;**Otherwise (i.e. it is 
;**not less-constrained or no operator deletes a precondition), take 
;**the less-constrained operator with the fewest conflicts.


(defvar *global-op-list* nil)

(defun decide-which-one-to-apply (applicable-ops)
  (cond
   ((null applicable-ops) nil)
   ((= (length applicable-ops) 1)
    (list (car applicable-ops)))
   (t
    (let* ((p-a-d-all-ops (preconds-adds-dels-list applicable-ops))
	   (most-free (find-most-free p-a-d-all-ops
				      (1- (length applicable-ops)))))
      (if most-free
	  (progn (setf *global-op-list* nil) most-free) ;hack to reset 
					                ;global list
	(let ((most-promising-less-constrained
	       (find-most-promising-less-constrained p-a-d-all-ops)))
	  (list 
	   (car
	    (cond (most-promising-less-constrained
		   (find-least-constrained most-promising-less-constrained))
		  (p-a-d-all-ops
		   (find-least-constrained p-a-d-all-ops))
		  (t
		   (list)))))))))))


;**this function only checks for the operator with the fewest conflicts
;**that deletes another operator(s)' preconditions.  It returns the 
;**affected operators only if they are less-constrained.
;***first it checks if this function has previously put some operators
;***in line to be worked on.  If they are still applicable, they get
;***priority.

(defun find-most-promising-less-constrained (filled-list-applicable-ops)
  (cond (*global-op-list*
	 (get-previously-most-promising filled-list-applicable-ops))
	(t
	 (let ((precond-deleters nil)
	       (result nil))
	   (dolist (op filled-list-applicable-ops)
		   (when (not (less-constrained-p op))
			 (push op precond-deleters)
;**this delete could be a problem.  Does it side-effect right?
			 (delete op filled-list-applicable-ops)))
	   (let ((most-likely-to-become-free-to-go 
		  (find-least-constrained precond-deleters)))
	     (dolist (conflict (nth 4 most-likely-to-become-free-to-go))
		     (when (and (eq (car conflict) 'deletes-precond)
				(less-constrained-p (cadr conflict)))
			   (push (cadr conflict) result)))
	     
;***if the global list is non-nil, it's first element is the operator that
;***deletes other operator(s)' preconditions.

	     (when result
		   (setf *global-op-list* (cons most-likely-to-become-free-to-go
						result)))
	     result)))))


;***takes an operator (from the global list) and resets its conflicts to the
;***current situation

(defun still-applicable-p (op filled-list-applicable-ops)
  (let ((current-status 
	 (member op filled-list-applicable-ops 
		 :test #'(lambda (x y) (equal (car x) (car y))))))
    (cond (current-status
	   (setf (nth 4 op)
		 (nth 4 (car current-status))))
	  (t nil))))
;***this is the function that handles the global operator list.  It
;***calls a function to update the list and then returns a list of 
;***old candidate operators if they are still candidates.

(defun get-previously-most-promising (filled-list-applicable-ops)
  (let ((old-most-likely-to-become-free (car *global-op-list*))
	(old-most-promising (cdr *global-op-list*)))
;***if the first element isn't applicable anymore, reset the global list to nil
    (cond ((not (still-applicable-p old-most-likely-to-become-free
				    filled-list-applicable-ops))
	   (setf *global-op-list* nil))
;***otherwise, delete all the no-longer-applicable operators from the 
;***global list, and reset their conflicts to the current values
;***(a side effect of still-applicable-p)
	  (t 
	   (mapc #'(lambda (x) 
		     (when 
		      (or 
		       (not (still-applicable-p x filled-list-applicable-ops))
		       (not (less-constrained-p x)))
		      (delete x *global-op-list*)
		      (setf old-most-promising (delete x old-most-promising))))
		 old-most-promising)
;***if no operators satisfy the conditions, call find-most-pr.. again
	   (cond (old-most-promising old-most-promising)
		 (t
		  (setf *global-op-list* nil)
		  (find-most-promising-less-constrained 
		   filled-list-applicable-ops)))))))
	     
				  

;**Now least-constrained means having the fewest number of conflicts.

(defun find-least-constrained (filled-list-applicable-ops)
  (let ((result nil)
	(min-number-of-conflicts most-positive-fixnum))
    (dolist (op filled-list-applicable-ops)
	    (when (< (length (nth 4 op)) min-number-of-conflicts)
		  (setf result op)
		  (setf min-number-of-conflicts (length (nth 4 op)))))
    result))
(defun find-most-free (filled-list-applicable-ops pos)
  (cond
    ((< pos 0) nil)
    ((free-to-go-p (nth pos filled-list-applicable-ops)
		   (remove (nth pos filled-list-applicable-ops)
			   filled-list-applicable-ops))
     (list (car (nth pos filled-list-applicable-ops))))
    (t
     (find-most-free filled-list-applicable-ops (1- pos)))))

;;; Relaxes free-to-go-p. 
;;; Less-constrained-p of op is true if
;;; op does not delete what some other needs

(defun less-constrained-p (p-a-d-possible-op)
  (let ((conflicts (nth 4 p-a-d-possible-op)))
    (notany #'(lambda (x) (eq (car x) 'deletes-precond))
	    conflicts)))

;;; Free-to-go-p  op is true if noone deletes what op adds,
;;; and op does not delete what some other needs

(defun free-to-go-p (p-a-d-possible-op filled-list-applicable-ops)
  (when filled-list-applicable-ops
    ;(format t "~% p-a-d-possible-op ~S" p-a-d-possible-op)
    ;(format t "~% filled-list-applicable-ops ~S" filled-list-applicable-ops)
    (let ((result t))
      (dolist (add (nth 2 p-a-d-possible-op)) ;should be primary add...
	;(format t "~% add ~S" add)
	;(format t "~% some-del-this-add ~S"
		;(some #'(lambda (x) (member add (nth 3 x)))
		 ;  filled-list-applicable-ops))
;**Goes through the entire list of possibly conflicting operators.
;**still returns true if the op is free to go, but otherwise all
;**the conflicts are put into the conflict space of the 
;**precond-adds-dels lists as lists.  The first element is the type
;**of conflict, the second is the operator that causes the conflict.
	(mapc #'(lambda (x) 
		  (when (member add (nth 3 x))
			(setf (nth 4 p-a-d-possible-op)
			      (cons (list 'has-add-deleted x)
				    (nth 4 p-a-d-possible-op)))
			(setf result nil)))
	      filled-list-applicable-ops))
      (dolist (del (nth 3 p-a-d-possible-op))
	      (mapc #'(lambda (x) 
		  (when (member del (nth 1 x))
			(setf (nth 4 p-a-d-possible-op)
			      (cons (list 'deletes-precond x)
				    (nth 4 p-a-d-possible-op)))
			(setf result nil)))
	      filled-list-applicable-ops))
      result)))

(defun preconds-adds-dels-list (applicable-ops)
  (let ((result nil))
    (dolist (inst-op applicable-ops)
      (let* ((op (instantiated-op-op inst-op))
	     (vars (rule-vars op))
	     (values (instantiated-op-values inst-op))
	     (precond-bindings
	      (precond-bindings vars values))
	     (rough-preconds
	      (binding-node-instantiated-preconds
	       (instantiated-op-binding-node-back-pointer inst-op)))
	     (preconds
	      (if (listp rough-preconds)
		  (cdr rough-preconds)
		  (list rough-preconds))))
	(push (list
	       inst-op
	       preconds
	       (simulate-effect-list-for-one
		      op (rule-add-list op) precond-bindings)
	       (simulate-effect-list-for-one
		      op (rule-del-list op) precond-bindings)
;**adding a dummy place in the list to keep track of conflicts
	       nil)
	      result)))
    result))

;;; Similar to as process-list-for-one but does not do anything at the node level
;;; Only works if effects are not conditional

(defun simulate-effect-list-for-one (op effects orig-binds)
  (let* ((res nil)
	(effect-decs (second (rule-effects op)))
	(reduced-bindings
	    (set-difference orig-binds effect-decs :key #'car)))
  (dolist (conditional-group effects)
    ;; First work out the bindings for this whole group.
    (let* ((conditional (effect-cond-conditional (car conditional-group)))
	   (bindings
	    (unless conditional
	      (list reduced-bindings))))
      ;; Second build literals for each effect in the group.
      (when (and bindings (not conditional))
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
				      (infinite-type-object-p
				       x *current-problem-space*))  
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
	    (dolist (final-binding augmented-bindings)
	      (push (instantiate-literal pred-head
					 (sublis final-binding pred-body))
		    res)
	      ))))))
  res))
  
    

(defun gen-all-applicable-ops (node applied-inst-ops)
  (cond ((null (nexus-parent node)) nil)
	((and (binding-node-p node)
	      (not (inference-rule-a-or-b-node-p node))
	      (applicable-op-p node)
	      (not (member node applied-inst-ops)))
	 (cons (binding-node-instantiated-op node)
	       (gen-all-applicable-ops
		(nexus-parent node)
		applied-inst-ops)))
	((and (typep node 'applied-op-node)
	      (not (inference-rule-a-or-b-node-p node)))
	 (gen-all-applicable-ops (nexus-parent node)
				 (cons (instantiated-op-binding-node-back-pointer
					(applied-op-node-instantiated-op node))
				       applied-inst-ops)))
	(t
	 (gen-all-applicable-ops (nexus-parent node) applied-inst-ops))))
