(in-package user)

;;;
;;; This file contains the code to collect empirical results on the
;;; rationale-driven sensing and goal transformation code (but most if not all
;;; goal transformation testing code resides in test-gtrans.lisp).
;;;




(defvar *results-directory* 
  (concatenate 
   'string 
   *prodigy-root-directory* 
   "domains/plan-exec/")
  "Where results are written to disk.")



;;;
;;; The current value of *n-ops* is kept on disk in this file. The run-data
;;; script file (in ~/Bin) invokes cl *max-ops* times. This is as opposed to
;;; the prior way that do-test worked (i.e., from a single invocation of lisp).
;;; .clinit.cl then can run the test each time if *auto-load-choice* is
;;; non-nil.
;;;
(defparameter *count-file-name* 
  (concatenate 'string 
	       *results-directory*
	       "counter.lisp"))


;;;
;;; The results of the monitor experiment run. Under *test-condition* =
;;; alternative-based-subgoal or alternative-based-usability, the result is a
;;; list of elements of the form (n-ops sensing-delay planning-time
;;; planning-nodes (length planning-solution)). If under *test-condition* =
;;; with-goal-transformations or without-goal-transformations (see the file
;;; test-gtrans.lisp), the result is a list of elements of the form 
;;; (n-goals resource-num planning-time planning-nodes capacity-reduction)
;;; 
(defvar *battery-results* nil 
  "The results of a set of trials during a call to test-battery (or testg-battery).")



