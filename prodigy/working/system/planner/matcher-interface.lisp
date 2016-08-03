;;; $Revision: 1.12 $
;;; $Date: 1996/02/20 15:59:31 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: matcher-interface.lisp,v $
;;; Revision 1.12  1996/02/20  15:59:31  jblythe
;;; Fixed a bug in unify where the object had to have the exact type of the
;;; matching variable, and couldn't be an instance of a subtype.
;;;
;;; Revision 1.11  1995/11/13  11:56:02  jblythe
;;; Removed an error generated when a goal is expanded twice - that's not an error.
;;; Changed the pattern of add and deletes stored for incremental pending goals -
;;; see update-pending-goals.
;;;
;;; Revision 1.10  1995/10/12  14:23:05  jblythe
;;; Added protection nodes as a node type and search strategy, turned on with
;;; the variable *use-protection* (off by default). Also added the "event"
;;; macro which accepts similar syntax to operators. The new file "protect.lisp"
;;; has the protection code.
;;;
;;; Revision 1.9  1995/10/03  11:04:46  jblythe
;;; Commiting files that were inadvertently edited in the working version
;;; release - two formatting edits by khaigh and a change to printing
;;; instantiated ops when a case is being used for guidance by mmv.
;;;
;;; Revision 1.8  1995/06/07  04:25:35  jblythe
;;; The relevance table was changed to make use of type information and more
;;; extensive error messages were provided for the domain checker. In the
;;; relevance table, permanent objects are assigned the top-type for simplicity.
;;;
;;; Revision 1.7  1995/04/05  16:39:32  jblythe
;;; Included some layers of changes to dealing with forall and exists
;;; goals that had been languishing in a separate file. Also added code to
;;; allow arbitrary slots of operators, that are added to the property
;;; list, and fixed a problem with optionally compiling the matching
;;; functions.
;;;
;;; Revision 1.6  1995/03/14  17:17:55  khaigh
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
;;; Revision 1.5  1995/03/13  00:39:29  jblythe
;;; General clean-ups, including a definition of gen-from-pred that can have
;;; more than one variable in the literal.
;;;
;;; Revision 1.4  1994/05/30  20:56:09  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.3  1994/05/30  20:30:20  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


;;; combined from opdecision.lisp, cntrl-stub.lisp, and op-match.lisp
;;; date: June 21, 1991

