;;; $Revision: 1.5 $
;;; $Date: 1995/03/14 17:17:58 $
;;; $Author: khaigh $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: meta-predicates.lisp,v $
;;; Revision 1.5  1995/03/14  17:17:58  khaigh
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
;;; Revision 1.4  1995/03/13  00:39:34  jblythe
;;; General clean-ups, including a definition of gen-from-pred that can have
;;; more than one variable in the literal.
;;;
;;; Revision 1.3  1994/05/30  20:56:14  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:26  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


;;; commonly used meta-predicates.

(in-package "USER")



;;; calling meta-predicate involves instantiate literals, 
;;; thus changes the assertion hash table. 
;;; Adding control rules can cause "give-me-all-pending-goals"
;;; return different order of pending goals, thus PRODIGY may
;;; end up returning different choosen-goal than when we are
;;; not calling control rules.  This randomness may give
;;; difficulty to debugging. It might be a good idea to have
;;; some kind of sorting in the literals, e.g.  by a time stamp,
;;; or the node number in which the literals are created.



;;; current-ops is a meta-predicate that cannot be renamed
;;; because in load-domain time, it is used to decide in which
;;; operators this select binding control will be put in.


;;; This seems to be a useful macro
(defmacro bind-up (variable value)
  "Produce a list of binding lists with one binding list with one binding."
  `(list (list (cons ,variable ,value))))

#| ---------------------- META PREDICATES ------------------------------------- |#


;;; returns T is the goal is among the set of goals we might choose to
;;; work on.  the set of goals comes after select/reject goals
;;; control-rules.   It will return all the possible instantiations of
;;; variables in goal with the set of candidate goals if there are
;;; variables in goal.

(defun candidate-goal (goal)
  "Test whether <goal> is a candidate goal for this node. Used when
deciding on the current goal, can be used as a generator for <goal>,
which can be partially instantiated, e.g. (CANDIDATE-GOAL (clear <x>))
is legal and will generate values for <x>."

  ;; 2/20/92 Mei, added checking goal loop.
  (declare (special *current-node* *current-problem-space*
		    *candidate-goals*))
  (test-match-goals goal (candidate-goals)))

(defun candidate-goals ()
  (declare (special *candidate-goals* *current-node*))
  (remove-if #'(lambda (x)(p4::goal-loop-p *current-node* x))
	     (if (boundp '*candidate-goals*)
		 *candidate-goals*
	       (p4::a-or-b-node-pending-goals
		(give-me-a-or-b-node *current-node*)))))


#|
  (declare (special *current-node* *current-problem-space*
		    *candidate-goals*))
  (test-match-goals
   goal
   (if (boundp '*candidate-goals*)
       *candidate-goals*
       (p4::a-or-b-node-pending-goals
	(give-me-a-or-b-node *current-node*)))))
|#

(defun expanded-goal (goal)
  "Tests whether <goal> is already expanded (but not achieved yet)
along the current path."
  (declare (special *current-problem-space*))
  (test-match-goals
   goal (p4::problem-space-expanded-goals *current-problem-space*)))

(defun on-goal-stack (goal)
  "Tests whether the goal is on the goal stack - either expanded or a candidate."
  (or (expanded-goal goal) (candidate-goal goal)))

#|
(defun test-match-goals (goal goals)
  (cond ((p4::strong-is-var-p goal)
	 (mapcar #'(lambda (g) (list (cons goal g))) goals))
	((typep goal 'p4::literal)
	 (if (member goal goals) t))
	((p4::has-unbound-vars goal)
	 (match-candidate-goal goal goals))
	((listp goal)
	 (if (member (p4::instantiate-consed-literal goal) goals) t))
	(t nil)))
|#

;;aperez Feb 25 93: modified to allow testing for candidate negated goals.
;;g is a goal if (literal-goal-p g) is true.
;;It is a positive goal if (and (literal-goal-p g)
;;                              (~ (literal-state-p g)))
;;It is a negative goal if (and (literal-neg-goal-p g)
;;                              (literal-state-p g))
;; (which is what negated-goal-p checks)
;;
(defun test-match-goals (goal goals)
  (cond ((p4::strong-is-var-p goal)
	 (mapcar #'(lambda (g) (list (cons goal g))) goals))
	((typep goal 'p4::literal)
	 (if (member goal goals) t))
	((p4::has-unbound-vars goal)
	 (match-candidate-goal goal goals))
	((and (listp goal)
	      ;;goal is negated
	      (member (car goal) '(~ not)))
	 (if (member (p4::instantiate-consed-literal (second goal))
		     goals
		     :test #'(lambda (cand g)
			       (and (p4::negated-goal-p g)
				    (eql cand g))))
	     t))
	((listp goal)
	 ;;aperez: we need this more complicated test so if goal is a
	 ;;positive goal it does not match a member of goals which is
	 ;;a negative goal (goals is a list of literals). And also
	 ;;make sure that it is a positive goal (i.e. it is a goal and
	 ;;it is not in the state)
	 (if (member (p4::instantiate-consed-literal goal) goals
		     :test #'(lambda (cand goal)
			       (and (p4::literal-goal-p goal)
				    (not (p4::literal-state-p goal))
				    (eql cand goal))))
	     t))
	(t nil)))


;;; if "goal" is an instantiated literal, it returns T if the goal is
;;; the current goal, that is, it is the goal we have chosen to work
;;; on at this moment.   If the "goal" has variables, it will returns
;;; all the instantiations for the variables in the "goal" that match
;;; the current-goal. If "goal" is a variable, returns it bound to a
;;; literal corresponding to the current goal.

;;aperez 3/10/93 change it to make it more efficient
(defun current-goal (goal)
  "Tests whether <goal> is the current goal. Can be used as a generator."
  (declare (special *current-node* *current-problem-space*))
  (let ;((goal-node (give-me-goal-node *current-node*))
	; (cur-goal (p4::goal-node-goal goal-node)))
      ((cur-goal (p4::goal-node-goal
		  (give-me-node-of-type 'p4::goal-node *current-node*))))
    (cond
      ((p4::strong-is-var-p goal)
       (list (list (cons goal cur-goal))))
      ((and (listp goal) (eq (car goal) '~))
       (and (p4::negated-goal-p cur-goal)
	    (instance-of cur-goal (cadr goal))))
      ((and (not (p4::negated-goal-p cur-goal))
	    (instance-of cur-goal  goal))))))



;;; meta-predicate, returns T if cons-lit is true in state.
;;; returns all the bindings for variables in expr if expr has variables.
(defun true-in-state (expr &optional type-declarations)
  "Tests whether <expr> is true in the state. Cannot be used as a
generator for nodes or expressions, but can be used to generate values
for the variables in <expr>. If the second argument is given, it
should be a bindings list for variables in expr, eg ((<x>  Object))"
  (declare (special *current-node* *current-problem-space*))
  (cond ((p4::has-unbound-vars (cdr expr))
	 (match-true-in-state expr type-declarations))
	((equal (car expr) '~)
	 (not (p4::literal-state-p
	       (p4::instantiate-consed-literal (second expr)))))
	(t (p4::literal-state-p (p4::instantiate-consed-literal expr)))))

;;; This predicate used to be called "known" in prodigy2, but was
;;; "true-in-state" in NoLimit.
(setf (symbol-function 'known) (symbol-function 'true-in-state))

;;; Some meta-predicates to test negated literals in the state. To
;;; replace the uses of (~ (known lit)) or  (known (~ lit)).

;;; increment-choice is defined in instantiate-op.lisp

;;; *****************************************************************
;;; Test if (~ literal) is true in the state.
;;; Each pair is (var type) where var is one of the unbound vars in
;;; the rule.

;;; Returns true if the literal is false for all possible bindings.
;;; Does not return bindings for the unbound vars. 
;;; Example: control-rule PUT-ON-MACHINE-TABLE-IF-NOT-HOLDING

(defun false-in-state-forall-values (literal &rest pairs)
  ;;first, get bindings for the variables:
  (do* ((values  ;;a list where each element is a list of all possible
		 ;;values for each var in pairs. Each value comes with
		 ;;the var in the form (var . value)
	 (mapcar #'(lambda (pair) (all-the-instances (second pair)))
		 pairs))
	(choice (make-list (length pairs) :initial-element 0)
		(p4::increment-choice choice values)))
       ((or (equal  values '(nil))(null choice))
	;;exit here if literal is false for all bindings (this includes
	;;when there are no possible bindings)
	t)
    (if (null (not-in-state literal choice values pairs))
	;;for some binding the literal is true
	(return nil))))


;;; *****************************************************************
;;; Returns true if the literal is false for some bindings.
;;; Does not return bindings for the unbound vars.

(defun false-in-state (literal &rest pairs)
  (if (apply #'false-in-state-generator (cons literal pairs))
      t))


;;; *****************************************************************
;;; Test if (~ literal) is true in the state.
;;; Each pair is (var type) where var is one of the unbound vars in
;;; the rule.
;;; Returns bindings for the unbound vars such that the literal is
;;; false. (Needed in bindings rules  only?)

(defun false-in-state-generator (literal &rest pairs)
  ;;first, get bindings for the variables:
  (do* ((values  ;;a list where each element is a list of all possible
		 ;;values for each var in pairs. Each value comes with
		 ;;the var in the form (var . value)
	 (mapcar #'(lambda (pair) (all-the-instances (second pair)))
		 pairs))
	(choice (make-list (length pairs) :initial-element 0)
		(p4::increment-choice choice values))
	sat result)
       ((null choice) 
	(cond 
	  ((null result) t)  ;there were no bindings for the unbound var
	  ((null (setf result (remove nil result))) nil)
	  ((remove t result))));;return set of bindings
    (setf sat  (not-in-state literal choice values pairs))
    (if sat (push sat result))))    

(defun not-in-state (literal choice values pairs)
  (let* ((bindings (mapcar #'(lambda (datum one-choice pair)
			      (cons (car pair)
				    (elt datum one-choice)))
			  values choice pairs))
	 (new-literal ;;substitute bindings in literal
	  (p4::substitute-binding literal bindings)))
    ;;this is what true-in-state does:
    (if (null (p4::literal-state-p
	       ;;aperez 3/10/93 changed for efficiency
	       ;;(p4::instantiate-consed-literal new-literal)
	       (p4::instantiate-literal (car new-literal)(cdr new-literal))))
	bindings)))
  

;;; *****************************************************************
;;type-of-object-gen returns a list where each element is a partial
;;binding, i. e. each element is ((var . value)). This is so it can be
;;used as a meta-predicate

(defun type-of-object-gen (obj type)
  (cond ((p4::strong-is-var-p type)
	 (error "~A has to be bound.~%" type))
	((p4::strong-is-var-p obj)
	 ;;generate bindings
	 (mapcar #'(lambda (instance)
		     (list (cons obj instance)))
		 (all-the-instances type)))
	(t (type-of-object obj type))))

;;type-instances gets all the instances of the type and its subtypes.
;;type-real-instances gets only the direct instances of the type

(defun all-the-instances (type-name)
  (p4::type-instances 
   (p4::type-name-to-type type-name p4::*current-problem-space*)))

(defun my-instances (type-name)
  (p4::type-real-instances 
   (p4::type-name-to-type type-name p4::*current-problem-space*)))


;;; ************************************************************
;;; meta-predicate, returns T if the current operator is a member of
;;; ops. This meta-predicate cannot be renamed since it is used in
;;; load-domain time to decide which operator the select/reject
;;; bindings control rule is  applied to. 

(defun current-ops (ops)
    "Used in select/reject bindings control rules only to tell the
rete-net what operators this control rule is used for, so you must use
this meta-predicates in all the select/reject bindings control rules.
Ops is a list of operator names."

  (declare (special *current-node* *current-problem-space*)
	   (list ops))
  (let* ((op-node (give-me-op-node *current-node*))
	 (current-op (p4::operator-node-operator op-node)))
    (if (member (p4::operator-name current-op) ops) t)))


;;; Returns t if op is the current operator, can be used to generate.
;;; This used to be called current-op, but the name has been changed to
;;; keep it distinct from current-ops.
(defun current-operator (op)
  "Tests whether <op> is the current <op> for the current goal  at the
current node.  Can be used as a generator."
  (declare (special *current-node* *current-problem-space*))
  
  (let* ((op-node (give-me-op-node *current-node*))
	 (current-op (p4::operator-node-operator op-node)))
    (cond ((p4::strong-is-var-p op)
	   (bind-up op current-op))
	  ((listp op)
	   (if (member (p4::operator-name current-op) op) t))
	  (t
	   (eq (p4::operator-name current-op)
	       (if (typep op 'operator) (p4::operator-name op)
		   op))))))

;;; Match op to a candidate operator for this node. Can be used as a
;;; generator. 
(defun candidate-operator (op)
  "Tests whether <op> is a member of the relevant ops being considered
at the current node.  Can be used as a generator."
  (declare (special *current-node* *candidate-operators*
		    *current-problem-space*))
  (let ((candidates (if (boundp '*candidate-operators*)
			*candidate-operators*
			(p4::goal-node-ops-left
			 (give-me-goal-node *current-node*)))))
    (cond ((eq candidates :not-computed) nil)
	  ((p4::strong-is-var-p op)
	   (mapcar #'(lambda (cand) (list (cons op cand))) candidates))
	  ((typep op 'p4::operator)
	   (if (member op candidates) t))
	  (t
	   (if (member (p4::rule-name-to-rule op *current-problem-space*)
		       candidates)
	       t)))))

(defun is-op-for-goal-p (inst-op-exp goal-exp)
  (declare (special *current-node*))
  ;;goal-exp and inst-op-exp have to be bound to lists
  ;;goal-exp has to be completely instantiated (from other meta-preds)
  ;;The car of inst-op-exp, (the op-name) has to be bound, but its 
  ;;arguments don't need to be bound
  ;;(we will use this meta-pred to get bindings for the vars in the op)
  (let ((binding-node
	 (find-inst-op-node *current-node* goal-exp nil)))
    (cond
     ((null binding-node) nil)
     ;;check op name 
     ((not (eq (p4::operator-name
		(p4::instantiated-op-op
		 (p4::binding-node-instantiated-op binding-node)))
	       (car inst-op-exp)))
      nil)
     (t
      (let* (new-bindings
	     (result
	       (every
		#'(lambda (arg-obj arg-name)
		    ;;allow arg-name to be a variable
		    (cond ((p4::strong-is-var-p arg-name)
			   (push (cons arg-name arg-obj) new-bindings))
			  (t (equal arg-obj arg-name))))
		(p4::instantiated-op-values
		 (p4::binding-node-instantiated-op binding-node))
		(cdr inst-op-exp))))
	(if new-bindings (list new-bindings) result))))))

(defun find-inst-op-node (node goal-exp grand-child)
  (declare (ignore grand-child))
  ;;path is (goal op bindings apply-op*)
  ;;this will break if node does not have enough ancestrors 
  (let ((next-goal-and-bind-nodes
	 (case
	  (type-of node)
	  (p4::goal-node
	   (next-goal (p4::nexus-parent node) node nil))
	  (p4::operator-node
	   (next-goal
	    (p4::nexus-parent (p4::nexus-parent node))
	    (p4::nexus-parent node)
	    node))
#|	  (p4::binding-node
	   (next-goal
	    (p4::nexus-parent (p4::nexus-parent (p4::nexus-parent node)))
	    (p4::nexus-parent (p4::nexus-parent node))
	    (p4::nexus-parent node)))
|#
          ;; Mei, 8/5/92
	  (p4::binding-node
	   (next-goal
	    (p4::nexus-parent (p4::nexus-parent node))
	    (p4::nexus-parent node)
	    node))
	  (p4::applied-op-node
	   (next-goal (p4::nexus-parent node) node nil)))))
    (if next-goal-and-bind-nodes
	(find-inst-op-node-rec (car next-goal-and-bind-nodes)
			       goal-exp
			       (cdr next-goal-and-bind-nodes)))))
      

(defun next-goal (node child grand-child)
  ;;return (goal-node . grand-child)
  (cond
   ((null node) nil)
   ((typep node 'p4::goal-node)
    (cons node grand-child))
   (t (next-goal (p4::nexus-parent node)
		 node child))))

  
(defun find-inst-op-node-rec (node goal-exp grand-child)
  ;;assumes goal-exp is fully instantiated
  (cond
   ((and 
     (typep node 'p4::goal-node)
     (equal (p4::goal-node-goal node)
	    (p4::instantiate-consed-literal goal-exp)))
    grand-child)
   ((null (p4::nexus-parent node)) nil)
   (t (find-inst-op-node-rec (p4::nexus-parent node)
			 goal-exp
			 (p4::nexus-parent grand-child)))))


;;; **************************************************************
;;; this fn is modeled after compute-expanded-goals in search.lisp 

;;; (problem-space-property :expanded-operators) is set to nil when the
;;; node changes (in fn main-search). Then the first time
;;; expanded-operator is called, the list of expanded-operators for this
;;; node is cached. 

(defun expanded-operator (inst-op-exp)
  "Tests whether <inst-op-exp> corresponds to an operator open in the
current path but not applied yet. Can be used as generator for
instantiated operators, or for the variables in <inst-op-exp>."
  (test-match-ops
   inst-op-exp
   (or (problem-space-property :expanded-operators)
       (setf (problem-space-property :expanded-operators)
	     (compute-expanded-operators)))))

(defun compute-expanded-operators (&optional (node *current-node*))
  (declare (type p4::nexus node)
	   (special *current-problem-space* *current-node*))
  (let (expanded-operators)
    (dolist
     (temp-node (p4::path-from-root
		 node #'(lambda (n) (p4::a-or-b-node-p n)))
		expanded-operators)
     (typecase temp-node
      (p4::binding-node
       (push (p4::a-or-b-node-instantiated-op temp-node)
	     expanded-operators))
      (p4::applied-op-node
       (cond
	((getf (p4::problem-space-plist *current-problem-space*)
	       :permute-application-order)
	 (setf expanded-operators
	       (remove (p4::a-or-b-node-instantiated-op temp-node)
		       expanded-operators)))
	(t (pop expanded-operators))))))))



(defun test-match-ops (inst-op-exp expanded-ops)
  (cond
   ((p4::strong-is-var-p inst-op-exp)
    (mapcar #'(lambda (op) (list (cons inst-op-exp op)))
	    expanded-ops))
   ((listp inst-op-exp)
    (if (eq 'quote (car inst-op-exp))
	(setf inst-op-exp (second inst-op-exp)))
    (let ((result
	   (mapcar
	    #'(lambda (expanded-op)
		(match-expanded-op inst-op-exp expanded-op))
	    expanded-ops)))
      (setf result (remove nil result))
      (cond
       ((null result) nil) ;no match returned
       ;;some match succeeded and  all vars were bound
       ((null (remove t result)))
       ;;some matches succeded and returned bindings for vars
       (t (remove t result)))))
   (t nil)))

(defun match-expanded-op (exp op)
  ;;exp is of the form (load-airplane package1 <airp> <loc>)
  ;;returns t, nil, or a list of bindings
  (and
   ;;first check op name
   (eq (car exp)
       (p4::operator-name (p4::instantiated-op-op op)))
   ;;now check bindings
   (let* (new-bindings
	  (result
	   (every #'(lambda (v1 v2)
		      (cond
		       ((p4::strong-is-var-p v1)
			(push (cons v1 v2) new-bindings))
		       ((or (equal v1 v2)
			    (and ;;aperez: this produced an error
			     (p4::prodigy-object-p v2)
			     (equal v1 (p4::prodigy-object-name v2)))))))
		  (cdr exp) (p4::instantiated-op-values op))))
     (if result 
	 (or new-bindings result)))))

;;; Note that *candidate-bindings* is bound to a list of values-lists
;;; for instantiated operators, whereas if we get the bindings-left
;;; from the node, we have a list of instantiated operators. I've left
;;; it this way so as not to generate extra lists if I have to. Some
;;; functions to make it easier for the writer of meta-predicates
;;; using bindings to convert between the two are included.

(defun candidate-bindings (binding)
  "Tests whether <bindings> is a candidate binding for the current
node, goal and op.  The argument can be a variable, or an association
list  of variable-object/variable pairs, where the first variable is a 
parameter of the current operator. Note that partial bindings are not
allowed. Can be used as a generator"
  (declare (special *current-node* *current-problem-space*
		    *candidate-bindings*))

  (cond ((boundp '*candidate-bindings*)
	 ;; Won't be bound unless this is an operator node.
	 (grab-candidate-bindings binding *current-node*
				  (car *candidate-bindings*)))
	((p4::operator-node-p *current-node*)
	 (let ((candidates (p4::operator-node-bindings-left *current-node*)))
	   (if (and candidates (not (eq candidates :not-computed)))
	       (grab-candidate-bindings binding *current-node* candidates))))))

(defun grab-candidate-bindings (binding node candidates)
  (declare (list candidates)
	   (type p4::operator-node node))
  (cond ((and (p4::strong-is-var-p binding) candidates)
	 (mapcar (cond ((typep (car candidates) 'p4::instantiated-op)
			#'(lambda (inst-op)
			    (list (cons binding
					(p4::instantiated-op-values inst-op)))))
		       ((listp (car candidates))
			#'(lambda (value-list)
			    (list (cons binding value-list)))))
		 candidates))
	((p4::binding-list-p binding)
	 (match-bindings binding node candidates))))

(defun match-bindings (binding node candidates)
  (declare (type p4::operator-node node)
	   (list binding candidates))
  (let* ((operator (p4::operator-node-operator node))
	 (args (p4::operator-vars operator)))
    (if (and candidates (= (length binding) (length args)))
	(catch 'no-bindings-needed
	  ;;aperez: as test-match-binding returns a binding list,
	  ;;the mapcan blended all those results in one single list,
	  ;;which is wrong. I have modified test-match-binding to
	  ;;return either nil or a list containing a binding list
	  (mapcan
	   (cond ((typep (car candidates) 'p4::instantiated-op)
		  #'(lambda (candidate)
		      (test-match-binding binding
					  (p4::instantiated-op-values candidate)
					  args nil)))
		 ((listp (car candidates))
		  #'(lambda (candidate)
		      (test-match-binding binding candidate args nil))))
	   candidates)))))

;;; Tests if the binding can match the candidate binding. It returns a
;;; binding list for matching the bindings (argh!).
(defun test-match-binding (binding candidate args ret-bindings
				   &aux new-bindings)
  (cond ((null binding)
;	 (or ret-bindings (throw 'no-bindings-needed t))
	 ;;aperez: the binding list has to be inside of another list
	 ;;(or the callingg mapcan will blend them with the results of
	 ;;other calls to test-match-binding)
	 (if ret-bindings
	     (list ret-bindings)
	     (throw 'no-bindings-needed t)))
	;; Otherwise try to match one binding and continue.
	((setq new-bindings
	       (match-one-binding (car binding) candidate args ret-bindings))
	 (test-match-binding (cdr binding) candidate args
			     (car new-bindings)))))

;;; Returns the new bindings in a cons cell, or nil if no match.
(defun match-one-binding (binder obj-list arg-list current-bindings)
  (declare (list obj-list arg-list current-bindings)
	   (cons binder))
  (cond ((p4::strong-is-var-p (cdr binder))
	 ;; If this is bound to a variable we already have, it should
	 ;; not have changed its value.
	 (if (assoc (cdr binder) current-bindings)
	     (and (eq (cdr (assoc (cdr binder) current-bindings))
		      (p4::prodigy-object-name
		       (elt obj-list (position (car binder) arg-list))))
		  (list current-bindings))
	     ;; Otherwise it's a new variable so bind it.
	     ;;aperez: if the var is from the effects list, it may not
	     ;;be bound yet in the candidate bindings, and therefore
	     ;;is nil: don't get its prodigy-object-name!! (same if
	     ;;the value is a number)
             (list (cons (cons (cdr binder)
		   (let ((arg-val
			  (elt obj-list (position (car binder) arg-list))))
		     (if (p4::prodigy-object-p arg-val)
			 (p4::prodigy-object-name arg-val)
			 arg-val))		     
		   )
                         current-bindings))))
	;; If it's not a variable it must match the object.
	;;aperez: but (cdr binder) can be both a symbol and a prodigy-object
	(;;(eq (cdr binder)
	 ;;    (p4::prodigy-object-name
	 ;;    (elt obj-list (position (car binder) arg-list))))
	 (let ((arg-val
		(elt obj-list (position (car binder) arg-list))))
	   (or (eq (cdr binder) arg-val)
	       (eq (cdr binder) (p4::prodigy-object-name arg-val))))
	 (list current-bindings))))


;;; match exp against the goals, and returns all the possible
;;; instantiations of the variables in exp.
;;; aperez: goals is a list of literals. We know if each is negated or
;;; not by looking to literal-goal-p and literal-neg-goal-p

(defun match-candidate-goal (exp goals)
  (mapcan #'(lambda (x)
	      (let ((match-res
		     (cond
		       ((member (car exp) '(~ not))
			;;make sure that x is a negated goal			
			(and (p4::literal-neg-goal-p x)
			     (instance-of x (second exp))))
		       (t 
			;;make sure that x is a positive goal (and not
			;;a negated one)
			(and (p4::literal-goal-p x)
			     (instance-of x exp))))))
		(if (eq match-res t)	; possible result
		    (list (list nil))
		    match-res)))
	  goals))

#|
(defun instance-of (instance schema)
  (if (equal (p4::literal-name instance) (car schema))
      (let* ((exp1 (p4::literal-arguments instance))
	     (exp2 (cdr schema))
	     (len1 (length exp1))
	     (len2 (length exp2)))
	(and (= len1 len2)
	     ;; Mei, 7/5/92.  I don't understand why (list t) is
	     ;; returned, it caused a bug in p1.lisp in
	     ;; extended-strips domain, so i change it to T for now.
	     ;; (or (and (= len1 0) (list t)))
	     (or (and (= len1 0) t)
		 (let ((temp (p4::unify exp1 exp2)))
		   (cond ((eq temp t) t)
			 (temp (list temp)))))))))
|#
;;aperez 3/10/93 tried to make it more efficient
(defun instance-of (instance schema)
  (if (equal (p4::literal-name instance) (car schema))
      (let ((len1 (length (p4::literal-arguments instance)))
	    (len2 (length (cdr schema))))
	(and (= len1 len2)
	     ;; Mei, 7/5/92.  I don't understand why (list t) is
	     ;; returned, it caused a bug in p1.lisp in
	     ;; extended-strips domain, so i change it to T for now
	     ;;(that is what zerop returns)
	     ;; (or (and (= len1 0) (list t)))
	     (or (zerop len1)
		 (let ((temp (p4::unify
			      (p4::literal-arguments instance)
			      (cdr schema))))
		   (cond ((eq temp t) t)
			 (temp (list temp)))))))))

;;; return all the possible instantiations of expr that are true in
;;; the current state.
;; Mei, 2/11/92, changed and added unify-if-state-false so that known
;; can be used for negated assertions, 
;; such as (known (~ (pred <x> A))).
;; Mei, 7/7/92.  Changed again, so where unify-if-state-false returns
;; True, match-true-in-state should return False.  I am not sure what
;; this really should be.  Suppose a control rule has a precondition
;; (known (~ (on <x> A))), and suppose only (on C A) is true, should
;; match-true-in-state returns NIL?  If yes, then (known (...))
;; should really be (~ (exist <x>) (on <x> A)).  
;; consider the following rule, I think Known returns NIL if there
;; exists a <k1> such that (is-key <door> <k1>).  So my thoughts is
;; correct. 
;; (control-rule GO-THRU-LOCKED-DR
;;  (if (and (current-goal (inroom robot <room>))
;;	   (current-operator GO-THRU-DR)
;;	   (known (dr-to-rm <door> <room>))
;;	   (known (locked <door>))
;;	   (known (~ (is-key <door> <k1>)))))
;;  (then reject bindings ((<ddx> . <door>))))
;; well, it's still wrong.
;; what's the semantics of (known (~ (on <x> A)))?
;; I take is as  (~ (exist <x>) (on <x> A)), therefore, I only need to
;; match those that are true in the state, and if there is one object
;; that satisfies (on <x> A), it returns nil.  So I am coming back to
;; the old function.

(defun match-true-in-state (expr type-declarations)
  (declare (list expr type-declarations)
	   (special *current-problem-space*))
  (let* ((negp (eq (car expr) 'user::~))
	 (expr (if negp (second expr) expr))
	 (assertions (gethash (car expr)
			      (p4::problem-space-assertion-hash
			       *current-problem-space*)))
	 (result nil))
    (when assertions
      (maphash #'(lambda (key val)
		   (declare (ignore key))
		   (let ((bindings
;			  (unify-if-state-true val (cdr expr)
;					       type-declarations)
			  ;;aperez: changed this for efficiency (there
			  ;;is a huge difference when true-in-state
			  ;;is heavily used (/../fischer/usr/aperez/results-monitor)
			  (if (p4::literal-state-p val)
			      (p4::unify (p4::literal-arguments val)
					 (cdr expr) type-declarations))))
		     (if bindings (push bindings result))))
	       assertions))
    (if negp (not result) result)))




#|
(defun match-true-in-state (expr)
  (declare (list expr)
	   (special *current-problem-space*))
  (let* ((negp (eq (car expr) 'user::~))
	 (expr (if negp (second expr) expr))
	 (assertions (gethash (car expr)
			      (p4::problem-space-assertion-hash
			       *current-problem-space*)))
	 (result nil))
    (when assertions
      (maphash #'(lambda (key val)
		   (declare (ignore key))
		   (let ((bindings
			  (if negp
			      (unify-if-state-false val (cdr expr))
			      (unify-if-state-true val (cdr expr)))))
		     (if bindings (push bindings result))))
	       assertions))
;	(setf result negp)
    (if negp (not result) result)))

    (if assertions
	(cond ((p4::static-pred-p (car expr))
	       (mapcan #'(lambda (x)
			   (let ((bindings (unify-if-state-true x (cdr expr))))
			     (if bindings (list bindings))))
		       assertions))
	      (t (maphash #'(lambda (key val)
			      (declare (ignore key))
			      (let ((bindings (unify-if-state-true val (cdr expr))))
				(if bindings (push bindings result))))
			  assertions)
	      result)))
|#

;;; do matching only if the literal is true-in-state.
(defun unify-if-state-true (literal args-list &optional type-declarations)
  (declare (type p4::literal literal)
	   (list args-list))
  (if (p4::literal-state-p literal)
      (p4::unify (p4::literal-arguments literal)
		 args-list type-declarations)))

;;; do matching only if the literal is NOT true-in-state.
(defun unify-if-state-false (literal args-list)
  (declare (type p4::literal literal)
	   (list args-list))
  (unless (p4::literal-state-p literal)
    (p4::unify (p4::literal-arguments literal)
	       args-list)))


;;;====================
;;; Predicates for nodes
;;;====================


;;; I don't really know when this would be called, but it's here for
;;; completeness.
;;; Match the node to a candidate node. It should either be a node
;;; name, when this node is checked to see if it is still an open node, or
;;; a variable, when all open nodes are considered.
(defun candidate-node (node)
  "Tests whether a node is among the candidate set of nodes in the
tree. Can be used as a generator."
  (declare (special *current-problem-space* *candidate-nodes*))
  (let ((candidates (if (boundp '*candidate-nodes*) *candidate-nodes*
			(p4::problem-space-property :expandable-nodes))))
    (cond ((p4::strong-is-var-p node)
	   (mapcar #'(lambda (cand) (list (cons node cand)))
		   candidates))
	  ((typep node 'p4::nexus)
	   (if (member node candidates) t))
	  ((typep node 'fixnum)
	   (if (member (find-node node) candidates) t)))))

(defun newest-candidate-node (node)
  "Tests whether <node> is the most recently created candidate node.
Can be used as a generator. Is used to implement depth-first search."
  (declare (special *current-problem-space*))
  (let ((most-recent-candidate-node
	 (p4::return-previous *current-problem-space*)))
    (cond ((p4::strong-is-var-p node)
	   (bind-up node most-recent-candidate-node))
	  ((typep node 'nexus)
	   (eq node most-recent-candidate-node))
	  ((typep node 'fixnum)
	   (eq (find-node node) most-recent-candidate-node)))))

(defun oldest-candidate-node (node)
  "Tests whether <node> is the oldest candidate node.  Can be used as
a generator. Is used to implement breadth-first search."
  (declare (special *current-problem-space*))
  (let ((oldest-candidate-node (p4::return-next *current-problem-space*)))
    (cond ((p4::strong-is-var-p node)
	   (bind-up node oldest-candidate-node))
	  ((typep node 'nexus)
	   (eq node oldest-candidate-node))
	  ((typep node 'fixnum)
	   (eq (find-node node) oldest-candidate-node)))))

;;; find the closest operator-node among the node's ancestors.
(defun give-me-op-node (node)
  (give-me-node-of-type 'p4::operator-node node))

;;; find the closest a-or-b-node among the node's ancestors.
(defun give-me-a-or-b-node (node)
  (give-me-node-of-type 'p4::a-or-b-node node))

;;; find the closest goal-node among the node's ancestors.
(defun give-me-goal-node (node)
  (give-me-node-of-type 'p4::goal-node node))

;;; find the closest applied-op-node among the node's ancestors.
(defun give-me-applied-op-node (node)
  (give-me-node-of-type 'p4::applied-op-node node))

(defun give-me-node-of-type (type node)
  (do ((parent node (p4::nexus-parent parent)))
      ((or (null parent) (typep parent type))
       parent)))



;;; Find the applicable operator and bindings for it. Will match a
;;; list of the form (stack <x> <y>), which looks a bit different from
;;; the normal bindings list thing, but the situation is different.
(defun applicable-operator (expr)
  "Tests whether <expr> is an applicable operator. Can be used as
generator if passed a variable or a list of the form
(Op <arg1> <arg2> ..)" 
  (declare (special *current-node* *applicable-op*))

  (let ((applicable-ops
	 (if (boundp '*applicable-op*)
	     (list *applicable-op*)
	     (p4::generate-applicable-ops *current-node*))))
    (cond ((p4::strong-is-var-p expr)
	   (mapcar #'(lambda (app) (bind-up expr app))
		   applicable-ops))
	  ((listp expr)
	   (catch 'no-variables
	     (mapcan #'(lambda (app)
		(let ((result (match-instantiated-op expr app)))
		  (if result (list result))))
	    applicable-ops)))
	  (t
	   (if (member expr applicable-ops) t)))))

(defun match-instantiated-op (expr inst-op)
  "Return a binding list if we can match the inst-op to the expression."
  (declare (list expr)
	   (type p4::instantiated-op inst-op))

  ;; This is not the expected use of unify, but it should work..
  (if (eq (car expr) (p4::operator-name (p4::instantiated-op-op inst-op)))
      (let ((match (p4::unify (p4::instantiated-op-values inst-op) (cdr expr))))
	(if (eq match t) (throw 'no-variables t)
	    match))))


;;; useage: either (gen-from-pred (lit <bound-var> <only-unbound-variable>))
;;; or (gen-from-pred (lit <var1> <var2>) <var2>)
(defun gen-from-pred (literal &optional variable)
  (if (and (not variable)
	   (> (count-if #'(lambda (x) (p4::strong-is-var-p x)) literal) 1))
      (error "~% too many unbound var in the predicate generator ~S" literal)
    (let ((res (true-in-state literal)))
      (or (eq res t)
	  (mapcar #'(lambda (x)
		      (cdr (if variable (assoc variable x)
			     (car x))))
		  res)))))

;; Mei: 8/5/92.
;; variables in goal-exp have to be bound when this function is
;; called. 
(defun goal-introduced-only-by-op (goal-exp inst-op-exp)
  (declare (special *current-node*))
  (when (p4::has-unbound-vars goal-exp)
    (error "There are unbound variable in goal-exp"))
  (let* ((g-lit (p4::instantiate-consed-literal goal-exp))
	 (introducing-inst-ops (p4::literal-goal-p g-lit))
	 (inst-op (car introducing-inst-ops)))
    (when (and inst-op (null (cdr introducing-inst-ops)))
      (p4::unify
       (cons (p4::rule-name (p4::instantiated-op-op inst-op))
	     (p4::instantiated-op-values inst-op))
       inst-op-exp))))

(defun only-one-candidate-goal ()
  (declare (special *current-node*))
  (let ((goal-node (give-me-node-of-type 'p4::goal-node *current-node*)))
    (null (p4::goal-node-goals-left goal-node))))

(defun is-top-level-goal (goal-exp)
  (declare (special *current-node*))
  (test-match-goals goal-exp 
		    (p4::binding-node-pending-goals (find-node 4))))

;=====
(defun candidate-applicable-op (applied-op)
    (test-match-applied-ops applied-op p4::*potential-applied-ops*))

;;===========================================================================
(defun test-match-applied-ops (applied-op applied-ops)
  ;; similar to test-match-goals
  (cond ((p4::strong-is-var-p applied-op)
	 (mapcar #'(lambda (ao) (list (cons applied-op ao)))
		 applied-ops))
	((p4::has-unbound-vars applied-op)
	 ;; need to bind them.
	 ;; for each applied op, if the name matches, bind each
	 ;; of the vars
	 (mapcan #'(lambda (x)
		     (instance-of-applied-op x applied-op)
		     )
		 applied-ops)
	 )
	(t nil)))

;;===========================================================================
(defun instance-of-applied-op (instance schema)
  (if (equal (p4::operator-name (p4::instantiated-op-op instance))
	     (car schema))
      (let ((len1 (length (p4::instantiated-op-values instance)))
	    (len2 (length (cdr schema))))
	(and (= len1 len2)
	     (or (zerop len1)
		 (let ((temp (p4::unify (p4::instantiated-op-values instance)
					(cdr schema))))
		   (cond ((eq temp t) t)
			 (temp (list temp)))))))))
