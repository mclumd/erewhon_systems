(in-package "PRODIGY4")

;;patch to matcher-interface.lisp

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
	   (copy-list
	    ;;aperez Nov 13 93
	    ;; pass goal as argument to get op for predicate and
	    ;; argument types (relevance-table as hash)
	    (relevant-operators goal ;(literal-name goal)
				*current-problem-space*
				(if (negated-goal-p goal) :del :add)))))))

;;patch to load-domain.lisp

;;; Build a hash table for adds and another for deletes.
;;; Hash on (pred-name type*) where type-i is the type for variable-i
;;; according to the op specification. Use always types that
;;; correspond to leaves in type hierarchy.
;;; The content of the entry is a list of operator (or rule)
;;; structures.

;;; If there are many subtypes and the arity is high, the number of
;;; combination can be quite big (ex: machining domain?). We are
;;; only considering the non-static predicates though.

;;; Notes: how to deal with infinite types: store `:infinite'
;;; Initialize the hash tables: in pspace defstruct? (as for assertion-hash)


;;This is a patch to load-domain.lisp
;;functions that remain:
;; build-relevance-table-for-p-space, reset-relevance-table,
;; add-rules-to-relevance-table, 

;;functions that change:
;; relevant-operators: get not only the pred-name but the whole literal.
;; add-to-relevance-table (to use type-spec)
;; remove-operator-for-relevance


(defun reset-relevance-table (p-space)
  (declare (type problem-space p-space))
  (setf (problem-space-relevance-table p-space)
	(vector (make-hash-table :test #'equal)
		(make-hash-table :test #'equal))))

;;change the callers to relevant-operators to pass the literal as a
;;list instead of only the predicate
;;This code assumes that the arguments are either prodigy objects or
;;numbers. Jim, is this true?
(defun relevant-operators (lit p-space parity)
  (declare (type literal lit)(type problem-space p-space))
  (let ((key (cons (literal-name lit)
		   (map 'list
			#'(lambda (arg)
			    (if (numberp arg)
				:infinite
				(type-name (prodigy-object-type arg))))
			(literal-arguments lit)))))
    (case parity
	((:add user::add)
	 (gethash key (elt (problem-space-relevance-table p-space) 0)))
	((:del user::del)
	 (gethash key (elt (problem-space-relevance-table p-space) 1)))
	(otherwise (error "Pred: ~S must be either :add, :del, ~
                           user::add or user::del.~%" lit)))))
  
(defun add-to-relevance-table (rule p-space)
  (dolist (effect (third (rule-effects rule)))
    (cond				; is it a del or add?
      ((member (car effect) '(user::del user::add))
       (add-rule-for-pred (second effect) rule p-space (car effect)))
      ;; no, then a conditional or universal effect.
      ((eq (car effect) 'user::if)
       (dolist (effect (third effect))
	 (add-rule-for-pred (second effect) rule p-space (car effect))))
      ((eq (car effect) 'user::forall)
       (dolist (effect (fourth effect))
	 (add-rule-for-pred (second effect) rule p-space (car effect))))
      (t 
       (error "~S is an illegal effect."
	      effect)))))


;; declarations =  (list (second (operator-precond-exp operator)))
;; plus the effects declarations
;; (lower-types-maybe-inf type pspace) returns lowest subtypes of type
;; or :infinite if it is an infinite type

(defun add-rule-for-pred (list rule p-space parity)
  " This adds the rule to the relevance table for the predicate and
the types of the variables in LIST.  The table is
made up of two smaller tables, 0 for adding predicates and 1 for
removing them.  Use the keyword :add for adding predicates and :del
for deleting."
  (declare (list list)(type rule rule))
  (case parity
    ((:add user::add)
     (dolist (lit (lit-to-schema-and-subs-for-relevance
		   list (list (append (second (operator-precond-exp rule))
				      (second (operator-effects rule))))
		   p-space))
       (pushnew
	rule (gethash lit (elt (problem-space-relevance-table p-space) 0)))))
    ((:del user::del)
     (dolist (lit (lit-to-schema-and-subs-for-relevance
		   list (list (append (second (operator-precond-exp rule))
				      (second (operator-effects rule))))
		   p-space))
       (pushnew
	rule (gethash lit (elt (problem-space-relevance-table p-space) 1)))))
    (otherwise (error "~S is not an acceptable parity.  Only :add ~
                         and :del.~%" parity))))


;; if the type is an infinite type, type-name-to-type returns the lisp
;; predicate that defines the type 

(defun lit-to-schema-and-subs-for-relevance (lit declarations pspace)
  (declare (list lit))
  (let ((possargs
	 (mapcar
	  #'(lambda (arg)
	      (let ((top (var-type-in-op arg declarations)))
		(cond
		  ((numberp top) ;;it is a numeric constant
		   (list :infinite))
		  ((null top)    ;;it is a constant
		   (list
		    (type-name 
		     (prodigy-object-type
		      (object-name-to-object arg pspace)))))
		  ((and (listp top)(eq (car top) 'user::or))
		   (remove-duplicates
		    (apply #'append 
			   (mapcar #'(lambda (typ)
				      (lower-types-maybe-inf
				       (type-name-to-type typ pspace)
				       pspace))
				   (cdr top)))))		   
		  ((and (listp top)(eq (car top) 'user::comp))
		   (mapcar
		    #'type-name
		    (remove (type-name-to-type (third top) pspace)
			    (type-sub (type-name-to-type (second top) pspace)))))
		  ((listp top)
		   (break "~A: case not considered" top))
		  (t (lower-types-maybe-inf
		      (type-name-to-type top pspace) pspace)))))
	  (cdr lit))))
    (if (every #'(lambda (list) (= (length list) 1)) possargs)
	;;only one type is possible for each var
	(list (cons (car lit)(apply #'append possargs)))
	(mapcar #'(lambda (argset)(cons (car lit)(copy-list argset)))
		(abs-cartesian-product possargs)))))


(defun var-type-in-op (var declarations)
  ;;returns type of var. From var-type in gen-hiers.lisp
  (some #'(lambda (decs)
	    (let ((type-spec (second (assoc var decs))))
	      (if (and (listp type-spec) (eq (car type-spec) 'user::AND))
		  (second type-spec)
		  type-spec)))
	declarations))


;;adapted from lower-types to deal with infinite types.
;;top is either a type struct or a function (if it corresponded to
;;an infinite type)

(defun lower-types-maybe-inf (top pspace)
  (declare (type problem-space pspace))
;;;  (cons top (mapcar #'type-name (all-subtypes top pspace)))
  (cond
    ((functionp top) (list :infinite))
    ((type-sub top)
     ;; this assumes the type hierarchy is a tree.
     (mapcan #'(lambda (type)
		 (lower-types-maybe-inf type pspace))
	     (type-sub top)))
    (t (list (type-name top)))))



;;because it is defined in load-domain.lisp

(defun remove-operator-for-relevance (lit rule p-space parity)
  (declare (type rule rule))
  "This removes an operator from a particular relevance condition.
For example if you run (remove-operator-for-relevance '(ON block block) 'STACK :add)
then STACK will not be considered when the goal is (ON block1 block2)"
  (if (not (typep rule 'rule))
      (error "~S is not type rule.~%" rule))

  (let ((index (case parity
		 ((:add user::add) 0)
		 ((:del user::del) 1)))
	(typed-list (cons (car lit)
			  (mapcar #'prodigy-object-type (cdr lit)))))
    (setf (getf (elt (problem-space-relevance-table p-space) index)
		typed-list)
	  (delete rule 
		  (getf (elt (problem-space-relevance-table p-space) index)
			typed-list)))))

;;; ********************************************************************
;;; Utilities

(defun give-me-all-relevances ()
  (list
   :add
   (let (temp)
    (maphash
     #'(lambda (key val)(push (list key val) temp))
     (elt (problem-space-relevance-table *current-problem-space*) 0))
    temp)
   :del 
   (let (temp)
    (maphash
     #'(lambda (key val)(push (list key val) temp))
     (elt (problem-space-relevance-table *current-problem-space*) 1))
    temp)))


;;this variable is used to determine the type of the first argument
;;for relevant-operators: a literal (with this version of relevance
;;tables) or a literal-name (old version of relevance tables)

(defvar *hash-on-literal-p* t)
