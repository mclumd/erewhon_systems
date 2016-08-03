#|
Author: Jim Blythe

Description:
   This file lets prodigy 4.0 signal and deal with partial
   satisfaction of its goals.
   To use it, call (set-partial-satisfaction) before (run).
   To turn it off again, call (set-partial-satisfaction nil)

How it works:
   It's all done with daemons and the interrupt system. Firstly,
   daemons are called when the state changes to see if more top-level
   goals are true. If so, an interrupt is signaled so that when the
   node is complete, we check to see if this state satisfies more
   top-level goals than the previous best state. Then when Prodigy
   runs out of time, a plan to achieve this state is returned rather
   than nothing.

Limitations:
   Currently no use is made of relative utility of goals. This will be
   added. It also only works if the goal is a conjunction of literals.

Example Trace:
   The action takes place in the good-old blocks world...

<cl> (run :current-problem
	  (create-problem
	   (objects (a b object))
	   (state (and (on-table b) (on a b) (clear a) (arm-empty)))
	   (igoal (and (on-table a) (on b a))))
	  :max-nodes 15)
Creating objects (A B) of type OBJECT

  2 n2 (done)
  4 n4 <*finish*>
  5   n5 (on-table a) [1]
  7   n7 <put-down a>
  8     n8 (holding a) [1]
  9     n9 pick-up ...goal loop with node 5
 10     n11 <unstack a b> [4]
 11     n12 <UNSTACK A B> [1]
 12   n13 <PUT-DOWN A> [1]
 13   n14 (on b a)
Hit node limit (15)

I didn't completely solve the problem,
because I exceeded a resource bound, :NODE,
but I solved 1 of the top-level goals with this plan:

	<unstack a b>
	<put-down a>


