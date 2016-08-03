(in-package :user)

;;;; 
;;;; 
;;;; This file generates data for the symbolic A-distance evaluation.
;;;; The data is composed of a randomly ordered sets of blocks, one
;;;; per file, in the following format. A block is a sequence of plan
;;;; executions from a given domain such that some target interval
;;;; exists somewhere within it. Unlike plans elsewhere in the block,
;;;; the plans in the target interval are anomalous in some
;;;; significant sense. The task of the A-distance metric is to detect
;;;; the start and ending locations of the target sequence.
;;;; 
;;;; A block begins with a number of randomly chosen normal plans
;;;; equal in length to the target. Normal plans come from the
;;;; *normal-pool* and represent solved problems using a complete and
;;;; uncorrupted domain. Anomalous plans represent those solved with
;;;; domains having missing or modified operators. After the first
;;;; sequence of normal plans, a stream of plans exists forming the
;;;; target sequence of *target-width* number of plans somewhere in
;;;; the remainder. Thus there will be some (possibly zero) further
;;;; normal plans, then a sequence of *target-width* mixed normal and
;;;; anomalous plans (the target), and then a final sequence of
;;;; possible zero normal plans.
;;;; 
;;;; The intensity of the anomalous target refers to the percentage of
;;;; plans drawn from the *anomaly-pool*. If all plans are anomalous
;;;; then the intensity is 100%. If half of the plans in the target
;;;; are normal and half are anomalous, then the intensity is 50%. The
;;;; intensity of targets vary from 0 to 100 in increments of 10%.
;;;; 
;;;; NOTE that the global pool variables (normal and anomalous) are in
;;;; files data.lisp and data-alt.lisp.
;;;; 
;;;; The main user function is assemble-data. The top level call is
;;;; simply (assemble-data) to generate the trial data files.
;;;; 
;;;; ||||| DEFINE INTENSITY. CHANGE NAME TO PURITY?



;;; 
;;; The value of this variable is set by function
;;; init-domain-specific-vars depending upon the value of the
;;; current-domain parameter.
;;; 
(defvar *data-directory*
    nil
  "The directory where results are stored on disk."
  )


;;; 
;;; The width of the incremental division of the block within the area
;;; the target can be placed. The value is calculated by function
;;; determine-increment-width.
;;; 
(defvar *increment-width* 44
  "Width of incremental block division." )


;;; 
;;; The width of the anomaly target in terms of the number of
;;; plans. The value is calculated by a call to the function
;;; determine-target-width.
;;; 
(defvar *target-width* 100 
  "Width of the anomaly target." )



;;; 
;;; Main function assemble-data randomizes the two pools and then
;;; generates a set of data with a number of increments equal to the
;;; parameter num-of-increments. Function write2file writes the data
;;; to files and then returns the answer key. Function assemble-data
;;; then writes out the answer key to a file along with the
;;; *target-width* and *increment-width* parameters. Function
;;; make-test-sets actually returns the data, and assemble-data
;;; randomizes the order.
;;; 
;;; The target sequence of *target-width* number of mixed anomalous
;;; and normal plans will be located somewhere between the end of the
;;; block and the 101st plan (the first 100 will always be
;;; normal). The parameter num-of-increments determines the possible
;;; locations for the target. If the function is called with the
;;; parameter set to 10, then the leftmost target plan will vary from
;;; 101 to 541 in equal increments of *increment-width* (i.e., 44).
;;; 
(defun assemble-data (&optional
		      (num-of-increments
		       10)
		      &aux
		      t-set)
  (setf *normal-pool* 
    (seqrnd (copy-seq *normal-pool*)))
  (setf *anomaly-pool* 
    (seqrnd (copy-seq *anomaly-pool*)))
  (with-open-file
      (ofile 
       (format 
	nil 
	"~atest-key.txt"	
	*data-directory*)
       :direction :output
       :if-exists :overwrite
       :if-does-not-exist :create)
    (format ofile 
	    ";;; This answer key contains a list of tuples of the~%")
    (format ofile 
	    ";;; following form. (increment percentage-normal file-number target-width)~%")
    (format ofile 
	    ";;; The target and increment widths occur at the end of the file.~%")
    (format ofile "~s~%~s~%~s" 
	    (write2file
	     (seqrnd (copy-seq 
		      (make-test-sets 
		       num-of-increments))))
	    *target-width*
	    *increment-width*))
  )


