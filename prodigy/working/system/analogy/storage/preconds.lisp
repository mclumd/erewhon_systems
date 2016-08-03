(defvar *loaded-preconds* t)


;;*****************************************************************************
;; Print the state as it was at each node
;;*****************************************************************************
;; Daniel. Changed node for n
(defun print-states (nodes)
  (let* ( (last-node (car (last nodes)))
          (state nil))
    (dolist (n (cdr nodes))
      (when (p4::applied-op-node-p n)
        (p4::maintain-state-and-goals last-node (p4::nexus-parent n))
        
        (setf state (true-literals last-node))
        (format t "~%~S~%     ~S" n state)
        
        (p4::maintain-state-and-goals (p4::nexus-parent n) last-node)
      ) ; when
    ) ; dolist
))

;;*****************************************************************************
;;For each op-application of an applied op node, put two lists into the
;;instantiated operator's plist
;; List 1: a list of all preconditions that made the rule fire. If the variable
;;         user::*short-circuit-preconditions* is t, then only the first T
;;         term in a disjunction will be added.
;;           i.e.  (or a b c), a c true
;;               user::*short-circuit-preconditions* t   ====> (a)
;;               user::*short-circuit-preconditions* nil ====> (a c)
;;     :satisfying-preconds
;;     (#<> ...)
;; 
;; List 2: a list of all conditional effect preconditions, and their effect.
;;         See (process-effects) lower for more detail.
;;     :conditional-preconditions
;;     ( del-list-info  add-list-info )
;;           where del-list-info and add-list-info are lists returned
;;           by (process-effects)
;;*****************************************************************************
(defun set-valid-preconds (last-node app-op-node)
  (let* ((state nil))
    ;; the function is called with (p4::nexus-parent n) because we
    ;; want the state before applying the operator.
    (p4::maintain-state-and-goals last-node (p4::nexus-parent app-op-node))
    (setf state (true-literals last-node))
    
    (dolist (application (reverse (p4::applied-op-node-applied app-op-node)))
      (let* ((adds  (p4::op-application-delta-adds application))
             (dels  (p4::op-application-delta-dels application))
             (instop (p4::op-application-instantiated-op application))
             (op    (p4::instantiated-op-op instop))
             (bind  (p4::precond-bindings (p4::rule-vars op)
                                          (p4::instantiated-op-values instop))))

        ; regular preconditions
        (if (null (getf (p4::instantiated-op-plist instop)
                        :satisfying-preconds))
            (let* ((exp    (third (p4::operator-precond-exp op)))
                   (preconds (process-all-precond-list
                              (p4::substitute-binding exp bind) instop))
                   (sat-preconds (create-satisfy-list preconds state)))

              (push sat-preconds (p4::instantiated-op-plist instop))
              (push ':SATISFYING-PRECONDS (p4::instantiated-op-plist instop))))

        ; conditional effects ; car is del-effects, second is add-effects
        (if (null (getf (p4::instantiated-op-plist instop)
                        :conditional-preconditions))
            (let ((add-effects (list (process-effects op (p4::rule-add-list op)
                                                      bind instop)))
                  (del-effects (process-effects op (p4::rule-del-list op)
                                                bind instop)))
              (push (cons del-effects add-effects)
                    (p4::instantiated-op-plist instop))
              (push ':CONDITIONAL-PRECONDITIONS
                    (p4::instantiated-op-plist instop))))

        (setf state (set-difference state dels :test #'equalp))
        (setf state (union state adds :test #'equalp))
      )
    )
    (p4::maintain-state-and-goals (p4::nexus-parent app-op-node) last-node)))

;;*****************************************************************************
; Mei's function. Returns a list of literals that were true for that node.
;;*****************************************************************************
(defun true-literals (node-name &optional (literals nil))
  (declare (ignore node-name))
  (let* (temp lit-hash-tables)
    (setf lit-hash-tables
          (cond (literals
                 (remove nil
                         (mapcar #'(lambda (lit)
                                     (gethash lit
                                              (p4::problem-space-assertion-hash
                                               *current-problem-space*)))
                                 literals)))
                (t (maphash
                    #'(lambda (key val)
                        (push (gethash key
                                       (p4::problem-space-assertion-hash
                                              *current-problem-space*))
                              temp))
                    (p4::problem-space-assertion-hash *current-problem-space*))
                   temp)))
    (when lit-hash-tables
      (apply #'append
             (mapcar #'(lambda (hash-table)
                         (setf temp nil)
                         (maphash #'(lambda (key val)
                                      (if (p4::literal-state-p val)
                                          (push val temp)))
                                  hash-table)
                         temp)
                     lit-hash-tables)))))


;;*****************************************************************************
; This function is a modification of (process-list-for-one)

; Returns list of ( [ (#<>...#<>) (#<>) ] ... )
; which is each effect and its immediate conditional preconditions.

; eg: (  (    (#<NEAR A BOMB1> #<SENSITIVE A>) (#<DESTROYED A>)      )
;        (    (#<NEAR B BOMB1> #<SENSITIVE B>) (#<DESTROYED B>)      )
;        (    nil                              (#<DESTROYED BOMB1>)  ) )
; which resulted from the following expression, for which A and B satisfied
; the forall. Note that the final ADD doesn't have any conditional effects,
; and so has NIL for "conditional-preconditions"
;
; (effects ()
;   ((forall ((<x> OBJECT)) (and (near <x> <bomb>)
;                                (sensitive <x>))
;                           ( (add (destroyed <x>)) ))
;    (add (destroyed <bomb>))))
;
;;*****************************************************************************
(defun process-effects (op effects orig-binds instop)
  (let* ((res nil)
         (effect-decs (second (p4::rule-effects op)))
         (reduced-bindings (set-difference orig-binds effect-decs :key #'car)))

    (dolist (conditional-group effects)
      (let* ((conditional (p4::effect-cond-conditional (car conditional-group)))

             (bound-precond
                (cond ((eq (car conditional) 'if)
                       (k-cache-and-match (second conditional)
                                            conditional
                                            instop
                                            reduced-bindings
                                            effect-decs))
                      ((eq (car conditional) 'forall)
                       (k-cache-and-match (third conditional)
                                            conditional
                                            instop
                                            (set-difference reduced-bindings
                                                            (second conditional)
                                                            :key #'car)
                                            effect-decs))
                      (t (list (list nil reduced-bindings)))))
             (bindings nil))
        
        (dolist (pair bound-precond)
          (push (second pair) bindings))
        (setf bindings (reverse bindings)) ; to keep same order as bound-precond

        (when bindings
          (dolist (effect-cond conditional-group)
            (let* ((orig-consed-lit (p4::effect-cond-effect effect-cond))

                   (pred-head       (car orig-consed-lit))

                   (pred-body (mapcar #'(lambda (x)
                     (if (or (p4::strong-is-var-p x) (numberp x))  
                         x
                         (p4::object-name-to-object x *current-problem-space*)))
                     (cdr orig-consed-lit)))

                   (bound-vars (mapcar #'(lambda (x) (car x))
                                       (first bindings)))

                   (used-vars (mapcan #'(lambda (x)
                                          (if (p4::strong-is-var-p x)
                                              (list x)))
                                      pred-body))

                   (relevant-vars (if used-vars
                                      (p4::get-depending-vars used-vars op)))

                   (augmented-bindings (p4::form-all-bindings
                                         bound-vars relevant-vars op bindings)))

              (mapcar #'(lambda (pre-effect-pr final-binding)
                          (setf (cdr pre-effect-pr)
                                (p4::instantiate-literal
                                   pred-head
                                   (sublis final-binding pred-body))))
                      bound-precond
                      augmented-bindings)

              (setf res (append bound-precond res))
              ))) ; when
      ) ;let
    ) ;do
    res)
)

(defun k-cache-and-match (expr conditional instop partial-bindings type-decls)
  (declare (ignore conditional))
  (let ((instantiated-preconds nil))
    (dolist (bindings (p4::descend-match expr nil partial-bindings type-decls))
      (push (list (process-all-precond-list
                      (p4::substitute-binding expr bindings)
                      instop)
                  bindings)
            instantiated-preconds))
    instantiated-preconds)
)

