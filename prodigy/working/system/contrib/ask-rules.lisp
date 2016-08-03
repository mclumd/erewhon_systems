;;;
;;; This is not well commented - the main authors (mmv and ledival) didn't
;;; intend to release this, but I (jblythe) put it here in contrib because
;;; it is very useful for me and perhaps others.
;;; The control rules defined here will cause prodigy to query the user
;;; through the UI for all choice points.

;============================================================================
;; Added here form-bindings-from-goal from 
;; /afs/cs/project/prodigy-wxm/prodigy4/system/planner/modify-feb6-93
;============================================================================

(control-rule ASK-FOR-GOAL
  (if (and
       (user-prefers-goal <goal>)))
  (then prefer goal <goal> <g>))

(control-rule ASK-FOR-OPERATOR
  (if (and
       (user-prefers-operator <operator>)))
  (then prefer operator <operator> <ops>))

(control-rule ASK-FOR-BINDINGS
  (if (and 
       (user-prefers-bindings <bindings>)))
  (then prefer bindings <bindings> <bs>))


;============================================================================
(in-package 'p4) 
(defun form-bindings-from-goal (node goal op)
  (let ((bindings (get-all-bindings node goal op
    				    (if (negated-goal-p goal)
	    				(operator-del-list op)
					(operator-add-list op))))
	(vars (rule-vars op)))
        (mapcar #'(lambda (x)
		    (mapcar #'(lambda (y z) (cons y z)) vars x))
	    (mapcar #'car bindings)))) 
(in-package 'user)

(defun goal-from-literal (literal)
  (cons (p4::literal-name literal)
	(list-args-names
	 (sv-to-list (p4::literal-arguments literal)))))

(defun list-args-names (objects)
  (mapcar #'(lambda (obj)
	      (cond ((p4::prodigy-object-p obj)
		     (p4::prodigy-object-name obj))
		    (t obj)))
	  objects))


(defun sv-to-list (vector)
  ;;converts a simple vector into a list
  (declare (type vector simple-vector))
  (do ((index 0 (+ 1 index))
       (list nil (append list (list(svref vector index)))))
      ((= index (array-dimension vector 0) ) list)))

;============================================================================

(setf *mark-node* nil)
(setf *user-guidance* t)

(defun user-prefers-goal (goal)
  (setf *print-case* :downcase)
  (if (and *user-guidance* (not (eq *mark-node* *current-node*)))
      (let ((all-possible-goals
	     (delete-if
	      #'(lambda (g)
		  (p4::goal-loop-p *current-node* g))
	      (p4::give-me-all-pending-goals *current-node*))))
	(setf *mark-node* *current-node*)
	(let ((selected (get-user-choice all-possible-goals "User:" "Choose goal")))
	  (if selected 
	      (list (list (cons goal (nth selected all-possible-goals))))
	      nil)))
      nil))

(setf *jim-trace* t)

(defun get-user-choice (objects message context)
  (send-to-tcl "Start-user-choice")
  (send-to-tcl message)
  (send-to-tcl context)
  (dolist (choice objects)
    (format t "~% Send to TCl: ~S" choice) 
    (send-to-tcl choice))
  ;; it would be simpler to read from the tcl stream directly,
  ;; but this method doesn't interfere with out separate process
  ;; that does that, so it allows both processes the initiative.
  (setf *last-line-from-tcl* nil)
  (send-to-tcl "User_end")
    ;; Enter a sub-server so that any clicks that access info from the
  ;; ui will be serviced. The menu code in menu.tcl MUST NOW SEND :cont.
  (sub-server)
  (let ((tcl-reply (read-line *tcl-send*)))
    (format t "~% ~% ~% tcl-reply ~S" tcl-reply)
    (cond
     ((eq (read-from-string tcl-reply) -1) nil)
     ((eq (read-from-string tcl-reply) -2)
      (setf *user-guidance* nil)
      (format t "~% ~S" *user-guidance*)
      nil)
     (t
      (read-from-string tcl-reply)))))

(defun user-prefers-operator (op)
  (setf *print-case* :downcase)
  (if (and *user-guidance* (not (eq *mark-node* *current-node*)))
      (let* ((cur-goal (p4::goal-node-goal
			(give-me-node-of-type 'p4::goal-node *current-node*)))
	     (all-ops (p4::get-all-ops cur-goal *current-node*)))
	(setf *mark-node* *current-node*)
	;;(format t "~% These are all the possible ops for this goal: ~% ~S"
		;;all-ops)
	;;(format t "~% Select one: enter 0, 1, 2,...")
	(let ((selected (get-user-choice all-ops "User:"
					 (format nil "Choose operator for ~A"
						 (goal-from-literal cur-goal)))))
	  (if selected 
	      (list (list (cons op (p4::operator-name (nth selected all-ops)))))
	      nil)))
       nil))

(defun user-prefers-bindings (bindings)
  (setf *print-case* :downcase)
  (if (and *user-guidance* (not (eq *mark-node* *current-node*)))
      (let* ((cur-goal (p4::goal-node-goal
			(give-me-node-of-type 'p4::goal-node
					      (p4::nexus-parent *current-node*))))
	     (all-bindings 
	      (p4::form-bindings-from-goal *current-node* cur-goal
					   (p4::operator-node-operator *current-node*))))
	(setf *mark-node* *current-node*)
	;;(format t "~% These are all the possible bindings for the chosen op: ~% ~S"
	;;all-bindings)
	;;(format t "~%~% These are all the possible bindings listed as name: ~% ~S"
		;;(get-name-from-bindings all-bindings))
	;;(format t "~% Select one: enter 0, 1, 2,...")
	(setf names (get-name-from-bindings all-bindings))
	(let ((selected
	       (get-user-choice names "User:"
				(format nil "Choose bindings for ~A" (p4::operator-name
						  (p4::operator-node-operator *current-node*))))))
	  (if selected 
	      (list (list (cons bindings (nth selected all-bindings))))
	      nil)))
       nil))



;; all-bindings is a list of lists of bindings
;; for example:
;;  (((<OB> . #<P-O: BLOCKB object>) (<UNDEROB> . #<P-O: BLOCKC object>))
;;   ((<OB> . #<P-O: BLOCKB object>) (<UNDEROB> . #<P-O: BLOCKA object>)))
;; get-name-from-bindings returns
;;  (((<OB> . BLOCKB) (<UNDEROB> . BLOCKC))
;;   ((<OB> . BLOCKB) (<UNDEROB> . BLOCKA)))

(defun get-name-from-bindings (all-bindings)
  (map 'list #'(lambda (x)
		 (map 'list #'(lambda (y)
				(cons (car y)
				      (p4::prodigy-object-name (cdr y))))
		      x))
       all-bindings))