#-clisp
(unless (find-package "PRODIGY4")
  (make-package "PRODIGY4" :nicknames '("P4")))

(in-package "PRODIGY4")

(export '(FIND-NODE))

;;; There has to be a more elegant way to do this.
(defvar *pending-goals-cache* nil)

;;; Perhaps this is it.
(defvar *pending-goals* nil
  "Incremental list of pending goals")

;;; The dangling pointers fix (4/18/94) can be turned off with this
;;; switch
(defvar *no-danglers* t
  "Whether to worry about dangling pointers")


(defvar *debug-apply-op-ctrl* nil)
;  ------------------ NODE DECISIONS  ------------------


(defun generate-all-nodes (hello)
  "Returns all the candidate nodes in a list."
  (declare (special *current-problem-space*)
	   (ignore hello))
  (values
   (getf (problem-space-plist *current-problem-space*) :expandable-nodes)
   nil))

;;; I assume that all rules that select nodes, and all predicates that
;;; can generate them, produce objects of type nexus. The user can use
;;; the function "find-node" with a number to do this.
(defun generate-nodes (node-or-failure-message)
  "Uses select and reject control rules to generate a set of candidate
nodes to expand next in the search."
  (declare (special *current-problem-space*)
	   (ignore node-or-failure-message))
  ;; First, see if any rules fire.
  (let ((user::*candidate-nodes* nil)
	(select-firedp nil)
	(reject-firedp nil)
	(rules-result nil))
    (declare (special user::*candidate-nodes*))

    (multiple-value-setq (user::*candidate-nodes* select-firedp)
      (scr-select-nodes
       (problem-space-select-nodes *current-problem-space*)))
    (multiple-value-setq (rules-result reject-firedp)
      (scr-reject-nodes
       user::*candidate-nodes*
       (problem-space-reject-nodes *current-problem-space*)
       nil))

    (if (or select-firedp reject-firedp)
	rules-result
	(let ((method (getf (problem-space-plist *current-problem-space*)
			    :search-default)))
	  (case method
	    (:breadth-first
	     ;; (print 'breadth-first)
	     (list (return-next *current-problem-space*)))
	    (:depth-first
	     ;; (print 'depth-first)
	     (list (return-previous *current-problem-space*)))
	    (t rules-result))))))

;;; This is now a multiple value function.  
(defun scr-select-nodes (rules)
  "Iterate through the select control rules trying to find one that fires."
  (if (null rules)
      (generate-all-nodes nil)
      (let ((res (match-select-node (car rules))))
	(if res
	    (values res t)
	    (scr-select-nodes (cdr rules))))))

(defun match-select-node (rule)
  (let ((matched (match-lhs (control-rule-if rule) nil))
	(select-expr (fourth (control-rule-then rule))))
    (if matched
	(let ((selected-nodes
	       (mapcar #'(lambda (binding)
			   (if (eq binding t)
			       select-expr
			       (sublis binding select-expr)))
		       matched)))
	  (output 3 t "~%Firing select node rule ~S to get ~S"
		  (control-rule-name rule) selected-nodes)
	  selected-nodes))))

(defun scr-reject-nodes (nodes rules matchedp)
  (if (or (null nodes) (null rules))
      (values nodes matchedp)
      (multiple-value-bind (new-nodes matched-one-p)
	  (match-reject-nodes nodes (car rules))
	(scr-reject-nodes new-nodes (cdr rules)
			  (or matchedp matched-one-p)))))

(defun match-reject-nodes (nodes rule)
  (declare (list nodes)
	   (type control-rule rule))
  (let ((reject-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) nil)))
    (when matched
      (output 3 t "~%Firing reject nodes ~S" (control-rule-name rule))
      (dolist (binding matched)
	(let ((offender (sublis binding reject-expr)))
	  (output 3 t "~%...deleting ~S" offender)
	  (setq nodes (delete offender nodes)))))
    (values nodes matched)))


;;; This function is a mess right now. If there is only one possible
;;; node at this abstraction level, but we can refine, we always jump
;;; to the front node without a chance to decide not to refine..
(defun choose-node (this-node nodes)
  "Uses preference rules to select a best node to move to. Defaults to
first node on the list."
  (declare (type nexus this-node)
	   (special *current-problem-space*))

  (let* ((can-refine (getf (nexus-plist this-node) 'winning-child))
	 (refine-node
	  (if can-refine
	      (nexus-parent (elt (problem-space-property :*finish-binding*)
				 (nexus-abs-level this-node)))
	      )))
    (multiple-value-bind (best firedp)
	(if (<= (length nodes) 1)
	    (values (car nodes) nil)
	    (find-a-best-one nodes
			     (problem-space-prefer-nodes *current-problem-space*)
			     :node))
      ;; by default, select a best one unless we just solved an
      ;; abstraction level and no other rules fired, in which case
      ;; choose the root at the same level.
      (cond (firedp best)
	    ;; If we just solved the problem at this level..
	    (can-refine (refine-node refine-node))
	    ;; Jump to the binding node with least conspiracy number.
	    ((and (eq (problem-space-property :search-default)
		      :conspiracy)
		  (operator-node-p this-node)
		  (least-conspiracy-binder this-node nodes)))
	    (t best)))))

;;; Choose the binding node with least conspiracy number, not counting
;;; the newest node, which will not have had the conspiracy number
;;; calculated. If the node chosen is in fact the binding node parent
;;; of this operator node, return the newest binding node to allow a
;;; depth-first-oid search to happen.
(defun least-conspiracy-binder (this nodes)
  (declare (type nexus this) (list nodes))
  (let ((best nil)
	(bestval nil))
    (dolist (candidate nodes)
      (when (and (binding-node-p candidate)
	       (not (eq (nexus-parent candidate) this))
	       (or (null best)
		   (< (nexus-conspiracy-number candidate) bestval)))
	(setf best candidate
	      bestval (nexus-conspiracy-number candidate))))
    best))


;  ------------------ OPERATOR DECISIONS  ------------------

;;; return all possible uninstantiated operators that can possibly achieve
;;; the given goal.  It's obtained by first running select rules, then
;;; reject rules. The copy-list here is so that we can use delete when
;;; we iterate through the rules, which should be more efficient.
(defun generate-operators (node goal)
  (declare (special *current-problem-space*))
  (let ((user::*candidate-operators*
	 (scr-select-ops
	  node goal (problem-space-select-operators *current-problem-space*))))
    (declare (special user::*candidate-operators*))
    (if (eq user::*candidate-operators* :big-lose)
	:big-lose
	(scr-reject-ops node user::*candidate-operators*
		(problem-space-reject-operators *current-problem-space*)))))


;;; look at select-operator control rules in sequence, stop at the first one
;;; that fires and return the selected operator, or if no rule fires, return
;;; all relevent operators by accessing slots in problem space.
(defun scr-select-ops (node goal ctrlrules)
  (cond ((null ctrlrules) 
	 (let ((ops (get-all-ops goal node)))
	   (if (null ops) :big-lose ops)))
	((match-select-op node goal (car ctrlrules)))
	(t (scr-select-ops node goal (cdr ctrlrules)))))
	   
;;; iterates through all rejects rules, return the remaining operators from
;;; ops that are not rejected. Slight bug fixed by Jim (29/6/91).
(defun scr-reject-ops (node ops reject-rules)
  (if (or (null reject-rules) (null ops))
      ops
      (scr-reject-ops node
		      (match-reject-op node (car reject-rules) ops)
		      (cdr reject-rules))))

;;; match select-operator control-rule; if it fires, return set of operators
;;; specified in the right-hand side of the rule, otherwise, return nil.
(defun match-select-op (node goal rule)
  (declare (ignore goal)
	   (special *current-problem-space*))
  (let ((select-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) node)))
    (when matched
      (let ((selected-ops
	     (delete-duplicates
	      (mapcar #'(lambda (bindings)
			  (rule-name-to-rule
			   (if (eq bindings t)
			       select-expr
			       (sublis bindings select-expr))
			   *current-problem-space*))
		      matched))))
	(output 3 t "~%Firing select op rule ~S to get ~S"
		(control-rule-name rule) selected-ops)
	selected-ops))))

;; match reject-operator control-rule; if it fires, return the operators in ops
;; that are not rejected by the right-hand side of the control-rule, otherwise
;; returns ops.
(defun match-reject-op (node rule ops)

  (let ((reject-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) node)))
    (cond
      ;;aperez (nov. 13, 92) extended to case when the op to reject is
      ;;a variable 
     ((and matched (strong-is-var-p reject-expr))
       ;;see if the op variable (reject-expr) is matched from the lhs.
       ;;If so, fire the rule once for each match. If not, give a
       ;;warning. 
       (dolist (match matched ops)
	 (let ((op (cdr (assoc reject-expr match :test #'equal))))
	   (cond
	     (op ;op is an operator structure
	      (output 3 t "~%Firing reject operator ~S ~S"
		      (control-rule-name rule) (rule-name op))
	      (setf ops (delete op ops)))
	     (t
	      (format t "Warning: rule ~S matches but the expression ~
                  rejected is an unbound var.~%" 
		  (control-rule-name rule)))))))
      (matched
       (output 3 t "~%Firing reject operator ~S ~S"
	       (control-rule-name rule) reject-expr)
       (delete (rule-name-to-rule reject-expr *current-problem-space*)
	       ops))
      (t
       ops))))

;;; accessing relevance-table slot of the problem space.
(defun get-all-ops (goal node)
  (declare (type literal goal)
	   (type nexus node)
	   (special *current-problem-space*))
  ;; If the node has an abstraction parent, select the operator(s)
  ;; corresponding to its favourite child of the moment. In general,
  ;; more than one operator at this level may correspond to the chosen
  ;; operator in the level above, but I'm fudging that for now.
  (let* ((abs (nexus-abs-parent node))
	 (winner (if abs (getf (nexus-plist abs) 'winning-child)))
	 primary-list)
    (cond (winner
	   (list (operator-node-operator winner)))
	  ((and (problem-space-property :use-primary-effects)
		(setf primary-list (match-primary goal)))
	   (copy-list primary-list))
	  (t
	    (relevant-operators goal *current-problem-space*
				(if (negated-goal-p goal) :del :add))))))

;;; Perhaps I should pre-process the primary list to make this
;;; matching a tiny bit faster, but I won't bother right now. One
;;; problem when this is done is that you will have to run load-domain
;;; when the primary effects change, which will not be obvious to the
;;; casual user.

;; Returns the operators that list the template matching the goal in
;; their primary effects.
(defun match-primary (goal)
  (declare (type literal goal))
  (some
   #'(lambda (primary)
       (if (and (eq (caar primary) (literal-name goal))
		(= (length (cdar primary)) (length (literal-arguments goal)))
		(every
		 #'(lambda (p-arg l-arg)
		     (and 
		      (if (symbolp p-arg) ; a type name
			  (eq (type-name (prodigy-object-type l-arg))
			      p-arg)
			  ;; Otherwise p-arg is a list for an object
			  (eq (object-name-to-object
			       (car p-arg) *current-problem-space*)
			      l-arg))))
		 (cdar primary) (literal-arguments goal) ))
	   (cdr primary)))
   (problem-space-property :primary-effects)))

(defun choose-operator (node ops)
  "Uses preference rules to pick a best operator."
  (declare (ignore node)
	   (special *current-problem-space*))
  (if (<= (length ops) 1)
      (car ops)
      (find-a-best-one
       ops (problem-space-prefer-operators *current-problem-space*)
       :operator)))



;  ------------------ BINDING DECISIONS  ------------------

;;; I'm going to change the data structure for a binding from list of
;;; ob to (cons list-of-obj condi), so I can know from which
;;; conditional effect this binding is coming from.

;;; Currently fudging to avoid the issue of sub-bindings for abstractions.
;;; This is because a lot of extra power may come from only doing the
;;; matching once for the parts that are shared, and this is a tricky
;;; one that I must hash out with Mei.

;;; Changed 12/7/91 to do gathering step before making instantiated
;;; operators, and sorting afterwards. This should be more efficient.
;;; (It was really slow on a simple stripsworld problem.)

(defun generate-bindings (node goal op)
  (declare (special *current-problem-space*))
  (let* ((abs (nexus-abs-parent node))
	 (winner (if abs (nexus-winner abs)))
	 (instop (if winner (binding-node-instantiated-op winner))))

    ;; If there is a node from the abstraction level above, that
    ;; should be the only possibility.
    (cond (instop
	   (let ((res (copy-instantiated-op instop)))
	     ;; Copy because need different back pointer
	     (setf (instantiated-op-precond res) nil)
	     (list res)))
	  (t
	   (let* ((user::*candidate-bindings*
		   (get-all-bindings node goal op
				     (if (negated-goal-p goal)
					  (operator-del-list op)
					  (operator-add-list op))))
		  (instantiated-ops
		   (convert-to-instantiated-ops
		    op user::*candidate-bindings*))
		  (*abslevel* (nexus-abs-level node)))
	     (declare (special user::*candidate-bindings* *abslevel*))
	     ;; Sort by conspiracy number if the switch is on.
	     (if (problem-space-property :min-conspiracy-number)
		 (progn
		   (mapc #'compute-conspiracy-number instantiated-ops)
		   (stable-sort instantiated-ops #'<
				:key #'instantiated-op-conspiracy))
		 instantiated-ops))))))


#| REPLACED BY FUNCTION ABOVE
(defun generate-bindings (node goal op)
  (declare (special *current-problem-space*))
  (let* ((abs (nexus-abs-parent node))
	 (winner (if abs (nexus-winner abs)))
	 (instop (if winner (binding-node-instantiated-op winner))))
    (cond (instop
	   (let ((res (copy-instantiated-op instop)))
	     ;; Copy because need different back pointer
	     (setf (instantiated-op-precond res) nil)
	     (list res)))
	  (t
	   (let* ((user::*candidate-bindings*
		    (get-all-bindings node goal op
				     (if (negated-goal-p goal)
					 (operator-del-list op)
					 (operator-add-list op))))
		  (instantiated-ops
		   (convert-to-instantiated-ops
		    op user::*candidate-bindings*))
		  (*abslevel* (nexus-abs-level node)))
	     (declare (special user::*candidate-bindings* *abslevel*))
	     ;; Sort by conspiracy number if the switch is on.
	     (if (problem-space-property :min-conspiracy-number)
		 (setf instantiated-ops
		       (mapcar #'car
			       (stable-sort (mapcar #'cons-conspiracy-number
					     instantiated-ops)
				     #'< :key #'cdr))))
	     (if (null (second (rule-effects op)))
		 instantiated-ops
		 (my-gather-together instantiated-ops op)))))))
|# ;; END OF REPLACE FUNCTION

(defun compute-conspiracy-number (binding)
  (declare (special *abslevel*)
	   (type instantiated-op binding))
  (let ((inst (build-instantiated-precond binding *abslevel*)))
    (setf (instantiated-op-precond binding) inst)
    (setf (instantiated-op-conspiracy binding) (conspiracy-num inst t))
    binding))

;;; new-gather-together is based on my-gather-together below, but
;;; works on the bindings rather than instantiated-ops to try to save
;;; the memory of making loads of redundant bindings into instantiated
;;; ops and then junking them next function call.
(defun new-gather-together (bindings op)
  (if (second (rule-effects op))
      (new-remove-singletons (new-gather-rec bindings op nil))
      bindings))

(defun new-remove-singletons (bindings)
  (dolist (binding bindings)
    (let ((values (car binding)))
      (dotimes (i (length values))
	(let ((val (elt values i)))
	  (if (and (listp val)
		   (= (length (delete-duplicates val)) 1))
	      (setf (elt values i) (car val)))))))
  bindings)

(defun new-gather-rec (bindings op gathered-bindings)
  (if (null bindings)
      gathered-bindings
      (let ((similar-binding
	     (find-similar-binding (car bindings) gathered-bindings op)))
	(if similar-binding
	    (progn (add-binding similar-binding (car bindings) op)
		   (new-gather-rec (cdr bindings) op gathered-bindings))
	    (new-gather-rec (cdr bindings) op
			    (cons (make-gathered-binding (car bindings) op)
				  gathered-bindings))))))

(defun find-similar-binding (binding gathered-bins op)
  (find binding gathered-bins
	:test #'(lambda (x y) (new-same-rel-binding x y op))))

;;; Could be more efficient, but probably not important.
(defun new-same-rel-binding (binding gathered op)
  (let* ((vars (rule-vars op))
	 (vars-len (length vars))
	 (precond-vars (rule-precond-vars op))
	 (precond-vars-len (length precond-vars))
	 (condi-single (cdr binding))
	 (condi-gathered (cdr gathered))
	 (var-condi (cdr (assoc condi-single (rule-effect-var-map op))))
	 (val-single (car binding))
	 (val-gathered (car gathered)))
    (and (eq condi-single condi-gathered)
	 (not (= (+ precond-vars-len (length var-condi)) vars-len))
	 (same-to-length val-single val-gathered precond-vars-len)
	 (every #'(lambda (x)
		    (eq (elt val-single (position x vars))
			(elt val-gathered (position x vars))))
		var-condi))))

(defun add-binding (gathered single op)
  (let ((numvars (length (rule-precond-vars op)))
	(vars (rule-vars op))
	(condi-var (cdr (assoc (cdr single) (rule-effect-var-map op)))))
    (dotimes (x (length (car gathered)))
      (if (and (>= x numvars)
	       (notany #'(lambda (y)
			   (eq (position y vars) x))
		       condi-var))
	  (push (elt (car single) x) (elt (car gathered) x))))))

(defun make-gathered-binding (binding op)
  (let ((numvars (length (rule-precond-vars op)))
	(vars (rule-vars op))
	(condi-var (cdr (assoc (cdr binding) (rule-effect-var-map op))))
	(values (car binding)))
    (cons (mapcar #'(lambda (x)
		      (if (zerop numvars)
			  (if (notany #'(lambda (y)
					  (eq (position y vars)
					      (position x values)))
				      condi-var)
			      (list x)
			      x)
			  (progn (decf numvars) x)))
		  values)
	  (cdr binding))))

#| REPLACE BY THE CODE ABOVE
;;; This was changed by Jim 7/12/91 to try to preserve the order of the
;;; arguments, since I've sorted them first.
(defun my-gather-together (raw-inst-ops op)
  (remove-singletons
   ;; my-gather-rec reverses the order.
   (nreverse (my-gather-rec raw-inst-ops op nil))))

;;; This step changes arguments which are really lists of 1 thing to
;;; be that one thing.
(defun remove-singletons (inst-ops)
  (dolist (op inst-ops)
    (let ((values (instantiated-op-values op)))
      (dotimes (n (length values))
	(let ((val (elt values n)))
	  (if (and (listp val)
		   (or (= (length val) 1)
		       (= (length (delete-duplicates val)) 1)))
	      (setf (elt values n) (car val)))))))
  inst-ops)

(defun my-gather-rec (raw-inst-ops op cooked-ops)
  (if (null raw-inst-ops)
      cooked-ops
    (let ((cooker (my-find-cooker (car raw-inst-ops) cooked-ops op)))
      ;; If there is an instantated operator already saved with all
      ;; the same important bindings, then mark this one up as a
      ;; variant of that one.
      (cond (cooker
	     (my-heat-up cooker (car raw-inst-ops) op)
	     (my-gather-rec (cdr raw-inst-ops) op cooked-ops))
	    ;; otherwise add it to the list of "unique" instops.
	    (t
	     (my-gather-rec (cdr raw-inst-ops) op
			    (cons (my-new-cooker (car raw-inst-ops) op)
				  cooked-ops)))))))

(defun my-find-cooker (raw cooked op)
  (find raw cooked
	:test #'(lambda (x y) (same-relevant-binding x y op))))
  
(defun same-relevant-binding (raw cooked op)
  (let* ((vars (rule-vars op))
	 (vars-len (length vars))
	 (precond-vars (rule-precond-vars op))
	 (precond-vars-len (length precond-vars))
	 (condi-raw (instantiated-op-conditional raw))
	 (condi-cooked (instantiated-op-conditional cooked))
	 (var-condi (cdr (assoc condi-raw (rule-effect-var-map op))))
	 (val-raw (instantiated-op-values raw))
	 (val-cooked (instantiated-op-values cooked)))
    (and (eq condi-raw condi-cooked)
	 (not (eq (+ precond-vars-len (length var-condi))
		  vars-len))
	 (same-to-length val-raw val-cooked precond-vars-len)
	 (every #'(lambda (x)
		    (eq (elt val-raw (position x vars))
			(elt val-cooked (position x vars))))
		var-condi))))
    
(defun my-heat-up (cooker raw op)
  (let ((len (length (rule-precond-vars op)))
	(vars (rule-vars op))
	(condi-var (cdr (assoc (instantiated-op-conditional raw)
			       (rule-effect-var-map op)))))
    (dotimes (x (length (instantiated-op-values cooker)))
      (if (and (>= x len)
	       (notany #'(lambda (y)
			   (eq (position y vars) x))
		       condi-var))
	  (push (elt (instantiated-op-values raw) x)
		(elt (instantiated-op-values cooker) x))))))

(defun my-new-cooker (raw op)
  (let ((len (length (rule-precond-vars op)))
	(vars (rule-vars op))
	(condi-var (cdr (assoc (instantiated-op-conditional raw)
			       (rule-effect-var-map op))))
	(values (instantiated-op-values raw)))
    (setf (instantiated-op-values raw)
	  (mapcar #'(lambda (x)
		      (if (zerop len)
			  (if (notany #'(lambda (y) (eq (position y vars)
							(position x values)))
				      condi-var)
			      (list x)
			      x)
			  (progn (decf len) x)))
		  values))
    raw))
|# ;; END OF REPLACED CODE

(defun convert-to-instantiated-ops (op bindings)
  (if (eq (car bindings) t)
      (list (make-instantiated-op :op op :values nil :conditional nil))
      (mapcar #'(lambda (x) (make-instantiated-op
			     :op op
			     :values (car x)
			     :conditional (cdr x)))
	      bindings)))

;; never called, commented out.  Mei, 2/10/92
#|
(defun scr-reject-bindings (node op bindings rules)
  (if (or (null bindings) (null rules))
      bindings
      (scr-reject-bindings node op
			   (match-reject-bindings node op (car rules) bindings)
			   (cdr rules))))

(defun match-reject-bindings (node op rule bindings)
  (let ((reject-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) node)))
    (when matched
      (output 3 t "~%Firing reject rule ~S" (control-rule-name rule))
      (dolist (rejected-bindings matched)
	(let ((offender (sublis (sublis rejected-bindings reject-expr)
				(cdr (operator-params op)))))
	  (output 3 t "~%..rejecting ~S" offender)
	  (setf bindings
		(delete-if #'(lambda (x) (equal (car x) offender))
			   bindings)))))
    bindings))
|#

;;; returns T if goal is a negation.
(defun negated-goal-p (goal)
  (and (literal-state-p goal)
       (literal-neg-goal-p goal)))

;;; post-conditions is a list of all effect in either add list or del list of
;;; an operator. The list is sublisted by conditional.
(defun get-all-bindings (node goal op post-conditions)
  (declare (type nexus node)
	   (type literal goal)
	   (type operator op)
	   (list post-conditions))
  (if post-conditions
      (let ((rhs-bindings (find-rhs-bindings (caar post-conditions) goal))
	    (other-bindings
	     (get-all-bindings
	      node goal op
	      (if (null (cdar post-conditions))
		  (cdr post-conditions)
		  (cons (cdar post-conditions) (cdr post-conditions)))
	      )))
	(if (null rhs-bindings)
	    other-bindings
	    (let ((binding1 (scr-select-bindings op rhs-bindings)))
	      (cond ((eq (car binding1) t)
		     (or other-bindings binding1))
		    (binding1
		     (append binding1 other-bindings))
		    (t
		     other-bindings)))))))


; post-condition should be a structure of type effect-cond.
; goal is represented as a literal. It return partial binding by matching one
; goal against one effect.  The result looks like :
; (((<x> . A) (<y> . B)) condi), in which condi is a pointer to the conditionfind
; of the conditional effect, condi is nil if the effect is unconditional.
(defun find-rhs-bindings (post-condition goal)
  (let* ((effect (effect-cond-effect post-condition))
	 (conditional (effect-cond-conditional post-condition))
	 (effect-pred (car effect))
	 (goal-pred (literal-name goal))
	 (expression (cdr effect))
	 (instance (literal-arguments goal))
	 (effect-arity (length expression))
         (goal-arity (length instance)))
    (when (and (equal effect-pred goal-pred) 
					;checking if they have the same pred
	       (= effect-arity goal-arity))
					;checking if the predicate for effect
					;and goal has the same arity
      (if (zerop goal-arity)
	  (cons nil conditional)
	  (let ((binding (unify instance expression)))
	    ;;note that binding can be T, instead of a binding list,
	    ;;if the expression is totally instantiated.
	    (when binding (cons binding conditional)))))))
					;conditional has to be in the result
					;returned.


;;;  rhs-bindings is what is returned by find-rhs-binding.
;;;  by calling match-select-bindings, it recurs through select-binding 
;;;  control rules.  returns bindings as soon as one control rule fires.  If
;;;  none of the rules fires, it returns all tuples that satisfy rhs-bindings.


(defun scr-select-bindings (op rhs-bindings)
  (let ((bindings (rete-gen-bindings op rhs-bindings)))
    (if bindings
	(form-final-bindings bindings rhs-bindings op))))

	
(defun rete-gen-bindings (op rhs-bindings)
  (let* ((foo (rule-generator op))
	 (data (if foo (funcall foo (change-to-real-pb (car rhs-bindings)))))
	 (all-simple-tests (rule-simple-tests op))
	 (all-unary-tests (rule-unary-tests op))
	 (all-join-tests (rule-join-tests op))
	 (all-neg-simple-tests (rule-neg-simple-tests op))
	 (all-neg-unary-tests (rule-neg-unary-tests op))
	 (all-neg-join-tests (rule-neg-join-tests op))
	 (number-of-rules (- (length all-unary-tests) 2)))

    (if (car all-unary-tests)
	(do* ((n number-of-rules (1- n))
	      (unary-tests all-unary-tests (cdr unary-tests))
	      (join-tests all-join-tests (cdr join-tests))
	      (simple-tests  all-simple-tests  (cdr simple-tests))
	      (precedence (simple-match (car simple-tests))
			  (simple-match (car simple-tests)))
	      (neg (if precedence
		       (neg-simple-match all-neg-simple-tests op))
		   (if precedence
		       (neg-simple-match all-neg-simple-tests op)))
	      (tuple (if neg (match (car unary-tests) 
				    (car join-tests)
				    all-neg-unary-tests
				    all-neg-join-tests
				    (cons neg data)
				    op))
		     (if neg (match (car unary-tests) 
				    (car join-tests) 
				    all-neg-unary-tests
				    all-neg-join-tests
				    (cons neg data)
				    op))))
		     
	     ((or tuple (null  (cdr unary-tests))) 
	      (progn
		(if (>= n 0)
		    (output 3 t "~%Firing select binding rule ~S at node ~S"
			    (control-rule-name
			     (nth n (rule-select-bindings-crs op)))
			    (nexus-name user::*current-node*)))
#|		    (output 3 t "~%Firing select binding rule ~S"
			    (control-rule-name
			     (nth n (rule-select-bindings-crs op)))))
|#
		tuple)))

	;; if the op does not have vars, then there will not be any
	;; binding control rule.  don't worry about firing stuff. 
	(and (simple-match (car all-simple-tests))
	     (neg-simple-match all-neg-simple-tests op)))))



