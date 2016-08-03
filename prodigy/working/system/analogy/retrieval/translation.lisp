;;;*****************************************************************
;;; Before, I stored and used the footprint in a list
;;; of literals in the state and goals they were used
;;; for -- what I called in the implementation "state-goal"
;;; This is what is stored in the problem header files.
;;; Example: (((holding a) (holding c))
;;;           ((clear c)   (holding c))
;;;           ((on-table c) (holding c))
;;;           ((clear b) (clear b)))
;;; Example of equivalent footprint-by-goal:
;;;          (((holding c) (clear c) (on-table c) (holding a))
;;;           ((clear b) (clear b)))

(defun footprint-by-goal-to-state-goal (footprint-by-goal)
  (let ((state-goal nil))
    (dolist (goal-state footprint-by-goal)
      (dolist (state (cdr goal-state))
	(push (list state (car goal-state)) state-goal)))
    state-goal))
;;;*****************************************************************
