;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;			       X-MERGE-EVAL.LISP
;;; 
;;;
;;; File x-merge-eval.lisp contains code that Mike Cox used to run some early 
;;; evaluations on existing case merge strategies. The function select-merge is 
;;; currently used in the UI code for the "Merge Strategies" button when in 
;;; Prodigy/Analogy mode. It selects a merge strategy. 
;;; 
;;;
;;; Also contains utilities for Prodigy/Analogy (e.g., guide2) when in the 
;;; rocket domain. See file ../domains/rocket/rocket-setup.lisp for similar 
;;; code.

(in-package "USER")



;;; Toggles analogical replay flag.
(defun togl () 
  (setf *analogical-replay* 
	(not *analogical-replay*)))


;;;
;;; Function select-merge allows the user to choose a case merging strategy. 
;;; It can be called interactively (when no argument is passed), or directly by
;;; the program. The UI calls it in Prodigy/Analogy mode from the "Merge 
;;; Strategy" button.
;;;
(defun select-merge (&optional merge-num)
  (when (not merge-num)
	(terpri)
	(format t "0. No Change~%")
	(format t "1. Saba (default)~%")
	(format t "2. Saba-cr~%")
	(format t "3. Eager Apply~%")
	(format t "4. Serial~%")
	(format t "5. Smart~%")
	(format t "6. Sequential~%")
	(format t "7. User~%")
	(format t "8. Random~%")
	(format t "Select merge-mode: "))
  (setf 
   *merge-mode* 
   (case (or merge-num (read))
	 (0 *merge-mode*)
	 (1 'saba)
	 (2 'saba-cr)
	 (3 'eager-apply)
	 (4 'serial)
	 (5 'smart)
	 (6 'sequential)
	 (7 'user)
	 (8 'random)
	 (otherwise *merge-mode*)
	 ))
  )


;;; Set world path.
(defun set-w (path)
  (case 
   path
   ((1 a) (setf *world-path* 
		(concatenate 'string 
			     *analogy-pathname*
			     "domains/")))
   ((2 m) (setf *world-path* 
		(concatenate 'string 
	       *prodigy-root-directory*
	       "domains/" )))
   (t (setf *world-path* "/afs/cs/project/prodigy-1/version4.0/domains/")))
  )


;;; From ~/prodigy/analogy/domains/rocket/rocket-setup.lisp
(defun guide1 ()
  (setf *analogical-replay* t
	*ui* t
	*talk-case-p* t)
  (setf *replay-cases*
	'(("case-prob2objs" "case-prob2objs" ((at obj1 locb) (at obj2 locb))
	  ((<r95> . r1) (<o21> . obj2) (<o74> . obj1) (<l86> . locb) (<l45> . loca))))))


;;; From ~/prodigy/analogy/domains/rocket/rocket-setup.lisp
(defun guide2 ()
  (setf *analogical-replay* t
	*talk-case-p* t
	*replay-cases*
	'(("case-prob1-robot" "case-obj2" ((at obj2 locb))
	   ((<r31> . r1) (<o77> . obj2) (<l15> . locb) (<l20> . loca)))
	  ("case-prob1-hammer" "case-obj1" ((at obj1 locb))
	   ((<r1> . r1) (<o44> . obj1) (<l54> . locb) (<l1> . <l1>))))))

;;; This one uses 2 cases; two rockets; three objs.
(defun guide31 ()
  (setf *analogical-replay* t
	*talk-case-p* t
	*replay-cases*
	'(("case-prob2objs-2" "case-prob2o" ((at obj1 locb)(at obj2 locb))
	   ((<r20> . r1) (<o72> . obj2) (<o65> . obj1) (<l50> . locb) (<l81> . loca)))
	  ("case-prob1-hammer" "case-hammer" ((at obj3 locb))
	   ((<r1> . r2) (<o44> . obj3) (<l54> . locb) (<l1> . loca)))
	  ))	)

;;; This one uses 2 cases; one rocket; three objs.
(defun guide32 ()
  (setf *analogical-replay* t
	*talk-case-p* t
	*replay-cases*
	'(("case-prob2objs-2" "case-prob2o" ((at obj1 locb)(at obj2 locb))
	   ((<r20> . r1) (<o72> . obj2) (<o65> . obj1) (<l50> . locb) (<l81> . loca)))
	  ("case-prob1-hammer" "case-hammer" ((at obj3 locb))
	   ((<r1> . r1) (<o44> . obj3) (<l54> . locb) (<l1> . loca)))
	  ))	)