;;; 
;;; Function make-test-sets recursively creates a series of sets of
;;; data each containing an anomaly target of varying intensity at
;;; various locations. The function normally starts from an increment
;;; of 10 (if assemble-data calls it with the value 10). Thus the
;;; increment will proceed from 10 to 1, returning 10 sets of 11
;;; blocks.
;;; 
(defun make-test-sets (increment
		       &optional
		       test-set)
  (cond ((equal 0 increment)
	 test-set)
	(t
	 (make-test-sets
	  (- increment 1)
	  (append 
	   (make-set increment 100)		;100 -> 0 to get all anomalies only.
		  test-set))))
  )


;;; 
;;; Function make-set creates a set of blocks having targets at the
;;; current increment (starting from 10) of varying purity. The set
;;; ranges from 100 percent normal (no anomalies) to 0 percent normal
;;; (all anomalous data).
;;; 
;;; The blocks returned are included in a list structure that contains
;;; the corresponding increment and percent normal. These are later
;;; added to the answer key as the data is written to disk.
;;; 
(defun make-set (increment
		 percentage-normal
		 &optional
		 blocks)
  (cond ((equal 
	  ;;Used to be 0, but that left out 100% anomalies
	  -10 percentage-normal)
	 blocks)
	(t
	 (let* ((normal-copy (seqrnd (copy-seq *normal-pool*)))
		(anomaly-copy (seqrnd (copy-seq *anomaly-pool*)))
		(temp-block (make-block
			     increment
			     percentage-normal)))
	   (setf *normal-pool* normal-copy)
	   (setf *anomaly-pool* anomaly-copy)
	   (make-set
	    increment
	    (- percentage-normal 10)
	    (cons (list increment percentage-normal temp-block *target-width*)
		  blocks)))))
  )


;;; 
;;; Function make-block generates a single block with a target located
;;; at the current increment with intensity at the given normality
;;; level. Increment ranges from 1 to 10, and percentage-normal from 0
;;; to 100. The length of the sequence of initial normal plans is
;;; equal to the width of the target.
;;; 
(defun make-block (increment
		   percentage-normal)
  (append (get-plans *target-width* t)
	  (get-plans (* increment *increment-width*) t)
	  (make-target percentage-normal)
	  (get-plans (* (- 10 increment) *increment-width*) t))
  )


;;; 
;;; Function make-target creates a randomly mixed set of plans from
;;; the two pools. Percentage-normal should be from 0-100 and
;;; represents the percentage of the set that comes from non-anomalous
;;; data. The fraction-normal parameter will range from 0-1.
;;; 
(defun make-target (percentage-normal
		    &aux
		    (fraction-normal
		     (/ percentage-normal 100.0)))
  (seqrnd 
   (copy-seq 
    (append (get-plans 
	     (round
	      (* *target-width* 
		 fraction-normal))
	     t)
	    (get-plans 
	     (round 
	      (* *target-width* 
		 (- 1.0 fraction-normal)))
	     nil))))
  )


;;; 
;;; Function get-plans returns plan-count number of plans from either
;;; *normal-pool* or *anomaly-pool* depending upon the value of the
;;; is-normal flag. The pools are destructively reduced as a
;;; side-effect.
;;; 
(defun get-plans (plan-count
		  is-normal
		  &optional
		  plans)
  (cond ((eql 0 plan-count)
	 plans)
	(t
	 (get-plans
	  (- plan-count 1)
	  is-normal
	  (cons (if is-normal
		    (pop *normal-pool*)
		  (pop *anomaly-pool*))
		plans))
	 )))


