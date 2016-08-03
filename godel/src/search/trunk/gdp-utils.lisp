(in-package :gdp)

;;;; ---------- UTILS FOR STATE PROGRESSION ---------------

;;; this function returns all bindings of the operator that achieve the goal from the current state
(defun bindings-of-operator-achieving-goal (goal current-state op)
  (let* ((std-op (standardize op)) ; standardize operator
         (pre-op (operator-preconditions std-op))
         (add-op (operator-additions std-op))
         (del-op (operator-deletions std-op))
         (head-op (operator-head std-op)))

    ;		(format t "for operator ~A : ~%" head-op)
    ;		(format t "--preconditions are : ~A ~%" pre-op)
    ;		(format t "--goal : ~A, subset result : ~A ~%" goal (subset goal current-state))

    ;; if the operator has no preconditions (i.e. the INOP operator) and 
    ;; the goal is asserted in the current state, then return op
    (if (and (null pre-op) (subset goal current-state))
      (progn
        ;				(format t "operator is ~A ~%" head-op)
        (list head-op))

      ;; now check if the op additions doesn't contain the goal predicates, then 
      ;; return nil.
      (progn
        ;				(format t "wow!! ~%")
        (if (not (goals-in-add-effects goal add-op))
          (progn
            ;						(format t "for op ~A, bindings are nil ~%" head-op)
            nil)
          (let ((all-bindings (find-satisfiers pre-op current-state)) 
                ;; all-bindings now contains all possible groundings of the preconditions of std-op
                (op-list nil))
            ;            (format t "all-bindings are ~A ~%" all-bindings)
            ;; loop over all possible groundings of std-op and check whether goal is asserted in add-effects 
            (loop for b in all-bindings do
                  (let ((grounded-add-effects (apply-substitution add-op b))
                        (grounded-head (apply-substitution head-op b)))

                    ;; Now, you have a fully grounded action with add-effects. Check if
                    ;; the action achieves (at least) a part of the goal; if so, its relevant
                    (if (intersection goal grounded-add-effects :test #'equal) 
                      (setf op-list (cons grounded-head op-list)))))


            ;; op-list now contains the actions that assert the goal from the current state
            op-list))))))

;;; this function returns all bindings of the gdr that achieve the goal from the current state
(defun bindings-of-gdr-achieving-goal (task-condition task-goal current-state gdr)
  (let* ((head (gdr-head gdr))
         (goal (gdr-goal gdr))
         (pre (gdr-preconditions gdr))
         (subgoals (gdr-subgoals gdr))
         (goal-obj (apply 'shop2.common:make-initial-state *domain* *state-encoding* (list task-goal)))
         (head-bindings (find-satisfiers goal goal-obj))
         (grounded-gdrs nil))

    ;; head-binding now contains a valid binding if gdr satisfies task-goal and nil if not.
    ;		(format t "current state : ~A ~%" (state-atoms current-state))
    ; (format t "In bogag ~A ... head-binding is ~A, pre : ~A ~%" head (length head-bindings) pre)
    (format t "head: ~A~%" head)
   	(format t "goal : ~A, task-goal : ~A ~%" goal task-goal)

    ;; if head-bindings is nil, return nil
    (if (null head-bindings)
      nil

      ;; if head-bindings is of length > 1 (something wrong since task-goal is fully ground), then error
      ;			(if (> (length head-bindings) 1)
      ;				(error "head-binding of length > 1, WRONG! ~% head-bindings : ~A" head-bindings)

      (progn
        (loop for head-binding in head-bindings do

              ;; Each of the bindings in head-bindings correspond to a different achievement
              ;; of the overall goal. Fetch this binding and apply substitution to rest
              ;; of gdr for next step, i.e. satisfying preconditions of gdr
              (let* ((partially-grounded-head (apply-substitution head head-binding))
                     (partially-grounded-pre (apply-substitution pre head-binding))
                     ;;							 (partially-grounded-subgoals (apply-substitution subgoals head-binding))
                     (pre-bindings (find-satisfiers partially-grounded-pre current-state)))
                (format t "head-binding is ~A ~%" head-binding)

                  	 (format t "After binding gdr with task-goal, bindings for pre are ~A ~%" pre-bindings)

                ;; IF pre-bindings is nil, then no bindings of gdr satisfy current-state, return nil
                (if (null pre-bindings)
                  (progn
                    ; (format t "pre-bindings for ~A is nil ~%" partially-grounded-head)
                    nil)
                  ;; if not nil, then return a list of all groundings of the gdr that achieve the goal
                  ;; and whose preconditions are satisfied in the initial state
                  (progn
                    (loop for b in pre-bindings do
                          (let ((grounded-head (apply-substitution partially-grounded-head b)))
                           	; (format t "method-head is ~A~%" grounded-head)
                            (if (not (groundp grounded-head))
                              (error "output not fully grounded!")
                              (setf grounded-gdrs (cons grounded-head grounded-gdrs)))
                            ; (format t "grounded-gdrs is ~A~%" grounded-gdrs)
                            ))))))
        (format t "in bogag, bindings are ~A ~%" grounded-gdrs)

        grounded-gdrs))))

;;; this function re-orders the actions using some tactic, FOR NOW just the identity function, later FF
(defun order-actions (a)
  a)

;;; this function re-orders the methods using some tactic, FOR NOW just the identity function, later FF
(defun order-methods (state methods task-goal)
  (let ((graph (planning-graph-init state))
        (methods-with-heur-values nil)
        (sorted-methods nil))
    ;		(let ((sort-start-time (get-internal-run-time)))
    (dolist (m methods)
      ;			(format t "considering method ~A now ... ~%" m)
      ;			(format t "subgoals are ~A ~%" (append (method-subgoals m) task-goal))
      (let* ((m-subgoals (method-subgoals m))
             (formula (append m-subgoals task-goal))
             ;							 (graph-levels (planning-graph-level graph m-subgoals)))
             (relaxed-length (planning-graph-rp-heuristic graph formula)))
        ;				(format t "value of ~A is ~A ~%" m graph-levels)
        (setf methods-with-heur-values (cons (make-method-value :m m 
                                                                :value relaxed-length)  
                                             methods-with-heur-values))))
    ;			(format t "time for sorting is ~A ~%" (/ (float (- (get-internal-run-time) sort-start-time)) internal-time-units-per-second)))
    ;		(format t "length of sorted-list before sorting is ~A ~%" (length methods-with-heur-values))
    ;		(format t "sorted list : ~A ~%" methods-with-heur-values)

    ;; at this point, methods-with-heur-values contains list of all methods and their 
    ;; heuristic values. Must now prune out all methods with INFINITY as heuristic value
    ;; since the subgoals of these methods are unreachable from the current state
    (setf methods-with-heur-values 
          (remove-if (lambda (m-with-val)
                       (format t "for method ~A, value is ~A ~%" m-with-val (method-value-value m-with-val))
                       (eq (method-value-value m-with-val) 'INFINITY))
                     methods-with-heur-values))

    (setf methods-with-heur-values (stable-sort methods-with-heur-values (lambda (m1 m2)
                                                                           (< (method-value-value m1) (method-value-value m2)))))
    ;		(format t "length of sorted list is ~A, actual list ~A ~%" (length methods-with-heur-values) (length methods))
    (dolist (m methods-with-heur-values)
      (setf sorted-methods (append sorted-methods (list (method-value-m m)))))

    ;		(format t "exiting order methods ... ~% ")

    sorted-methods))

;;; After modifying the heuristic function, we can now compare actions and methods
;;; on an equal footing. Given the problem (s0, g): 
;;; -- for action a : the heuristic value is len(rpg(gamma(s0,a),g))
;;; -- for method m : the heuristic value is len(rpg(s0,g /\ sub(m)))
(defun order-options (state options task-goal)
  ;    (format t "------- ~% goal is ~A ~%" task-goal)
  (if (= 1 (length options))
    options
    (let (;(graph (planning-graph-init state))
          (options-with-heur-values nil)
          (sorted-options nil))
      ;		(let ((sort-start-time (get-internal-run-time)))
      (dolist (o options)
        ;; if o is an action, apply the first equation
        (if (primitive-op-p o)
          (let* ((state-copy (shop2.common:make-initial-state *domain*
                                                 *state-encoding*
                                                 (state-atoms state)))
                 (successor-state (apply-action-to-state state-copy o))
                 (successor-graph (planning-graph-init successor-state))
                 (relaxed-length (progn
                                   (let ((start-time (get-internal-run-time))
                                         (return-value (planning-graph-rp-heuristic successor-graph task-goal)))
                                     (setf *relevant-time* (+ *relevant-time* (/ (float (- (get-internal-run-time) start-time))
                                                                                 internal-time-units-per-second)))
                                     return-value))))
            (setf options-with-heur-values (cons (make-option-value :o o
                                                                    ; :value 1)
                                                                    :value (+ 1 relaxed-length))
                                                 options-with-heur-values)))
          ;; else, o must be a method ...
          (let* ((m-subgoals (method-subgoals o))
                 (formula ((lambda (subgoals main-goal)
                             (let ((value nil))
                               (loop for x in subgoals do
                                     (setf value (append value x)))
                               ;                               (append value task-goal)))
                               value))
                           m-subgoals task-goal))
                 ;               							 (graph-levels (planning-graph-level graph m-subgoals)))
                 (relaxed-length (progn
                                   ;                                   (format t "before heuristic, formula is ~A ... ~%" formula)
                                   (let ((start-time (get-internal-run-time))
                                         (return-value (planning-graph-rp-heuristic-simple *planning-graph* 
                                                                                           state 
                                                                                           formula))) 
                                     ;*state-changed-p*)))
                                     (setf *relevant-time* (+ *relevant-time* (/ (float (- (get-internal-run-time) start-time))
                                                                                 internal-time-units-per-second)))
                                     return-value))))
            ;          (format t "formula in order-options is ~A ~%" formula)
            ;				(format t "value of ~A is ~A ~%" m graph-levels)
            (setf options-with-heur-values (cons (make-option-value :o o 
                                                                    :value relaxed-length)  
                                                 options-with-heur-values))
            (setf *state-changed-p* nil))))
      (setf options-with-heur-values 
            (remove-if (lambda (m-with-val)
                         ;                           (format t "for method ~A, value is ~A ~%" m-with-val (method-value-value m-with-val))
                         (eq (option-value-value m-with-val) 'INFINITY))
                       options-with-heur-values))

      ;              (format t "~% options with heuristic values are : ~% ~A ~%~%" options-with-heur-values)

      (setf options-with-heur-values (stable-sort options-with-heur-values (lambda (m1 m2)
                                                                             (< (option-value-value m1) (option-value-value m2)))))
      (dolist (o options-with-heur-values)
        (setf sorted-options (append sorted-options (list (option-value-o o)))))
      sorted-options)))

;;; Overview :
;;;		This function combines bindings-of-operator-achieving-goal and bindings-of-gdr-achieving-goal
;;;		to return all options for a given task in a given state. 
;;;	Notes :
;;;		NONE.
;;;	Return Value :
;;;		list of options, i.e. either action heads or method heads
(defun option-list-for-task (task-node current-state)
  (let ((task-goal (second (task-node-contents task-node)))
        (task-condition (first (task-node-contents task-node)))
        (methods (domain-methods *domain*))
        (operators (domain-operators *domain*))
        (applicable-methods nil)
        (applicable-actions nil)
        (output1 nil)
        (output2 nil)
        (not-use-heuristic nil))

    ;    (format t "task-goal is ~A ~%" task-goal)
    ;    (format t "state is ~A ~%" (state-atoms current-state))
    ;    (format t "difference is ~A" (set-difference task-goal (state-atoms current-state) :test #'equal))

    ;; remove all parts of the goal already asserted in the current state
    (setf task-goal (set-difference task-goal (state-atoms current-state) :test #'equal))
    ;    (format t "leftover goals are ~A ~%" task-goal)

    ;; first calculate all the applicable actions whose preconds are satisfied in 
    ;; the current state and which achieve the task goal
    (maphash
      (lambda (key value)
        (setf applicable-actions (append applicable-actions (bindings-of-operator-achieving-goal task-goal 
                                                                                                 current-state 
                                                                                                 value))))
      operators)

    ;		(format t "applicable ops are ~A ~%" applicable-actions)

    ;; then calculate all applicable methods whose preconds are satisfied in 
    ;; the current state and whose goal unifies with the task goal
    (maphash
      (lambda (key value)
        (setf applicable-methods 
              (append applicable-methods (bindings-of-gdr-achieving-goal task-condition 
                                                                         task-goal 
                                                                         current-state 
                                                                         value))))
      methods)

    ;		(format t "applicable ops are ~A ~%" applicable-actions)
    ;				(format t "applicable methods before ordering are ~A ~%" applicable-methods)
    ;		(let ((ff-start-time (get-internal-run-time)))
    ;			(setf applicable-methods (order-methods current-state applicable-methods task-goal))
    ;			(format t "rpg took ~A seconds ~%" (/ (float (- (get-internal-run-time) ff-start-time)) internal-time-units-per-second)))
    ;		(format t "applicable methods are ~A ~%" applicable-methods)

    ;		(format t "actions are ~A, methods are ~A~%" applicable-actions applicable-methods)

    ;   (format t "use-heuristic is ~A~%" *use-heuristic*)

    (setf not-use-heuristic (not *use-heuristic*))

    (if nil
      (progn
        (setf output1 (append applicable-actions applicable-methods)))
      (progn
        ;        (format t "applying heuristic ... *use-heuristic* : ~A ~%" *use-heuristic*)
        (setf output1 (append applicable-actions (order-options current-state applicable-methods task-goal)))))

    output1))

;;;;-----------------------GDR accessors------------------------;;;;

(defun gdr-head (gdr)
  (second gdr))

(defun gdr-goal (gdr)
  (caddr gdr))

(defun gdr-preconditions (gdr)
  (cadddr gdr))

(defun gdr-subgoals (gdr)
  (cadddr (cdr gdr)))

(defun make-gdr (head goal pre subgoals)
  (list ':gdr head goal pre subgoals))

(defun print-contents-from-child-list (task-list)
  (loop for x in task-list do
        (format t "--contents are ~A ~%" (task-node-contents x))))

;;;;---------------- TASK UTILS ---------------------

;;; I don't understand what this function is doing here. Its not used
;;; anywhere; don't see which representation of tasks is it using. 
;;; This function returns the goals from the task
(defun goals-from-task (task)
  (let ((goals (cdr (second task))))
    (cons goals nil)))

;;; The tasks function here is an accessor from the 'problem' class. 
(defun goal-list-from-problem (problem)
  (format t "tasks outputs : ~A~%" (shop2::tasks problem))
  (let ((task-list (cdr (shop2::tasks problem)))
        (goals nil))
    (dolist (task task-list)
      (setf goals (append goals (list (cdr task)))))
    goals))

;;; OVERVIEW:
;;;   This function returns the goal formula contained in the task node.
;;; RETURN VALUE:
;;;   g = (p1 p2 ... pn)
(defun goals-from-task-node (task-node)
  (second (task-node-contents task-node)))

;;; Overview :
;;;		This function makes a copy of the task node. Not a deep copy, but a shallow one.
;;; Notes :
;;;		NONE.
;;; Return Value : 
;;;		a copy of the task
(defun copy-task-node (task)
  (let ((node-contents-copy (task-node-contents task))
        (parent-task-copy (task-node-parent-task task))
        (child-list-copy (task-node-child-list task)))
    (make-task-node :contents node-contents-copy :parent-task parent-task-copy :child-list child-list-copy)))

;;; Overview :
;;;		Constructs task-list out of goal-list with 'task' as the parent task
;;;		for each task in task-list. 
;;;	Notes :
;;;		NONE.
;;;	Return Value : 
;;;		list of tasks
(defun get-task-list-from-goal-list (goal-list task)
  ; (format t "goal-list in gtlfgl is ~A ~%" goal-list)
  ;  (list (make-task-node :contents (list nil goal-list) :parent-task task :child-list nil)))
  (if (null goal-list)
    nil
    (cons (make-task-node :contents (list nil (car goal-list)) :parent-task task :child-list nil)
          (get-task-list-from-goal-list (cdr goal-list) task))))

;;; Prints out task-list in a legible manner. Useful for debugging. 
(defun pretty-print-task-list (task-list)
  (format t "(")
  (loop for x in task-list do
        (format t "~A " (second (task-node-contents x))))
  (format t ")~%"))

;;;; ------------------- METHOD UTILS ----------------------

;;; Overview :
;;;		This function gets the full method object from the grounded head
;;; Notes : 
;;;		NONE.
;;;	Return Value : 
;;;		grounded method object
(defun get-method-object-from-head (m-head)
  (let* ((methods (domain-methods *domain*))
         (ungrounded-method (gethash (car m-head) methods))
         (subs (unify (gdr-head ungrounded-method) m-head)))
    (if (eq subs 'shop2.unifier::fail)
      (error "Unable to unify in get-method-object-from-head") ; ~A with ~A in get-method-object-from-head ~%" ungrounded-method m-head)
      (let ((grd-goal (apply-substitution (gdr-goal ungrounded-method) subs))
            (grd-pre (apply-substitution (gdr-preconditions ungrounded-method) subs))
            (grd-sub (apply-substitution (gdr-subgoals ungrounded-method) subs)))
        (make-gdr m-head grd-goal grd-pre grd-sub)))))

;;;; ------------------ ACTION UTILS ------------------------

;;; Overview :
;;;		This function tests whether the given operator is a primitive one or a non-primitive one.
;;; Notes : 
;;;		This assumes that there can exist no operators and methods with the same names. 
;;; Return Value : 
;;;		T if primitive operator, nil if not.
(defun primitive-op-p (op)
  (let ((operators (domain-operators *domain*))
        (methods (domain-methods *domain*))
        (name (first op)))
    (if (gethash name operators)
      t
      (if (gethash name methods)
        nil
        (error "name ~A doesn't exist in either ops or methods!" name)))))

;;; Same as primitive-op-p, but does not terminate with an error
;;; if op is neither an operator or a method. 
(defun action? (op)
  (let ((operators (domain-operators *domain*))
        (methods (domain-methods *domain*))
        (name (first op)))
    (if (gethash name operators)
      t
      nil)))

;;; Overview : 
;;;		These functions are helpers to 'bindings-of-operator-achieving-goal'. Checks whether the 
;;;		predicates in the goal are present in the add effects.
;;;	Return Value :
;;;		nil if not present, t if present
;;;	NOTES :
;;;		NONE.
(defun goals-in-add-effects (goals add-effects)
  ;; if no more goals are left to check, return TRUE
  (if (null goals)
    t
    ;; if more, then check if both the first goal is present and the remaining 
    ;; are (recursively).
    (and (goal-predicate-in-add-effects (car goals) add-effects)
         (goals-in-add-effects (cdr goals) add-effects))))

(defun goal-predicate-in-add-effects (goal add-effects)
  (if (null add-effects)
    nil
    (if (equal (car goal) (car (car add-effects)))
      t
      (goal-predicate-in-add-effects goal (cdr add-effects)))))

;;;; ----------------- STATE UTILS ---------------------------

;;; Overview : 
;;;		This function applies a subplan to a state and returns the resulting state
;;;	Notes :
;;;		DESTRUCTIVELY modifies the state argument
;;;	Return : 
;;;		The modified state object
(defun apply-plan-to-state (state plan)
  (if (null plan)
    state
    (let ((new-state (apply-action-to-state state (car plan))))
      (apply-plan-to-state new-state (cdr plan)))))

;;; Overview :
;;;		This function applies an action to a state and returns resulting state
;;;	Notes :
;;;		DESTRUCTIVELY modifies state argument
;;;	Return :
;;;		Modified state object
(defun apply-action-to-state (state action)
  (let* ((operators (domain-operators *domain*))
         (op (gethash (first action) operators))
         (subs (unify (shop2:operator-head op) action))
         (adds (apply-substitution (shop2:operator-additions op) subs))
         (dels (apply-substitution (shop2:operator-deletions op) subs)))
    ;		(format t "for ~A, adds are : ~A, dels are : ~A ~%" action adds dels)
    (loop for p in dels do
          (delete-atom-from-state p state 0 op))
    (loop for p in adds do
          (add-atom-to-state p state 0 op))
    state))

;;; Takes a list of objects in the problem and sets global variable
;;; *problem-objects* 
;(defun defobjects (objects)
;	(setf *problem-objects* (cons ':objects objects))
;	(format t "HAHA! ~A ~%" *problem-objects*))

;;; Gets a list of constants from the state object
(defun get-objects-from-state (state)
  (get-objects-from-state-helper (state-atoms state) nil))

(defun get-objects-from-state-helper (atoms objects)
  (if (null atoms)
    (remove-duplicates objects :test #'equal)
    (let ((a (car atoms)))
      (cond
        ((not (listp a)) (get-objects-from-state-helper (cdr atoms) objects))
        ((eq (car a) 'not) (get-objects-from-state-helper (cons (cdr a) atoms) objects))
        ((= (length a) 1) (get-objects-from-state-helper (cdr atoms) objects))
        (t (get-objects-from-state-helper (cdr atoms) (append objects (cdr a))))))))

(defun state-objects (current-state)
  (let ((atoms (state-atoms current-state))
        (objects nil))
    ;		(format t "atoms : ~A ~%" atoms)
    (dolist (x atoms)
      (setf objects (append objects (cdr x))))
    (remove-duplicates objects :test #'equal)))