;;; This one uses 1 case; one rocket; three objs.
(defun guide33 ()
  (setf *analogical-replay* t
	*talk-case-p* t
	*replay-cases*
	'(("case-prob2objs-2" "case-prob2o" ((at obj1 locb)(at obj2 locb))
	   ((<r20> . r1) (<o72> . obj2) (<o65> . obj1) (<l50> . locb) (<l81> . loca)))
	  ))	)



;;;
;;; Function run-trial-sets is the main function in this file. It is used to 
;;; execute a series of trials to evaluate various existing merge strategies 
;;; for analogical replay. 
;;;
;;; For example:
;;;
;;; (run-trial-sets "test7.drib" 
;;;   '(prob2objs-2 prob2objs-3 prob2rockets prob2rockets prob2rockets)
;;;   '( guide2 guide2 guide31 guide32 guide33 ))
;;;
(defun run-trial-sets (dribble-file-name problem-name-set case-name-set)
  (when (not (eq (length problem-name-set) (length case-name-set)))
	(format t "Bad sets~%")
	(return-from run-trial-sets))
  (dribble dribble-file-name)
  (set-w 'a)
  (setf count 0)
  (dolist (each-problem problem-name-set)
	  (format t "~%Test Battery Number ~s.~%"
		  (1+ count))
	  (test-battery each-problem 
			(nth count case-name-set))
	  (setf count (1+ count)))
  (dribble)
  )


;;;
;;; Function test-battery executes one evaluation of case merging through the 
;;; various merging strategies given a name of a problem and the name of a 
;;; function to call that establishes the old case bindings.
;;;
(defun test-battery (problem-name setup-name)
  (if *analogical-replay*
      (togl))
  (domain 'rocket)
  (problem problem-name)
  (set-running-mode 'savta)
  (run :depth-bound 50 :time-bound 60)
  (format t "~%~s~%" *prodigy-result*)
  (set-running-mode 'saba)
  (run :depth-bound 50 :time-bound 60)
  (format t "~%~s~%" *prodigy-result*)

  (togl)
  (domain 'rocket)
  (problem problem-name)
  (eval (list setup-name)) ; e.g., (guide2)
  (load-cases)

  ;; Four separate random merge trials
  (dotimes (x 3)
	   (select-merge 8)
	   (init-guiding)
	   (run :depth-bound 50 :time-bound 60)
	   (format t "~%~s~%" *prodigy-result*))

  ;; A saba, saba-cr, eager-apply, and a serial.
  (dotimes (x 5)
	   ;; Changed select-merge to do nothing on zero because of its use in 
	   ;; the UI, so I made random 8 (was 0) and added null clause below.
	   (cond ((eq x 0) nil) 
		 ((and (or (eq setup-name 'guide31)
			   (eq setup-name 'guide33))
		       (eq x 3)
		       (eq problem-name 'prob2rockets))
		  (format t "~%SKIPPING TRIAL~%"))
		 (t
		  (select-merge x)
		  (init-guiding)
		  (run :depth-bound 50 :time-bound 60)
		  (format t "~%~s~%" *prodigy-result*))))

  ;; One more serial trial
  (select-merge 4)
  (init-guiding)
  (run :depth-bound 50 :time-bound 60)
  (format t "~%~s~%" *prodigy-result*)

  ;; Finally an unguided trial
  (run :depth-bound 50 :time-bound 60)
  (format t "~%~s~%" *prodigy-result*)
  )

