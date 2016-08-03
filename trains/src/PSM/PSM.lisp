;;;;   PSM
;;
;;  The PSM module manages the task-tree, which encodes the problem development so far
;; 
;;  speech act requests that relate to the task-tree (update, undo, etc) are found here
;;  as well as all the code for propagating information and solutions around the task tree.


(in-package "PSM")

;;  INITIALIZATION

(defvar *ROOT-TASK*
    (make-task :objective '(ROOT) 
	       :status :unsolved))

(defvar *ROOT-TASK-TREE*
  (create-task-tree *ROOT-TASK*))

(defvar *ROOT-NODE-NAME*
  (caar (task-tree-symbol-table *ROOT-TASK-TREE*)))

(defun init-psm nil
  (clear-psm-history)
  (init-KB)
  (push-psm *ROOT-TASK-TREE* (gensymbol 'pss) nil))

;;=============================================================================================
;;  INTERPRETING SPEECH ACTS
;;    with respect to a PSS and focus node
;;    This handles the domain-independent actions that manipulate the task tree
;;    Domain-specific acts are simply passed on to the domain reasoner after
;;    added some contextual information

(defun interpret-sa (SA pss focus-node)
  "Interpret the speech act SA wrt the problem solving state PSS and focus node FOCUS-NODE"
  (let*
      ((sa-type (car SA))
       (ST (task-tree-symbol-table pss))
       (sa-content (find-arg-in-act SA :content))
       (plan-id (find-arg-in-act SA :plan-id))
       (focus-node-name (if plan-id plan-id
			  (if (task-node-p focus-node)
			      (task-node-name focus-node)
			    (task-tree-focus pss))))
       (focus-node (get-node-by-name focus-node-name ST)))
    (if 
	(task-node-p focus-node)
	(let 
	    ((focus-task (task-node-content focus-node))
	     )
	  (case sa-type
	    ;; First we have PSM level speech acts
	    (:UPDATE-PSS    ;;  UPDATE-PSS SAs comes from the discourse level, not the user
	     ;;  This is the ONLY way the pss history gets changed.
	     (let* ((ps-state-id (find-arg-in-act SA :ps-state))
		    (parent-node (get-node-by-name (find-arg-in-act SA :parent) ST))
		    (answer (extend-pss-history sa-content ps-state-id parent-node pss)))
	       (cond 
		((symbolp answer)
		 (list 'ANSWER :RESULT '(:PSS-UPDATE :SUCCESS) :PLAN-ID answer))
		((and (listp answer) (member (car answer) '(error sorry)))
		 answer)
		(t (make-sorry-msg (format t "Extend-PSS returned illegal value: ~S" answer))))
	       ))

	    (:REJECT-SOLUTION
	     (process-reject-solution sa-content focus-node-name focus-task)
	    )
         
	    (:CONFIRM    
	     (process-confirm sa-content focus-node-name focus-task)
	     )

	    (:DELETE-PLAN 
	     (PSM-Warn "DElete-plan not implemented yet: ~S" SA))
	    
	    ;; Here we have more general speech acts that could occur at different levels.
	    (otherwise
	     (call-domain sa focus-task focus-node-name ST))

	    )) ;; end case SA-TYPE
      ;; bad plan-id
      (make-error-msg (format nil "Unknown plan id: ~S" plan-id)))
    )
  )  ;; end INTERPRET-SA


;;  calls domain reasoner and then inserts the focus node in the
;;   answer structure returned.
(defun call-domain (SA task nodename ST)
  (let ((ans (interpret-domain-SA SA task nodename ST)))
    (cond ((answer-p ans)
           (add-node-name-to-answer ans nodename))
	  ((and (consp ans) (eq (car ans) 'failure))
	   (build-impossible-answer (or (cadr ans) :i-cant-handle-disjunctions)))
	  ((and (consp ans) (member (car ans) '(error sorry)))
	   ans)
          (t (psm-warn "CALL DOMAIN: Domain reasoner did not return a legal answer:~S" ans)))))

;;===========================================================================================
;;
;;  Handling the Domain Independent actions

;;  PROCESS-REJECT-SOLUTION

(defun process-reject-solution (sa-arg focus-node-name focus-task)
  (let* ((old-soln (task-solution focus-task))
	 (objective (task-objective focus-task))
	 (key-objects (find-objects-in-constraints (get-constraints-from-act objective)))
	 (answer
	  (if old-soln
	      (let ((new-soln
		     ;;  bare reject - simply delete current soln and try another
		     (get-alternate-soln old-soln)))
	       (if (solution-set-p new-soln)
		   (build-route-answer :GOOD :GOOD 
				       (list 'update
					     (list 'task
						   :key-objects key-objects
						   :status :solved
						   :plan-id (task-plan-id focus-task)
						   :objective objective
						   :solution new-soln)))
		
		   (build-route-answer :GOOD :BAD
				     (list 'update
					   (list 'task 
						 :key-objects key-objects
						 :status :unsolved
						 :plan-id (task-plan-id focus-task)
						 :objective objective
						 :solution nil))
				     :NO-MORE-SOLUTIONS)))
	    (build-impossible-answer :cant-reject-non-solution  nil))))
	   
    (add-node-name-to-answer answer focus-node-name)
    ))

;;  PROCESS-CONFIRM
;;     If focus node is not yet accepted, then GOOD,GOOD
;;     if already accepted, it may be redundant, rated OK,GOOD (as a no-op)
;;     if private, don't accept  confirm interp

(defun process-confirm (sa-args focus-node-name focus-task)
  (let
    ((recognition-score nil)
     (reason nil))
    (cond 
     ;;  If solution found, then CONFIRM addresses the solution (and possible the goal)
     ((task-solution focus-task)
       (case (task-soln-Dstatus focus-task) 
        (:proposed (setq recognition-score :GOOD))
        (:agreed (setq recognition-score :OK))
        ((:private nil) 
	 (setq recognition-score :IMPOSSIBLE)
	 (setq reason (make-reason :MSG "Solution not proposed yet"
                                            :TYPE :impossible)))
        (otherwise 
         (psm-warn "Illegal task-soln-Dstatus: ~S" (task-soln-Dstatus focus-task))))
                                           
       (add-node-name-to-answer
        (build-route-answer recognition-score :GOOD 
		      (list 'confirm
                          (list 'task :soln-Dstatus :agreed :goal-Dstatus :goal-accepted))
		      reason)
        focus-node-name))

     ;;  If solution not yet found, then CONFIRM can only address goal
     (t 
      (case (task-goal-Dstatus focus-task) 
	(:goal-proposed
	 (add-node-name-to-answer
	  (build-route-answer :GOOD :GOOD 
			      (list 'update
				    (list 'task :goal-Dstatus :goal-accepted)))
	  focus-node-name))
        (:goal-agreed (build-answer :OK :GOOD 'noop nil))
	(otherwise
	 (build-impossible-answer
		       (make-reason :MSG "No goal or solution proposed"
                                    :TYPE :impossible)))
				     
                   
	)
      ) ;; end t
     ) ;; end cond
    )
  )
;;=============================================================================
;;=============================================================================
;;
;;    UPDATING THE TASK-TREE
;;  All updates are performed by EXTEND-PSS-HISTORY

;;   This updates the PSS-HISTORY relative to the focus-node, and
;;   names the new pss state with the ps-state-id

(defun extend-pss-history (update ps-state-id focus-node pss)
  "updates the PSS-HISTORY relative to the focus-node, and names the new pss state with the ps-state-id"
  (if (task-node-p focus-node) 
      (let* ((new-pss (make-copy-task-tree (current-pss)))
	     (update-type (car update))
	     (focus-node-name (task-node-name focus-node))
	     (args (cdr update)))
	(case update-type
	  (DECOMP
	   ;;  decomposition - add to tree and set focus to first node
	   (let
	       ((new-focus-name
		 (build-decomposition-from-descr
		  args focus-node-name new-pss)))
	     (set-focus new-focus-name new-pss)
	     (update-tree new-focus-name new-pss)
	     (push-psm new-pss ps-state-id (list focus-node-name new-focus-name))
	     new-focus-name)
	   )   ;; end DECOMP

	  ((UPDATE CONFIRM)
	   ;; update takes a single arg
	   (let* ((content (car args)))
	     ;;  update a node in the existing tree -use focus-node if :plan-id is not set in TASK structure
	     (if (and (listp content) (eq (car content) 'task))
		 (let* ((changes (cdr content))
			(node-name1 (find-arg changes :plan-id))
			(node (if node-name1 (get-node-by-name node-name1 (task-tree-symbol-table pss)) focus-node))
			(node-name (or node-name1 focus-node-name)))
		   (modify-node-content node changes new-pss)
		   (if (not (eq (task-tree-focus new-pss) node-name))
		       (set-focus node-name  new-pss))
		   (update-tree node-name new-pss)
		   (push-psm new-pss ps-state-id (list node-name))
		   node-name)
	       (psm-warn "Bad argument for update act: ~S" args))
	     )) ;; end UPDATE
	  
	  (DELETE-GOAL 
	   (delete-task focus-node-name new-pss)
	   (push-psm new-pss ps-state-id (list focus-node-name))
	   focus-node-name)
	    
	  (NOOP
	   ;;  no-op 
	   focus-node-name)
	  ) ;; end CASE UPDATE-TYPE
	)
    (make-sorry-msg "In EXTEND-PSS-HISTORY: No focus node")))

(defun build-decomposition-from-descr (args parentname task-tree)
  "Decomposes the node PARENTNAME in the task tree TASK-TREE using the decomposition in ARGS"
  (let*
      ((subtasks (mapcar #'build-task-from-descr args))
       (decomps (mapcar #'(lambda (a) (find-arg (cdr a) :decomp)) args))
       (new-focus-node (add-decomposition subtasks parentname task-tree)))
    
    ;;  Now add recursive decompositions if they are present
    (mapcar #'(lambda (node decomp)
		(if decomp
		    (build-decomposition-from-descr decomp (task-plan-id node) task-tree)))
	    subtasks decomps)
    new-focus-node))
    

(defun build-task-from-descr (descr)
  "takes a task description and builds the task structure after inserting the appropriate discourse status info"
  (if (eq (car descr) 'task)
    (let ((soln-Dstatus :proposed)
          (ans (remove-decomp-from-description (cdr  descr))))
      (apply #'make-task (append (list :soln-Dstatus soln-Dstatus :goal-Dstatus :goal-proposed)
                                 (cdr ans))))
    (psm-warn "Bad task description passed to BUILD-TASK-FROM-DESCR:~S" descr)))

(defun remove-decomp-from-description (descr)
  " This remove the :descr slot from the list and recursively builds the trak description 
of the decomposition. It returns a pair of form (list of subtasks . reduced description)"
  (when descr
    (if (eq (car descr) :decomp)
	(cons (mapcar #'build-task-from-descr (cadr descr))
	      (cddr descr))
      (let ((ans (remove-decomp-from-description (cddr descr))))
	(if (car ans)
	    (cons (car ans) (cons (car descr) (cons (cadr descr) (cdr ans))))
	  (cons nil descr))))))

;;====================================================================================
;;
;;   UPDATING THE TREE
;;
;;  Code here propagates information around the tree. There are two main types of information
;;  passed around. Solutions for subgoals are combined to compuet the solution for the parent,
;;  and status flags indicating discourse and PS status are propagated.

(defun update-tree (node-name pss)
  ;;(Format t "~%Update tree called on ~S" node-name)
  (let* ((ST (task-tree-symbol-table pss))
	 (node (if (task-node-p node-name) node-name
		 (get-node-by-name node-name ST)))
	 (pname (task-node-parent  node))
	 (pnode (get-node-by-name pname ST)))
    (update-status-flags node pname pss ST)
    ;;  If the parent node is solved, we recompute the solution (wasteful is a few cases where update is trivial)
    ;;  find PNODE again as it may have been updated.
    (setq pnode (get-node-by-name pname (task-tree-symbol-table pss)))
    (if (and (task-node-p pnode)
	     (eq (task-status (task-node-content pnode)) :solved))
	(compute-solution-from-subgoals pnode pss ST)))
  )
  
;;=====================
;;  UPDATE-STATUS-FLAGS
;;
;;   This uses propagation rules to update the status flags in a tree
;;  Rules implemented are, given node N, parent P, and children C  
;;  FROM N to parent P:
;;     goal-Dstatus(N)=goal-accepted => goal-Dstatus(P)=goal-accepted
;;     status(N)=unsolved => status(P)=unsolved
;;  FROM N to children Ci:
;;     soln-Dstatus(N)=agreed => soln-Dstatus(Ci)=agreed
;;  FROM children Ci to N:
;;     (All i .status(Ci)=solved)  => status(N)=solved
;;    
;;   Note: this is a destructive operation on the tree - make copy first if you care!

(defun update-status-flags (node pname pss ST)
  ;;(format t "~%~%Calling update-status-flags on ~S, pname is ~S~%" node pname)
  (let* ((task (task-node-content node))
	 (children (mapcar #'(lambda (x) (get-node-by-name x ST))
			   (task-node-decomposition node))))
         
    ;;  propagation up to parent. Check all conditions first an
    ;;  build up a list of changes to make at end.
    (when pname
      (let*
        ((pnode (get-node-by-name pname ST))
         (ptask (task-node-content pnode))
         (siblings (mapcar #'(lambda (x) (get-node-by-name x ST))
                          (task-node-decomposition pnode)))
         (pchanges nil))
        
        (if (and (eq (task-goal-Dstatus task) :goal-accepted)
                 (not (eq (task-goal-Dstatus ptask) :goal-accepted)))
	    (setq pchanges '(:goal-Dstatus :goal-accepted)))
	
        (cond 
	 ((eq (task-status task) :unsolved)
          (if (eq (task-status ptask) :solved)
            (setq pchanges (append '(:status :unsolved) pchanges))))
         ((and (not (eq (task-status ptask) :solved))
               (every #'(lambda (x) (eq (task-status (task-node-content x)) :solved))
                      siblings))
          (setq pchanges (append '(:status :solved) pchanges))))
	
        (if pchanges
          (set-task-and-propagate pnode pname pchanges pss))))

    ;;  propagation to the children
    (if (eq (task-soln-Dstatus task) :agreed)
       (mapcar #'(lambda (x)
                   ;;  optimize this later to avoid uncessary copying
                  (set-task-and-propagate x (task-node-name x) '(:soln-Dstatus :agreed) pss))
              children))
   ))

(defun set-task-and-propagate (node node-name changes pss)
  ;;(format t "~%Set-task-and-propagate called with ~S for changes ~S" node-name changes)
  (when changes
    (modify-node-content node changes pss)
    (update-tree node-name pss)))
  
;;=======================
;;  Propagating solutions up the tree
;;

(defun compute-solution-from-subgoals (node pss ST)
  (let* 
      ((act-type (car (task-objective (task-node-content node))))
       (children (mapcar #'(lambda (n) (get-node-by-name n ST))
			 (task-node-decomposition node)))
       (solution-sets (mapcar #'(lambda (n)
			      (task-solution (task-node-content n)))
			      children)))
    (if (every #'solution-set-p solution-sets)
	(case act-type
	  (GO (combine-GO-subplans node solution-sets))
	  (otherwise 
	   (combine-GO-subplans node solution-sets))))))
       
    