;;; 
;;; Function write2file outputs each datum to a file and then returns
;;; the answer key. Each filename is numbered consecutively. The
;;; answer key contains a list of tuples of the following form.
;;; (increment percentage-normal file-number target-width)
;;; 
(defun write2file (data
		   &optional 
		   (file-number 1)
		   answer-key)
  (cond ((null data)
	 answer-key)
	(t 
	 (with-open-file
	     (ofile 
	      (format 
	       nil
	       "~atest-data~a.txt"
	       *data-directory* 
	       file-number)
	      :direction :output
	      :if-does-not-exist :create)
	   (format ofile "~s" (third (first data))))
	 (write2file (rest data)
		     (+ 1 file-number)
		     (cons (list (first (first data))  
				 (second (first data))
				 file-number
				 (fourth (first data)))
			   answer-key)))
	)
  )


;;; 
;;; Function read-from-file returns the test data read from the file
;;; numbered by file-number in directory dir.
;;; 
(defun read-from-file (file-number
		       &optional
		       (dir *data-directory*)
		       )
  (with-open-file
	     (ifile 
	      (format 
	       nil
	       "~atest-data~a.txt"
	       dir
	       file-number)
	      :direction :input)
	   (read ifile))
  )


;;; 
;;; Call with the following for example
;;; (do-eval 10 0.45
;;;  (concatenate
;;;     'string
;;;   *data-directory* 
;;;   "Tmp2/"))
;;; 
;;; Returns the results (i.e., detection lists and timings).
;;; 
(defun do-eval (&optional 
		(last-file-number 100)
		epsilon
		(dir 
		 *data-directory*)
		;; Should always start at 1
		(current-file-number 1))
  (cond ((eql current-file-number 
	      (+ 1 last-file-number))
	 nil)
	(t 
	 ;; Because detect-anomalies returns 2 values, this
	 ;; collects pairs that include the timing value.
	 (cons (multiple-value-bind (detection-list timing-val)
		   (detect-anomalies
		    (read-from-file current-file-number
				    dir)
		    epsilon)
		 (list detection-list timing-val))
	       (do-eval 
		   last-file-number
		 epsilon
		 dir
		 (+ 1 current-file-number)))))
  )


;;; ||||| Needs comments.  Returns the results lists and timings after
;;; writing them to disk and printing them to the screen.
(defun eval-and-write (&optional 
		       (last-file-number 100)
		       epsilon
		       (dir 
			*data-directory*)
		       &aux
		       return-list)
  (with-open-file
      (ofile 
       (format 
	nil 
	"~aresults-~F.txt"	
	dir epsilon)
       :direction :output
       :if-exists :append
       :if-does-not-exist :create)
    (format ofile ";;; Called with global epsilon value of ~F~%"
	    epsilon)
    (format ofile "~S~%"
	    (setf return-list
	      (do-eval 
		  last-file-number
		epsilon
		dir))))
  (format t "~%~s~%" return-list)
  return-list
  )



;;; 
;;; Function return-tuple returns the tuple indexed by file
;;; number. That is it returns the triple that corresponds to the data
;;; in the file ending with number file-number. The answer key
;;; contains a list of tuples of the following form.  (increment
;;; percentage-normal file-number target-width)
;;; 
(defun return-tuple (file-number 
		     answer-key)
  (find file-number 
	answer-key 
	:test 
	#'(lambda (key current-tuple)
	    (equal key
		   (third current-tuple))))
  )


;;; 
;;; Function return-anomalous calculates the anomaly intensity of the
;;; anomaly target in the block contained in the file identified by
;;; file-number. The answer key contains a list of tuples of the
;;; following form. (increment percentage-normal file-number
;;; target-width)
;;; 
(defun return-anomalous (file-number 
			 answer-key)
  (let ((tuple 
	 (return-tuple file-number 
		       answer-key)))
    (if tuple
	(float				;to get decimal point repr
	 (/ (- 100 
	       ;; Percent normal
	       (second 
		tuple))
	    100))))
  )


