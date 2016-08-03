;;; *********************************
;;; Manuela Veloso - March 1997
;;; Information in a friendly format for execution
;;; *********************************
;;; Data structures
;;; *********************************

(defstruct problem-plan
  (name nil)
  (state nil)
  (goal nil)
  (plan nil) ;list of plan steps
)
  
(defstruct plan-step
  (name nil)
  (preconds nil)     ; List of preconds
  (adds nil)         ; List of assertions added
  (dels nil)         ; List of assertions deleted
  (cost 1)           ; cost of plan step
)

;;; *********************************
;;; Save problem and solution plan to file
;;; *********************************

(defun save-visible-problem-plan (filename)
  (with-open-file (ofile filename :direction :output
			 :if-exists :rename-and-delete
			 :if-does-not-exist :create)
    (setf *print-case* :downcase)
    (get-solution-path)
    (format ofile "~%(setf *v-~S*" (p4::problem-name (current-problem)))
    (format ofile "~%  (make-problem-plan ~%    :name '~S" (p4::problem-name (current-problem)))
    (format ofile "~%    :state '~S" (get-list-of-lits (p4::problem-state (current-problem))))
    (format ofile "~%    :goal '~S" (get-list-of-lits (p4::problem-goal (current-problem))))
    (format ofile "~%    :plan (list")
    (dolist (node (cdr *solution-path*))
      (case (type-of node)
	(p4::applied-op-node
	 (format ofile "~%      (make-plan-step :name '~S"
		 (get-visible-inst-op
		  (p4::op-application-instantiated-op
		   (car (p4::a-or-b-node-applied node)))))
	 (format ofile "~%                      :preconds '~S"
		 (mapcar #'get-visible-goal
		  (get-list-of-lits
		   (p4::binding-node-instantiated-preconds
		    (p4::instantiated-op-binding-node-back-pointer 
		     (p4::a-or-b-node-instantiated-op node))))))
	 (format ofile "~%                      :adds '~S"
		 (mapcar #'get-visible-goal
			 (p4::op-application-delta-adds 
			  (car (p4::a-or-b-node-applied node)))))
	 (format ofile "~%                      :dels '~S"
		 (mapcar #'get-visible-goal
			 (p4::op-application-delta-dels 
			  (car (p4::a-or-b-node-applied node)))))
	 (format ofile "~%      )"))
	(t
	 nil)))
    (format ofile "~%)))")))

;;; *********************************

(defun set-equal (l1 l2)
  (and (subsetp l1 l2 :test #'equal)
       (subsetp l2 l1 :test #'equal)))

(defun perfrom-action-p (plan-step state)
  (subsetp (plan-step-preconds plan-step) state :test #'equal))
   
(defun perfrom-action (plan-step state)
  (set-difference (union state (plan-step-adds plan-step))
		  (plan-step-dels plan-step) :test #'equal))

(defun how-valid-plan (plan state)
  (let ((holes 0.0))
    (dolist (s plan)
      (cond
       ((perfrom-action-p s state)
	(setf state (perfrom-action s state)))
       (t
	(incf holes))))
    (if (zerop holes)
	1 (/ holes (length plan)))))

(defun execute-valid-plan (plan initial-state)
  (setf state initial-state)
  (dolist (s plan)
    (perfrom-action-p s state)
    (setf state (perfrom-action s state)))
  state)

(defun show-execute-plan (plan initial-state)
  (setf state initial-state)
  (format t "~%      ~S" state)
  (dolist (s plan)
    (format t "~% ~S" (plan-step-name s))
    (cond
     ((perfrom-action-p s state)
      (setf state (perfrom-action s state))
      (format t "~%      ~S" state))
     (t
      (format t "~% Cannot execute action.")
      (return)))))

;;; *********************************
;;; Needs to have just solved a problem before
;;; *********************************

(defun get-solution-path ()
  (setf *solution-path* 
	(p4::path-from-root
	 (cdr (prodigy-result-interrupt *prodigy-result*)))))

;;; *********************************
;;; Shows plan - needs to have called get-solution-path before
;;; just names of operators
;;; *********************************

(defun get-visible-plan ()
  (let* ((plan (mapcan
		#'(lambda (node)
		    (if (p4::a-or-b-node-p node)
			(nreverse (mapcar #'p4::op-application-instantiated-op
					  (p4::a-or-b-node-applied node)))))
		*solution-path*)))
    (setf *plan* (mapcar #'get-visible-inst-op plan))))

;;; *********************************
;;; Shows complete plan - needs to have called get-solution-path before
;;; names, preconds, and effects of operators
;;; *********************************

(defun get-all-plan-steps ()
  (dolist (node (cdr *solution-path*))
    (case (type-of node)
      (p4::applied-op-node
       (get-plan-step node))
      (t
       nil))))

(defun get-plan-step (applied-op-node)
  (format t "~% ~S" (get-visible-inst-op
		     (p4::op-application-instantiated-op
		      (car
		       (p4::a-or-b-node-applied applied-op-node)))))
  (format t "~% preconds: ~S"
	  (mapcar #'get-visible-goal
		  (get-list-of-lits
		   (p4::binding-node-instantiated-preconds
		    (p4::instantiated-op-binding-node-back-pointer 
		     (p4::a-or-b-node-instantiated-op applied-op-node))))))
  (format t "~% adds: ~S"
	  (mapcar #'get-visible-goal
		  (p4::op-application-delta-adds 
		   (car
		    (p4::a-or-b-node-applied applied-op-node)))))
  (format t "~% dels: ~S"
	  (mapcar #'get-visible-goal
		  (p4::op-application-delta-dels 
		   (car
		    (p4::a-or-b-node-applied applied-op-node))))))

;;; *********************************
;;; Auxiliary functions
;;; messy-rep can be of the form lit, (and lit1 lit2...),
;;; or (bla (and lit1 lit2...))
;;; it returns the list of the literals 

(defun get-list-of-lits (messy-rep)
  (cond
   ((not (listp messy-rep)) (list messy-rep))
   ((eq (car messy-rep) 'and) (cdr messy-rep))
   (t
    (get-lits-no-and messy-rep))))

;;; *********************************
;;; From my-comforts.lisp
;;; *********************************

(defun get-visible-inst-op (instop)
  (cons (p4::operator-name (p4::instantiated-op-op instop))
	(list-args-names (p4::instantiated-op-values instop))))


(defun list-args-names (objects)
  (mapcar #'(lambda (obj)
	      (cond ((p4::prodigy-object-p obj)
		     (p4::prodigy-object-name obj))
		    (t obj)))
	  objects))

(defun get-visible-goal (literal)
  (let* ((lit-name (p4::literal-name literal))
	 (lit-args-list (sv-to-list (p4::literal-arguments literal)))
	 (visible-goal (list lit-name)))
    (dolist (arg lit-args-list)
      (if (p4::prodigy-object-p arg)
	  (push (p4::prodigy-object-name arg) visible-goal)
	  (push arg visible-goal)))
    (reverse visible-goal)))

(defun sv-to-list (vector)
  ;;converts a simple vector into a list
  (declare (type vector simple-vector))
  (do ((index 0 (+ 1 index))
       (list nil (append list (list(svref vector index)))))
      ((= index (array-dimension vector 0) ) list)))

(defun get-lits-no-and (messy-rep)
  (let ((lits (cdr messy-rep)))
    (if (eq (caar lits) 'and)
	(setf lits (cdr (car lits))))
    lits))

;;; *********************************      
