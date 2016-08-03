(in-package 'p4)
(export 'build-partial)


;;; ***********************************************
;;;
;;;  Generating a partial order from a total order
;;;
;;;     Manuela Veloso, SCS, CMU, March 1990.
;;;
;;; ***********************************************

;;; A total order is viewed as a sequence of actions.
;;; We call this sequence, a plan.
;;; The steps in the total order are related to
;;; some of the other steps but not necessarily
;;; to all of the other steps.
;;; Therefore there is a partially ordered sequence of
;;; dependencies embedded in the given total order.
;;; The plan steps relate to each other through:
;;;     - preconditions as the facts necessary
;;;       to be true before the step is applied,
;;;     - add-list as the new facts added by
;;;       performing the step, hence true after it,
;;;     - del-list as the facts that are deleted
;;;       by performing the step, hence not true
;;;       after the step is applied.

;;; ***********************************************
;;; Change log
;;; aperez  4-14-1993
;;; In the initial call to reachable-p, the value of step has to be 0
;;; (instead of 1) so we can remove a transitive edge between s and
;;; *finish*. Such an edge exists if some of the top-level goals are
;;; true in the initial state). Another solution could be just remove
;;; that edge (as it is always transitive if there is at least one
;;; other op in the plan).
;;;
;;; aperez 5-20-1993
;;; Changed `~ to 'user::~
;;;
;;; aperez 5-20-1993
;;; When processing the initial state, consider the literals that are
;;; NOT in the state, as some ops (in particular inference rules) may
;;; have negated preconditions.
;;;
;;; ***********************************************

(defvar *partial-graph* nil)
(defvar *literals-hash* nil)
(defvar *talkp* nil)

;;; ***********************************************

;; Build-partial gets arguments
;;    - plan - the total order as a list of actions
;;             or operators.
;;    - state - the initial situation, e.g. a list
;;             of literals defining the initial state.
;;

(defun build-partial (plan state)
  (let* ((operators (cons 's plan))
	 (dim (length operators))
	 (real-ops (cdr operators)))
    (setf *partial-graph* (make-array (list dim dim) :initial-element 0))
    (setf *literals-hash* nil)
    (setf *literals-hash* (make-hash-table :test #'equal))
    (process-operators (reverse real-ops) operators (length real-ops))
    (process-initial-state state)
    
    (setf *partial-graph* 
	  (remove-cycles *partial-graph* (1+ (length real-ops))))
    (links *partial-graph* (length operators))
    *partial-graph*))

;;; ***********************************************

;; Each operator or step of the plan is processed.

(defun process-operators (ops all-ops pos-op)
  (cond
   ((null ops) nil)
   (t
    (if *talkp* (literals-hash))
    (if *talkp* (links *partial-graph* (length all-ops)))
    (if *talkp*
	(format t "~%~% Processing op ~S: ~S"
		pos-op (get-plan-step-name (car ops))))
    (process-preconds pos-op (get-op-preconds (car ops)))
    (process-adds pos-op (get-op-adds (car ops)))
;    (process-dels pos-op (get-op-dels (car ops)))
    (process-dels
     pos-op (get-needed-dels
	     all-ops pos-op (get-op-dels (car ops))))
    (process-operators (cdr ops) all-ops (1- pos-op)))))


;;; ***********************************************

;; *literals-hash* is an hash table, with key a literal
;; and value a list of three values, the list of 
;; the positions of the ops that need the literal,
;; the position of the last op that added the literal,
;; and the position of the last op that deleted it.
;; Example
;; in the 2objs rocket-problem -
;; with the plan: s, load1, load2, move, unload1, unload2, f
;; after back-processing load1:
;;           key   - (at ROCKET locA)
;;           value - ((1 2 3) nil 3)

(defun process-preconds (pos preconds)
  (if (null preconds)
      (setf (aref *partial-graph* 0 pos) 1)
    (dolist (precond preconds)
      (let* ((literal-values (gethash precond *literals-hash*))
	     (del-op (if literal-values (third literal-values) nil)))
	(cond
	 (literal-values
	  (setf (gethash precond *literals-hash*)
		(append (list (cons pos (car literal-values)))
			(cdr literal-values)))
	  (if del-op
	      (setf (aref *partial-graph* pos del-op) 1)))
	 (t
	  (setf (gethash precond *literals-hash*)
		(list (list pos) nil nil))))))))

(defun process-adds (pos adds)
  (dolist (add adds)
    (let* ((literal-values (gethash add *literals-hash*))
	  (need-ops (if literal-values (car literal-values) nil)))
      (when literal-values 
	(setf (gethash add *literals-hash*)
	      (append (list nil pos nil)))
	(dolist (need-op need-ops)
	  (setf (aref *partial-graph* pos need-op) 1))))))

(defun process-dels (pos dels)
  (dolist (del dels)
    (let* ((literal-values-pos (gethash del *literals-hash*))
	   (add-op (if literal-values-pos (second literal-values-pos) nil)))
      (if add-op
	  (setf (aref *partial-graph* pos add-op) 1))
      (setf (gethash del *literals-hash*)
	    (append (list (car literal-values-pos) nil pos))))
    (let* ((literal-values-neg (gethash (list 'user::~ del) *literals-hash*))
	   (need-ops (if literal-values-neg (car literal-values-neg) nil)))
      (if need-ops
	  (dolist (need-op need-ops)
	    (setf (aref *partial-graph* pos need-op) 1))))))

;;; ***********************************************

(defun process-initial-state (state)
  (dolist (literal state)
    (let* ((literal-values (gethash literal *literals-hash*))
	  (need-ops (if literal-values (car literal-values) nil)))
      (if literal-values 
	  (dolist (need-op need-ops)
	    (setf (aref *partial-graph* 0 need-op) 1)))))
   (process-initial-state-negated-lits state))

(defun process-initial-state-negated-lits (state)
  ;;find all negated literals that are true in the state (therefore
  ;;they are not in "state"), from the hash-table
  (maphash
   #'(lambda (key val)
       (if (and (listp key) (eq (car key) 'user::~)
		(not (member (second key) state :test #'equal)))
	   ;;do the dirty
	   (dolist (need-op (car val))
	     (setf (aref *partial-graph* 0 need-op) 1))))
   *literals-hash*))

;;; ***********************************************

(defun remove-cycles (graph dim)
  (let ((newgraph graph))
    (do ((i (1- dim) (1- i)))
	((eq i -1) newgraph)
      (do ((j 0 (1+ j)))
	  ((eq j dim) newgraph)
	(if (eq (aref newgraph i j) 1)  ;exists direct edge from i to j
	    (if (check-reachable-p newgraph i j dim)
		(setf (aref newgraph i j) 0) ;found an indirect path
		(setf (aref newgraph i j) 1) ;leave direct edge
		))))))

(defun check-reachable-p (graph i j dim)
  (setf (aref graph i j) 0)
  ;;aperez april 14 1993
  ;;the first arg of reachable-p has to be 0 (see change log above)
  ;;(reachable-p 1 (list i) j graph dim)
  (reachable-p 0 (list i) j graph dim))

(defun reachable-p (step reached target graph dim)
  (cond
   ((eq step dim) nil)
   ((null reached) nil)
   ((member target reached) t)
   (t
    (reachable-p (1+ step)
		 (linked-to reached graph dim) target graph dim))))

(defun linked-to (nodes graph dim)
  (let ((res nil))
    (dolist (node nodes)
      (setf res (remove-duplicates 
		 (append (links-one-node node graph dim) res))))
    res))

(defun links-one-node (node graph dim)
  (let ((res nil))
    (do ((j 0 (1+ j)))
	((eq j dim) res)
      (if (eq (aref graph node j) 1)
	  (setf res (cons j res))))))

;;; *****************************************************

(defun literals-hash ()
  (maphash #'(lambda (key val)
	       (format t "~% Literal: ~S ~S" key val))
	   *LITERALS-HASH*)
  (format t "~%"))

(defun links (graph dim)
  (format t "~%")
  (do ((i 0 (1+ i)))
      ((eq i (1- dim)) graph)
    (if (zerop i)
	(format t "~% Op 0 (start) goes to ")
	(format t "~% Op ~S goes to " i))
    (do ((j 0 (1+ j)))
	((eq j dim) graph)
      (if (eq (aref graph i j) 1)
	  (format t "~S " j))))
  (format t "~%"))

;;; *****************************************************

(defun get-needed-dels (all-ops pos-op dels)
  (let ((already-linked-ops (map 'list #'(lambda (x)
					   (nth x all-ops))
				 (get-links pos-op)))
	(remaining-dels nil))
    (dolist (del dels)
      (if (some #'(lambda (x) (member del (get-op-adds x)
				      :test #'equal))
		already-linked-ops)
	  nil
	  (push del remaining-dels)))
    remaining-dels))


;;; *****************************************************

(defun get-links (pos-op)
  (let ((links nil))
    (dotimes (i (car (array-dimensions *partial-graph*)))
      (if (not (zerop (aref *partial-graph* pos-op i)))
	  (push i links)))
    links))

;;; *****************************************************    

