;;; File: node.lisp
;;; Author: Jim Blythe
;;; Created: Feb 3 91
;;; Last modified: Feb 3 91
;;;
;;; Notes: Copied from Dan Kahn's version but extended for some of the
;;; things Manuela mentioned.

;;; $Revision: 1.7 $
;;; $Date: 1995/10/12 14:23:08 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: node.lisp,v $
;;; Revision 1.7  1995/10/12  14:23:08  jblythe
;;; Added protection nodes as a node type and search strategy, turned on with
;;; the variable *use-protection* (off by default). Also added the "event"
;;; macro which accepts similar syntax to operators. The new file "protect.lisp"
;;; has the protection code.
;;;
;;; Revision 1.6  1994/05/30  20:56:22  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.5  1994/05/30  20:30:33  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


(in-package "PRODIGY4")

(defstruct (nexus (:print-function nexus-print))
           (name 0 :type fixnum)
	   (abs-level 0 :type fixnum)
	   (abs-parent nil)
	   (abs-children nil)
	   (open-node-link nil)
	   (parent nil)
	   (children nil)
	   (plist nil))

(defmacro nexus-conspiracy-number (node)
  `(getf (nexus-plist ,node) :consp-num))

(defmacro nexus-winner (node)
  `(getf (nexus-plist ,node) 'winning-child))

(defun nexus-print (nexus stream z)
  (declare (type nexus nexus)
	   (stream stream)
	   (ignore z))

  (let ((*standard-output* stream))
    (princ "#<")
    (princ (type-of nexus))
    (princ " name ")
    (princ (nexus-name nexus))
    (princ ">")))


(defstruct (goal-node (:include nexus) (:print-function print-goal-node))
	   goal				; literal structure
	   goals-left			; alternative goals
	   applicable-ops-left		; alternative applies
	   introducing-operators	; binding-nodes that need this
					; goal
	   (ops-left :not-computed)	; alternative operators to
					; achieve it
	   (positive? t))		; whether this is a positive
					; or negative goal

(defun print-goal-node (node stream z)
  (declare (type goal-node node)
	   (stream stream)
	   (ignore z))
  (begin-node node stream "GOAL-NODE")
  (unless (goal-node-positive? node)
      (princ "~ " stream))
  (princ (goal-node-goal node) stream)
  (princ ">" stream))

(defstruct (operator-node (:include nexus) (:print-function print-operator-node))
           operator
	   ops-left
	   (bindings-left :not-computed))

(defun print-operator-node (node stream z)
  (declare (type operator-node node)
	   (stream stream)
	   (ignore z))
  (begin-node node stream "OPERATOR-NODE")
  (princ (operator-node-operator node) stream)
  (princ ">" stream))
  

;;; This extra level is useful because of the way I organise the
;;; search routines.
(defstruct (a-or-b-node (:include nexus))
  (pending-goals nil)
  (goals-left :not-computed)		; nil would mean no goals-left
  (applicable-ops-left :not-computed)
  (protections-left :not-computed)
  (applied nil)				; A list of application structures
  instantiated-op			; The primary reason for the node.
  justification-table)			; currently an assoc list.

;;; An application represents applying an instantiated operator. Every
;;; applied-op node has at least one, but all a-or-b-nodes can have
;;; more than one, because of multiple firing of inference rules. Much
;;; of this stuff used to be in the applied-op-node

(defstruct (op-application (:print-function print-application))
  instantiated-op
  binding-node				; Nil if eager rule.
  (delta-adds nil)			; Lists of assertions changed
  (delta-dels nil))			; when applying this operator

(defun print-application (appl stream z)
  (declare (type op-application appl)
	   (stream stream)
	   (ignore z))
  (princ "#<Application of " stream)
  (princ (op-application-instantiated-op appl) stream)
  (princ ">" stream))

;;; Disjunction-path is a list of the choices made as you read the
;;; preconditions from left to right and hit "or"s. Backtracking will
;;; be done by incrementing the choice from the bottom up. This
;;; creates a new binding node that shares the following fields:
;;; instantiated-preconds, instantiated-op.
(defstruct (binding-node (:include a-or-b-node)
			 (:print-function print-a-or-b-node))
	   instantiated-preconds
	   (disjunction-path :no-preference))		; See above.

(defstruct (applied-op-node (:include a-or-b-node)
			    (:print-function print-a-or-b-node)))

(defun print-a-or-b-node (node stream z)
  (declare (type a-or-b-node node)
	   (stream stream)
	   (ignore z))
  (begin-node node stream (symbol-name (type-of node)))
  (princ (a-or-b-node-instantiated-op node) stream)
  (princ ">" stream))

;;; New node to introduce goal protection. Some of the fields of a
;;; normal a-or-b-node aren't included: for instance
;;; justification-table. instantiated-op refers to the op whose
;;; preconditions are being altered at this node to protect the goal
;;; (referred to in the goal field).

(defstruct (protection-node (:include a-or-b-node)
			    (:print-function print-protection-node))
  goal					; the goal protected
  ;; the old instantiated preconds for the instantiated op.
  old-preconds
  ;; the old disjunction path in the binding node that introduced the
  ;; instantiatied operator whose preconds are being augmented
  old-disjunction-path 
  ;; the new ones  (taking effect below this node)
  new-preconds
  new-delta-disjunction
  new-disjunction-path
  ;; list of the literals that become goals (or neg goals) at this point.
  new-goals)

(defun print-protection-node (node stream z)
  (declare (ignore z))
  (begin-node node stream (symbol-name (type-of node)))
  (format t "Protecting ~S from ~S>"
	  (protection-node-goal node)
	  (protection-node-instantiated-op node)))

;;; All the nodes start off looking the same. This allows me to update
;;; things like how to print abstraction levels uniformly.
(defun begin-node (node stream string)
  (princ "#<" stream)
  (princ string stream)
  (princ " " stream)
  (when (> (nexus-abs-level node) 0)
    (princ (nexus-abs-level node) stream)
    (princ "-" stream))
  (princ (nexus-name node) stream)
  (princ " " stream))
    
(defstruct (node-link (:print-function node-link-print))
           (previous :dummy)
	   (next :dummy))

(defun node-link-print (link stream z)
  (declare (type node-link link)
	   (type stream stream)
	   (ignore z))
  (princ "#<Link between: " stream)
  (princ (node-name-or-thing (node-link-previous link)) stream)
  (princ " & " stream)
  (princ (node-name-or-thing (node-link-next link)) stream)
  (princ ">" stream))

(defun node-name-or-thing (x)
;  (format t "~&Type of thing : ~S.~%" (type-of x))
;  (format t "~&Is of type nexus: ~S.~%" (typep x 'nexus))
  (finish-output)
  (if (or (typep x 'nexus) (typep x 'operator-node))
      (progn
;	(format t "~&Type of name: ~S.~%" (type-of (nexus-name x)))
	(if (typep (nexus-name x) 'node-link)

	    (format t "Yuk, a node link.~%")
	    (nexus-name x)))
      (progn
;	(format t "~&X is ~S:~%" x)
	x)))

;; The semantics of the expandable-nodes slot is the problem-space
;; structure is that it is a vector length 2.  Element 0 is the tail
;; of the double linked list of expandable nodes and element 1 is the
;; head of that list.

;; To do depth first search we will always expand the previous of the
;; list.  To do breadth first search we always expand the oldest node
;; on the least and push its new children onto the previous of the list.

;;; These macros make it easier for me to see what's going on.
(defmacro head (l) `(svref ,l 1))
(defmacro tail (l) `(svref ,l 0))


(defun push-previous (node p-space)
  (declare (type nexus node)
	   (type problem-space p-space))
  "Inserts a node on to the previous of the node list, in other words,
at the end of the list.  This is how new nodes are maintained after
they are created."

  (let ((last-and-first (problem-space-expandable-nodes p-space))
	(new-link (make-node-link)))
    (setf (nexus-open-node-link node) new-link)
    (if (tail last-and-first)		; there is a node in the list.
	(let ((ultimate-link (nexus-open-node-link (tail last-and-first))))
	  (setf (node-link-previous new-link) :dummy)
	  (setf (node-link-previous ultimate-link) node)

	  (setf (node-link-next new-link);; garbage shift it off
		(tail last-and-first))
	  (setf (tail last-and-first) node))
	;; Otherwise make this the first and last node
	(progn
	  (if (head last-and-first)
	      (error "The list of expandable nodes has a head but no tail.~%"))
	  (initialize-expandable-nodes p-space node)))
    node))


(defun pop-previous (p-space)
  (declare (type problem-space p-space))
  "Removes the previous of the expandable nodes and returns it.  This
is the LAST node in the list.  Useful for depth first search."
  
  (let* ((last-and-first (problem-space-expandable-nodes p-space))
	 (last-node (tail last-and-first)))
    (cond ((eq (tail last-and-first) (head last-and-first))
	   (setf (tail last-and-first) nil)
	   (setf (head last-and-first) nil))
	  (t
	   (let* ((ultimate-link (nexus-open-node-link last-node))
		  (penultimate-link (nexus-open-node-link (node-link-next ultimate-link))))
	   (shiftf
	    (tail last-and-first)
	    (node-link-next ultimate-link))
	   
	   (shiftf
	    (node-link-previous penultimate-link)
	    (node-link-previous ultimate-link)))))
    last-node))

  
(defun return-previous (p-space)
  (declare (type problem-space p-space))
  "Returns the previous of the expandable-nodes list without modifing~
the list.  This will always be the newest expandable node."
  (tail (problem-space-expandable-nodes p-space)))


(defun pop-next (p-space)
  (declare (type problem-space p-space))
  "Removes the next or head of the expandable nodes and returns it.
This node can be used for breadth first search."
  (let* ((last-and-first (problem-space-expandable-nodes p-space))
	 (prime-node (head last-and-first))
	 (prime-link (nexus-open-node-link prime-node)) ; head link in list
	 (second-link (nexus-open-node-link
		       (node-link-previous prime-link)))) ; link before head

    (setf (nexus-open-node-link (head last-and-first)) nil)
    
    (setf (head last-and-first)
	  (node-link-previous prime-link))

    (setf (node-link-next second-link)
	  (node-link-next prime-link))
  
    prime-node))


(defun return-next (p-space)
  (declare (type problem-space p-space))
  (head (problem-space-expandable-nodes p-space)))


(defun initialize-expandable-nodes (p-space node)
  (let ((expandable-nodes (problem-space-expandable-nodes p-space)))
    (if (not (typep expandable-nodes 'simple-vector))
	(error "~S is wrong type.~%" expandable-nodes))
    (setf (head expandable-nodes) node)
    (setf (tail expandable-nodes) node))
  (setf (nexus-open-node-link node) (make-node-link))
  node)

;;; Modified by Jim, 18/9/91, to behave well when asked to delete a
;;; node that's not really in the list. It could be argued that this
;;; case should be checked before calling delete-node-link, but I
;;; think it's more efficient to do it here.
(defun delete-node-link (node p-space)
  (let ((link (nexus-open-node-link node)))
    #|
    (format t "~%This node link is ~S~%Expandables: ~S~%This list is: "
	    link (problem-space-expandable-nodes p-space))
    (print-node-list (return-next p-space))
    (terpri)
|#
    (cond ((null link))
	  ((eq (node-link-previous link) :dummy)
	   ;; It's either at the end or not really in the list.
	   (when (eq node (return-previous p-space))
	     ;; (format t "This is at the end~%")
	     (pop-previous p-space)))
	  ((eq (node-link-next link) :dummy)
	   (pop-next p-space))
	  (t
	   (let* ((previous (node-link-previous link))
		  (next (node-link-next link))
		  (previous-link (nexus-open-node-link previous))
		  (next-link (nexus-open-node-link next)))

	     (setf (node-link-previous next-link) previous)
	     (setf (node-link-next previous-link) next)
	     (setf (nexus-open-node-link node) nil))))))

(defun print-node-list (node)
  (unless (or (null node) (eq node :dummy))
    (princ " ") (princ (nexus-name node))
    (print-node-list (node-link-next (nexus-open-node-link node)))))

(defun print-previous-list (node)
  (unless (or (null node) (eq node :dummy))
    (princ " ") (princ (nexus-name node))
    (print-node-list (node-link-previous (nexus-open-node-link node)))))
