;;;
;;; Routines for applying operators and inference rules, initially
;;; culled from the file search.lisp when it got too large.
;;;
;;; Authors: Jim Blythe, Dan Kahn, Mei Wang
;;; File Created: July 91
;;; Last Modified: 
;;;
;;; Notes:
;;;

;;; $Revision: 1.11 $
;;; $Date: 1995/11/12 22:08:16 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: apply.lisp,v $
;;; Revision 1.11  1995/11/12  22:08:16  jblythe
;;; Main change is to fix some parts of apply and instantiate-op that assumed all
;;; infinite type objects were numbers. Now other sorts of objects can be used.
;;; Also removed some dead code for a general clean-up.
;;;
;;; Revision 1.10  1995/11/12  22:04:38  jblythe
;;; Since some external code (analogy and hamlet) calls process-list-for-one
;;; with an application rather than the applied-op-node, this function now works
;;; with either. In treeprint.lisp, brief-print-inst-op checks there is a
;;; binding-node for the instantiated op when *analogical-replay* is true: this
;;; is needed when there are eager inference rules.
;;;
;;; Revision 1.9  1995/10/12  14:22:56  jblythe
;;; Added protection nodes as a node type and search strategy, turned on with
;;; the variable *use-protection* (off by default). Also added the "event"
;;; macro which accepts similar syntax to operators. The new file "protect.lisp"
;;; has the protection code.
;;;
;;; Revision 1.8  1995/04/20  00:01:26  jblythe
;;; Added code to allow eager inference rules to use quantifiers, and to
;;; have the system notice if the goal is already achieved in the initial
;;; state after eager inference rules have fired.
;;;
;;; Revision 1.7  1995/04/12  15:12:05  jblythe
;;; Fixed a bug in p-t-l-forall that led to truth maintenance not working
;;; for (forall (X) (~ (P X))) or (~ (exists (X) (P X))) inference rules.
;;;
;;; Revision 1.6  1995/04/05  16:39:13  jblythe
;;; Included some layers of changes to dealing with forall and exists
;;; goals that had been languishing in a separate file. Also added code to
;;; allow arbitrary slots of operators, that are added to the property
;;; list, and fixed a problem with optionally compiling the matching
;;; functions.
;;;
;;; Revision 1.5  1994/06/05  00:50:18  rudis
;;; 1994-06-04 Rujith de Silva.
;;; Modified form-cross-product-and-check-functions to handle internal Prodigy
;;; functions by using (substitute-internal).
;;;
;;; Revision 1.4  1994/05/30  20:55:30  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.3  1994/05/30  20:29:40  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(in-package "PRODIGY4")

;;; First, some macros for accessing the tms structures
(defmacro literal-justification (literal node)
  "Retrieve the justification structure for a literal at a node."
  `(or (assoc ,literal (a-or-b-node-justification-table ,node))
    (car (push
	  (or (copy-tree (inherit-justification ,literal (nexus-parent ,node)))
	      (list ,literal nil nil))
	  (a-or-b-node-justification-table ,node)))))

(defmacro literal-expl (literal node)
  "The explanation for a literal at a node."
  `(second (literal-justification ,literal ,node)))