(((:PARTIAL-ACHIEVE #<APPLIED-OP-NODE 13 #<PUT-DOWN [<OB> A]>>
		    (#<ON-TABLE A>))
  ((:STOP :RESOURCE-BOUND :NODE) . #<OPERATOR-NODE 15 #<OP: STACK>>))
 #<UNSTACK [<OB> A] [<UNDEROB> B]> #<PUT-DOWN [<OB> A]>) 
<cl>

;;; Note that the cdr of the returned structure is the plan as usual.
;;; The car has the token :partial-achieve to show that the goal
;;; wasn't completely achieved, and a list of the goals that were achieved.

Version History:
   Nov 7 92: file created.
|#

(in-package "PRODIGY4")

(export 'set-partial-satisfaction)

;;; I made this a global variable rather than a problem space property
;;; because there are already too many of those.
(defparameter *partial-satisfaction* nil
  "Whether partial satisfaction is turned on. Do that via
set-partial-satisfaction unless you want some non-standard behaviour.")

(defparameter *closest-to-goal* nil
  "Stores the node that came satisfied the most top-level goals, and
how many.")

(defun set-partial-satisfaction (&optional (on/off t))
  (cond (on/off
	 (setf *partial-satisfaction* t)
	 (user::pset :push-goal-daemon #'add-top-level-goal)
	 (user::pset :push-neg-goal-daemon #'add-top-level-negated-goal)
	 (user::pset :state-daemon #'check-top-level-goal-satisfied))
	(t
	 (setf *partial-satisfaction* nil)
	 (user::pset :push-goal-daemon nil)
	 (user::pset :push-neg-goal-daemon nil)
	 (user::pset :state-daemon nil))))

;;; This function can be used to record the time when subgoals were
;;; satisfied. This could provide statistics for deliberation scheduling.

(defun record-individual-goals ()
  (remove-prod-handler :achieve-one-goal #'record-a-single-goal)
  (define-prod-handler :achieve-one-goal #'record-a-single-goal)
  (define-prod-handler :achieve #'record-a-single-goal)
  (define-prod-handler :start-run #'startup-single-goals))

;;; Add functions that note when a literal is being added as a goal or
;;; negative subgoal for *finish* and add :top-level-goal to the
;;; property list of the literal. It would be more efficient to do
;;; this only after the bindings for the *finish* operator have been
;;; considered, but this ain't too bad.

(defun add-top-level-goal (literal pspace)
  (declare (ignore pspace))
  (if (and (instantiated-op-p (car (literal-goal-p literal)))
	   (eq (rule-name (instantiated-op-op (car (literal-goal-p literal))))
	       '*finish*))
      (setf (getf (literal-plist literal) :top-level) 'positive)))

(defun add-top-level-negated-goal (literal pspace)
  (declare (ignore pspace))
  (if (and (instantiated-op-p (car (literal-neg-goal-p literal)))
	   (eq (rule-name (instantiated-op-op (car (literal-neg-goal-p literal))))
	       '*finish*))
      (setf (getf (literal-plist literal) :top-level) 'negative)))


;;; A daemon to signal success when one of these is added.

(defun check-top-level-goal-satisfied (literal pspace)
  (declare (ignore pspace))
  (if (if (literal-state-p literal)
	  (eq (getf (literal-plist literal) :top-level) 'positive)
	  (eq (getf (literal-plist literal) :top-level) 'negative))
      (prod-signal :achieve-one-goal
		   (list literal (if (boundp 'a-op-node)
				     a-op-node
				     user::*current-node*)))))


;;; A handler for achieve-one-goal
;;; Not implemented yet.
(defun ask-when-one-goal-achieved (signal)
  (let ((goal (second signal))
	(applied-op-node (third signal)))
    (if (y-or-n-p "I achieved the top level goal ~% ~S~%  should I stop?"
		  goal)
	(list :stop :achieved-one-goal goal))))

;;; More accurate to record times with a signal handler rather than a
;;; daemon, because this is the time Prodigy could actually respond.
(defun record-a-single-goal (signal)
  (let ((goal (if (= (length signal) 3)
		  (second signal)
		  :finish)))
    (push (cons goal
		(float
		 (/ (- (get-internal-run-time) *start-time*)
		   internal-time-units-per-second)))
	  *time-signature*)))

(defun startup-single-goals (signal)
  (setf *start-time* (get-internal-run-time)
	*time-signature* nil))

;;;======================================================
;;; Salvaging interrupted work
;;;======================================================
;;;
;;; If the planner is interrupted (because of exceeding a resource
;;; bound, for example) we'd like to return a plan that gets as far as
;;; possible towards achieving the goals.

;;; "result" is what main-search returns when it terminates. For this
;;; function to be called, "result" indicates that some resource bound
;;; was reached.
(defun prepare-partial-plan (result)

  ;; It's hard to figure out the "best" branch in the search tree
  ;; quickly, and this must be a fast algorithm since it deals with
  ;; time-bounds. For this reason I'll only do anything if the goal is
  ;; a conjunction of literals. When this is the case I use the
  ;; interrupt system to keep track of the applied-op node that
  ;; corresponds to the closest point to a solution (see
  ;; maintain-best-plan).
  (if (and (goal-is-conjunction-of-literals)
	   *closest-to-goal*)
      (cons
       (list (cons :partial-achieve *closest-to-goal*) result)
       (mapcan #'(lambda (node)
		   (nreverse (mapcar #'op-application-instantiated-op
				     (a-or-b-node-applied node))))
	       (cdr (path-from-root (car *closest-to-goal*)
				    #'a-or-b-node-p))))))

(defun goal-is-conjunction-of-literals ()
  (let ((goal (third (rule-precond-exp 
		      (rule-name-to-rule '*finish*
					 *current-problem-space*)))))
    (and (eq (car goal) 'user::and)
	 ;; Each subgoal must either be (~ <literal>) or a literal.
	 (every #'(lambda (sub)
		    (if (eq (car sub) 'user::~)
			(not (member (car (second sub))
				     '(user::and user::~ user::or)))
			(not (member (car sub) '(user::and user::or)))))
		(cdr goal)))))

;;; This is an interrupt handler called when :achieve-one-goal is
;;; signalled. If this happens, the last node achieved at least one
;;; top-level goal, and if that happens we want to see how many top
;;; level goals are achieved and if this is the best yet.
(defun maintain-best-plan (signal)

  (let* ((res nil)
	 (top-level-node (find-node 4))
	 (goals-satisfied
	  (if top-level-node
	      (dolist (literal (cdr (binding-node-instantiated-preconds
				     (find-node 4)))
		       res)
		(if (or (and (eq (getf (literal-plist literal) :top-level)
				 'positive)
			     (literal-state-p literal))
			(and (eq (getf (literal-plist literal) :top-level)
				 'negative)
			     (not (literal-state-p literal))))
		    (push literal res))))))
    (if (or (null *closest-to-goal*)
	    (> (length goals-satisfied) (length (second *closest-to-goal*))))
	(setf *closest-to-goal*
	      (list (third signal) goals-satisfied)))))