;;; 
;;; Function return-position returns the starting position of the
;;; anomaly target in the block contained in the file identified by
;;; file-number. The answer key contains a list of tuples of the
;;; following form. (increment percentage-normal file-number
;;; target-width)
;;; 
(defun return-position (file-number 
			answer-key
			target-width
			increment-width)
  (calculate-position
   ;; Increment count
   (first 
    (return-tuple file-number 
		  answer-key))
   target-width
   increment-width)
  )


;;; 
;;; Function calculate-position actually does the calculation of the
;;; starting position of the anomaly target in the block. Old style no
;;; longer used. However this does assume a uniform target width
;;; instead of widths that vary from block to block. This also
;;; calculates the plan position rather than the vector position
;;; (which is returned by thr detect-anomalies function.  
;;; 
;;; ||||| Modify to calculate using widths in answer key.
;;; 
(defun calculate-position (increment
			   target-width
			   increment-width
			   &optional
			   is-old-style)
  (if increment
      (+ 
       (+ 1 (if is-old-style
		*target-width*
	      target-width))
       (* (if is-old-style
	      *increment-width*
	    increment-width)
	  increment)))
  )


;;; ||||| Needs comments
(defun return-result (file-number
		      results)
  (first 
   (nth (- file-number 1)
	results))
  )

;;; ||||| Needs comments
(defun first-not-neg (result)
  (cond ((null result)
	 0)
	((>= (first result) 0)
	 (first result))
	(t
	 (first-not-neg (rest result))))
  )

;;; ||||| Needs comments
(defun return-step-predictions (file-number
				results
				&aux
				(result
				 (return-result 
				  file-number
				  results))
				first-result)
  (values
   (setf first-result 
     (first-not-neg result))
   (step2plan (read-from-file file-number)
	      first-result)
   (mapcar #'(lambda (x)
	       (if (eql -1 x)
		   0
		 x))
	   result)
   )
  )


