(in-package p4)

(defun generate-bindings (node goal op)
  (declare (special *current-problem-space*))
  (let* ((abs (nexus-abs-parent node))
	 (winner (if abs (nexus-winner abs)))
	 (instop (if winner (binding-node-instantiated-op winner))))

    ;; If there is a node from the abstraction level above, that
    ;; should be the only possibility.
    (cond (instop
	   (let ((res (copy-instantiated-op instop)))
	     ;; Copy because need different back pointer
	     (setf (instantiated-op-precond res) nil)
	     (list res)))
	  (t
	   (let* ((user::*candidate-bindings*
		   (gen-candidate-bindings node op goal))
		  (instantiated-ops
		   (convert-to-instantiated-ops
		    op user::*candidate-bindings*))
		  (*abslevel* (nexus-abs-level node)))
	     (declare (special user::*candidate-bindings* *abslevel*))
	     ;; Sort by conspiracy number if the switch is on.
	     (if (problem-space-property :min-conspiracy-number)
		 (progn
		   (mapc #'compute-conspiracy-number instantiated-ops)
		   (stable-sort instantiated-ops #'<
				:key #'instantiated-op-conspiracy))
		 instantiated-ops))))))


(defun gen-candidate-bindings (node op goal)
  (let ((analogy-selected-bindings
	 (scr-select-bindings-analogy node op goal)))
    (cond (analogy-selected-bindings
	   (transform-bindings
	    (scr-reject-bindings-no-new-matcher node op analogy-selected-bindings)
	    op))
	  (t (get-all-bindings node goal op
			       (if (negated-goal-p goal)
				   (operator-del-list op)
				   (operator-add-list op)))))))




;;; returns ( (((<x> . a) (<y> . b) ...) condi) *)
(defun scr-select-bindings-analogy (node op goal)
  (let (res bindings)
    (when (rule-analogy-select-bindings-crs op)
      (do* ((crs (rule-analogy-select-bindings-crs op) (cdr crs)))
	   ((or (null crs) bindings)
	    (setf res bindings))
	(setf bindings (match-select-bindings-rule node goal op (car crs)))))
    res))

;;; returns ( (((<x> . a) (<y> . b) ...) condi) *)
(defun match-select-bindings-rule (node goal op rule)
  (declare (ignore op goal))
  (let ((matched (match-lhs (control-rule-if rule) node)))
    (when matched
      (fire-select-bindings rule matched))))

(defun fire-select-bindings (rule bindings)
  (let* ((select (fourth (control-rule-then rule)))
	 (bindings-selected
	  (mapcar #'(lambda (x) (sublis x select)) bindings)))
    (output 3 t "~%Firing select bindings ~S selecting ~S"
	    (control-rule-name rule) bindings-selected)
    bindings-selected))
    

(defun scr-reject-bindings-no-new-matcher (node op bindings)
  (scr-reject-bindings
   node op bindings (rule-reject-bindings-crs op)))

(defun scr-reject-bindings (node op bindings rules)
  (if (or (null bindings) (null rules))
      bindings
      (scr-reject-bindings node op
			   (match-reject-bindings node op (car rules) bindings)
			   (cdr rules))))

(defun match-reject-bindings (node op rule bindings)
  (let ((reject-expr (fourth (control-rule-then rule)))
	(matched (match-lhs (control-rule-if rule) node)))
    (when matched
      (output 3 t "~%Firing reject rule ~S" (control-rule-name rule))
      (dolist (rejected-bindings matched)
	(let ((offender (sublis (sublis rejected-bindings reject-expr)
				(cdr (operator-params op)))))
	  (output 3 t "~%..rejecting ~S" offender)
	  (setf bindings
		(delete-if #'(lambda (x) (same-bindings (car x) offender))
			   bindings)))))
    bindings))

(defun same-bindings (b1 b2)
  (and (set-difference b1 b2 :test #'equal)
       (set-difference b2 b1 :test #'equal)))

(defun rule-analogy-select-bindings-crs (op)
  (getf (rule-plist op) :analogy-select-bindings))

;;; transform bindings of the form ( ((<x> . a) (<y>  b) ... condi) *) to 
;;; ((a b ... condi) *).
(defun transform-bindings (bindings op)
  (let ((vars (rule-vars op))
	(res nil))
    (dolist (b bindings)
      (setf res (cons (cons (sublis b vars) nil) res)))
    res))

;;; ******************************
;;; changes to load-domain.lisp
;;; ******************************


(defun analogy-select-bindings-ctrl-rule-p (crule)
  (not (listp (fourth (control-rule-then crule)))))

;;; (getf (control-rule-plist cr) :all-tests) is a list of
;;;  (op-name all-tests-for-this-op). 
(defun build-select-binding-all-tests (p-space)
  (declare (type problem-space p-space))
  (dolist (cr (problem-space-select-bindings p-space))
    (let ((relevant-ops-names (ops-relevent-to-cr cr)))
      (cond ((null relevant-ops-names)
	     (error
	      "Can't find relevant operators for the control-rule ~S~% - ~
you should use current-ops or current-operator."
	      (control-rule-name cr)))
	    (t (if (analogy-select-bindings-ctrl-rule-p cr)
		   (dolist (op-name relevant-ops-names)
		     (setf (getf (rule-plist (rule-name-to-rule
					      op-name *current-problem-space*))
				 :analogy-select-bindings)
			   (list cr)))
		   (setf (getf (control-rule-plist cr) :all-tests)
			 (extract-all-tests-for-all-ops cr relevant-ops-names p-space))))))))

(defun form-bindings-from-goal (node goal op)
  (let ((bindings (get-all-bindings node goal op
				    (if (negated-goal-p goal)
					(operator-del-list op)
					(operator-add-list op))))
	(vars (rule-vars op)))
    (mapcar #'(lambda (x)
		(mapcar #'(lambda (y z) (cons y z)) vars x))
	    (mapcar #'car bindings))))


;;; ******************************
;;; changes to my-extract-cr.lisp
;;; ******************************

(defun find-current-ops (list-structure)
  (let ((found-ops (find-current-ops-2 list-structure)))
    (if found-ops
	found-ops
      (remove-if #'(lambda (x) (eq x '*finish*))
		 (mapcar #'rule-name (problem-space-operators *current-problem-space*))))))


(defun find-current-ops-2 (list-structure)
  (cond ((or (null list-structure)
	     (symbolp list-structure))
	  nil)
	((member (car list-structure)
		 '(user::current-op user::current-operator))
	 (if (not (strong-is-var-p (second list-structure)))
	     (cdr list-structure)))
	((member (car list-structure)
		 '(user::current-ops user::current-operators))
	 (if (not (strong-is-var-p (second list-structure)))
	     (second list-structure)))
	((or (find-current-ops-2 (car list-structure))
	     (find-current-ops-2 (cdr list-structure))))))


;;; ******************************
;;; changes to rete-match.lisp
;;; ******************************

(defun get-all-simple-tests (op)
  (let ((crs (remove-if #'analogy-select-bindings-ctrl-rule-p
			(rule-select-bindings-crs op)))
	(static (get-static-simple-tests op)))
    (do ((cr crs (cdr cr))
	 (tests (list static)
		(cons (combine-simple
		       static
		       (get-simple-tests-for-cr op (car cr)))
		      tests)))
	((endp cr) tests))))

(defun get-all-unary-tests (op)
  (let* ((static (get-static-1-tests op))
	 (crs (remove-if #'analogy-select-bindings-ctrl-rule-p
			 (rule-select-bindings-crs op))))
    (do ((cr crs (cdr cr))
	 (tests (list static)
		(cons (mapcar #'combine-static-and-cr
			      static (get-unary-tests-for-cr op (car cr)))
		      tests)))
	((endp cr)  tests))))

(defun get-all-join-tests (op)
  (let ((vars (operator-precond-vars op)))
    (unless (= (length vars) 1)
      (let* ((static (get-static-n-tests op))
	     (crs (remove-if #'analogy-select-bindings-ctrl-rule-p
			     (rule-select-bindings-crs op))))
	(do ((cr crs (cdr cr))
	     (tests (list static)
		    (cons (mapcar #'combine-static-and-cr
				  static (get-join-tests-for-cr op
								(car cr)))
			  tests)))
	    ((endp cr) tests))))))

(defun get-all-neg-simple-tests (op)
  (let ((crs (remove-if #'analogy-select-bindings-ctrl-rule-p
			(rule-reject-bindings-crs op))))
    (do ((cr crs (cdr cr))
	 (tests nil
		(cons (get-simple-tests-for-cr op (car cr)) tests)))
	((endp cr) tests))))
  
(defun get-all-neg-unary-tests (op)
  (let ((tests nil))
    (dolist (var (get-vars-for-op op))
      (let ((res nil))
	(dolist (cr (remove-if #'analogy-select-bindings-ctrl-rule-p
			       (rule-reject-bindings-crs op)))
	  (push (my-build-test-from-cr cr op nil (list var)) res))
	(push res tests)))
    tests))

(defun get-all-neg-join-tests (op)
  (let ((tests nil)
	(vars (get-vars-for-op op)))
    (dotimes (n (1- (length vars)))
      (let ((res nil))
	(dolist (cr (remove-if #'analogy-select-bindings-ctrl-rule-p
			       (rule-reject-bindings-crs op)))
	  (push
            (my-build-test-from-cr
             cr op (reverse (nthcdr (1+ n) vars)) (list (nth n vars))) res))
	(push res tests)))
    tests))

