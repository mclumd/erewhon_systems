;;====================================================================================
;;
;;     STRUCTURES FOR THE PROBLEM SOLVING STATE
;;
;;====================================================================================

(in-package "PSM")

;;   The problem solving state is maintained as a series of task-trees that
;;   maintain a linear history of the development of the task throughout the
;;   dialogue.  If nothing else, this provides us with an unlimited UNDO operation,
;;   but I expect it to be useful for other uses as we move along.

;;   The TASK-TREE structure

;;(defstruct TASK-TREE
;;  root                 ;;  the root node
;;  focus                ;;  the focus node of the tree
;;  leaf-cache           ;;  cache for leaf nodes
;;  symbol-table         ;;  symbol table for node reference
;;)


;;   The TASK-NODE structure
 
;;(defstruct TASK-NODE
;;  name                 ;;  this task node's symbol table name
;;  content              ;;  a task structure
;;  decomposition        ;;  an ordered list of subtask node names (if any)
;;  parent               ;;  the supertask node name
;;)


;;   The TASK structure

;;(defstruct task
;;  objective           ;;  the goal being pursued (an act-type and the hard constraints)
;;  filter
;;  preference-function         ;;  the evaluation criteria
;;  key-objects         ;;  list of important objects involved in this task (currently just the engine)
;;  Soft-Constraints    ;;  list of violatable constraints (i.e., preferences)
;;  solution            ;;  an solution-set structure 
;;  status              ;;  problem solving status: must be one of :achieved, :impossible, :unsolved, :solved
;;  goal-Dstatus        ;;  goal discourse status: must be one of :goal-proposed, :goal-accepted, :goal-provate
;;  soln-Dstatus        ;;  solution discourse status: only relevant when status=:solved
                      ;;       must be one of :agreed, :proposed, :private
;;  )



;;========================================
;;
;;  TREE SYMBOL TABLE MANAGEMENT FOR NODES
;;
;;  A symbol table maps node names to nodes, allowing for efficient updates to trees.

(defun add-node (name node node-table)
  (setq node-table (cons (cons name node) node-table)))

(defun get-node-by-name (name node-table)
  (cdr (assoc name node-table)))
  
;;======================
;;   TREE-MAP FUNCTIONS

;;  General syntax for tree map functions
;;   {MAP- | FIND-IN-} {TREE- | LEAF-} {CONTENT | NODE)
;;   consequences of choices:
;;    1. MAP- returns an answer for all tested nodes
;;       FIND-IN- only returns non-null answers
;;    2. TREE- searches entire tree
;;       LEAF- searches leaf nodes only
;;    3. CONTENT - applies test to content of node
;;       NODE - applies test to node

;;  Basic mapping function over task trees, with test made on CONTENT of node
;;   returns a list of answers - one for each node in left-to-right depth-first order

(defun map-tree-content (task-tree fn)
  (if (task-tree-p task-tree)
    (map-by-content (task-tree-root task-tree) 
                    (task-tree-symbol-table task-tree) 
                    fn)))

;;  like map-task-tree-content, but returns only the non-null answers

(defun find-in-tree-content (task-tree fn)
  (if (task-tree-p task-tree)
    (delete-if #'null (map-by-content (task-tree-root task-tree) 
                                      (task-tree-symbol-table task-tree) 
                                      fn))))

;;  These are a variants of the mapping fns 
;;  that check only the content of leaf nodes
;;  because of caching, this can be faster than a standard map-tree.