;;;
;;; Called in .clinit.cl
;;;
(defun run-experiment ()
  "The top-level function for executing monitor experiments."
  (case  *test-condition* 
	  ((with-goal-transformations without-goal-transformations)
	   (do-gtest *max-g-num*		;var in ~mcox/prodigy/Interleave/test-gtrans.lisp
		     (eq *test-condition* 
			 'with-goal-transformations)
		     t
		     *o-level*))
	  ((alternative-based-subgoal alternative-based-usability)
	   (set-seq *max-delay*)
	   (do-test *max-ops* 
		    *use-monitors-p* 
		    t
		    *o-level*))
	  (t
	   (break "ERROR: Incorrect test condition."))
	  )
  )


 
;;;
;;; Function set-seq is used by fn run-experiment during experiments under
;;; alternative-based-subgoal and alternative-based-usability *test-condition*
;;; (i.e., the results reported in Veloso, Pollack & Cox, 1998). The function
;;; assisgns a value to the global *sequence-list*. 
;;;
;;; As an example, the call of (set-seq 3 '(a (new-literal x y))) returns the
;;; value of ((a (new-literal x y)) "" (t a (new-literal x y)) "" (t t a
;;; (new-literal x y)) "") Thus the sequence has a progressively longer delay
;;; for each trial so that the new literall is first sensed on the first
;;; planning cycle, the second has a one cycle delay, and the third has a two
;;; cycle delay. NOTE that the magnitude of the cycle delay is controlled by
;;; the global *sensing-cycle-length* (see file sensing.lisp).
;;;
(defun set-seq (size 
		&optional 
		(seed (first *sequence-list*)))
  (setf *sequence-list* 
	(create-sequence
	 seed
	 size))
  )


;;;
;;; Function create-sequence generates a list of environmental sense inputs,
;;; each with progressively longer sense delays (signaled by each t). See
;;; comments on set-seq function above.  Even elements are null comment
;;; strings (see parameter *sequence-list* in sensing.lisp). 
;;;
(defun create-sequence (seed 
			size 
			&optional 
			(element seed))
  "Return a sense input sequence for an experiment."
  (cond ((= 0 size)
	 nil)
	(t
	 (cons element
	       (cons ""
		     (create-sequence
		      seed
		      (1- size)
		      (cons t element))))))
  )
	 


#|
(defun do-test (&optional 
		(num-trials 10)
		with-monitors-p
		write-results-p
		(o-level 0))
  (setf *battery-results* nil)
  (if (eq o-level 0)
      (setf *monitor-trace* nil))
  (dotimes (x num-trials) 
	   (setf *n-ops* (+ 1 x))
	   (domain 'plan-exec)
	   (if (eq  *test-condition* 'alternative-based-subgoal)
	       (problem 'p1)
	     (if (eq  *test-condition* 'alternative-based-usability)
		 (problem 'p2)))
	   (output-level o-level)
	   ;; Test with or without monitoring the environment
	   (test-battery 
	    *n-ops*
	    with-monitors-p 
;	    (list (first *sequence-list*)
;		  (second *sequence-list*))
	    )
	   )
  (if write-results-p
      (create-res-file 
       with-monitors-p))
  )
|#


#|
(defun do-test (&optional 
		(num-trials *max-ops*)		;*max-ops* in .clinit.cl
		with-monitors-p
		write-results-p
		(o-level 0))
  (setf *battery-results* nil)
  (if (eq o-level 0)
      (setf *monitor-trace* nil))
  (setf *n-ops* (read-current-n-ops))
  (domain 'plan-exec)
  (if (eq  *test-condition* 'alternative-based-subgoal)
      (problem 'p1)
    (if (eq  *test-condition* 'alternative-based-usability)
	(problem 'p2)))
  (output-level o-level)
  ;; Test with or without monitoring the environment
  (test-battery 
   *n-ops*
   with-monitors-p)
  (if write-results-p
      (create-res-file 
       with-monitors-p))
  (write-current-n-ops
   (if (= *n-ops* num-trials)
       1
     (+ 1 *n-ops*)))
  )
|#


(defun do-test (&optional 
		(max-num-trials *max-ops*)		;*max-ops* in .clinit.cl
		with-monitors-p
		write-results-p
		(o-level 0)
		&aux
		(delay (read-current-delay))
		(n-ops (read-current-n-ops)))
  (setf *battery-results* nil)
  (if (eq o-level 0)
      (setf *monitor-trace* nil))

  ;; Test with or without monitoring the environment
  (dotimes (i 5)
	   (do-1-trial n-ops 
		       delay 
		       with-monitors-p
		       o-level)
	   (setf delay (+ delay 1)))

  (if write-results-p
      (create-res-file 
       with-monitors-p))
  (let ((new-op-num-p (= (- delay 1) *max-delay*)))
    (write-current-status
     (if new-op-num-p 1 delay)
     (if new-op-num-p 
	 (if (= n-ops max-num-trials)
	     1
	   (+ 1 n-ops))
       n-ops)))     
  )



;;; For performing a single test trial at a given number of operators (n-ops)
;;; and sensing delay. 
;;;
(defun do-1-trial (n-ops 
		   sensing-delay 
		   &optional 
		   with-monitors-p
		   (o-level 0))
  ;; Commented out below for 3rd version of do-test [8dec97]
;  (setf *battery-results* nil)
;  (if (eq o-level 0)
;      (setf *monitor-trace* nil))  
  (setf *n-ops* n-ops)
  (domain 'plan-exec)
  (if (eq  *test-condition* 'alternative-based-subgoal)
      (problem 'p1)
    (if (eq  *test-condition* 'alternative-based-usability)
	(problem 'p2)))
  (output-level o-level)
  (test-battery 
   *n-ops*
   with-monitors-p 
   (list (gen-single-seq (- sensing-delay 1)) "")
   sensing-delay)
  )

;;; Is this function used???
(defun trial (&optional 
	      (n-ops *n-ops*)
	      (o-level 3))
  (setf *n-ops* n-ops)
  (domain 'plan-exec)
  (if (eq  *test-condition* 'alternative-based-subgoal)
      (problem 'p1)
    (if (eq  *test-condition* 'alternative-based-usability)
	(problem 'p2)))
  (output-level o-level)
  (reset)
  (run)
  )



(defun gen-single-seq (len 
		       &optional 
		       (seq (first *sequence-list*)))
  "Generate sequence with len t's in front of 1st element of *sequence-list*"
  (cond ((= len 0)
	 seq)
	(t
	 (gen-single-seq (- len 1)
			 (cons t seq))))
  )


#|
;;; Old recursive version
(defun test-battery (n-ops
		     &optional 
		     with-monitors-p
		     (seq-list *sequence-list*)
		     (sensing-delay 1))
  (declare (special *sequence-list*))
  (cond ((null seq-list)
	 nil)
	(t
	 (unless (and (eq *test-condition* 'alternative-based-subgoal)
		      (not with-monitors-p))
		 (setf *sequence* (first seq-list))
		 (reset))
	 (let ((p-result (run)))
	   (setf *battery-results* 
		 (cons 
		  ;;(copy-structure (run))
		  (list n-ops 
			sensing-delay 
			(prodigy-result-time p-result)
			(prodigy-result-nodes p-result)
			(length (prodigy-result-solution p-result)))
		  *battery-results*))
	   (test-battery n-ops
			 with-monitors-p 
			 (rest (rest seq-list))
			 (+ 1 sensing-delay)))))
  )
|#

(defun test-battery (n-ops
		     &optional 
		     with-monitors-p
		     (seq-list *sequence-list*)
		     (sensing-delay 1)
		     &aux
		     p-result)
  (declare (special *sequence-list*))
  (dotimes (x (/ (length seq-list) 2))
	   (unless (and (eq *test-condition* 'alternative-based-subgoal)
			(not with-monitors-p))
		   (setf *sequence* (first seq-list))
		   (reset))
	   (setf seq-list (rest (rest seq-list)))
	   (setf p-result (run :depth-bound 1000))
	   (setf *battery-results* 
		 (cons 
		  (list n-ops 
			sensing-delay 
			(prodigy-result-time p-result)
			(prodigy-result-nodes p-result)
			(length (prodigy-result-solution p-result)))
		  *battery-results*))
	   (setf sensing-delay 
		 (+ 1 sensing-delay)))
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Functions to write results to disk. Also to read and write experiment
;;; status to disk.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun read-current-n-ops ()
  "Return the current number of operators from disk."
  (with-open-file
   (file-in *count-file-name* 
	    :direction :input)
   (first (read file-in)))
  )

(defun read-current-delay ()
  "Return the current sensing delay from disk."
  (with-open-file
   (file-in *count-file-name* 
	    :direction :input)
   (second (read file-in)))
  )

(defun write-current-n-ops (n)
  (with-open-file
   (file-out *count-file-name* 
	     :direction :output
	     :if-exists :overwrite
	     :if-does-not-exist :create)
   (format file-out
	   "~S"
	   n))
  )

(defun write-current-status (delay n-ops)
  (with-open-file
   (file-out *count-file-name* 
	     :direction :output
	     :if-exists :overwrite
	     :if-does-not-exist :create)
   (format file-out
	   "(~S ~S)"
	   n-ops
	   delay))
  )


(defun create-res-file (&optional
			with-monitors-p
			(results *battery-results*))
  "Write out partial results in format handled by Systat."
  (with-open-file
   (file-out 
    (concatenate 'string 
		 *results-directory*
		 (if with-monitors-p
		     "results-monit.txt"
		   "results-no-monit.txt"))
    :direction :output
    :if-exists :append
    :if-does-not-exist :create)
   (mapc #'(lambda (tuple)
	     (write-results 
	      (first tuple)
	      (second tuple)
	      (third tuple)
	      file-out))
	 results))
  nil
  )


(defun create-raw-res-file (&optional
			    with-monitors-p)
  "Write an entire trial battery of results to disk."
  (with-open-file
   (file-out 
    (concatenate 'string 
		 *results-directory*
		 (if with-monitors-p
		     "results-monit-raw.txt"
		   "results-no-monit-raw.txt"))
    :direction :output
    :if-exists :overwrite
    :if-does-not-exist :create)
   (format file-out "~S" *battery-results*))
  )


(defun write-results (n-ops
		      delay
		      measure
		      stream)
  (format stream
	  "~,5F, ~,5F, ~,5F~%"
	  n-ops
	  delay
	  measure)
  )


(defun find-highest (raw-data
		     &aux
		     (highest 0))
  "Find the highest planning time in the raw-data."
  (mapc #'(lambda (x)
	    (if (>= (third x) highest)
		(setf highest (third x))))
	raw-data)
  highest
  )



(defun filter-on-n-ops (raw-data
			n-ops)
  "Take a raw file, return those points matching the number of operators."
  (mapcan #'(lambda (x)
	    (if (= (first x) n-ops)
		(list (list (second  x) (third x)))))
	  raw-data)
  )



(defun filter-on-delay (raw-data
			sense-delay)
  "Take a raw file, return those points matching the sense-delay time."
  (mapcan #'(lambda (x)
	    (if (= (second x) sense-delay)
		(list (list (first x) (third x)))))
	  raw-data)
  )


;;; Example:
;;; (create-2d-data-file
;;;  (filter-on-delay *no-monit-data* 20)
;;;  nil
;;;  "./long-slice-no-monit.txt")
;;; 
;;; where *no-monit-data* is the value of the list written to the file with a
;;; call of (create-res-file nil). It may work work with *battery-results*
;;; directly.
;;;
(defun create-2d-data-file (data
			    &optional
			    with-monitors-p
			    fname)
  (with-open-file
   (file-out 
    (or fname
	(concatenate 'string 
		     *results-directory*
		     (if with-monitors-p
			 "2d-monit.txt"
		       "2d-no-monit.txt")))
    :direction :output
    :if-exists :overwrite
    :if-does-not-exist :create)
   (mapc #'(lambda (data-point)
	     (format file-out 
		     "~S ~S~%" 
		     (first data-point) 
		     (second data-point)))
	 data))
  )


;;; Note that this function does not differentiate file names between x cut
;;; graphs and y cut graphs (x and y here is meant to refer to the 3-d image).
;;;
(defun gen-plot (cut-val
		 &optional
		 x-filter-p
		 monitor-experiment-p
		 null-hypo-p
		 &aux
		 (fname 
		  (if monitor-experiment-p
		      (concatenate 'string 
				   *results-directory*
				   (if null-hypo-p
				       "2d-no-monit-"
				     "2d-monit-")
				   (format nil
					   "~a"
					   cut-val)
				   ".txt")
		    (concatenate 'string 
				 *gresults-directory* 
				 (if null-hypo-p
				     "2d-no-gtrans-"
				   "2d-gtrans-")
				 (format nil
					 "~a"
					 cut-val)
				 ".txt")
		    ))
		 (global-var
		  (if monitor-experiment-p
		      (if null-hypo-p
			  *no-monit-data*
			*monit-data*)
		    (if null-hypo-p
			*no-trans-data*
		      *trans-data*)))
		 )
  (if x-filter-p
      (create-2d-data-file
       (filter-on-n-ops global-var cut-val)
       t
       fname)
    (create-2d-data-file
     (filter-on-delay global-var cut-val)
     t
     fname))
  )


(defun gen-dual-plots (cut-val
		       &optional
		       x-filter-p
		       monitor-experiment-p)
  (gen-plot cut-val
	    x-filter-p
	    monitor-experiment-p)
  (gen-plot cut-val
	    x-filter-p
	    monitor-experiment-p 
	    t)
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Utilities. Seems to be no longer used.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun odd-items (alist)
  "Return a list composed of all odd elements of alist."
  (cond ((null alist)
	 nil)
	((eq (length alist) 1)
	 alist)
	(t
	 (cons (first alist)
	       (odd-items
		(rest 
		 (rest alist))))))
  )

(defun even-items (alist)
  "Return a list composed of all even elements of alist."
  (cond ((null alist)
	 nil)
	((eq (length alist) 1)
	 nil)
	(t
	 (cons (second alist)
	       (even-items
		(rest 
		 (rest alist))))))
  )


