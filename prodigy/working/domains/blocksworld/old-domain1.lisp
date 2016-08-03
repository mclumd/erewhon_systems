;; This is the blocksworld according to the proposed 4.0 syntax

(create-problem-space 'blocksworld :current t)

(ptype-of OBJECT :top-type)

(OPERATOR 
  PICK-UP
  (params <ob1>)
  (preconds 
   ((<ob1> OBJECT))
   (and (clear <ob1>)
	(on-table <ob1>)
	(arm-empty)))
  (effects 
      () ; no vars need genenerated in effects list
      ((del (on-table <ob1>))
       (del (clear <ob1>))
       (del (arm-empty))
       (add (holding <ob1>))))))

(OPERATOR
  PUT-DOWN
  (params <ob>)
  (preconds 
   ((<ob> (and OBJECT (use-ob-p <ob>))))
    (holding <ob>))
  (effects 
        ()
	((del (holding <ob>))
	 (add (clear <ob>))
	 (add (arm-empty))
	 (add (on-table <ob>)))))

(OPERATOR
 STACK
 (params <ob> <underob>)
 (preconds 
   ((<ob> (and OBJECT (use-ob-p <ob>)))
    (<underob> (and OBJECT (diff <ob> <underob>))))
    (and (clear <underob>)
	 (holding <ob>)))
 (effects 
      ()
      ((del (holding <ob>))
       (del (clear <underob>))
       (add (arm-empty))
       (add (clear <ob> ))
       (add (on <ob> <underob>)))))

(OPERATOR
 UNSTACK
 (params <ob> <underob>)
 (preconds
  ((<ob> OBJECT)
   (<underob> (and OBJECT (diff <ob> <underob>)
		          (unstack-for-clear <ob>))))
  (and (on <ob> <underob>)
       (clear <ob>)
       (arm-empty)))
 (effects 
        ()
	((del (on <ob> <underob>))
	 (del (clear <ob>))
	 (del (arm-empty))
	 (add (holding <ob>))
	 (add (clear <underob>)))))
  

;;; calling meta-predicate involves instantiate literals, 
;;; thus changes the assertion hash table. 
;;; Adding control rules can cause "give-me-all-pending-goals"
;;; return different order of pending goals, thus PRODIGY may
;;; end up returning different choosen-goal than when we are
;;; not calling control rules.  This randomness may give
;;; difficulty to debugging. It might be a good idea to have
;;; some kind of sorting in the literals, e.g.  by a time stamp,
;;; or the node number in which the literals are created.


(control-rule DEPTH-FIRST-SEARCH
	      (IF (newest-candidate-node <node>))
	      (THEN select node <node>))


;;; current-ops is a meta-predicate that cannot be renamed
;;; because in load-domain time, it is used to decide in which
;;; operators this select binding control will be put in.


(CONTROL-RULE SELECT-BINDINGS-UNSTACK-CLEAR
	      (IF (and (current-goal (clear <y>))
		       (current-ops (UNSTACK))
		       (true-in-state (on <x> <y>))))
	      (THEN select bindings ((<ob> . <x>) (<underob> . <y>))))


#|
;;; Note that all clear blocks will be selected by this rule.
(Control-Rule Select-Bindings-Stack-Armempty
	      (IF (and (current-goal (arm-empty))
		       (current-ops (stack))
		       (true-in-state (holding <x>))
		       (true-in-state (clear <y>))))
	      (THEN select bindings ((<ob> . <x>) (<underob> . <y>))))
|#

(CONTROL-RULE SELECT-BINDINGS-UNSTACK-HOLDING
	      (IF (and (current-goal (holding <x>))
		       (current-ops (UNSTACK))
		       (true-in-state (on <x> <y>))))
	      (THEN select bindings ((<ob> . <x>) (<underob> . <y>))))


(CONTROL-RULE SELECT-OP-UNSTACK-FOR-HOLDING
	      (IF (and (current-goal (holding <x>))
		       (true-in-state (on <x> <y>))))
	      (THEN select operator UNSTACK))

(CONTROL-RULE SELECT-OP-UNSTACK-FOR-CLEAR
	      (IF (and (current-goal (clear <x>))
		       (true-in-state (on <y> <x>))))
	      (THEN select operator UNSTACK))

(CONTROL-RULE SELECT-PICKUP-FOR-HOLDING-IF-ON-TABLE
	      (IF (and (current-goal (holding <ob>))
		       (true-in-state (on-table <ob>))))
	      (THEN select operator PICK-UP))

(CONTROL-RULE PUTDOWN-CLEAR-IF-HOLDING
	      (IF (and (current-goal (clear <ob>))
		       (true-in-state (holding <other-ob>))))
	      (THEN select operator PUT-DOWN))

(CONTROL-RULE SELECT-BINDINGS-PUTDOWN-ARMEMPTY
	      (IF (and (current-goal (arm-empty))
		       (current-ops (PUT-DOWN))
		       (true-in-state (holding <x>))))
        
	      (THEN select bindings ((<OB> . <x>))))


(CONTROL-RULE REJECT-WRONG-GOAL
	      (IF (and (candidate-goal (on <x> <y>))
		       (candidate-goal (on <y> <z>))
		       (true-in-state (clear <x>))))
	      (THEN reject goal (on <x> <y>)))

(Control-Rule avoid-apply-for-wrong-goal
	      (IF (and (candidate-goal (on <x> <y>))
		       (candidate-goal (on <y> <z>))
		       (applicable-operator (pick-up <x>))))
	      (THEN sub-goal))

(defun diff (x y)
  (not (eq x y)))