(defmacro literal-deps (literal node)
  "The dependents of a literal at a node."
  `(third (literal-justification ,literal ,node)))

(defun inherit-justification (literal node)
  (declare (type literal literal)
	   (type (or nexus null) node))
  "Look for the most recent justification of the literal at or above
this node."
  (cond ((null node) nil)
	((and (typep node 'a-or-b-node)
	      (assoc literal (a-or-b-node-justification-table node))))
	(t
	 (inherit-justification literal (nexus-parent node)))))

;;; Apply-and-check applies an operator at a node, which is usually an
;;; applied-op-node but which can be a binding node, then checks to
;;; see if other inference rules have become applicable and
;;; recursively applies them, check all the while if we've achieved
;;; the top level goal. It stops and returns t if this is ever true,
;;; otherwise it applies everything it can and returns nil. inst-op
;;; can be either an operator or an inference-rule.

(defun apply-and-check (node inst-op)
  "Apply an operator, also applying appropriate lazy and eager
inference rules. Returns non-nil if the original problem is solved."
  (declare (type a-or-b-node node)
	   (type instantiated-op inst-op)
	   (special *current-problem-space*))

  ;; First apply this operator
  (apply-op node inst-op)

  ;; Now apply eager inference rules without chaining.
  (fire-eager-inference-rules node)

  ;; Now see what we can do with lazy inference rules. These chain,
  ;; but of course we only apply the ones that already have
  ;; instantiated operator nodes above on the search tree.
  (do* ((irule (get-next-applicable-irule node)
	       (get-next-applicable-irule node))
	(finish-op (elt (problem-space-property :*finish-binding*)
			(nexus-abs-level node)))
	(finish-nodes (nexus-children finish-op))
	(done (or (eq finish-op
		      (nexus-parent
		       (instantiated-op-binding-node-back-pointer inst-op)))
		  (some #'applicable-op-p finish-nodes))
	      (some #'applicable-op-p finish-nodes)))
       ((or done (null irule)) done)
    (apply-op node irule)))


(defun get-next-applicable-irule (node)
  (get-next-irule-r node nil))

(defun get-next-irule-r (node applied-irules)
  (let ((new-applied-irules
	 (if (and (a-or-b-node-p node)
		  (a-or-b-node-applied node))
	     (nconc (mapcan
		     #'(lambda (appl)
			 (let ((iop (op-application-instantiated-op appl)))
			   (if (inference-rule-p (instantiated-op-op iop))
			       (list iop))))
		     (a-or-b-node-applied node))
		    applied-irules)
	     applied-irules)))
    (cond ((null (nexus-parent node)) nil)
	  ((and (binding-node-p node)
		(inference-rule-a-or-b-node-p node)
		(not (member (binding-node-instantiated-op node)
			     new-applied-irules))
		(applicable-op-p node))
	   (binding-node-instantiated-op node))
	  (t
	   (get-next-irule-r (nexus-parent node) new-applied-irules)))))

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

    ;; Iterate over the del-list and add-list of the operator. For each
    ;; one, find the associated literal in the state and do the dirty.
    ;; We have to work out what literals to fire first, in case there
    ;; are bindings, and firing off one lot alters the bindings of the
    ;; other. If that is the case, it matters what order the adds and
    ;; dels are in, but we don't preserve that order. I do the del's
    ;; first so that if a literal is in both lists, it stays around.
    (let ((adds-and-deletes (compute-effects op precond-bindings node)))
      (dolist (dellit (first adds-and-deletes))
	(apply-for-one-literal dellit justification application nil node))
      (dolist (addlit (second adds-and-deletes))
	(apply-for-one-literal addlit justification application t node)))
    
    ;; Not sure this is the right thing to do..
    (unless justn (delete-instantiated-op-from-literals inst-op))))

(defun precond-bindings (vars values)
  (mapcan #'(lambda (x y)
	      (if y (list (cons x y))))
	  vars values))

#|
(defun process-list (op effects justification application addingp orig-binds
			     vars values node &optional (do-justifications t))
  (declare (list effects)
	   (ignore justification addingp)
	   (special *current-problem-space*))
  ;; effects is a list of effects grouped (listed) by conditional.
  (let ((res nil))

    (dolist (conditional-group effects)
      (let* ((conditional (effect-cond-conditional (car conditional-group)))
	     (bindings (if conditional
			   (descend-match (second conditional) node orig-binds)
			   (list orig-binds))))
	(if bindings
	    (dolist (effect-cond conditional-group)
	      
	      (let* ((orig-consed-lit (effect-cond-effect effect-cond))
		     (pred-head (car orig-consed-lit))
		     (pred-body
		      (mapcar #'(lambda (x)
				  (if (strong-is-var-p x) x
				      (object-name-to-object
				       x *current-problem-space*)))
			      (cdr orig-consed-lit)))
		     (bound-vars (mapcar #'(lambda (x) (car x))
					   (first bindings)))
		     (relevant-vars (mapcan #'(lambda (x)
						(if (strong-is-var-p x)
						    (list x)))
					    pred-body)))

		;; Now we have the bindings from matching conditional
		;; effects. We may still have unbound variables, and
		;; they should be fired all possible ways.

		(dolist (final-binding
			  (form-all-bindings
			   bound-vars relevant-vars op bindings))
		  (let ((literal (check-and-instantiate
				  final-binding op pred-head pred-body)))
		    (when literal
		      (pushnew literal res :test #'equal)
		      (setf (instantiated-op-values 
			     (op-application-instantiated-op application))
			    (mapcar #'(lambda (x)
					(cdr x)) final-binding))))))))))
    res))
|#

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

(defun compute-effects (op orig-binds node)
  (declare (list effects)
	   (special *current-problem-space*))

  ;; I create a cache for calls to descend-match to avoid calling it twice.
  (let ((*cached-matches* nil))
    (declare (special *cached-matches*))
    ;; Jim 1/94: extra optional arg
    (list
     (process-list-for-one op (rule-del-list op) orig-binds node nil)
     (process-list-for-one op (rule-add-list op) orig-binds node t))))

(defun cache-and-match (expr conditional node partial-bindings
			     type-declarations)
  (declare (special *cached-matches*))
  (or (cdr (assoc conditional *cached-matches*))
      (let ((match (descend-match expr node partial-bindings
				  type-declarations)))
	(push (cons conditional match) *cached-matches*)
	match)))

(defun process-list-for-one (op effects orig-binds node &optional addingp)
  (let* ((res nil)
	 (saver nil)			; list for each effect group
	 (effect-decs (second (rule-effects op)))
	 (reduced-bindings
	  (set-difference orig-binds effect-decs :key #'car)))
    (dolist (conditional-group effects)
      ;; Jim 1/94: save the literals attached to each group so they can
      ;; be protected easily. "node" is nil when this is a static
      ;; eager inference rule. Right now I am not able to protect
      ;; goals by negating preconditions of these rules.
      (when (and node (applied-op-node-p node))
	(setf saver (list (effect-cond-conditional (car conditional-group))))
	(push saver (getf (nexus-plist node)
			  (if addingp :effect-adds :effect-dels))))
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
		    (t (list reduced-bindings)))))
	;; Second build literals for each effect in the group.
	(when bindings
	  (dolist (effect-cond conditional-group)
	    (let* ((orig-consed-lit (effect-cond-effect effect-cond))
		   (pred-head (car orig-consed-lit))
		   (pred-body
		    ;;aperez: strong-is-var-p is needed when the
		    ;;effect contains a number (it is neither a var
		    ;;nor has a prodigy object associated with it)
		    ;;Jim: Changed to allow non-numeric infinite types
		    (mapcar #'(lambda (x)
				(if (or (strong-is-var-p x)
					(infinite-type-object-p
					 x *current-problem-space*))  
				    x
				  (object-name-to-object
				   x *current-problem-space*)))
			    (cdr orig-consed-lit)))
		   (bound-vars (mapcar #'car (first bindings)))
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
		(let ((lit (instantiate-literal
			    pred-head (sublis final-binding pred-body))))
		  (if (and node (applied-op-node-p node))
		      (push lit (cdr saver)))
		  (push lit res))
		;; Not sure why this is here. The values are
		;; originally set up from bindings that matched the
		;; rule. The new ones are not necessarily in the right
		;; order to print out properly. It would perhaps be
		;; useful to record the different sets of bindings
		;; that fired, but this structure is not set up to do
		;; that.
		#|
		(setf (instantiated-op-values
		       (op-application-instantiated-op application))
		      (mapcar #'(lambda (x) (cdr x))
			      final-binding))
|#
		))))))
    res))

;;; Get all possible bindings lists based on the bindings passed in,
;;; with any bindings from focus-vars that are mentioned in the
;;; effect-decs replaced by all instances of the appropriate type.
(defun type-cross-product (bindings focus-vars effect-decs)
  (let ((this-var (caar bindings)))
    (cond ((null bindings) (list nil))
	  ((and (member this-var focus-vars)
		(member this-var effect-decs :key #'car))
	   (let ((instances
		  (type-instances
		   (type-name-to-type (second (assoc this-var effect-decs))
				      *current-problem-space*))))
	     (mapcan #'(lambda (part)
			 (mapcar #'(lambda (instance)
				     (cons (cons this-var instance)
					   part))
				 instances))
		     (type-cross-product (cdr bindings) focus-vars
					 effect-decs))))
	  (t
	   (mapcar #'(lambda (part) (cons (car bindings) part))
		   (type-cross-product (cdr bindings) focus-vars
				       effect-decs))))))


;; vars are a subset of variables that appear only in the effect list
;; of the operator.  This functions returns all the variables that are
;; needed in order to generate bindings for vars.  Then sort them
;; according to the order they appear in the effect list.
(defun get-depending-vars (vars op)
  (let ((final-vars vars)
	(new-vars vars)
	(cont nil))
    (do ()
	((and (endp new-vars) (not cont))
	 final-vars)
      (let* ((depending-vars (find-depending-vars-for-var (car new-vars) op))
	     (added-vars (set-difference depending-vars final-vars)))
	(setf new-vars (append (cdr new-vars) added-vars))
	(setf final-vars (append final-vars new-vars))))))

;; find the variables that var depends on.  The specification of var
;; appears in the effect list of op.
(defun find-depending-vars-for-var (var op)
  (let ((spec (second (assoc var (second (rule-effects op))))))
    (all-vars spec)))

(defun my-sort (vars op)
  (let ((all-vars (mapcar #'(lambda (x) (car x))
			  (second (rule-effects op)))))
    (delete-if-not #'(lambda (x) (member x vars)) all-vars)))


#|
(defun check-and-instantiate (final-binding op pred-head inst-body)
  (and (runtime-type-check final-binding op)
       (every #'(lambda (x) (check-functions-for-var x final-binding op))
	      (set-difference (rule-vars op) (rule-precond-vars op)))
       (instantiate-literal pred-head (sublis final-binding inst-body))))
|#

(defun check-and-instantiate (final-binding op pred-head inst-body)
  (let ((all-vars (mapcar #'(lambda (x) (car x)) final-binding)))
    (and (runtime-type-check final-binding op)
	 (every #'(lambda (x)
		    (check-functions-for-var x final-binding op))
		all-vars)
	 (instantiate-literal pred-head
			      (sublis final-binding inst-body)))))


(defun form-all-bindings (bound-vars relevant-vars op bindings)
  (let ((unbound-vars
	 (my-sort (set-difference relevant-vars bound-vars) op))
	(res nil))
    (if unbound-vars
	(dolist (binding bindings res)
	  (setf res
		(append (get-some-bindings unbound-vars op binding)
			res)))
      bindings)))

#|
(defun get-some-bindings (unbound-vars op binding)
  (let ((all-values nil)
	(still-unbound-vars nil)
	(new-bounded nil)
	(final-bindings nil))
    ;; first generate bindings for those that are not of infinite
    ;; types.
    (dolist (var unbound-vars)
      (if (infinite-type-var var op)
	  (push var still-unbound-vars)
	  (and (push (generate-values-for-var var op) all-values)
	       (push var new-bounded))))
    ;; then generate bindings for vars of infinite type if there
    ;; are any; still-unbound-vars are such vars
    (dolist (var-binding (form-all-vars new-bounded all-values))
      (if still-unbound-vars
	  (let ((res nil)
		(full-binding (append binding var-binding)))
	    (dolist (var still-unbound-vars)
	      (push (gen-binding-for-inf-var var full-binding op) res))
	    (setf final-bindings
		  (append
		   (mapcar #'(lambda (x) (append full-binding x))
			   (form-all-vars (reverse still-unbound-vars)
					  res))
		   final-bindings)))
	  (push (append binding var-binding) final-bindings)))
    final-bindings))
|#

;;; all unbound-vars will be used in the predicate, so we have to
;;; generate the cross product of all these variables.
(defun get-some-bindings (unbound-vars op binding)
  (if (null unbound-vars)
      (list binding)
    (let ((new-bindings (form-new-bindings
			 (car unbound-vars) op binding))
	  (res nil))
      (if (null (cdr unbound-vars))
	  new-bindings
	(dolist (bind new-bindings res)
	  (setf res
		(nconc (get-some-bindings
			(cdr unbound-vars) op bind)
		       res)))))))

(defun form-new-bindings (var op binding)
  (if (infinite-type-var var op)
      (let ((inf-var-binds
	     (gen-binding-for-inf-var var binding op)))
	(cross-product (form-real-bindings var inf-var-binds)
		       (list binding)))
    (let ((var-binds (generate-values-for-var var op)))
      (form-cross-product-and-check-functions
       var op (form-real-bindings var var-binds)
       (list binding)))))

(defun form-real-bindings (var values)
  (mapcar #'(lambda (x) (cons var x)) values))

(defun form-cross-product-and-check-functions
  (var op bindings-for-var bindings)
  (let ((all-bindings (cross-product bindings-for-var bindings))
	(functions-for-var (get-functions-for-var var op)))
    (if functions-for-var
	(delete-if-not
	 #'(lambda (x)
	     ;; Jim: went back to apply from eval. Let me know of any
	     ;; problems.
	     (every #'(lambda (y)
			(apply
			 (substitute-internal (car y))
			 (mapcar #'permanent-object-to-prodigy-object
				 (sublis x (cdr y)))))
		    functions-for-var))
	     all-bindings)
	 all-bindings)))
  
(defun permanent-object-to-prodigy-object (z)
  (if (and (not (prodigy-object-p z))
	   (object-name-to-object z *current-problem-space*))
      (object-name-to-object z *current-problem-space*)
      z))


;; var only appears in the effect list
(defun get-functions-for-var (var op)
  ;; Jim: was (let ((spec (assoc ...))))
  (let ((spec (second (assoc var (second (rule-effects op))))))
    (if (and (listp spec) (eq (car spec) 'user::and))
	(cddr spec)
      #| We don't really want to test this every time, do we?
 	(mapcan #'(lambda (x)
		    (and (listp x) (functionp (car x)) (list x)))
		(cddr spec))
|#
      )))

;; generate values for an variable. won't work if var is of infinite
;; type.
(defun generate-values-for-var (var op)
  (let ((spec (second (assoc var (second (rule-effects op))))))
    (mapcan #'get-values-from-types (make-type-list spec))))


(defun form-all-vars (vars values)
  (if (null vars)
      '(nil)
    (let ((binding1
	   (mapcar #'(lambda (x) (cons (car vars) x))
		   (car values))))
      (cross-product binding1
		     (form-all-vars (cdr vars) (cdr values))))))

;; form the bindings to include bindings for infinite type vars. For
;; effects only
(defun form-final-binding-inf (vars binding op)
  (if (null vars)
      binding
    (cons
     (gen-binding-for-inf-var (car vars) binding op)
     (form-final-binding-inf (cdr vars) binding op))))

;; var is an infinite type var in the effect list of op; binding is of
;; the form ((<x> . a) (<y> .b)), it is bindings for other variables
;; in the op.
(defun gen-binding-for-inf-var (var binding op)
  (let* ((spec (second (assoc var (second (rule-effects op)))))
	 (generator (sublis binding (third spec))))
    (apply (car generator) (cdr generator))))


(defun infinite-type-var (var op)
  (declare (special *current-problem-space*))
  (let ((spec (second (or (assoc var (second (rule-precond-exp op)))
			  (assoc var (second (rule-effects op)))))))
    (and (listp spec)
	 (is-infinite-type-p (second spec) *current-problem-space*))))


(defun all-apply-bindings (arglist vars values)

  (let* ((vars-involved (intersection vars arglist))
	 (values-involved
	  (mapcar #'(lambda (var)
		      (elt values (position var vars)))
		  vars-involved))
	 (list-length
	  (some #'(lambda (x) (if (listp x) (length x)))
		values-involved))
	 (result nil))
    (if list-length
	(dotimes (x list-length)
	  (push (mapcar #'(lambda (var val)
			    (cons var (if (listp val)
					  (elt val x)
					  val)))
			vars-involved values-involved)
		result))
	(setf result (list (mapcar #'cons vars values))))
    result))


;;; This function makes the literal true or false depending on the
;;; value of "addingp". The literal is an effect of the operator being
;;; applied.

(defun apply-for-one-literal (literal justification application
				      addingp node)
  
  ;; First check if the value actually changes.
  (cond ((if addingp
	     (not (literal-state-p literal))
	     (literal-state-p literal))

	 (setf *this-literal-deps* NIL)   ;;aperez
	 (maintain-and-set-state-p literal addingp node justification)

	 ;;aperez april 1 93
	 ;;moved this to maintain-and-set-state-p so it is also done
	 ;;for the dependencies 
;         ;; delete the goal from the open goals set.
;         (setf (problem-space-expanded-goals *current-problem-space*)
;               (delete literal
;                       (problem-space-expanded-goals *current-problem-space*)))

	 (if addingp
	     (push literal (op-application-delta-adds application))
	     (push literal (op-application-delta-dels application)))
	 ;;aperez: I believe we don't care about what this fn returns
	 (dolist (dep-literal *this-literal-deps*)
	   (if (cdr dep-literal)
	       (push (car dep-literal) (op-application-delta-adds application))
	       (push (car dep-literal) (op-application-delta-dels application))))
	 )

	;; If the value hasn't changed, maybe the justification should.
	;; This is a fairly arbitrary criterion:
	((subsetp justification (literal-expl literal node))
	 (update-justification literal node justification))))


;;; This is cached the first time called.

(defun preconds-to-list (bnode)

  (let ((cached? (getf (binding-node-plist bnode) :listed-preconds)))
    (if cached?
	(cdr cached?)
	(let* ((inst-precs (binding-node-instantiated-preconds bnode))
	       (instop (binding-node-instantiated-op bnode))
	       (operator (instantiated-op-op instop))
	       (listed-preconds
		(if inst-precs
		    (p-t-l-r inst-precs
			     (binding-node-disjunction-path bnode)
			     operator t
			     (mapcar #'(lambda (var val) (cons var val))
				     (rule-vars operator)
				     (instantiated-op-values instop))))))
	  (setf (getf (binding-node-plist bnode) :listed-preconds)
		listed-preconds)
	  listed-preconds))))

(defun p-t-l-r (expr disj op parity bindings)
  (cond ((typep expr 'literal) (list expr))
	((eq (car expr) (if parity 'user::and 'user::or))
	 (mapcan #'(lambda (x d) (p-t-l-r x d op parity bindings))
		 (cdr expr) disj))
	((eq (car expr) (if parity 'user::or 'user::and))
	 (p-t-l-r (elt expr (car disj)) (cdr disj) op parity bindings))
	((eq (car expr) 'user::~)
	 (p-t-l-r (second expr) disj op (not parity) bindings))
	((eq (car expr) (if parity 'user::forall 'user::exists))
	 (p-t-l-forall expr disj op parity bindings))
	((eq (car expr) (if parity 'user::exists 'user::forall))
	 (p-t-l-r (third expr) disj op parity bindings))
	(t
	 (list (instantiate-consed-literal (sublis bindings expr))))))

#|
the old-p-t-l-forall function called below is renamed p-t-l-forall
in the code just below that.
(defun p-t-l-forall (exp disj op parity bindings)
  (let ((expr (third exp))
	(result nil))
    (if (or (and parity (eq (car expr) 'user::~))
	    (and (not parity) (not (eq (car expr) 'user::~))))
	;; This is wrong.
	(let* ((real-expr (if parity (second expr) expr))
	       (forall-bindings (descend-match real-expr nil bindings)))
	  (dolist (bind forall-bindings result)
	    (when (runtime-check-type-and-function-forall bind exp)
	      (setf result 
		    (nconc (p-t-l-r expr disj op parity bind)
			   result)))))
	(old-p-t-l-forall exp disj op parity bindings)))
  (old-p-t-l-forall exp disj op parity bindings)
  )
|#

(defun p-t-l-forall (expr disj op parity bindings)
  (do* ((gen (cdr (assoc (second expr)
			 (getf (rule-plist op) :quantifier-generators))))
	(static-data (if gen (funcall gen nil)))
	(vars (mapcar #'car (second expr)))
	(dynamic-data
	 (first-valid-choice static-data vars bindings (second expr))
	 (next-valid-choice static-data (first dynamic-data)
			    (second dynamic-data) 0 vars bindings
			    (second expr)))
	(choice (first dynamic-data) (first dynamic-data))
	(data (second dynamic-data) (second dynamic-data))
	(result nil))
       ((null choice) result)
    (setf result
	  (nconc (p-t-l-r (third expr) disj op parity
			  (nconc (choice-bindings expr data choice)
				 bindings))
		 result))))

;;; This is just like your common-or-garden tms a la theo, excepting
;;; that the justifications are stored at the node.

(defun maintain-and-set-state-p (literal value node justifiers)
  (declare (type literal literal)
	   (type a-or-b-node node)
	   (list justifiers))

  ;; Take care of the old justifications
  (update-justification literal node justifiers)

  ;; Set the value
  (set-state-p literal value)

  ;;aperez april 1 93
  ;;next comes from apply-for-one-literal so it is also done for the
  ;;dependencies 
  ;; delete the goal from the open goals set.
  (setf (problem-space-expanded-goals *current-problem-space*)
	(delete literal
		(problem-space-expanded-goals *current-problem-space*)))
  
  
  ;; Follow dependencies
  (dolist (dep-literal (literal-deps literal node))
    ;;aperez: 
    ;;keep track of dependencies to store them in application structure
    (push (cons dep-literal (not (literal-state-p dep-literal)))
	  *this-literal-deps*)
    (maintain-and-set-state-p dep-literal (not (literal-state-p dep-literal))
			      node nil)))


(defun update-justification (literal node justifiers)
  (declare (type literal literal)
	   (type a-or-b-node node)
	   (list justifiers))

  ;; a justification is a three-element list: literal, explanation,
  ;; dependencies. If it is not currently stored at this node, it is
  ;; inherited and created by literal-justification.
  (let ((justification (literal-justification literal node)))
    (dolist (old-dep (second justification))
      (let ((old-dep-just (literal-justification old-dep node)))
	(setf (third old-dep-just)
	      (delete literal (third old-dep-just)))))
    (setf (second justification) justifiers)
    (dolist (new-dep justifiers)
      (push literal (literal-deps new-dep node)))))
	  

(defun do-state (application forwardsp)
  (declare (type op-application application))
  "Apply the state changes made by this applied operator. If forwardsp
is t, the application is done, if it is nil, the application is reversed."
  (let* ((adds (op-application-delta-adds application))
	 (dels (op-application-delta-dels application)))
    ;; If forwards, delete the deletes then add the adds. If
    ;; backwards, delete the adds then add the deletes.
    (dolist (deleted (if forwardsp dels adds))
      (set-state-p deleted nil))
    (dolist (added (if forwardsp adds dels))
      (set-state-p added t))))

;;; Author: Jim Blythe
;;; Date: 91-06-11
;;; Will need to be re-written if I do justifications the way I'm
;;; thinking of doing them.
(defun state-loop-p (node)
  (declare (type applied-op-node node))
  "Check if there is a state loop going on"

  (unzip-states-loop-p
   (a-or-b-node-parent node)
   (reduce #'union
	   (mapcar #'op-application-delta-adds (a-or-b-node-applied node)))
   (reduce #'union
	   (mapcar #'op-application-delta-dels (a-or-b-node-applied node)))))
		       
;;; This version is pretty much an exact copy of Manuela's. Some
;;; efficiency hacks should be made to it at some stage.

(defun unzip-states-loop-p (node adds dels)
  (declare (type (or nexus null) node)
	   (list adds dels))
  "Recursively unzip the state, checking to see if we loop"

  (cond ((null node) nil)
	((and (null adds) (null dels)) t)
	((typep node 'a-or-b-node)
	 (let ((all-adds (reduce #'union
				 (cons adds
				       (mapcar #'op-application-delta-adds
					       (a-or-b-node-applied node)))))
	       (all-dels (reduce #'union
				 (cons dels
				       (mapcar #'op-application-delta-dels
					       (a-or-b-node-applied node))))))
	   (unzip-states-loop-p (nexus-parent node)
				(set-difference all-adds all-dels)
				(set-difference all-dels all-adds))))
	(t
	 (unzip-states-loop-p (nexus-parent node) adds dels))))


;;;=====================
;;; Book Keeping
;;;
(defun do-book-keeping (node &optional parent)
  (declare (type nexus node)
	   (special *current-problem-space*))
  "Maintain names and list of nodes.."
  (push-previous node *current-problem-space*)
  (push node (problem-space-property :expandable-nodes))
  (set-node-name node)
  (setf (nexus-conspiracy-number node) 1)
  #| 
  (format t "~%Forwards: ")
  (print-previous-list (return-next *current-problem-space*))
  (format t "~%Backwards: ")
  (print-node-list (return-previous *current-problem-space*))
|#
  (if parent (push node (nexus-children parent))))


;;; set-node-name maintains the counter. In the current version, the
;;; name is a string, beginning with a letter for the type of node and
;;; ending with a unique number, and, frankly, with very little in between.
;;; Later we decided this was too complicated and took the letter out.
(defun set-node-name (node)
  (declare (special *node-counter*))
  "Set the name of the node and then increment the variable
*node-counter*.  Should be called right after creating a node."
  (setf (nexus-name node) (incf *node-counter*)))


;;; close-node is called when we find there are no more children to
;;; expand at a node. Delete the node from the list of expandable
;;; nodes in the problem space, and then maybe propagate the failure
;;; back up to do some dependency-directed backtracking type stuff.
;;; Returns the failure.

;;; This isn't perfect - for example if closing a node because it
;;; can't be refined is enough to tell us we could kill off a goal
;;; loop, we'll miss that. But hey, it's a start.

(defun close-node (node &optional failure)
  (declare (type nexus node)
	   (special *current-problem-space*))
  "Delete the node from the list of nodes."

  ;; this test stops infinite recursion.
  (when (not (getf (nexus-plist node) :under-deletion))
    (setf (getf (nexus-plist node) :under-deletion) t)

    ;; This bit removes this node.
    (delete-node-link node *current-problem-space*)
    (setf (problem-space-property :expandable-nodes)
	  (delete node (problem-space-property :expandable-nodes)))

    ;; Record the reason to close the node if we know it.
    ;; Daniel. Added the test to whether it is a solution node, so
    ;; that when finding multiple-sols, it will not change the label
    ;; of a solution leaf node

    (if (and failure
	     (not (eq :achieve (getf (nexus-plist node)
				     :termination-reason))))
	(setf (getf (nexus-plist node) :termination-reason)
	      failure))

    ;; Propagate the node closing if we can.
    ;; refine failures are propagated regardless of the node type.
    (if (eq failure :not-refineable)
	(let* ((deepest (elt (problem-space-property :deepest-point)
			     (1- (nexus-abs-level node))))
	       (ancestor (and deepest (not (eq deepest node))
			      (ancestor deepest node))))
	  (if ancestor
	      (close-node (nexus-parent node) :not-refineable)))

      (unless (problem-space-property :chronological-backtracking)
	(typecase node
	  (operator-node
	   (check-term-goal-node (nexus-parent node) node failure))
	  (binding-node
	   (check-term-operator-node (nexus-parent node) node failure))
	  (goal-node
	   (check-term-intro-nodes (goal-node-introducing-operators node)
				   node failure)))))
    (setf (getf (nexus-plist node) :under-deletion) nil))
  failure)

;;; Recall that a node is closed when it is exhausted - ie all 
;;; its children have already been added to the search tree. We might
;;; not want to close all its children yet, though. But if we do, this
;;; is the function to call.
(defun close-node-and-children (node &optional failure)
  (declare (type nexus node))
  (dolist (child (nexus-children node))
    (close-node-and-children child failure))
;;;  (if (nexus-open-node-link node)   ; why?
  (close-node node failure)
;;;  )
)

;;; This one doesn't try to prune other nodes based on pruning the nodes
;;; in the subtree, unlike close-node-and-children.
(defun close-subtree (node &optional failure)
  (declare (type nexus node))

  (dolist (child (nexus-children node)) 
    (close-subtree child))

  ;; This bit removes this node.
  (delete-node-link node *current-problem-space*)
  (setf (problem-space-property :expandable-nodes)
        (delete node (problem-space-property :expandable-nodes)))
  
  ;; Record the reason to close the node if we know it.
  (if failure
    (setf (getf (nexus-plist node) :termination-reason)
          failure)))

;;; This function decides whether to remove the instantiated operator
;;; nodes that introduced a goal whose node was just deleted.
(defun check-term-intro-nodes (binding-nodes child child-failure)
  (declare (list binding-nodes)
	   (type goal-node child)
	   (special *current-problem-space*))
  (cond
    ((eq child-failure :no-op)
     (backtrack-past-undoable-goal binding-nodes child))
    ((and (eq child-failure :no-good-operators)
	  (problem-space-property :excise-loops))
     ;; There may have been goal loops. Only close off introducing
     ;; operators that are contained within the loops.
     (let* ((loop-tops
	     (delete-duplicates
	      (mapcan
	       #'(lambda (op-child)
		   (mapcan
		    #'(lambda (bin-child)
			(let ((term (getf (nexus-plist bin-child)
					  :termination-reason)))
			  (if (and (consp term)
				   (eq (car term) :causes-goal-loop))
			      (copy-list (cdr term)))))
		    (nexus-children op-child)))
	       (nexus-children child))))
	    (relevant-intros
	     (mapcan #'(lambda (binder)
			 (if (every #'(lambda (loop-node)
					(nexus-ancestor loop-node binder))
				    loop-tops)
			     (list binder)))
		     binding-nodes)))
       (if relevant-intros
	   ;; Jim 4/93: this was wrong. The error here is
	   ;; :no-good-operators, which is affected by changes in
	   ;; state. We can only go up to the most recent application
	   ;; if this is more recent than the introducing operator
	   ;; nodes. So I added the keyword to stop at any application.
	   (backtrack-past-undoable-goal relevant-intros child
					 :stop-at-application t)
	   )))))

;;; If the child died for a reason like no operators or no good
;;; operators, close off the highest possible node on the branch.
;;; This is the highest node that requires the goal, or the one where
;;; the truth value changed if this is a lower node.

(defun backtrack-past-undoable-goal (intros goal-node
					    &key (stop-at-application nil))
  (declare (list intros)
	   (type goal-node goal-node))
  ;; Go up the ancestors of the search path until you hit either the
  ;; last intro node or a node where the value of goal changes.
  (do ((node goal-node (nexus-parent node))
       (intros-to-hit (length intros))
       (goal (goal-node-goal goal-node)))
      ((null (nexus-parent node))
       ;; Bail out - this should never have happened.
       (cerror "Do chronological backtracking"
	       "Backtracking went too far"))
    (cond ((and (binding-node-p node)
		(member node intros))
	   (setf intros-to-hit (1- intros-to-hit))
	   (when (= intros-to-hit 0)
	     (close-node-and-children
	      node :unsolvable-goal-introduced-here-or-above)
	     (return)))
	  ((and (a-or-b-node-p node)
		(or (and stop-at-application
			 (applied-op-node-p node))
		    (some #'(lambda (app)
			      (member goal
				      (if (literal-state-p goal)
					  (op-application-delta-adds app)
					  (op-application-delta-dels app))))
			  (a-or-b-node-applied node))))
	   (close-node-and-children node :irreversible-bad-state-change)
	   (return)))))

(defun nexus-ancestor (older younger)
  (or (eq older younger)
      (and (nexus-parent younger)
	   (nexus-ancestor older (nexus-parent younger)))))

(defun check-term-operator-node (node child child-failure)
  (declare (type operator-node node)
	   (type binding-node child)
	   (ignore child child-failure)
	   (special *current-problem-space*))
  ;; If all the children die for reasons like unsolvable goals and
  ;; there are no binding select or reject control rules, mark
  ;; this operator node as unuseable.
  (if (and (null (operator-node-bindings-left node))
	   (null (problem-space-select-bindings *current-problem-space*))
	   (null (problem-space-reject-bindings *current-problem-space*))
	   (every #'(lambda (bind-node)
		      (let ((term (getf (nexus-plist bind-node)
					:termination-reason)))
			(or (eq term :uses-unsolvable-goal)
			    (and (consp term)
				 (eq (car term) :causes-goal-loop)))))
		  (nexus-children node)))
      (close-node node :no-good-bindings)))

(defun check-term-goal-node (node child child-failure)
  (declare (type goal-node node)
	   (ignore child child-failure)
	   (special *current-problem-space*))

  ;; If all the children failed for reasons like no binding choices,
  ;; and there are no select or reject operator control rules, we can
  ;; determine that this goal would never have succeeded. This is a
  ;; bit tricky, though.
  (if (and (null (goal-node-ops-left node))
	   (null (problem-space-select-operators *current-problem-space*))
	   (null (problem-space-reject-operators *current-problem-space*))
	   (every #'(lambda (op-node)
		      (let ((term (getf (nexus-plist op-node)
					:termination-reason)))
			(or
			 ;;(member term '(:no-binding-choices :no-good-bindings))
			 ;; Only the regression result is safe.
			 (eq term :no-good-bindings)
			 (and (consp term)
			      (eq (car term) :causes-goal-loop)))))
		  (nexus-children node)))
      (close-node node :no-good-operators)))

;;========================================
;; fire static eager inference rules stuff
;; written by Mei, June 25, 1991
;;========================================


(defun fire-static-eager-inference-rules ()
  (declare (special *current-problem-space*))
  (mapcan #'(lambda (rule)
	      (if (static-inference-rule-p rule)
		  (fire-one-static-eager-inference-rule rule)))
	  (problem-space-eager-inference-rules *current-problem-space*)))

;;; find all the possible matchs of the state with the preconds of the
;;; rule, add/del all the effects
;;; Returns a list of applications.

(defun fire-one-static-eager-inference-rule (rule)

  ;; Since the preconditions are static, no more is needed than to run
  ;; these tests.
  (mapcar #'(lambda (binding) (simple-apply-op binding rule))
	  (get-possible-bindings rule)))

;;; apply an inference rule in the beginning of the problem solving,
;;; it's simple because we don't need to keep justifications, worry
;;; about backtracking, resetting goals and all that stuff.  the only
;;; thing needs to be done here is to add/del literals of the effect
;;; list of the inference rules.
(defun simple-apply-op (binding rule)

  (let* ((inst-op (make-instantiated-op :op rule
					:values binding))
	 (application (make-op-application :instantiated-op inst-op))
	 (vars (rule-vars rule))
	 (precond-binds
	  (precond-bindings vars binding)))

    ;;(output 2 t "Applying static rule ~S~%" inst-op)
    (when (and (problem-space-property :*output-level*)
	       (>= (problem-space-property :*output-level*) 2))
      (format t "~%Applying static rule ")
      (brief-print-inst-op inst-op))

    (let ((adds-and-deletes (compute-effects rule precond-binds nil)))
      (dolist (dellit (first adds-and-deletes)) (set-state-p dellit nil))
      (dolist (addlit (second adds-and-deletes)) (set-state-p addlit t)))
    application))


(defun fire-eager-inference-rules (node)
  (declare (special *current-problem-space*)
	   (type a-or-b-node node))
  "Apply newly applicable eager inference rules, without chaining."
  
  (dolist (rule (problem-space-eager-inference-rules *current-problem-space*))
    (unless (static-inference-rule-p rule)
      (dolist (binding (getf (rule-plist rule) :possible-bindings))

	;; Check if each binding works, and if so apply with that as
	;; the justification.
	(let ((justification (check-binding binding rule)))
	  (if justification
	      (apply-op node
			(make-instantiated-op :op rule :values binding)
			justification)))))))

;;; This used to be fired every application of an eager inference
;;; rule. Now it's only fired at the start, and the results saved.
;;; Need to run some tests to find which is quicker.
(defun get-possible-bindings (rule)

  ;; Only take the last of these tests, because we're not interested
  ;; in the binding control rules - we'll fire all matches.
  (let* ((data (if (rule-generator rule)
		   (funcall (rule-generator rule) nil)))
	 (simple-test (car (last (rule-simple-tests rule))))
	 (unary-test  (car (last (rule-unary-tests  rule))))
	 (join-test   (car (last (rule-join-tests   rule))))
	 (neg-simple-tests   (car (last (rule-neg-simple-tests   rule))))
	 (neg-unary-tests   (car (last (rule-neg-unary-tests   rule))))
	 (neg-join-tests   (car (last (rule-neg-join-tests   rule))))
	 (precedence (simple-match simple-test))
	 (neg (if precedence (neg-simple-match neg-simple-tests rule))))
    (if neg
	(if (rule-vars rule)
	    ;; eager inf rules should not have conditional effect
	    (mapcar #'car 
		    (match unary-test join-test neg-unary-tests neg-join-tests
			   (cons neg data) rule))
	    ;; If there are no variables, the null binding is ok.
	    (list nil))
	    )))


(defun gather-together (raw-possibles length)
  (gather-rec raw-possibles length nil))

(defun gather-rec (raw length cooked)
  (if (null raw) cooked
      (let ((cooker (find-cooker (car raw) cooked length)))
	(cond (cooker
	       (heat-up cooker (car raw) length)
	       (gather-rec (cdr raw) length cooked))
	      (t
	       (gather-rec (cdr raw) length
			   (cons (new-cooker (caar raw) length) cooked)))))))

(defun find-cooker (raw cooked length)
  (find raw cooked
	:test #'(lambda (x y) (same-to-length (car x) y length))))

(defun same-to-length (x y length)
  (cond ((zerop length) t)
	((eq (car x) (car y))
	 (same-to-length (cdr x) (cdr y) (1- length)))))

(defun heat-up (cooker raw length)
  (dotimes (x (length cooker))
    (if (>= x length) (push (elt (car raw) x) (elt cooker x)))))

(defun new-cooker (raw length)
  (mapcar
   #'(lambda (x) (if (zerop length) (list x)
		     (progn (decf length) x)))
   raw))

(defun check-binding (oblist rule)
  "Check that the preconditions of the rule are satisfied with the
given bindings."
  (declare (list oblist)
	   (type operator rule))
  (check-binding-r oblist (operator-vars rule)
		   (third (operator-precond-exp rule)) rule t))

;;aperez 3/93 added rule argument to allow exists and foralls in
;;eager inference rules
(defun check-binding-r (oblist vars expr rule want-true-p)
  (cond ((or (and (eq (car expr) 'user::and) want-true-p)
	     (and (eq (car expr) 'user::or) (not want-true-p)))
	 (catch 'failed
	   (mapcan
	    #'(lambda (x) (or (check-binding-r oblist vars x rule want-true-p)
			      (throw 'failed nil)))
		   (cdr expr))))
	((or (and (eq (car expr) 'user::or) want-true-p)
	     (and (eq (car expr) 'user::and) (not want-true-p)))
	 (some #'(lambda (x) (check-binding-r oblist vars x rule want-true-p))
	       (cdr expr)))
	((eq (car expr) 'user::~)
	 (check-binding-r oblist vars (second expr) rule (not want-true-p)))

	;;aperez: allow exists and foralls in eager inference rules
	((or (and (eq (car expr) 'user::forall) want-true-p)
	     (and (eq (car expr) 'user::exists) (not want-true-p)))
	 (check-forall-binding oblist vars expr rule want-true-p))

	((or (and (eq (car expr) 'user::exists) want-true-p)
	     (and (eq (car expr) 'user::forall) (not want-true-p)))
	 (check-exists-binding oblist vars expr rule want-true-p))
		
	;; Anything else is assumed to be a predicate. I use the
	;; double negation to make sure that everything is either t or
	;; nil.
	((let ((lit (make-up-literal expr oblist vars)))
	   (if (eq (not (literal-state-p lit))
		   (not want-true-p))
	       (list lit))))))


;;This has to return the list of literals satisfied in the forall
;;(that is what check-binding should return to be stored as justification)

(defun check-forall-binding (oblist vars expr rule want-true-p)
  ;;checks the body with all possible bindings for the quantified variables.
  ;;assoc finds quantifier generator for this forall (there may be
  ;;several foralls in the operator) and then funcall gets all
  ;;the possible bindings for each the vars
  (do* ((gen (cdr (assoc (second expr)
			 (getf (rule-plist rule)
			       :quantifier-generators))))
	(data (if gen (funcall gen nil)))
	(choice (make-list (length data) :initial-element 0)
		(increment-choice choice data))
	(forall-bindings (choice-bindings expr data choice)
			 (choice-bindings expr data choice))
	this-binding-justif final-justif)
       ((null choice) (reverse final-justif))
    (setf this-binding-justif
	  (check-binding-r
	   (append oblist (mapcar #'cdr forall-bindings)) ;;objects
	   (append vars (mapcar #'car forall-bindings)) ;;vars
	   (third expr) rule want-true-p))
    (if this-binding-justif
	(push this-binding-justif final-justif)
	(return nil))))

(defun check-exists-binding (oblist vars expr rule want-true-p)
  (do* ((gen (cdr (assoc (second expr)
			 (getf (rule-plist rule)
			       :quantifier-generators))))
	(data (if gen (funcall gen nil)))
	(choice (make-list (length data) :initial-element 0)
		(increment-choice choice data))
	(exists-bindings (choice-bindings expr data choice)
			 (choice-bindings expr data choice))
	this-binding-justif)
       ((null choice) nil)
    (setf this-binding-justif
	  (check-binding-r
	   (append oblist (mapcar #'cdr exists-bindings)) ;;objects
	   (append vars (mapcar #'car exists-bindings)) ;;vars
	   (third expr) rule want-true-p))
    (if this-binding-justif (return this-binding-justif))))



(defun make-up-literal (expr oblist vars)
  (instantiate-consed-literal
   (cons (car expr)
	 (mapcar #'(lambda (arg)
		     (if (strong-is-var-p arg)
			 (elt oblist (position arg vars))
			 arg))
		 (cdr expr)))))