(defun form-final-bindings (bindings rhs-bindings op)
  (let* ((all-vars (rule-vars op))
	 (bound-vars (if (eq t (car rhs-bindings))
			 nil
			 (mapcar #'(lambda (x) (car x))
				 (car rhs-bindings))))
	 (precond-vars (rule-precond-vars op))
	 (len (- (length all-vars) (length precond-vars)))
	 (other-vars (set-difference bound-vars precond-vars)))

    (if other-vars
	(let* ((effect-binds (bind-effect-vars 
			    other-vars (car rhs-bindings) op))
	       (res nil))
	  (and effect-binds
	       (dolist (bind bindings res)
		 (dolist (effect-bind effect-binds)
		   (if (check-functions (car bind) effect-bind op)
		       (let ((b (append (car bind) (make-sequence 'list len))))
			 (dolist (x effect-bind)
			   (setf (nth (position (car x) all-vars) b) (cdr x)))
			 (push (cons b (cdr rhs-bindings)) res)))))))

        ;;; bindings is t if the operator doesn't have any vars, but
	;;; the simple-tests are satisfied.
	;;; bindings is of the form: ((data . label)*)
	
	(if (eq (car bindings) t)
	    (cons (car bindings) (cdr rhs-bindings))
	    (mapcar #'(lambda (x)  
			(cons (append (car x) (make-sequence 'list len))
			      (cdr rhs-bindings)))
		    bindings)))))
  

;; check if bind (bindings for reg-variables) and cond-b (bindings for
;; conditional variables) satisfy functions for cond-b.
(defun check-functions (bind cond-b op)
  (let* ((reg-binds (mapcar #'(lambda (x y) (cons x y))
			    (rule-precond-vars op) bind))
	 (bindings (append reg-binds cond-b)))
    (every #'(lambda (x)
	       (check-functions-for-var (car x) bindings op))
	   cond-b)))

(defun check-functions-for-var (x bindings op)
  (let ((spec (cadr (assoc x (second (rule-effects op))))))
;    (format t "~% spec: ~s" spec)
    (if (and (listp spec) (eq (car spec) 'user::and))
	(every #'(lambda (y)
		   (apply (car y) (sublis bindings (cdr y))))
	       (cddr spec))
	t)))


;; used to test if partial-bindings is a formed from a conditional
;; effect. partial-bindings is what is returned from
;; find-rhs-bindings. 
(defun subg-cond-effect (partial-bindings)
  (if (cdr partial-bindings) t nil))

;;; find the conditional variables for conditional effect condi of
;;; operator op. 
(defun find-effect-vars (op condi)
  (cdr (assoc condi (rule-effect-var-map op))))


(defun bind-effect-vars (cond-vars partial-bind op)
  (cond ((null cond-vars) '(nil))
	(t (let ((cond-binds
		  (bind-effect-vars (cdr cond-vars) partial-bind op))
		 (bind (assoc (car cond-vars) partial-bind))
		 (generator (assoc (car cond-vars) 
				   (second (rule-effects op)))))
	     (if bind
		 (if (runtime-type-check (list bind) op)
		     (mapcar #'(lambda (b)
				 (cons bind b))
			     cond-binds))
		 (let ((all-values (candidate-types (second generator))))
		   (mapcar #'(lambda (x)
			       (mapcar #'(lambda (y)
					   (append (cons (car
							 cond-vars) x) y))
				       cond-binds))
			   all-values)))))))
			       
		 

;; since what Dan's code requires for partial-bindings is ((<x> A B) +),
;; I need to change my representation to Dan's when using the function
;; generated from (build-generator-for-rule op).
(defun change-to-real-pb (rhs-bindings)
  (if (listp rhs-bindings)
      (mapcar #'(lambda (x) (list (car x) (cdr x))) rhs-bindings)
      rhs-bindings))

;;; Changed by Jim so as to unify an object and a symbol of the same
;;; name correctly. Note that e1 will probably be an object (it comes
;;; from a goal) while e2 may be either a variable or the name of an
;;; object (eg 'block1).

;;; Also changed to accept type declarations. If the second arg is a
;;; variable, then if it has a type and the first argument is an
;;; object with a type, the object type must be a subtype of the
;;; variable type. The assumption that the first arg is not a variable
;;; was already built in. Jim.

(defun unifyp (e1 e2 type-declarations)
  (cond ((strong-is-var-p e2)
	 (or (not (prodigy-object-p e1))
	     (let ((e2-type (second (assoc e2 type-declarations))))
	       (or (not e2-type)
		   (eq e2-type (type-name (prodigy-object-type e1)))
		   ;; should match a subtype. Fixing 2/96, Jim
		   (child-type-p
		    (prodigy-object-type e1)
		    (type-name-to-type e2-type *current-problem-space*))))))
	((equal e1 e2))
	((and (prodigy-object-p e1)
	      (symbolp e2)
	      (eq (prodigy-object-name e1) e2)))))

(defun substitute-binding (expression bindings)
  (cond ((or (null bindings) (null expression)) expression)
        ((atom expression)
         (let ((value (cdr (assoc expression bindings))))
           (if value value expression)))
        (t (cons (substitute-binding (car expression) bindings)
                 (substitute-binding (cdr expression) bindings)))))

;;  instance is a vector, whereas expression is a list of {variables/object}
;;  partial-bindings without conditional. The result looks like 
;; ((<x> . A) (<y> . B))
(defun unify (instance expression &optional type-declarations)
  (when (= (length instance) (length expression))
        (do* ((n 0 (1+ n))
              (elements2 expression (cdr elements2))
              (e2 (car elements2) (car elements2))
              (bindings nil))
             ((or (null e2)
                  (not (unifyp (elt instance n) e2 type-declarations)))
              (if (null e2)
                  (or bindings t)))
	       ;;; this is the case where everything is matched, and
	       ;;; bindings should be returned; OR is used  because
	       ;;; bindings may have value nil when there is no variable
	       ;;; in expression and no binding is returned.
             (if (strong-is-var-p e2)
                 (let ((binding-pair (cons e2 (elt instance n))))
                   (push binding-pair bindings)
                   (setq elements2 (substitute-binding elements2 (list binding-pair))))))))

(defun choose-binding (node bindings)
  "Uses preference rules to pick a best binding."
  (declare (type operator-node node) (list bindings))

  (let ((*the-operator* (operator-node-operator node)))
    (declare (special *the-operator* *current-problem-space*))
    (or (eq bindings t)
	(and (<= (length bindings) 1) (car bindings))
	(find-a-best-one
	 bindings (problem-space-prefer-bindings *current-problem-space*)
	 :bindings))))

;;;=================================
;;; Preference Rules
;;;=================================

;;; This function is modelled after prodigy 2, although I don't
;;; believe the way I'm doing it here is as efficient. This is kind of
;;; a first pass.

;;; This is a multiple value function, whose first return value is a
;;; best candidate, and whose second is t or nil depending whether any
;;; rules fired or not. This is used in choose-node to implement
;;; default behaviour.
(defun find-a-best-one (candidates rules type)
  "Find an candidate that no preference rule would object to."
  (declare (list candidates rules)
	   (symbol type)		; :operator, :bindings, etc
	   (special *current-problem-space*))

  (cond (rules
	 (find-a-best-recur (car candidates) candidates rules nil type nil))
	((and (eq type :bindings)
	      (problem-space-property :min-conspiracy-number))
	 ;; Under this switch, try to minimise the number of unsolved
	 ;; goals that will come from the bindings. Note they were
	 ;; sorted earlier.
	 (values (first candidates) nil))
	((and (eq type :goal)
	      (problem-space-property :use-abs-level))
	 ;; pick the highest abstraction level. (Note already sorted).
	 (values (first candidates) nil))
	(t
	 (values
	  (let ((random-behaviour (problem-space-property :random-behaviour)))
	    ;; If the random-behaviour property is a random state, use it.
	    (cond ((random-state-p random-behaviour)
		   (elt candidates (random (length candidates) random-behaviour)))
		  ;; If it's otherwise non-nil, use default random behaviour
		  (random-behaviour
		   (elt candidates (random (length candidates))))
		  ;; Otherwise take the first element.
		  (t (first candidates))))
	  nil))))


(defun find-a-best-recur (best-so-far candidates rules path type firedp)
  (let (better-things)
    (cond ((member best-so-far path)
	   ;; If we already tried this one, that's a cycle.
	   (output 2 t
   "~%Warning: cycle found in the preference control rules for type ~S"
		   type)
	   nil)
	  ((setq better-things
		 (find-better-things best-so-far candidates rules type))
	   ;; If we find some things which are better, try them.
	   (let ((new-path (cons best-so-far path)))
	     (some #'(lambda (better)
		       (find-a-best-recur better candidates
					  rules new-path type t))
		   better-things)))
	  (t
	   ;; If we found nothing better, this must be a best one.
	   (values best-so-far firedp)))))

(defun find-better-things (best candidates rules type)
  "Iterate through the preference rules looking for one that prefers
other candidates over the current best."
  (cond ((null rules) nil)
	((match-pref-rule best candidates (car rules) type))
	(t (find-better-things best candidates (cdr rules) type))))

(defun match-pref-rule (best candidates rule type)
;;;  (declare (special *preferences*))
  (let* ((rhs (control-rule-then rule))
	 (appropriate-rule-bindings (desired-binding (fifth rhs) best type))
	 (bindings (if appropriate-rule-bindings
		       (descend-match (control-rule-if rule) nil
				      (car appropriate-rule-bindings))))
	 (better-things
	  (if bindings (fire-prefer rule (fourth rhs) bindings
				    candidates best type))))
    (when better-things
;;;      (push (cons best better-things) *preferences*)
      better-things)))

;;; Changed this so it wouldn't alter the order of the candidates, at
;;; least for goals and operators. It's harder to do for bindings, and
;;; I'm not so sure it matters.
(defun fire-prefer (rule pref bindings candidates preferee type)
  (let ((preferred-things
	 (delete preferee
		 (delete-duplicates
		  (translate-rule-symbols bindings pref candidates type)))))
    (if preferred-things
	(output 3 t "~%Firing pref rule ~S for ~S over ~S"
		(control-rule-name rule) preferred-things preferee))
    preferred-things))

(defun desired-binding (target object type)
  "Return a list containing the binding which would allow us to find something
preferred to object by the preference statement of this control rule, or nil."
  (declare (special *the-operator*))
  (ecase type
    ;; No bindings for operators or nodes.
    (:operator
     (cond ((strong-is-var-p target)
	    (list (list (cons target object))))
	   ((eq (operator-name object) target) (list nil))))
    (:goal				; I assume the object is a literal.
     (cond ((strong-is-var-p target)
	    (list (list (cons target object))))
	   ;; Reject if the negated-ness doesn't match up.
	   ((not (or (and (eq (car target) 'user::~)
			  (literal-neg-goal-p object))
		     (and (not (eq (car target) 'user::~))
			  (literal-goal-p object))))
	    nil)
	   (t
	    (if (eq (car target) 'user::~)
		(setf target (second target)))
	    (let ((result (user::instance-of object target)))
	      (if (or (eq result t) (eq (car result) t))
		  (list nil)
		  result)))))
#|	  (if (eq (car result) t) (list nil) result))))) |#
    ;; For bindings, the target is specified as a binding list, and
    ;; object is an instantiated-operator.
    (:bindings
     (cond ((strong-is-var-p target)
	    (list (list (cons target object))))
	   (t
	    (let ((ordered-vars-or-objects
		   (sublis target (operator-vars *the-operator*))))
	      (list (unify (instantiated-op-values object)
			   ordered-vars-or-objects))))))
    (:node
     (cond ((strong-is-var-p target) (list (list (cons target object))))
	   ((and (numberp target) (= (nexus-name object) target))
	    (list nil))))
    ))

(defun translate-rule-symbols (bindings pref candidates type)
  "Turn the expression into the member of candidates it represents, if
there, otherwise return nil."
  (declare (special *current-problem-space* *the-operator*))
  (ecase type
    (:operator
     (let ((prefs
	    (mapcar #'(lambda (binding)
			(let ((expression
			       (if (eq binding t) pref (sublis
							binding pref))))
	    (if (operator-p expression)
		expression
		(rule-name-to-rule expression *current-problem-space*))))
		    bindings)))
       (mapcan #'(lambda (cand) (if (member cand prefs) (list cand)))
	       candidates)))
    (:goal
     (let ((prefs
	    (mapcar #'(lambda (binding)
			(let ((expression
			       (if (eq binding t) pref
				   (sublis binding pref))))
	    (if (literal-p expression)
		expression
		(instantiate-consed-literal expression))))
		    bindings)))
       (mapcan #'(lambda (cand) (if (member cand prefs) (list cand)))
	       candidates)))
    ;; For bindings, expression is a binding list and we need to get a
    ;; member of the candidates, which are instantiated-operators.
    (:bindings
     (mapcan #'(lambda (binding)
		 (let ((expression
			(if (eq binding t) pref (sublis binding pref))))
     (find-binding expression candidates (operator-vars *the-operator*))))
	     bindings))
    (:node (mapcar #'(lambda (binding)
		       (if (eq binding t) pref
			   (sublis binding pref)))
		   bindings))))

(defun find-binding (blist candidates vars)
  (cond ((null candidates) nil)
	((match-this-binding blist
			     (instantiated-op-values (car candidates)) vars)
	 (list (car candidates)))	; list for mapcan above.
	(t (find-binding blist (cdr candidates) vars))))

;;; changed by Jim 12/7/91 to allow a match if only some of the
;;; bindings are specified in the rule.
(defun match-this-binding (blist candidate-values vars)
  (cond ((null candidate-values) t)
	((let ((target (cdr (assoc (car vars) blist)))
	       (value (car candidate-values)))
	   (not (or (null target)	; variable not specified in rule
		    (strong-is-var-p target)
		    (eq target value)
		    (and (symbolp target)
			 (eq (prodigy-object-name value) target)))))
	 nil)
	(t (match-this-binding blist (cdr candidate-values) (cdr vars)))))

;;; Some hard-coded heuristics.

(defun min-conspiracy (bindings)
  (declare (list bindings)		; of instantiated operators.
	   (special *abslevel*))

  ;; This is expensive here, but hopefully allows us to be smarter later.
  (cdar
   (sort (mapcar #'(lambda (instop)
		     (let ((inst (build-instantiated-precond instop *abslevel*)))
		       (setf (instantiated-op-precond instop) inst)
		       (cons (conspiracy-num inst t) instop)))
		 bindings)
	 #'< :key #'car)))

;;; This is not completely correct - I estimate pessimistically for
;;; expressions that still contain variables. This is to avoid extra
;;; matching cost at the time of choosing bindings, and hey, it's a
;;; heuristic.
(defun conspiracy-num (expr parity)
  (cond ((literal-p expr)
	 (if (eq parity (literal-state-p expr)) 0 1))
	((member (car expr) '(user::and user::or))
	 (apply (if (eq (eq (car expr) 'user::and) parity) #'+ #'min)
		(mapcar #'(lambda (sub) (conspiracy-num sub parity))
			    (cdr expr))))
	((member (car expr) '(user::exists user::forall))
	 (conspiracy-num (third expr) parity))
	((eq (car expr) 'user::~)
	 (conspiracy-num (second expr) (not parity)))
	;; This is the fudge bit for expressions that still have variables.
	(t 1)))
			    


;;;  ------------------ GOAL DECISIONS  ------------------


;; generate all goals of the node.  Run select control rules first, then
;; reject control rules to reject goals from what is returned by the select
;; rules.
(defun generate-goals (node)
  (declare (special *current-problem-space*))
  ;; moved the copy-list to here from the call in scr-reject-goals in
  ;; case people write destructive meta-predicates. Jim 12/93.
  (let ((user::*candidate-goals*
	 (copy-list
	  (scr-select-goals
	   node (problem-space-select-goals *current-problem-space*)))))
    (declare (special user::*candidate-goals*))
    ;; The nested let is needed (I think) because the reject goal 
    ;; control rules might access that global.
    (let ((res
	   (scr-reject-goals
	    node user::*candidate-goals*
	    (problem-space-reject-goals *current-problem-space*))))
      (if (problem-space-property :use-abs-level)
	  ;; Should be stable-sort to preserve the goal ordering.
	  ;; Use compute-abstraction-level to catch new literals that
	  ;; were made after we added the abstraction level to all
	  ;; existing literals.
	  (stable-sort
	   res #'>
	   :key #'(lambda (x)
		    (compute-abstraction-level x *current-problem-space*)))
	  res))))

;; Recurs through all select-goals control rules to select set of goals to work
;; on. Stop recuring at the first rule that fires.
;; If no control rules fire, return all pending-goals. 
(defun scr-select-goals (node rules)
  (cond ((null rules) 
	 (if *incremental-pending-goals*
	     (a-or-b-node-pending-goals node)
	     (give-me-all-pending-goals node)))
	((match-select-goal node (car rules)))
	(t (scr-select-goals node (cdr rules)))))

;; Match one select goal control rule.  Returns nil if the rule doesn't fire,
;; return the goals specified by the rule if the rule fires.
(defun match-select-goal (node rule)
  (declare (type nexus node)
	   (type control-rule rule))
  (let ((select-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) node)))
    (if matched 
	(let ((selected-goals
	       (delete-duplicates
		(mapcar #'(lambda (bindings)
			    (let ((res (sublis bindings select-expr)))
			      (if (literal-p res)
				  res
				  (instantiate-consed-literal res))))
			matched))))
	  (output 3 t "~%Firing select goals rule ~S to get ~S"
		  (control-rule-name rule) selected-goals)
	  selected-goals))))

;;; The hope is that this will be faster because (1) it only looks at
;;; the predicates which have appeared in the left hand sides of
;;; operators and (2) it doesn't call merge every time.

;;; Jim 1/8/91 - added the :linear property of the problem space which
;;; will hopefully restrict the goals to produce linear problem solving.
;;; Jim 3/1/93 - since this is used frequently in control rules, I'm
;;; adding a cache for it. This cache won't save the result if we
;;; switch to another node and then back to this one, but that isn't
;;; the case I'm trying to deal with.
(defun give-me-all-pending-goals (node)
  (declare (special *current-problem-space*))

  ;; check the cache
  (cond ((and *pending-goals-cache*
	      (eq (car *pending-goals-cache*) node))
	 (cdr *pending-goals-cache*))
	(t
	 (let* ((pred (getf (problem-space-plist *current-problem-space*)
			    :lexical-goal-ordering))
		(unsorted-goals
		 (delete-duplicates
		  (if (problem-space-property :linear)
		      (pending-goals-from-op (active-binding-node node))
		    (pending-goals-on-branch node nil))
		  :from-end t))		; :from-end t preserves order
					; of goals for dfs (spotted by
					; aperez, 3/93)
		(result
		 (if pred
		     (sort unsorted-goals pred)
		   unsorted-goals)))
	   ;; set the cache.
	   (setf *pending-goals-cache*
		 (cons node result))
	   result))))

(defun pending-goals-on-branch (node applications)
  "Get the list of pending (ie required and unsolved) goals on the
search branch"
  (when node
    (if (and (typep node 'a-or-b-node)
	     (a-or-b-node-applied node))
	(push (a-or-b-node-applied node) applications))
    (if (and (typep node 'binding-node)
	     (not (some #'(lambda (appl-list)
			    (member (binding-node-instantiated-op node)
				    appl-list
				    :key #'op-application-instantiated-op))
			applications)))
	(nconc (pending-goals-from-op node)
	       (pending-goals-on-branch
		(nexus-parent (nexus-parent (nexus-parent node)))
		applications))
	(pending-goals-on-branch (nexus-parent node) applications))))


;;; Modified 14/4/94 to deal with "dangling pointers" - when the goal
;;; is in service of another that is already satisfied (and the
;;; transitive closure of this).
(defun pending-goals-from-op (bnode)
  "get the list of pending goals from this binding node"
  (declare (type binding-node bnode))
  (let ((inst-preconds (binding-node-instantiated-preconds bnode))
	(inst-op (binding-node-instantiated-op bnode)))
    (if inst-preconds
	(let ((result
	       (penders-rec inst-preconds
			    (binding-node-disjunction-path bnode)
			    (instantiated-op-op inst-op)
			    t
			    (mapcar #'(lambda (varspec val)
					(cons (first varspec) val))
				    (second (rule-precond-exp
					     (instantiated-op-op inst-op)))
				    (instantiated-op-values inst-op))
			    (binding-node-abs-level bnode) bnode)))
	  (if *no-danglers*
	      (delete-if #'dangling-literal? result) ; code below
	    result)))))

;;; Modified 30/9/91 by Jim to take account of the abstraction level.
;;; It only includes a literal as a goal if its abstraction level is
;;; at least as great as that of the problem space.
(defun penders-rec (expr disj op parity bindings level bnode)
  (declare (special *current-problem-space*)
	   (fixnum level))
  (cond ((typep expr 'literal)
	 ;; Cause an error if the goal has a higher abstraction level
	 ;; than the current level, and a plan was made at a higher
	 ;; level, but this operator wasn't used at a higher
	 ;; abstraction level - that shouldn't happen with an ordered
	 ;; monotonic abstraction hierarchy.
	 (let ((expr-abs-level
		(compute-abstraction-level expr *current-problem-space*)))
	   (when (and (> expr-abs-level level)
		      (> (nexus-abs-level (problem-space-property :root))
			 level)
		      (not (or (nexus-abs-parent bnode)
			       (problem-space-property
				:allow-funny-abstract-hierarchies))))
	     ;; give lots of information because this is a hard bug to
	     ;; figure out.
	     (let ((goal (goal-node-goal (nexus-parent (nexus-parent bnode)))))
	       (cerror "carry on regardless"
		       "~%Abstraction hierarchy is not ordered ~
monotonic - ~%this violates assumptions made while planning, ~
~%so the plan may not be correct.~%~
The goal ~S~%from the preconditions of ~S~%has abstraction level ~S,~%~
but the operator was introduced to solve goal~%~
~S with abstraction level ~S"
		       expr op expr-abs-level goal
		       (compute-abstraction-level
			goal *current-problem-space*))
	       (setf (problem-space-property :allow-funny-abstract-hierarchies)
		     t)))
	   (if (and (>= expr-abs-level level)
		    (if parity
			(and (not (literal-state-p expr))
			     (literal-goal-p expr))
			(and (literal-state-p expr)
			     (literal-neg-goal-p expr))))
	       (list expr))))
	((eq (car expr) (if parity 'user::or 'user::and))
	 (penders-rec (elt expr (car disj)) (cdr disj) op parity
		      bindings level bnode))
	((eq (car expr) (if parity 'user::and 'user::or))
	 	 ;;aperez:
	 ;;if disj is nil, penders-rec is not called at all! It should
	 ;;have as many elements as (cdr exp)
	 (if (null disj)
	     (mapcan #'(lambda (subexp)
			 (penders-rec subexp disj op parity bindings level
				      bnode))
		     (cdr expr))
	   (mapcan #'(lambda (subexp subdisj)
		       (penders-rec subexp subdisj op parity bindings level
				    bnode))
		   (cdr expr) disj)))
	((eq (car expr) 'user::~)
	 (penders-rec (second expr) disj op (not parity) bindings level
		      bnode))
	((eq (car expr) (if parity 'user::forall 'user::exists))
	 (get-forall-goals expr disj op parity bindings level bnode))
	((eq (car expr) (if parity 'user::exists 'user::forall))
	 (penders-rec (third expr) disj op parity bindings level
		      bnode))
	(t
	 (let ((literal (instantiate-consed-literal (sublis bindings expr))))
	   (if (and (>= (compute-abstraction-level literal *current-problem-space*)
			level)
		    (if parity
			(and (not (literal-state-p literal))
			     (literal-goal-p literal))
			(and (literal-state-p literal)
			     (literal-neg-goal-p literal))))
	       (list literal))))))
		 
#|
(defun get-forall-goals (expr disj op parity bindings level)
  (declare (list expr) (fixnum level) (type rule op))
  (do* ((generator (cdr (assoc (second expr) 
			       (getf (rule-plist op) :quantifier-generators))))
	(data (if generator (funcall generator nil)))
	(choice (make-list (length data) :initial-element 0)
		(increment-choice choice data))
	(result nil))
       ((null choice) result)
    (setf result
	  (nconc (penders-rec (third expr) disj op parity
			      (nconc (choice-bindings expr data choice)
				     bindings) level)
		 result))))
|#

(defun get-forall-goals (exp disj op parity bindings level bnode)
  (declare (list expr) (fixnum level) (type rule op))
  (let ((expr (third exp)))
    (if (or (and parity (eq (car expr) 'user::~))
	    (and (not parity) (not (eq (car expr) 'user::~))))
	(let* ((real-expr (if parity (second expr) expr))
	       (forall-bindings (descend-match real-expr nil bindings))
	       (res nil))
	  (dolist (bind forall-bindings res)
	    (setf res 
		  (nconc (penders-rec expr disj op parity bind level bnode)
			 res))))
	(old-get-forall-goals exp disj op parity bindings level bnode))))

(defun old-get-forall-goals (expr disj op parity bindings level bnode)
  (do* ((generator (cdr (assoc (second expr) 
			       (getf (rule-plist op) :quantifier-generators))))
	(static-data (if generator (funcall generator nil)))
	(vars (mapcar #'car (second expr)))
	(running-data
	 (first-valid-choice static-data vars bindings (second expr))
	 (next-valid-choice static-data (first running-data)
			    (second running-data) 0 vars bindings
			    (second expr)))
	(choice (first running-data) (first running-data))
	(result nil))
       ((null choice) result)
    ;;(when (true-bindings-p
    ;;expr (second running-data) choice bindings fcs) )
    ;;aperez dec 9 put this test back
    ;;       may 28 94 removed again (processp)
;    (when (true-bindings-p
;           expr (second running-data) choice bindings
;           (get-all-functions-forall expr))
      (setf result
	    (nconc (penders-rec (third expr) disj op parity
				(nconc
				 (choice-bindings
				  expr (second running-data) choice)
				 bindings)
				level bnode)
		   result))))

(defun get-all-functions-forall (expr)
  (let (res)
    (dolist (var-spec (second expr))
      (if (and (listp (second var-spec))
	       (eq (car (second var-spec)) 'user::and))
	  (setf res (append res (cddr (second var-spec))))))
    res))

;;; Code to determine dangling pointers.
(defun dangling-literal? (literal)
  ;; Check if the goal node for each instantiated operator for which
  ;; this literal is a goal is dangling.
  (every #'(lambda (instop)
	     (dangling-goal-node?
	      (nexus-parent
	       (nexus-parent
		(instantiated-op-binding-node-back-pointer instop)))))
	 (if (literal-state-p literal)
	     (literal-neg-goal-p literal)
	   (literal-goal-p literal))))

;;; Walks up the goal tree looking for a node that is satisfied in the
;;; current state.
(defun dangling-goal-node? (gnode)
  (cond ((eq (literal-state-p (goal-node-goal gnode))
	     (goal-node-positive? gnode))
	 t)
	;; It's not dangling if there are no parents in the goal tree.
	;; If there are, check them.
	((goal-node-introducing-operators gnode)
	 (every #'(lambda (bnode)
		    (dangling-goal-node?
		     (nexus-parent (nexus-parent bnode))))
		(goal-node-introducing-operators gnode)))))


(defun active-binding-node (node)
  "Returns the closest parent binding node whose instantiated-op
hasn't been applied."
  (do* ((parent node (nexus-parent parent))
	(applications (if (typep parent 'a-or-b-node)
			  (list (a-or-b-node-applied parent)))
		      (if (typep parent 'a-or-b-node)
			  (cons (a-or-b-node-applied parent)
				applications)
			  applications)))
      ((or (null parent)
	   (and (typep parent 'binding-node)
		(not (some #'(lambda (appl-list)
			       (member (binding-node-instantiated-op parent)
				       appl-list
				       :key #'op-application-instantiated-op))
			   applications))))
       parent)))

;;; Calculates the pending goals as a delta on the ones from above
;;; (unless this is the *finish* node). See notes for this version.
;;; For now the pending goals are stored as *pending-goals* so as not
;;; to mess the rest of the code up.
;;; Jim 9/93
(defun get-delta-pending-goals (node)
  (declare (type a-or-b-node node))
  (cond ((and (typep node 'binding-node)
	      (eq (rule-name (operator-node-operator (nexus-parent node)))
		  '*finish*))
	 ;; Start off as before:
	 (add-list-to-pending-goals (pending-goals-from-op node) node))
	;; If it's a binding node delete the stated goal and add the
	;; preconditions.
	((typep node 'binding-node)
	 (delete-from-pending-goals 
	  (goal-node-goal (nexus-parent (nexus-parent node))) node)
	 ;; add the subgoals to the front and delete them from
	 ;; elsewhere.
	 (let ((goals-from-op (pending-goals-from-op node)))
	   (dolist (subgoal goals-from-op)
	     (if (literal-pending-goal-predecessor subgoal)
		 (delete-from-pending-goals subgoal node)))
	   (add-list-to-pending-goals goals-from-op node)) ; adds to front
	 ;; Deal with any applications
	 (dolist (appl (a-or-b-node-applied node))
	   (update-pending-goals-for-application appl node)))
	;; Otherwise just deal with the applications
	(t
	 (dolist (appl (a-or-b-node-applied node))
	   (update-pending-goals-for-application appl node))))
  ;; return the incremental stash
  (cdr *pending-goals*))

;;; Changes the pending goals when things change. For each deleted
;;; literal, if it is a negated goal, deletes it from the pending
;;; goals. If it is a goal, adds it at the front. Does the same sort
;;; of thing for the added literals.
(defun update-pending-goals-for-application (appl node)
  ;; the deletes should come first since that's the order we use to
  ;; apply. I go through the application adds and dels building up the
  ;; pending goal adds and deletes so that I can get the correct order
  ;; in maintain-state-and-goals just by following two lists.
  (let ((deletes nil)
	(adds nil))
    (dolist (del (op-application-delta-dels appl))
      (if (literal-pending-goal-predecessor del)
	  (push del deletes))
      (if (literal-goal-p del)
	  (push del adds)))
    (dolist (add (op-application-delta-adds appl))
      (if (literal-pending-goal-predecessor add)
	  (push add deletes))
      (if (literal-neg-goal-p add)
	  (push add adds)))
    (dolist (del (reverse deletes))
      (delete-from-pending-goals del node))
    (dolist (add (reverse adds))
      (add-to-pending-goals add node))))

;;; Makes use of the stored information to reset the pending goals on
;;; a backtrack up through a node.
(defun reverse-pending-goals (node)
  (dolist (lit (getf (nexus-plist node) :pending-goals-added))
    (delete-from-pending-goals lit nil))	; nil means don't record
  (dolist (pair (getf (nexus-plist node) :pending-goals-deleted))
    (insert-pending-after (car pair) (cdr pair))))

;;; Makes use of the stored information to set the pending goals back
;;; as they were going back down a node (this never happens in
;;; depth-first search).
(defun redo-delta-pending-goals (node)
  (dolist (pair (getf (nexus-plist node) :pending-goals-deleted))
    (delete-from-pending-goals (cdr pair) nil))
  (dolist (lit (getf (nexus-plist node) :pending-goals-added))
    (add-to-pending-goals lit nil)))

;;; Deletes a literal from the pending goals, storing its old position
;;; in the list at the node so it can be reinstated on backtrack.
(defun delete-from-pending-goals (literal node)
  (let ((pred (literal-pending-goal-predecessor literal)))
    (setf (cdr pred) (cddr pred))	; delete this node
    ;; update the pointers for this literal and the next.
    (setf (literal-pending-goal-predecessor literal) nil)
    (if (cadr pred)
	(setf (literal-pending-goal-predecessor (cadr pred)) pred))
    (if node
	(push (cons pred literal)
	      (getf (nexus-plist node) :pending-goals-deleted)))))

;;; Adds a literal to the front of the list of pending goals. The list
;;; has a dummy at the start, so this is the same as adding it after
;;; the dummy cons cell.
(defun add-to-pending-goals (literal node)
  (if node
      (push literal (getf (nexus-plist node) :pending-goals-added)))
  (insert-pending-after *pending-goals* literal))

;;; Adds the literal to the pending goals list after prior. The
;;; "prior" is supposed to be the actual cons cell, but this breaks
;;; down, so I'm doing the member test in the first line instead. This
;;; is inefficient, and I'll have to try to fix it later.
(defun insert-pending-after (prior literal)
  (setf prior (member (car prior) *pending-goals*))
  (let ((newpos (cons literal (cdr prior))))
    (if (cadr prior)
	(setf (literal-pending-goal-predecessor (cadr prior))
	      newpos))
    (setf (literal-pending-goal-predecessor literal) prior)
    (setf (cdr prior) newpos)))

;;; I don't just call add-to-pending-goals over this list because I
;;; don't want the order reversed. Users want to see the same goals
;;; with the new incremental method.
(defun add-list-to-pending-goals (list node)
  (when list
    (if node
	(setf (getf (nexus-plist node) :pending-goals-added)
	      (nconc (reverse list)
		     (getf (nexus-plist node) :pending-goals-added))))
    (let ((last (last list))
	  (old (cdr *pending-goals*))
	  (predecessor *pending-goals*))
      (mapl #'(lambda (l)
		(setf (literal-pending-goal-predecessor (car l))
		      predecessor)
		(setf predecessor l))
	    list)
      (when old
	(setf (cdr last) old)
	(setf (literal-pending-goal-predecessor (car old)) last))
      (setf (cdr *pending-goals*) list))))

	

;; Recurs through all reject-goals control rules, return the remaining goals
;; that are not rejected.  Calls function reject-goals.
(defun scr-reject-goals (node goals rules)
  (if (or (null rules) (null goals))
      goals
      (let ((rejected (match-reject-goal node goals (car rules))))
	(scr-reject-goals node
			  (delete-if #'(lambda (x) (member x rejected))
				     goals)
			  (cdr rules)))))


;; match one reject-goal control rule.  If the rule fires, return the subset
;; of goals that are not rejected by rule; otherwise, return nil.
(defun match-reject-goal (node goals rule)
  (declare (ignore goals))
  (let ((reject-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) node)))
    (if matched 
	(let ((deleted-goals
	       (mapcar #'(lambda (x)
			   (let ((goal (substitute-binding reject-expr x)))
			     (if (listp goal)
				 (instantiate-consed-literal goal)
				 goal)))
		       matched)))
	  (output 3 t "~%Firing delete goals ~S ~S"
		  (control-rule-name rule) deleted-goals)
	  deleted-goals))))


#|
;;; This goal loop checking is now done inside
;;; expand-binding-or-applied-op-node.
(defun choose-goal (node goals)
  (do* ((goal-cdr goals (cdr goal-cdr))
	(glp (goal-loop-p node (car goal-cdr))
	     (goal-loop-p node (car goal-cdr))))
       ((or (endp goal-cdr)
	    (not glp))
	(car goal-cdr))
    (if glp
	(setf (a-or-b-node-goals-left node)
	      (delete (car goal-cdr) (a-or-b-node-goals-left node))))))
|#

(defun choose-goal (node goals)
  (declare (special *current-problem-space*)
	   (ignore node))
  (if (<= (length goals) 1)
      (car goals)
      (find-a-best-one
       goals (problem-space-prefer-goals *current-problem-space*) :goal)))


;  ------------------ OTHERS   ------------------


;; feb 14, 1995. modified by karen to call the control rules.

(defun choose-applicable-op (node ops)
  "This function is bogus if
      *smart-apply-p* is not set
  and *running-mode* is not 'saba
  because only the most recently posted applicable op can be applied."

  ;; ops are all the appliable ops at this node.
  ;; this is where we want to run the control rules.
  (declare (ignore node))
  (let* ((select-rules (getf (p4::problem-space-plist *current-problem-space*)
			     :select-apply-op))
	 (reject-rules (getf (p4::problem-space-plist *current-problem-space*)
			     :reject-apply-op))
	 (reduced-ops (scr-reject-applied-ops
		       (scr-select-applied-ops ops
					       select-rules)
		       reject-rules)))
    ;; fire the rules and then sort the
    ;; remainder with decide-which-one-to-apply
    (car (decide-which-one-to-apply reduced-ops))))



#|
(defun choose-apply-or-subgoal (node app-ops goals)
  "If there are no control rules, decides to apply as soon as it can."
  (declare (special *current-problem-space*)
	   (ignore node)
	   (list app-ops goals))
  (cond ((null app-ops) :sub-goal)
	((null goals)   :apply)
	(t
	 (let ((user::*applicable-op* (car app-ops)))
	   (declare (special user::*applicable-op*))
	   (scr-choose-apply-or-subgoal
	    (problem-space-apply-or-subgoal *current-problem-space*))))))
|#

(defun choose-apply-or-subgoal (node app-ops goals)
  "If there are no control rules, decides to apply as soon as it can."
  (declare (special *current-problem-space*)
	   (ignore node goals)
	   (list app-ops goals))
  (cond ((null app-ops) :sub-goal)
	(t (let ((user::*applicable-op* (car app-ops)))
	     (declare (special user::*applicable-op*))
	     (scr-choose-apply-or-subgoal
	      (problem-space-apply-or-subgoal *current-problem-space*))))))
  
(defun scr-choose-apply-or-subgoal (rules)
  (declare (list app-ops rules))
  (cond ((null rules) :apply)
	((match-a-or-s-rule (car rules)))
	(t (scr-choose-apply-or-subgoal (cdr rules)))))

(defun match-a-or-s-rule (rule)
  (declare (type control-rule rule))
  (when (match-lhs (control-rule-if rule) nil)
    (let ((decision (second (control-rule-then rule))))
      (output 3 t "~%Firing apply/subgoal ~S deciding ~S"
	      (control-rule-name rule) decision)
      ;; There are no bindings on the right hand side, so the match
      ;; that is returned is ignored.
      (case decision
	(user::sub-goal :sub-goal)
	(user::protect :protect)
	(user::apply   :apply)))))

(defun depth (node child-func)
  (let ((children (funcall child-func node)))
    (if children
	(1+ (apply #'max
		   (mapcar #'(lambda (x) (depth x child-func))
			   children)))
	0)))

(defun terminatep ()
  (declare (special *current-problem-space*))

  (every #'(lambda (literal)
	     (cond ((and (member :top-level-goal (literal-goal-p literal))
			 (literal-state-p literal))
		    :terminate)
		   ((and (member :top-level-goal (literal-neg-goal-p literal))
			 (not (literal-state-p literal)))
		    :terminate)
		   (t nil)))

    (getf (problem-space-plist *current-problem-space*) :*finish*)))



(defun find-node (name &optional (abstraction-level 0))
  (declare (fixnum abstraction-level))

  ;; First find the root at the right level.
  (let* ((root (problem-space-property :root))
	 (top-goal (first (nexus-children root)))
	 (toplevel (nexus-abs-level root)))

    ;; If the user asks for the node numbered 1, it can only be found at
    ;; the top abstraction level.
    (cond ((or (zerop name) (= name 1))
	   (return-from find-node root))
	  ((> abstraction-level toplevel)
	   (format
	    t "~%There are no nodes at abstraction level ~S (highest is ~S)~%"
	    abstraction-level toplevel)
	   nil)
	  (t
	   (dotimes (iters (- toplevel abstraction-level))
	     (if top-goal
		 (setf top-goal (first (nexus-abs-children top-goal)))
		 (return-from find-node nil)))
	   ;; Then search from there.
	   (if top-goal
	       (find-node-at-level name top-goal))))))


;;; This function searches for a node with the given name, without
;;; changing abstraction level.
(defun find-node-at-level (name node)
  (declare (type nexus node))
  (if (equal (nexus-name node) name)
      node
      (some #'(lambda (x) (find-node-at-level name x)) (nexus-children node))))


;;; Always expand unless we're on a solved level - then refine.
;;; I intend to add control rules for this later.
(defun choose-refine-or-expand (node)
  (declare (special *current-problem-space*)
	   (type nexus node))
  (scr-choose-refine-or-expand
   node (problem-space-refine-or-expand *current-problem-space*)))

(defun scr-choose-refine-or-expand (node rules)
  (cond ((null rules)
	 (if (getf (nexus-plist node) 'winning-child)
	     :refine
	     :expand))
	((match-r-or-e-rule (car rules)))
	(t (scr-choose-refine-or-expand node (cdr rules)))))

(defun match-r-or-e-rule (rule)
  (declare (type control-rule rule))
  (when (match-lhs (control-rule-if rule) nil)
    (let ((decision (second (control-rule-then rule))))
      (output 3 t "~%Firing apply/subgoal ~S deciding ~S"
	      (control-rule-name rule) decision)
      ;; There are no bindings on the right hand side, so the match
      ;; that is returned is ignored.
      (case decision
	((user::refine :refine) :refine)
	((user::expand :expand)  :expand)))))

;;==========
;; functions for select/reject apply-op

(defun scr-select-applied-ops (applied-ops rules)
  (declare (special *potential-applied-ops*))
  (setf *potential-applied-ops* applied-ops)
  (when *debug-apply-op-ctrl*
    (format t "~%SCR-SELECT-APPLIED-OPS: ~S" (mapcar #'p4::nexus-name applied-ops))
    (format t "~%                 RULES: ~S" rules))
  (cond ((or (null rules)
	     (null applied-ops))
	 applied-ops)
	((match-select-applied-ops applied-ops (car rules)))
	(t (scr-select-applied-ops applied-ops (cdr rules)))))

(defun scr-reject-applied-ops (applied-ops rules)
  (declare (special *potential-applied-ops*))
  (setf *potential-applied-ops* applied-ops)
  (when *debug-apply-op-ctrl*
    (format t "~%SCR-REJECT-APPLIED-OPS: ~S" (mapcar #'p4::nexus-name applied-ops))
    (format t "~%                 RULES: ~S" rules))
  (if (or (null rules) (null applied-ops))
      applied-ops
    ;; otherwise, fire the first rule and then
    ;; recurse with the result of that call and the
    ;; remaining rules.
    (scr-reject-applied-ops (match-reject-applied-op applied-ops
						     (car rules))
			    (cdr rules))))

(defun find-applied-op-given-bindings (appops bindings)
  (mapcan #'(lambda (app-op)
	      (let ((actual-vals (instantiated-op-values app-op))
		    (wanted-vals (mapcar #'(lambda (var)
					     (cdr (assoc var bindings)))
					 (operator-vars
					  (instantiated-op-op app-op)))))
		(when *debug-apply-op-ctrl*
		  (format t "~%Wanted: ~S" wanted-vals)
		  (format t "~%Actual: ~S" actual-vals))
		(if (equal actual-vals
			   wanted-vals)
		    app-op)))
	  appops))
  
;; this function should return applied-op structures.
(defun match-select-applied-ops (applied-ops rule)
  (declare (special *current-problem-space*))
  (when *debug-apply-op-ctrl*
    (format t "~%MATCH-SELECT-APPLIED-OPS"))
  (let ((select-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) nil)))
    (when *debug-apply-op-ctrl*
      (format t "~%  Select-expr: ~S" select-expr)
      (format t "~%  Matched    : ~S" matched))
    (cond
     ((and matched (strong-is-var-p select-expr))
      ;; it's the whole applied op

      (let ((selected-ops
	     (mapcar #'(lambda (bindings)
			 (cdr (assoc select-expr bindings)))
		     matched)))
	(output 3 t "~%Firing select applied-op rule ~S to get~%    ~S"
		(control-rule-name rule)
		selected-ops)
	selected-ops))
     (matched
      (let ((selected-ops
	     (mapcar #'(lambda (bindings)
			 ;; bindings would only = t if no vars are bound,
			 ;; which should never happen here.
			 ;;
			 ;; we need to find the p4::*potential-applied-ops* which
			 ;; matches these bindings.

			 (find-applied-op-given-bindings p4::*potential-applied-ops*
							 bindings))
			 matched)))
	    (output 3 t "~%Firing select applied-op rule ~S to get~%    ~S"
		    (control-rule-name rule)
		    selected-ops)
	    selected-ops))
     (t nil))))


;; this function should return applied-op structures. IT
;; RETURNS THE LIST OF REMAINING OPS
(defun match-reject-applied-op (applied-ops rule)
  (let ((reject-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) nil)))
    (when *debug-apply-op-ctrl*
	    (format t "~%MATCH-REJECT-APPLIED-OP var in RHS")
	  (format t "~%  reject-expr: ~S" reject-expr)
	  (format t "~%  Matched:     ~S" matched))
    (cond
     ((and matched (strong-is-var-p reject-expr))
      ;; see if something in the LHS matched, then fire rule
      ;; once for each match. otherwise warning.
      (dolist (match matched applied-ops)
	      (let ((op (cdr (assoc reject-expr match :test #'equal))))
		(cond (op (output 3 t "~%Firing reject applied-operator ~S to remove~%    ~S"
				  (control-rule-name rule)
				  op
				  )
			  (setf applied-ops (delete op applied-ops)))
		      (t (format t "Warning: rule ~S matches but the expression ~
                           rejected unbound var.~S"
				 (control-rule-name rule)))))))
     (matched
      (let ((rejected-ops
	     (mapcar #'(lambda (bindings)
			 (find-applied-op-given-bindings p4::*potential-applied-ops*
							 bindings))
		     matched)))
	(output 3 t "~%Firing reject applied-operator ~S to remove~%     ~S"
		(control-rule-name rule)
		rejected-ops)
	(set-difference applied-ops
			rejected-ops)))
     (t
      applied-ops))))