#|
(defun candidate-goal (goal)

  (declare (special *current-node* *current-problem-space*))
  (let* ((a-or-b-node (give-me-a-or-b-node *current-node*))
	 (goals (p4::a-or-b-node-pending-goals a-or-b-node)))
    (cond ((p4::has-unbound-vars goal)
	   (match-candidate-goal goal goals))
	  (t (member (p4::instantiate-consed-literal goal) goals)))))

(defun give-me-a-or-b-node (node)
  (cond ((null node) nil)
	((typep node 'p4::a-or-b-node) node)
	(t (give-me-a-or-b-node (p4::nexus-parent node)))))


(defun match-candidate-goal (exp goals)
  (mapcan #'(lambda (x) (filter (goal-match x exp))) goals))

(defun filter (x)
  (if x (list x)))

;;;  instance is a literal; exp looks like (on <x> A).
;;; returns binding for the variables in exp.
(defun goal-match (instance exp)
  (if (eq  (p4::literal-name instance) (car exp))
      (let* ((inst (p4::literal-arguments instance))
	     (inst-len (length inst))
	     (exp-len (length (cdr exp))))
	(and (eq inst-len exp-len)
	     (p4::unify inst (cdr exp))))))

       
(defun current-goal (goal)
  (declare (special *current-node* *current-problem-space*))
  (let* ((goal-node (give-me-goal-node *current-node*))
	 (cur-goal (p4::goal-node-goal goal-node)))
    (if (eq (car goal) '~)
	(and (p4::negated-goal-p cur-goal)
	     (instance-of cur-goal (cadr goal) ))
	(instance-of cur-goal  goal))))

(defun instance-of (instance schema)
  (if (equal (p4::literal-name instance) (car schema))
      (let* ((exp1 (p4::literal-arguments instance))
	     (exp2 (cdr schema))
	     (len1 (length exp1))
	     (len2 (length exp2)))
	(and (eq len1 len2)
	     (or (= len1 0)
		 (let ((temp (p4::unify exp1 exp2)))
		   (if temp
		       (list temp)
		       nil)))))))


(defun give-me-goal-node (node)
  (cond ((null node) nil)
	((typep node 'p4::goal-node) node)
	(t (give-me-goal-node (p4::nexus-parent node)))))


;;; meta-predicate, returns T if cons-lit is true in state.
;;; wonder if this way of doing it would generate too many literals.
(defun true-in-state (expr)
  (declare (special *current-node* *current-problem-space*))
  (cond ((p4::has-unbound-vars (cdr expr))
	 (match-true-in-state expr))
	(t (let ((literal (p4::instantiate-consed-literal expr)))
	     (p4::literal-state-p literal)))))


(defun match-true-in-state (expr)
  (declare (list expr)
	   (special *current-problem-space*))
  (let ((assertions (gethash (car expr)
			     (p4::problem-space-assertion-hash
			      *current-problem-space*)))
	(result nil))
    
    (cond ((p4::static-pred-p (car expr))
	   (mapcan #'(lambda (x) 
		       (unify-if-state-true x (cdr expr)))
		   assertions))
	  (t (maphash #'(lambda (key val)
			  (declare (ignore key))
			  (let ((bindings (unify-if-state-true val (cdr expr))))
			    (if bindings (push bindings result))))
		      assertions)
	     result))))

(defun unify-if-state-true (literal expr)
  (if (p4::literal-state-p literal)
      (p4::unify (p4::literal-arguments literal) expr)))


;;; meta-predicate, returns T if the current operator is a member of
;;; ops (which is a list of operators that this control rule applies to.)
(defun current-ops (ops)
  (declare (special *current-node* *current-problem-space*))
  (let* ((op-node (give-me-op-node *current-node*))
	 (current-op (p4::operator-node-operator op-node)))
    (member (p4::operator-name current-op) ops)))


(defun give-me-op-node (node)
  (cond ((null node) nil)
	((typep node 'p4::operator-node) node)
	(t (give-me-op-node (p4::nexus-parent node)))))




(defun use-ob-p (x)
  (declare (special *current-node* *current-problem-space*))
  "This will take an object and determine if it can be used."

  (let* ((goal-node (p4::operator-node-parent *current-node*))
	 (arm-empty (p4::instantiate-consed-literal '(arm-empty))))

    (cond ((eq (p4::goal-node-goal goal-node) arm-empty)
	   (cond ((p4::literal-state-p (p4::instantiate-literal 'holding (list x)))
		  t)
		 (t nil)))
	   (t t))))


(defun unstack-for-clear (x)
  (declare (special *current-node* *current-problem-space*))
  "This will take an object and determine if it can be used."

  (let* ((goal-node (p4::operator-node-parent *current-node*))
 	 (clear (p4::instantiate-literal 'clear (list x))))

    (cond ((eq (p4::goal-node-goal goal-node) clear)
	   (cond ((x-under-other-ob-p x *current-problem-space*)
		  t)
		 (t nil)))
	  (t t))))

	   

(defun x-under-other-ob-p (ob p-space)

  (let ((assertion-h (gethash 'on
			      (p4::problem-space-assertion-hash p-space)))
	(result nil))

    (if (hash-table-p assertion-h)
	(maphash #'(lambda (key value)
		     (declare (ignore key))
		     (if (and (p4::literal-state-p value)
			      (eq (elt (p4::literal-arguments value) 1) ob))
			 
			 (setf result t)))
		 assertion-h))
    result))



;;; control rules translated from ebl-learned-rules in Prodigy2.0.

;; from sr13
(CONTROL-RULE SELECT-UNSTACK-IF-NOT-ON-TABLE
    (IF (and (current-goal (holding <x>))
	     (not (true-in-state (on-table <x>)))))
    (THEN select operator UNSTACK))

|#

