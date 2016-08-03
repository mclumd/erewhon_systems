;;; 1994-05-28 Rujith de Silva
;;; Various functions for manipulating the state.  They manipulate the
;;; existing state, unlike some of Prodigy's functions, which insist on
;;; creating a new set of state literals.
;;; (initial-state) modifies the state to be that at the beginning of the
;;; problem, i.e., the initial state of the problem.
;;; (state-at-node node) modifies the state to be that which existed just
;;; after the creation of the specified node.

(in-package "PRODIGY4")

(export '(;initial-state 
	  state-at-node))

;;; This file is loaded so that the monitor system can use state-at-node. [cox]



;;; Set all literals in the state to nil, i.e., de-asserted.
(defun state-nil (p-space)
  (maphash
   #'(lambda (key val)
       (maphash #'(lambda (key2 val2)
                    (setf (literal-state-p val2) nil))
                val))
   (problem-space-assertion-hash p-space)))

;;; Set the state to the initial state of the current problem.
(defun initial-state ()
  (declare (special *current-problem-space*))
  (let* ((cp (current-problem)))
    (when cp
          (state-nil *current-problem-space*) ; Set all literals to nil.

    ; And then re-initialize the literals listed in the initial state of
    ; the problem.  The following code is very close to doing (eval
    ; (problem-state cp)), but I dislike using #'eval unless truly
    ; necessary.
          (let* ((state (problem-state cp)))
            (when (and (consp state)
                       (eq (car state) 'state))
                  (let* ((sl (cadr state)))
                    (cond
                     ((eq (car sl) 'user::and)
                      (mapcar #'instantiate-consed-exp (cdr sl)))
                     ((consp (car sl))
                      (mapcar #'instantiate-consed-exp sl))
                     ((symbolp (car sl))
                      (instantiate-consed-exp sl))
                     (t
                      (error "~&Bad state in ~S.~%" sl))))))
          (fire-static-eager-inference-rules)))
  t)

;;; The given path contains a sequence of applied-op-node.  Apply them in
;;; sequence, either doing the effects of the operators, or undoing them,
;;; according to sense.  If sense is nil, signaling that the operators'
;;; effects are being undone, then undo them in reverse order (this is a
;;; useful thing to do).
(defun follow-path (path sense)
  (dolist (aop (if sense path (reverse path)))
	  ;; Added conditional [10oct97 cox]
	  (if (not (has-been-executed? aop))
	      (dolist (appl (a-or-b-node-applied aop))
		      (do-state appl sense))))
  )
  

;;; Set the state to that which existed at the specified node.  If node-now
;;; is supplied, assume that the state is currently that which existed at
;;; node-now.  Otherwise, do not assume anything about the state; just
;;; re-initialize from the initial state.
(defun state-at-node (node &optional (node-now nil node-now-supplied))
    ; Allow a little leeway in how the desired nodes are specified.
  (let* ((n (cond ((nexus-p node) node)
                  ((numberp node) (find-node node))
                  (t (error "state-at-node: ~A is not a node.~%" node))))
         (nw (cond ((not node-now-supplied) nil)
                   ((nexus-p node-now) node-now)
                   ((numberp node-now) (find-node node-now))
                   (t (error "state-at-node: ~A is not a node.~%"
                             node-now))))

    ; Get the operators applied on the path to the nodes.
         (path (path-from-root n #'applied-op-node-p))
         (path-now (when nw (path-from-root nw #'applied-op-node-p))))

    ; If the state isn't currently `at' some node, then start from the
    ; initial state.
    (unless node-now-supplied
            (initial-state))

    ; Remove any common initial segment of the two paths, so that we don't
    ; undo some operators and them immediately redo them.  Note that this
    ; works fine, even if node-now was not supplied, as path-now is then
    ; nil, and no operators are undone.
    (do ((path-now path-now (cdr path-now))
         (path path (cdr path)))
        ((or (null path-now)
             (null path)
             (not (eq (car path) (car path-now))))
    ; The paths have diverged.  So undo the operators from node-now to the
    ; point of divergence ...
         (when path-now (follow-path path-now nil))

    ; ... and then re-do the operators from the point of divergence to
    ; `node'.
         (when path (follow-path path t))))
    n))
