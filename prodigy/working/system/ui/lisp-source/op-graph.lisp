;;;
;;; Build an operator graph as a way of visualizing the domain
;;;
;;; Jim Blythe, 3/96

;;; Create nodes for predicates with arities (ignore types for now),
;;; and for operators. Have an arrow from a positive predicate to an
;;; operator that adds it (respectively for negative and deletes), and
;;; from an operator to anything in its preconditions.

;;; This is a handy top-level function, that creates the graph and
;;; prints it to a file that dag can read.

(defun dagfile-op-graph (&optional (filename "/tmp/tmp.dag"))
  (with-open-file (out filename :direction :output
		       :if-does-not-exist :create
		       :if-exists :rename-and-delete)
		  (dag-op-graph (make-op-graph)
				:stream out)))

;;; If the UI is loaded, this one also calls the dag routine to make a
;;; graph that the UI can parse
(defun ui-make-op-graph (dagfile picfile)
  (dagfile-op-graph dagfile)
  (excl:run-shell-command
   (format nil "~A/dagshell ~A ~A" *prod-ui-home* dagfile picfile)))
	   

;;; The graph is returned as a list of pairs, where one element is a
;;; rule and one is a predicate + truth-value + arity.

(defun make-op-graph ()
  (let ((res nil))
    (dolist (op (p4::problem-space-operators *current-problem-space*))
      (setf res (append res (add-links-from-op op))))
    (dolist (op (p4::problem-space-lazy-inference-rules *current-problem-space*))
      (setf res (append res (add-links-from-op op))))
    (dolist (op (p4::problem-space-eager-inference-rules *current-problem-space*))
      (setf res (append res (add-links-from-op op))))
    res))

;;; Print it in a form DAG can process.
(defun dag-op-graph (graph &key (stream t)
			   (pointsize nil) (width 7) (height 10))
  (let ((*print-case* :downcase))
    (format stream ".GS ~S ~S fill~%" width height)
    (if pointsize
	(format stream "draw nodes pointsize ~S;~%" pointsize))
    ;; pre-process the graph for all rules.
    (dolist (rule (get-all-rules graph))
      (format stream "draw ~S as Box;~%" (el-rep rule)))
    (dolist (link graph)
      (format stream "~S ~S;~%"
	      (el-rep (first link)) (el-rep (second link))))
    (format stream ".GE~%")))

;;; Print it in a form KrackPlot can process.
;;; For this, I make a list of the nodes and use it to write an
;;; adjacency matrix.
(defun kp-op-graph (graph &key (stream t))
  (let ((*print-case* :downcase)
	(nodes (list-nodes graph)))
    (format stream "~S !nc~%" (length nodes))
    ;; Give each node an appropriate type
    (dolist (node nodes)
      (format stream "~S ~S~%" (el-rep node)
	      (if (p4::rule-p node) 'step 'pred)))
    ;; This is the slow part
    (dolist (node nodes)
      (dolist (other-node nodes)
	(if (member (list node other-node) graph :test #'tree-equal)
	    (format stream "1")
	  (format stream "0")))
      (terpri stream))
    ))

;;; Find the subgraph consisting of only children of the given node.
;;; This is done with a depth-first search from the node. The
;;; representation makes this inefficient, but the graphs are
;;; typically small (oil-events has 200 nodes).
;;; Example: (child-subgraph (list 'unprotected-sensitive-area 1) graph)

(defun child-subgraph (node graph)
  (do ((visited nil)
       (inlinks nil)
       (to-visit (list node))
       (thisnode nil))
      ((null to-visit) inlinks)
    (setf thisnode (pop to-visit))
    ;;(format t "checking ~S~%" thisnode)
    (push thisnode visited)
    ;; Add every link from this node to the graph, add children to the
    ;; list to-visit unless they are already in visited.
    (dolist (link graph)
      (when (equal (first link) thisnode)
	(unless (member link inlinks :test #'tree-equal)
	  ;;(format t "   adding ~S~%" link)
	  (push link inlinks))
	(unless (or (member (second link) visited  :test #'equal)
		    (member (second link) to-visit :test #'equal))
	  (push (second link) to-visit))))))



;;;
;;; MAKING THE GRAPH
;;;

(defun add-links-from-op (op)
  (append (add-links-from-preconds
	   op (third (p4::rule-precond-exp op)) t)
	  (add-links-to-effects op (third (p4::rule-effects op)))))

(defun add-links-from-preconds (op expr positive?)
  (cond ((null expr) nil)
	((or (eq (car expr) 'and) (eq (car expr) 'or))
	 (mapcan #'(lambda (x) (add-links-from-preconds op x positive?))
		 (cdr expr)))
	((eq (car expr) '~)
	 (add-links-from-preconds op (second expr) (not positive?)))
	((or (eq (car expr) 'forall) (eq (car expr) 'exists))
	 (add-links-from-preconds op (third expr) positive?))
	(t (list (make-link op (make-pred expr positive?))))))

(defun add-links-to-effects (op effects)
  (mapcan #'(lambda (effect)
	      (cond ((eq (car effect) 'add)
		     (list (make-link (make-pred (second effect) t) op)))
		    ((eq (car effect) 'del)
		     (list (make-link (make-pred (second effect) nil) op)))
		    ((eq (car effect) 'if)
		     (add-links-to-effects op (cddr effect)))))
	  effects))

(defun make-link (from to) (list from to))

(defun make-pred (pred sense) (list (car pred) sense (length (cdr pred))))



(defun el-rep (element)
  (cond ((p4::rule-p element) (p4::rule-name element))
	((listp element)
	 (intern (format nil "~A~S/~S"
			 (if (second element) "" "Not_")
			 (first element) (third element))))))

(defun get-all-rules (graph)
  (let ((res nil))
    (dolist (link graph)
      (mapcar #'(lambda (node)
		  (if (p4::rule-p node) (pushnew node res)))
	      link))
    res))

(defun list-nodes (graph)
  (let ((res nil))
    (dolist (link graph)
      (mapcar #'(lambda (node)
		  (unless (member node res :test #'equal)
		    (push node res)))
	      link))
    res))