;;; 
;;; Function write-answer outputs a single comma-delimited line of
;;; text with the file number, position and intensity of the target.
;;; 
;;; Changed from comma delimited to tab delimited format.[mcox 8aug12]
;;; 
(defun write-answer (file-number 
		     answer-key
		     target-width
		     increment-width
		     results
		     &aux
		     (temp-str ""))
  (multiple-value-bind (step-prediction plan-num result-list)
      (return-step-predictions 
       file-number
       results)
    (format nil "~D~A ~D~A ~F~A ~D~A ~D~A~%"
	    file-number #\tab
	    (return-position file-number
			     answer-key
			     target-width
			     increment-width) #\tab
	    (return-anomalous file-number 
			      answer-key) #\tab
	    step-prediction #\tab
	    plan-num
	    (dolist (each-element result-list temp-str)
	      (setf temp-str
		(concatenate 'string
		  temp-str
		  (format nil "~A ~D" #\tab each-element)))))
    )
  )


;;; 
;;; Function read-key opens and read a file to obtain the answer key
;;; for an A-distance experiment. Multiple values returned are the
;;; key, the target width, and the increment width.
;;; 
(defun read-key (&optional
		 (key-dir
		  *data-directory*))
  (with-open-file
   (ifile 
    (format 
     nil
     "~atest-key.txt"
     key-dir)
    :direction :input)
   (values
    (read ifile)			;Key
    (read ifile)			;target width
    (read ifile)))			;increment width
  )


;;; 
;;; Function output-answers writes position and intensity data for
;;; all blocks of an experiment. The function reads from an answer key
;;; on disk and translates it into plan positions and intensity
;;; percentages. The data is output to a file.
;;; 
;;; ||||| NOTE THAT WE NEED TO READ THE ORIGINAL *target-width* AND
;;; *increment-width* VARIABLES TO PERFORM THIS CALCULATION CORRECTLY.
;;; 
;;; Changed from comma delimited to tab delimited format.[mcox 8aug12]
;;; 
(defun output-answers (block-limit 
		       &optional
		       epsilon
		       (results (if (not 
				     (boundp 'results))
				    (read-data
				     (concatenate 
					 'string 
				       *data-directory* 
				       "results.txt"))))
		       answer-key
		       target-width
		       increment-width)
  (if (not answer-key)
      (multiple-value-setq (answer-key
			    target-width
			    increment-width)
	(read-key)))
  (with-open-file
   (ofile 
    (format 
     nil
     "~atest-answer-~F.txt"
     *data-directory*
     epsilon)
    :direction :output
    :if-does-not-exist :create)
   ;; Write header
   (format ofile 
	   "File Num~A Target Loc~A Intensity~A Step Predict~A Loc Predict"
	    #\tab #\tab #\tab #\tab)
   ;; ||||| Is the following in the right order?
   (dolist (each-predicate *predicates*)
     (format ofile "~A ~s" #\tab each-predicate))
   (terpri ofile)
   (dotimes (block-number block-limit)
     (format ofile "~A"
	     (write-answer 
	      (+ block-number 1)
	      answer-key
	      target-width
	      increment-width
	      results))))
  )


;;; 
;;; Function determine-target-width automatically calculates a value
;;; to be assigned the global variable *target-width*. The value is 15
;;; percent the length of the *normal-pool*, but not less than 30 or
;;; more than 150.
;;; 
;;; ||||| SHOULD HAVE ERROR MSGS WHEN OUT OF BOUNDS.
;;; 
(defun determine-target-width ()
  "Calculate a value for *target-width* between 30 and width of *anomaly-pool*"
  (min (length *anomaly-pool*)
       (max 30
	    (floor
	     (* .15 
		(length *normal-pool*)))))
  )


;;; 
;;; We need 10 increments in the space left after the width of the
;;; target and the initial normal increment (which is also the width
;;; of the target) is removed.
;;; 
(defun determine-increment-width ()
  "Calculate a value for *increment-width* no less than 15"
  (max 15
       (floor 
	(/ (- (length *normal-pool*) 
	      (* 2 (determine-target-width))) 
	   10)))
  )


;;; 
;;; Function prep-pools assigns values to the normal and anomaly pools
;;; from disk. They were previously written by function solve-problems.
;;; 
(defun prep-pools (&optional
		   (file-name
		    (format 
		     nil 
		     "~adata.txt"
		     *data-directory*)))
  (setf *normal-pool*
    (remove-nulls
     (read-data file-name)))
  (setf *anomaly-pool*
    (remove-nulls
     (read-data
      (format  nil 
	       "~adata-anomalous.txt"
	       *data-directory*))))
  )


;;; ||||| Comment
(defun solve-all (number-of-problems
		   &optional
		   ( domain-name 'logistics)
		   )
  (load-a-dist domain-name)
  (solve-problems number-of-problems 
		  t)
  (init-anomalous-run domain-name)
  (solve-problems number-of-problems 
		  t 
		  300 
		  (format  nil 
			   "~adata-anomalous.txt"
			   *data-directory*))
  (restore-file-names domain-name)
  )

;;; If called by itself, call load-a-dist.
(defun process-solns (&optional
		      epsilon)
  (prep-pools)
  (assemble-data)
  (if epsilon
      (output-answers 110 epsilon
		      (eval-and-write 110 epsilon))
    ;; Epsilon ranges from .2 to .75 inclusive
    (dotimes (n 6)
       
       (setf epsilon (+ (/ 1 10) (/ (+ 1 n) 10))) 
       (eval-and-write 110 epsilon)
     
       (setf epsilon (+ (/ 1 20) epsilon) )
       (eval-and-write 110 epsilon)))
  )
  
  
(defun run-a-dist (number-of-problems
		   &optional
		   (domain-name 'logistics)
		   epsilon
		   )
  (solve-all number-of-problems
	     domain-name )
  (process-solns epsilon)
  )