(defun map-leaf-content (task-tree fn)
  (mapcar fn (mapcar #'task-node-content (task-tree-leafs task-tree))))

(defun find-in-leaf-content (task-tree fn)
  (find-in fn (mapcar #'task-node-content (task-tree-leafs task-tree))))

;;  The same mapping functions but test is made on NODE rather than content

(defun map-tree-node (task-tree fn)
  (if (task-tree-p task-tree)
    (map-by-node (task-tree-root task-tree)
              (task-tree-symbol-table task-tree)
              fn)))

;;  like map-task-tree, but returns only the non-null answers

(defun find-in-tree-node (task-tree fn)
  (if (task-tree-p task-tree)
    (delete-if #'null (map-by-node (task-tree-root task-tree) 
                                (task-tree-symbol-table task-tree)
                                fn))))

;; mapping over leaf nodes

(defun map-leaf-node (task-tree fn)
  (mapcar fn (task-tree-leafs task-tree)))

(defun find-in-leaf-node (task-tree fn)
  (if (task-tree-p task-tree)
    (find-in fn (task-tree-leafs task-tree))
    (psm-warn "Bad arg to FIND-IN-LEAF-NODE: first arg must be a TASk TREE: ~S" task-tree)))

;;  here's the actual tree traversal functions
;;   MAP-BY-NODE is the most general function, and does tests on nodes

(defun map-by-node (node ST fn)
  (cons (apply fn (list node))
        (flatten-answers 
         (mapcar #'(lambda (x) (map-by-node (get-node-by-name x ST) ST fn))
                 (task-node-decomposition node)))))

;;  MAP-BY-CONTENT  test on the content of the node only
(defun map-by-content (node ST fn)
  (cons (apply fn (list (task-node-content node)))
        (flatten-answers 
         (mapcar #'(lambda (x) (map-by-content (get-node-by-name x ST) ST fn))
                 (task-node-decomposition node)))))

;;  uses nconc to convert a list of lists into a list
(defun flatten-answers (answer-list)
  (if (null answer-list) 
    nil
    (nconc (car answer-list)
            (flatten-answers (cdr answer-list))))) 

;;  STANDARD LIST MAP deleting NULL answers - probably a built-in function that does this

(defun find-in (fn ll)
  (delete-if #'null
             (mapcar fn ll))) 

(defun task-tree-leafs (task-tree)
  (let ((ST (task-tree-symbol-table task-tree)))
    (mapcar #'(lambda (x) (get-node-by-name x ST))
            (task-tree-leaf-cache task-tree))))

;;=================
;;
;;  COPYING, UPDATING, TASK-TREEs
;;


;; CREATING a new TASK TREE
(defun create-task-tree (root-task)
  (let*  ((rootname (gensymbol 'R))
          (root-node (make-task-node :name rootname
                                     :content root-task)))
    (make-task-tree :root rootname
                    :leaf-cache (list rootname)
                    :focus rootname
                    :symbol-table (list (cons rootname root-node)))))

;;  COPYING a TASK TREE
(defun make-copy-task-tree (task-tree)
  (if (task-tree-p task-tree)
    (make-task-tree :root (task-tree-root task-tree)
                    :focus (task-tree-focus task-tree)
                    :leaf-cache (task-tree-leaf-cache task-tree)
                    :symbol-table (task-tree-symbol-table task-tree))))
 
;;  DESTRUCTIVELY adds a LEAF node to a TASK-TREE
(defun add-leaf-to-tree (node parentname task-tree)
  (add-decomposition (list node) parentname task-tree))


;;  ADD-DECOMPOSITION
;;   Given a list of tasks and a node, it DESTRUCTIVELY  extends the task-tree by adding
;;   each task as a subnode.
;;   It returns the name of the first node of the decomposition, which is often the new focus

(defun add-decomposition (task-list parentname task-tree)
  (if (and (task-list-p task-list) (task-tree-p task-tree))
    (let* ((ST (task-tree-symbol-table task-tree))
           (parent (get-node-by-name parentname ST))
	   (current-decomposition (task-node-decomposition parent))
           (newnodes (mapcar #'(lambda (x)
                                 (setup-new-node x parentname))
                             task-list))
           (newnames (mapcar #'task-node-name newnodes))
           (new-ST-entries (mapcar #'(lambda (x y) (cons x y)) newnames newnodes)))
      ;; check that this has not already been done
      (if (null (intersection current-decomposition newnames))
	  (let nil
	    ;; update the leaf cache for tree
	    (setf (task-tree-leaf-cache task-tree)
	      (append newnames (remove-if #'(lambda (x) (eq x parentname)) 
					  (task-tree-leaf-cache task-tree))))

	    ;;  add new definition of parent to ST, plus defn of new nodes.
	    (setf (task-tree-symbol-table task-tree)
	      (append new-ST-entries
		      (cons (cons parentname (add-subnode parent newnames))
			    (task-tree-symbol-table task-tree))))
	    (car newnames))
	(psm-warn "Attempting to add decomposition twice: request ignored: ~S" (list task-list parentname task-tree))))

     (psm-warn "Bad args to ADD-DECOMPOSITION: ~S" (list task-list  parentname task-tree))))

(defun task-list-p (task-list)
  (or (null task-list)
      (and (consp task-list)
           (task-p (car task-list))
           (task-list-p (cdr task-list)))))

;;  SETUP-NEW-NODE 
;;   defines a name for the node and sets its parent slot
(defun setup-new-node (task parentname)
      (make-task-node :name (task-plan-id task)
                      :content task
                      :parent parentname))


;;  add-subnode creates a new copy of supernode with the new decomposition
(defun add-subnode (supernode nodenames)
  (make-task-node :name (task-node-name supernode)
                  :parent (task-node-parent supernode)
                  :decomposition (append nodenames (task-node-decomposition supernode))
                  :content (task-node-content supernode)))

;; delete-subnode
(defun delete-subnode (nodename supernode)
  (make-task-node :name (task-node-name supernode)
                  :parent (task-node-parent supernode)
                  :decomposition (remove-if #'(lambda (x) (eq x nodename))
					    (task-node-decomposition supernode))
                  :content (task-node-content supernode)))

;;  SET-FOCUS
;;
;;  this DESTRUCTIVELY updates the FOCUS node in a TASK TREE
;;    it accepts either the name of a task or the task-node.

(defun set-focus (task-id task-tree)
  (cond 
   ((task-tree-p task-tree)
    (if (task-node-p task-id)
      (setq task-id (task-node-name task-id)))

    (if (symbolp task-id)
      (setf (task-tree-focus task-tree) task-id)
      (psm-warn "Bad task-id passed to SET-FOCUS: ~S" task-id)))
   (t (psm-warn "Bad task-tree passed to SET-FOCUS: ~S" task-tree))))


;;  MODIFY-NODE-CONTENT
;;   This DESTRUCTIVELY modifies the content of a node in the current tree

(defun  modify-node-content (node changes task-tree)
  (let ((nodename (task-node-name node)))
    (setf (task-tree-symbol-table task-tree)
          (cons (cons nodename
                      (make-task-node :name nodename
                                      :content (make-modified-task (task-node-content node)
                                                                   changes)
                                      :parent (task-node-parent node)
                                      :decomposition (task-node-decomposition node)))
                (task-tree-symbol-table task-tree)))))

(defun make-modified-task (task changes)
  (let ((slot-defs nil))
    ;;  check each slot and set either from changes list or from old task
    (mapcar #'(lambda (name)
                (if (member name changes)
                  (setq slot-defs (cons name (cons (find-value-in-list name changes) slot-defs)))
                  (setq slot-defs (cons name (cons (get-task-slot task name)
                                                   slot-defs)))))
          '(:objective :filter :preference-function :key-objects :plan-id
            :Soft-Constraints :status :goal-Dstatus :soln-Dstatus))
    ;;  solution is treated differently as we want to record the name of the solution set on the symbol table
    ;;  for later reference
    
    (if (member :solution changes)
	(let ((solution-set (find-value-in-list :solution changes)))
	  (if (solution-set-p solution-set)
	      (declare-an-object (solution-set-name solution-set) :solution-set solution-set))
	  (setq slot-defs (cons :solution (cons solution-set slot-defs))))
      (setq slot-defs (cons :solution (cons (get-task-slot task :solution) slot-defs))))
    ;; now build the task
    (apply #'make-task slot-defs)))

(defun get-task-slot (task name)
  (case name 
    (:objective (task-objective task))
    (:filter (task-filter task))
    (:preference-function (task-preference-function task))
    (:key-objects (task-key-objects task))
    (:Soft-Constraints (task-soft-constraints task))
    (:solution (task-solution task))
    (:status (task-status task))
    (:goal-Dstatus (task-goal-Dstatus task))
    (:soln-Dstatus (task-soln-Dstatus task))))

;; given a list of form (name val nam val ...)
;;  returns the val that follows the indicated name
 
(defun find-value-in-list (name val-list)
  (if (null val-list) nil
      (if (eq (car val-list) name)
        (cadr val-list)
        (find-value-in-list name (cddr val-list)))))

;;   DELETING NODES
;;   Deletes the node named NAME from the TASK-TREE
;;   NB: Destructive update of TASK-TREE

(defun delete-task (name task-tree)
  (if (eq name (task-tree-root task-tree))
      (PSM-warn "Trying to delete root node!" name)
    (let* 
	((ST (task-tree-symbol-table task-tree))
	 (node (get-node-by-name name ST))
	 (parent (task-node-parent node)))
      
      ;; update the node
      (if (eq name (task-tree-focus task-tree))
	  (setf (task-tree-focus task-tree) nil))
      (setf (task-tree-leaf-cache task-tree)
	(remove-if #'(lambda (x) (eq x name))
		   (task-tree-leaf-cache task-tree)))
      
      ;;  set node to NIL on symbol table and update parent
      (setf (task-tree-symbol-table task-tree)
	  (append
	   (list (cons name nil) 
		 (cons parent (delete-subtask name (get-node-by-name parent ST))))
	   (task-tree-symbol-table task-tree)))
      ;;  propagate properties through tree
      ;;  we do this by picking a still existing subnode of parent and starting there
      ;;   this is needed as the information alwasy propgates up the tree.
      (let ((subnode (car (task-node-decomposition (get-node-by-name parent (task-tree-symbol-table task-tree))))))
	(if subnode
	    (update-tree subnode task-tree))))))

(defun delete-subtask (name parent-node)
  "This deletes old solution information and removes the subtask from the tree"
  (let ((old-content (task-node-content parent-node)))
  (delete-subnode name
		  (make-task-node :name (task-node-name parent-node)
				  :content (make-task :plan-id (task-plan-id old-content)
						      :objective (task-objective old-content)
						      :filter (task-filter old-content)
						      :preference-function (task-preference-function old-content)
						      :status :unsolved ;; set to UNSOLVED to force recomputation of solution
						      :goal-dstatus (task-goal-dstatus old-content)
						      :soln-dstatus (task-soln-dstatus old-content))
				  :decomposition (task-node-decomposition parent-node)
				  :parent (task-node-parent parent-node)))))
;;=====================================================================================
;;
;; PRINTING TASK TREES
;;
;;

(defun print-task-tree (task-tree)
  (when (task-tree-p task-tree)
    (format t "~%TREE IS")
    (print-and-traverse 1 (task-tree-root task-tree) (task-tree-symbol-table task-tree))
    (format t "~%with FOCUS ~S" (task-tree-focus task-tree))))

(defun print-and-traverse (level nodename ST)
  (let* ((node (get-node-by-name nodename ST))
         (decomp (task-node-decomposition node)))
    (format t "~%")
    (print-blanks level)
    (print-node node)
    (mapcar #'(lambda (x) (print-and-traverse (+ 1 level) x ST))
            decomp)))

(defun print-node (node)
  (let* ((c (task-node-content node))
         (soln (task-solution c)))
    (format t "~S: TASK=~S STAT=~S,~S,~s"  (task-node-name node) 
            (task-objective c) (task-status c) (task-goal-Dstatus c) (task-soln-Dstatus c))
    (when soln
      (let ((exec-trace (solution-set-execution-trace soln)))
	(if (null exec-trace)
	    (format t "~%                   ERROR: no execution trace specified")
	  (if (equal (task-objective c) '(root))
	      (format t ". DURATION=~S. COST=~S" 
		      (schedule-duration exec-trace)
		      (schedule-cost exec-trace))
	    (format t "~%    SOLN=~A" 
		    (if *PSM-TRACE-VERBOSE* 
			exec-trace
		      (format nil "<duration=~S. cost=~S. plan=~S>" 
			      (schedule-duration exec-trace)
			      (schedule-cost exec-trace)
			      (mapcan #'extract-sched-info (schedule-states exec-trace)))))))))))

(defun extract-sched-info (item)
  (let ((state (schedule-item-state item)))
    (cond 
     ((not (eq (car state) 'doing))
      (if (= (Schedule-item-end-time item) (schedule-item-start-time item))
	  (list state)
	(list (append  state (list 'delay  (- (Schedule-item-end-time item) (schedule-item-start-time item)))))))
     ((schedule-item-delay-flag item)
      (list (list state 'delay (schedule-item-delay-flag item))))
     (t (list)))))
	   
	  
(defun print-blanks (n)
  (when (> n 0)
    (format t "  ")
    (print-blanks (- n 1))))
  

;;====================
;;
;;   The ANSWER structure
;;
;;  All responses from the domain reasoners, and all responses generated
;;   from the problem solving manager are in terms of the ANSWER structure,
;;   which is easily accessable with the functions defined here

;;  ANSWERS are evaluated in 2 dimensions, coherence and confidence in success
;;    Recognition-score captures notions of whether the intent of the request makes sense in context
;;    Answer-score captures how well the system performed the requested act
;;       
;;  These are independent as seen in the following examples: you can combine any non-impossible
;;  example of recognition-score with any example of the answer-score. An example of each
;;  is given in response to an example request to show a weather map for an area X.

;;  Recognition-Score
;;       :GOOD e.g., displaying a weather map of X is an expected step of the current task
;;       :OK   e.g., displaying a weather map of X was not expected, but is compatible with the current task
;;       :BAD e.g., displaying a weather map is possible but serves no purpose in the current task (mapybe area X isn't involved in the current task)
;;       :IMPOSSIBLE e.g., either system does not understand what the action is begin requested,
;;                or the action does not make sense in the current task (in fact, the task might involve not doing the action)
;; Answer-score 
;;       :GOOD: e.g., returns weather map info for area X
;;       :OK    e.g., returns weather map for an area larger than X
;;       :BAD    e.g., returns map but does not cover all of desired area
;;       :IMPOSSIBLE  e.g., weather map server is down so request cannot be accomodated


;;(defstruct ANSWER
;;  Recognition-score  ;; the recognition-score
;;  Answer-score       ;; The answer score
;;  psm-update         ;;  The update act that will install this is the PSS
;;  Result             ;;  the result of the request, passes info back to caller about display updates, etc.
;;  Reason             ;;  a list of REASONS
;;  node-name          ;;  the name of the node that answer is based on 
;;)

(defun score-p (x) (member x '(:GOOD :OK :BAD :IMPOSSIBLE)))

(defvar *impossible-answer*
  (make-answer :recognition-score :IMPOSSIBLE :answer-score :IMPOSSIBLE
               :result nil :reason nil))

(defun build-impossible-answer (reason-type &optional reason-info)
  (make-answer :recognition-score :IMPOSSIBLE :answer-score :IMPOSSIBLE
               :reason (if (reason-p reason-type)
			   reason-type
			 (make-reason :type reason-type :info reason-info))))
  
;; This builds the answer structure with optional reaons - which may either be a REASON structure
;;   or the reason-type and reason-info

(defun build-answer (recognition-score answer-score update result &optional reason-type reason-info)
  (if (and (score-p recognition-score) (score-p answer-score))
      (if reason-type
        (make-answer :recognition-score recognition-score
                     :answer-score answer-score
		     :psm-update update
                     :result result
                     :reason (if (symbolp reason-type)
				 (make-reason :type reason-type :info reason-info)
			       reason-type))
        (make-answer :recognition-score recognition-score
                     :answer-score answer-score
		     :psm-update update
                     :result result
                     ))
      (let nil
        (psm-warn "Bad answer format: ~s:"
                  (list :recognition-score recognition-score
                        :answer-score answer-score
			:psm-update update
                        :reason (list reason-type reason-info)
                        :result result))
        *impossible-answer*)))

(defun add-node-name-to-answer (answer nodename)
  (if (null (answer-node-name answer))
      (setf (answer-node-name answer) nodename))
  answer)
             
(defun find-goal (constraints)
  (let ((from-to (find-constraint constraints :FROM-TO)))
    (if from-to
      (second from-to)
      (find-constraint constraints :TO))))

(defun downgrade-recognition-score (answer reason)
  (setf (answer-recognition-score answer)
        (case (answer-recognition-score answer)
          ((:GOOD :OK) :OK)
	  (:BAD :BAD)
          (:IMPOSSIBLE :IMPOSSIBLE)))
  (setf (answer-reason answer)
    (if (answer-reason answer)
      	(list :and reason (answer-reason answer))
      reason))
  answer)

(defun downgrade-answer-score (answer reason)
  (setf (answer-answer-score answer)
        (case (answer-answer-score answer)
          ((:GOOD :OK) :OK)
	  (:BAD :BAD)
          (:IMPOSSIBLE :IMPOSSIBLE)))
  (setf (answer-reason answer)
    (if (answer-reason answer)
      	(list :and reason (answer-reason answer))
      reason))
  answer)


;;  given a list of ansers, returns the ones with the best recognition score
;;   with equal recognition scores, the answer score is used.


(defun find-best-answers (answers)
  (if (every #'answer-p answers)
      (sort-answers-with-fn answers #'>=)
    answers))

(defun find-worst-answers (answers)
  (sort-answers-with-fn answers #'<=))

(defun sort-answers-with-fn (answers fn)
  (let* ((ans
	 (stable-sort 
	  (sort (copy-list answers) fn :key #'(lambda (x) 
						  (convert-to-numb (answer-answer-score x))))
	  fn :key  #'(lambda (x) 
			(convert-to-numb (answer-recognition-score x)))))
	 (best-recog-score (answer-recognition-score (car ans)))
	 (best-answer-score (answer-answer-score (car ans))))
    (remove-if-not #'(lambda (a)
		       (and (eq (answer-recognition-score a) best-recog-score)
			    (eq (answer-answer-score a) best-answer-score)))
		   ans)))


		    
(defun convert-to-numb (score)
  (case score
    (:GOOD 4)
    (:OK 3)
    (:BAD 2)
    (:IMPOSSIBLE 1)))



;;(defstruct REASON
;;  Msg
;;  Type               ;; the type of reason 
                     ;;      one of :FAILED-PRECONDITION,:UNSATISFIED-SUBGOAL, :UNSATISFIED-CONSTRAINT
                     ;;          :NEEDS-CONFIRMATION, :IMPOSSIBLE, :UNDOES-SATISFIED-GOAL
;;  Info               ;; determined by the type: e.g., for FAILED-PRECONDITION it is the precondition
;;)


;;=======================================================================================
;;
;;   THE PROBLEM SOLVING STATE
;;
;;=======================================================================================

(let
    ((psm-history nil))

  (defun push-psm (pss id changes)
    (push (list id pss changes) psm-history)
    )
  
  (defun undo-psm (id)
    (let ((pss (get-pss-by-name id)))
      (if pss
	  (let 
	      ((changes (gather-changes-from-psm-history id)))
	    (push-psm pss id (get-pss-changes-by-name id))
	    changes)
	(let ((changes (current-pss-changes)))
	  (if (> (length psm-history) 1)
	      (let nil
		(setq psm-history (cdr psm-history))
		changes)
	    (make-error-msg (format nil "Attempt to undo original start state")))))))
  
  (defun current-pss nil
    (second (car psm-history)))
  
  (defun current-pss-id nil
    (first (car psm-history)))
  
  (defun current-pss-changes nil
    (third (car psm-history)))
  
  (defun get-pss-by-name (id)
    (cadr (assoc id psm-history))) 
  
  (defun get-pss-changes-by-name (id)
    (third (assoc id psm-history)))

  (defun psm-history nil
    psm-history)

  (defun clear-psm-history nil
    (setq psm-history nil))
  
  (defun backup-psm-history (id)
    (if (assoc id psm-history)
	(setq psm-history  (clear-up-to id psm-history))
      (PSM-Warn "Tried backing up to non-existent state:~S" id)))

  ;; removes everything after the ID pss
  (defun clear-up-to (id history)
    (if (eq id (caar history))
	history
      (clear-up-to id (cdr history))))

)

(defun gather-changes-from-psm-history (id)
  (let ((answer (gather-changes id (psm-history))))
    (delete-if #'(lambda (x) (eq x *ROOT-NODE-NAME*)) (delete-duplicates answer))))
     
(defun gather-changes (id psm-history)
  (when psm-history
    (if (eq id (caar psm-history))
	nil
      (append (third (car psm-history)) (gather-changes id (cdr psm-history))))))

;;==============
;;==============
;;  OTHER STUFF NEEDED

(defun gensymbol (n)
  (if (symbolp n) (setq n (symbol-name n)))
  (intern (symbol-name (gensym n))))
