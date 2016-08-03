(in-package USER)

(defvar *debug-top-priority-goals* nil)

;;===========================================================================
;; META-PREDICATES
;;===========================================================================


;;===========================================================================
(defun applied-op-is-for-top-priority-goal (applied-op)
  ;; actually, it's an instantiated op
;;  (format t "~%         Applied-op: ~S" applied-op)
  (let ((top-level-goals (inst-op-to-top-level-goals
			  applied-op)))
;;    (format t "~%    Top-level-goals: ~S" top-level-goals)
;;    (format t "~%     Priority goals: ~S" (mapcar #'top-priority-goal top-level-goals))

    (if (eval (cons 'or
		    ;; or should it be and?
		    (mapcar #'top-priority-goal
			    top-level-goals)))
	t
      nil)
    )
  )


;;===========================================================================

(defun literal-name-diff-from (predicate-name goal)
  (not (eq predicate-name
	   (p4::literal-name goal))))

(defun node-name-diff-from (node node-name)
  (not (eq node-name
	   (p4::nexus-name node))))

(defun inst-op-name-eq (instop name)
  (eq (p4::operator-name (p4::instantiated-op-op instop))
      name))

;;===========================================================================
;; this function returns "t" when the goal currently being
;; expanded is under the same top-level-goal as (goal)

(defun under-same-top-level-goal (goal)
  (if (eq (type-of *current-node*) 'p4::applied-op-node)
      nil
    (let ((current-top-level-goal (binding-node-to-top-level-goals *current-node*))
	  (this-goal-top-level-goal (literal-to-top-level-goals goal))
	  )
      (if (not (consp current-top-level-goal))
	  (setf current-top-level-goal
		(list current-top-level-goal)))
      (if (intersection current-top-level-goal
			this-goal-top-level-goal
			:test #'equal)
	  t
	nil)
      )))


;;===========================================================================
;; basically candidate-goal but for ALL candidates...
(defun real-candidate-goal (goal)
  (test-match-goals goal (all-candidate-goals)))

;;===========================================================================
(defun all-candidate-goals ()
  (if (not (boundp '*current-node*))
      nil
    (remove-if #'(lambda (x)(p4::goal-loop-p *current-node* x))
	       (p4::give-me-all-pending-goals
		    (give-me-a-or-b-node *current-node*)))))


;===========================================================================
;; This function returns "nil" if <goal> isn't the grand*child of a
;; top-priority-goal
;;
;; I don't believe this works as generator
;;
(defun ancestor-is-top-priority-goal (goal)
  ;; check if any of it's ancestors are top-level
  (when *debug-top-priority-goals*
    (format t "~%~&Working on current goal : ~S" goal)
    (format t "~%~&    related top-level goals: ~S" (literal-to-top-level-goals goal))
    (format t "~%~&    priority top-level goals: ~S"
	    (mapcar #'top-priority-goal
		    (literal-to-top-level-goals goal))))
  (if (eval (cons 'or
		  ;; or should it be and?
		  (mapcar #'top-priority-goal
			  (literal-to-top-level-goals goal))))
      t
    nil)
  )


;;============================================================================
;; This function returns "nil" if <goal> is not a top-priority-goal.
;; Can be used as a generator if needed.
;; eg   (top-priority-goal <goal>)
;;      returns ( ((<GOAL> HAS-ITEM MMV PICKUPFAX)) ((<GOAL> HAS-ITEM KHAIGH PICKUPMAIL)) )
;; will also bind variables or return "t" if already bound.
;;
;;
(defun top-priority-goal (goal)
  (let* ((high-priority-goals (top-priority-goals))
	 (instantiated-top-goals (mapcar #'p4::instantiate-consed-literal
					 high-priority-goals))
	 )
    (test-match-goals goal instantiated-top-goals)))

;;===========================================================================
;;FROM MANUELA
;;; ***********************************************************
;;; Following the subgoaling structure up to top-level goals
;;; (see page 51 yellow research note book)
;;; top-level goals are returned as a list of LITERAL structures
;;; ***********************************************************

(defun flatten-literals (litlist)
  (cond	((typep litlist 'p4::literal)
	 (list litlist))
	((null litlist)
	 nil)
	((and (listp litlist)
	      (member (car litlist) '(~ not)))
	 (list litlist))
	((listp litlist)
	 (append (flatten-literals (car litlist))
		 (flatten-literals (cdr litlist))))
	(t
	 (format t  "~%Something strange: ~S" litlist))))

	
(defun literal-to-top-level-goals (literal)
  (let ((result nil)
	(top-level-goals (nested-literal-to-top-level-goals literal)))
    (flatten-literals top-level-goals))
  )


;; this will return something horribly nested occasionally.
(defun nested-literal-to-top-level-goals (literal)
  (let ((intro-inst-ops (p4::literal-goal-p literal)))
    (cond
     ((and (= (length intro-inst-ops) 1)
	   (eq (p4::operator-node-name
		(p4::instantiated-op-op
		 (car intro-inst-ops)))
	       'p4::*finish*)
	   (list literal)))
     (t
      (mapcar
       #'binding-node-to-top-level-goals
       (mapcar
	#'p4::instantiated-op-binding-node-back-pointer
	(p4::literal-goal-p literal)))))))

(defun binding-node-to-top-level-goals (binding-node)
  (operator-node-to-top-level-goals
   (p4::binding-node-parent binding-node)))

(defun operator-node-to-top-level-goals (operator-node)
  (goal-node-to-top-level-goals
   (p4::operator-node-parent operator-node)))

;; when goal-node 5 only has one goal, then this
;; function doesn't return a list
;; of course, if I wrap the literal in a list,
;; then i get too much nesting later
;; the dolist append dies when appending non-lists
(defun goal-node-to-top-level-goals (goal-node)
  (let ((intro-binding-nodes
	 (p4::goal-node-introducing-operators goal-node)))
    (cond
     ((= 1 (length intro-binding-nodes))
      (if (eq (p4::operator-node-name
	       (p4::instantiated-op-op
		(p4::binding-node-instantiated-op
		 (car intro-binding-nodes))))
	      'p4::*finish*)
	  (p4::goal-node-goal goal-node)
	(binding-node-to-top-level-goals (car intro-binding-nodes))))
     (t (let (g result)
	  (dolist (bn intro-binding-nodes)
		  (setf g (binding-node-to-top-level-goals bn))
		  (if (listp g)
		      (setf result (union g result))
		    (setf result (adjoin g result))))
	  result)))))


(defun applied-op-node-to-top-level-goals (applied-op-node)
  (inst-op-to-top-level-goals 
   (p4::applied-op-node-instantiated-op applied-op-node)))

(defun inst-op-to-top-level-goals (inst-op)
  (let ((res (binding-node-to-top-level-goals
	      (p4::instantiated-op-binding-node-back-pointer
	       inst-op))))
    (if (listp res) res (list res))))

;;;***********************************************************
