(in-package :gdp)

;;;;----------------------------Structure Declarations-----------------------------------

;; This data structure encodes a node in the decomposition tree. Each node could be a task, in which case :
;;;; contents - (condition, goal) pair, parent-node - parent, child-list - list of subgoals
;; or an action, in which case :
;;;; contents - action, parent-node - parent, child-list - list of causal links it supports
(defstruct (task-node 
  (:print-function 
		(lambda (p s k)
			(format t "<~%contents:")
			(format t "~A" (task-node-contents p))
			(format t "~%childlist :~%")
			(print-contents-from-child-list (task-node-child-list p))
			(format t ">~%"))))
	(contents nil) ;; If primitive-task node a, then = ((a)) else ((c) (g))
  (parent-task nil)
  (child-list nil))

;;;; ------------ For FF Heuristic Function -------------------

;;; The structure for holding (method, heuristic-value) pairs. 
(defstruct method-value
  (m nil)
  (value 0))

;;; The new structure for holding (option, heuristic-value) pairs. 
(defstruct option-value
  (o nil)
  (value 0))


;; Global Variables used by GDP during its execution
(defparameter *hgn-output* nil)
(defparameter *relevant-time* 0)
(defparameter *use-heuristic* t)
(defparameter *scrambled* nil)

;; heuristic parameters
(defparameter *planning-graph* nil)
(defparameter *state-changed-p* t)
(defparameter *infinity* most-positive-fixnum)
