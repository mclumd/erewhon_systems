(in-package :user)


;;;A window is a list, an empty window is an empty list
(defun make-window ()
  ())

#|
;;; No longer used [mcox 5apr12]

;;;removes the last item in a list. Used for inserting into full windows.
(defun remove-last (front back)
  (if front
      (if back
	  (cons front (remove-last (first back) (rest back)))
	())
    ()))


;;;add val to window, if window at capacity, remove last item
(defun add-to-window (window val capacity)
  (if (< (list-length window) capacity)
      (cons val window)
    (cons val (remove-last (first window) (rest window)))))
|#

;;;essentially a wrapper for list-length
(defun window-full (window n)
  (= n (list-length window)))

;;;an interval is a length 3 list (min max numItems)
(defun create-interval (min max)
  (list min max 0))


;;; 
;;; An interval is a length-3 list (min max numItems)
;;; Set the numItems to 0 [mcox 4apr12]
;;; 
(defun clear-interval (interval)
  (when (consp interval)			;If non-empty list
    (setf (third interval) 0)
    interval)
  )

#|
;;; No longer used [mcox 5apr12]

;;;adds an item to an interval if it is in the range
(defun add-to-interval (interval val)
  (if (and (>= val (first interval)) (<= val (second interval)))
      (list (first interval) (second interval) (+ 1 (third interval)))
    interval))

;;;removes an item if in range
(defun remove-from-interval (interval val)
  (if (and (>= val (first interval)) (<= val (second interval)))
      (list (first interval) (second interval) (- (third interval) 1))
    interval))
|#


;;; 
;;; We want to use the interval-size function as an access function to
;;; make the code more readable, but we want the compiler to open-code
;;; the function calls (i.e., replace the procedure calls directly
;;; with the parameterized code body). [mcox 5apr12]
;;; 
(proclaim '(inline interval-size))

;;;I do not believe this is used, but returns the number of items in interval
(defun interval-size (interval)
  (third interval))

#|
;;; No longer used [mcox 5apr12]

;;;adds a value to every interval in a list
(defun add-to-all (val list)
  (if list
      (cons (add-to-interval (first list) val) 
	    (add-to-all val (rest list)))
    list))

;;;removes from every interval in a list
(defun remove-from-all (val list)
  (if list
      (cons (remove-from-interval (first list) val) (remove-from-all val (rest list)))
    list))
|#

;;;the only data structure, contains two windows, two lists of intervals,
;;;and the max size of the windows.
(defstruct windowPair w1 w2 i1 i2 n)

;;;creates a windowPair with
;;; data = data sample to base intervals on
;;; p = proportion of total data set each interval covers
;;; o = overlap between intervals
;;; n = size of windows
(defun make-wp (data p o n)
  (make-windowPair :w1 () 
		   :w2 () 
		   :i1 (create-proportional-intervals 
			(copy-list data) p o)
		   :i2 (create-proportional-intervals 
			(copy-list data) p o) 
		   :n n))

;;; 
;;; Function init-wp initializes the given window pair by adding n
;;; data to both pairs (i.e., filling in the initial window data). The
;;; function assumes that the intervals are already established by
;;; make-wp. [mcox 5apr12]
;;; 
(defun init-wp (wp data)
  (when (= (length data) (windowPair-n wp))
    (setf (windowPair-w1 wp) 
      (setf data (reverse data)))
    (setf (windowPair-w2 wp) data)	;This is thus reversed also.
    (mapcar #'(lambda (x)
		(setf (windowPair-i1 wp)
		  (add2intervals (windowPair-i1 wp) x))
		(setf (windowPair-i2 wp)
		  (add2intervals (windowPair-i2 wp) x))
		)
	    data)
    )
  )


;;; 
;;; Function add2intervals increments the interval counters for the
;;; value of val. Added [mcox 3 Apr12]
;;; 
(defun add2intervals (intervals val)
  (cond ((null intervals)
	 nil)
	(t
	 (if (in-interval-p (first intervals) val)
	     (incf (third (first intervals))))
	 (cons (first intervals) 
	       (add2intervals (rest intervals) val)))
	)
  )

;;; 
;;; Function remove-from-intervals decrements the interval counters
;;; for the value of val. This function is used when a value is
;;; removed from a sliding window. Added [mcox 3 Apr12]
;;; 
(defun remove-from-intervals (intervals val)
  (cond ((null intervals)
	 nil)
	(t
	 (if (in-interval-p (first intervals) val)
	     (decf (third (first intervals))))
	 (if (< (interval-size (first intervals)) 0)
	     (break "Negative interval ~S~%" (third (first intervals))))
	 (cons (first intervals) 
	       (remove-from-intervals (rest intervals) val)))
	)
  )


;;; Added [mcox 3 Apr12]
(defun in-interval-p (interval val)
  "Returns non-nil if val is within the interval."
  (and (>= val (first interval))
       (<= val (second interval)))
  )


;;;add one data element to a window pair
;;; 
;;; Changed this function to assign new values to the fields of the
;;; structure wp instead of creating new structures each time. [mcox
;;; 4apr12]
;;; 
(defun add-data (wp value)
  (cond ((window-full (windowPair-w1 wp) 
		      (windowPair-n wp))
	 (setf (windowPair-i2 wp) 
	   (add2intervals (setf (windowPair-i2 wp) 
			    (remove-from-intervals
			     (windowPair-i2 wp)
			     (first (last (windowPair-w2 wp)))))
			  value))
	 (setf (windowPair-w2 wp)
	   (cons value (butlast (windowPair-w2 wp)))))
	(t
	 (setf (windowPair-w1 wp) 
	   (cons value (windowPair-w1 wp)))
	 (setf (windowPair-w2 wp)
	   (cons value (windowPair-w2 wp)))
	 (setf (windowPair-i1 wp)
	   (add2intervals (windowPair-i1 wp) 
			  value))
	 (setf (windowPair-i2 wp)
	   (add2intervals (windowPair-i2 wp) 
			  value)))
	)
  wp					;Returns wp
  )


;;;add an entire data list to a window pair
(defun add-all-data (wp data)
  ;; Should use null rather than not [mcox 4apr12]
  (if (null data) 
      wp
    (add-all-data 
     (add-data wp (first data))
     (rest data))))

;;;returns the part of a list after n elements
(defun restN (l n)
  (if (= 0 n) l
    (restN (rest l) (- n 1))))

;;;helper function for creating intervals for a given dataset
(defun proportional-helper (data width offset)
  (if data
      (if (<= (list-length data) width)
	  (cons (create-interval (first data) 
				 (nth (- (list-length data) 1) data))
		(proportional-helper () width offset))
	
	(cons (create-interval (first data) 
			       (nth width data))
	      (proportional-helper (restN data offset) 
				   width offset)))
    
    ()))

;;;given data list, creates a list of intervals, each of which covers a
;;;proportion p of the data set and overlaps o of the next interval
(defun create-proportional-intervals (data p o)
  (let ((sortedData (sort data #'<)))
    (proportional-helper sortedData 
			 (max 1 (floor (* (list-length sortedData) 
					  p)))
			 (max 1 (floor (* (floor (* (list-length sortedData) p)) 
					  (- 1 o))))
			 )))

;;;finds the min value in a list of intervals
;;; 
;;; Removed recursive call [mcox 3Apr12]
;;; 
(defun min-all-ints (ints)
  (if ints
      (first (first ints))		;Should just be found in first element.
      ;;(min (first (first ints)) 
	   ;;(min-all-ints (rest ints)))
    1e20))

;;max value in a list of intervals
;;; 
;;; Removed recursive call [mcox 3Apr12]
;;; 
(defun max-all-ints (ints)
  (if ints
      (second (last ints)) 
      ;;(max (second (first ints)) 
	;;   (max-all-ints (rest ints)))
    -1e20))

;;;helper funct for finding a uniform sample in a range. Can be used by
;;;itself to create samples without a corresponding wp.
(defun sample-helper (n low high)
  (if (> n 0)
      (cons (+ low (random (- high low)))
	    (sample-helper (- n 1) low high))
    ;; nil is the default "then" value [mcox 4apr12]
    ;;nil
    ))

;;;returns a uniform sample based on the range of the input wp, with size n
;;;currently, all samples returns are integers.
(defun uniform-sample (wp n)
  (let ((low (min-all-ints (windowPair-i1 wp))) 
	(high (max-all-ints (windowPair-i2 wp))))
    (sample-helper n low high)))

;;;relativizes a value based on Tim's code
(defun relativize (val p1 p2)
  (/ val (sqrt (min (/ (+ p1 p2) 2) 
		    (- 1 (/ (+ p1 p2) 2))))))

;;;helper funct for a-dist
;;; 
;;; Added local variables i1s-proportion and i2s-proportion. [mcox 2Apr12]
;;; 
(defun max-dist (n i1 i2 relativized
		 &aux
		 (i1s-proportion (if i1 (/ (interval-size (first i1)) n)))
		 (i2s-proportion (if i2 (/ (interval-size (first i2)) n)))
		  )
  (if i1
      (if (= i1s-proportion i2s-proportion)
	  (max 0 
	       (max-dist n (rest i1) (rest i2) relativized))
	
	(let ((val (abs (- i1s-proportion
			   i2s-proportion))))
	  (if relativized
	      (max (relativize val 
			       i1s-proportion 
			       i2s-proportion)
		   (max-dist n (rest i1) (rest i2) relativized))
	    (max val 
		 (max-dist n (rest i1) (rest i2) relativized)))))
    -1e20))


;;;returns the a-distance between the windows in given wp. relativized is a
;;;bool value.
(defun a-dist (wp relativized)
  (max-dist (windowPair-n wp) 
	    (windowPair-i1 wp) 
	    (windowPair-i2 wp) 
	    relativized)
  )

;;;clears to zero all counts from a list of intervals
(defun intervals-clear (intervals)
  (if intervals
      (cons 
       ;; Changed to call of clear-interval 
       ;; from create-interval [mcox 4 apr12]
       (clear-interval (first intervals))
       (intervals-clear (rest intervals)))
    nil)
  )


;;;clears a wp
(defun wp-clear (wp)
  (setf (windowPair-w1 wp) nil)
  (setf (windowPair-w2 wp) nil)
  (setf (windowPair-i1 wp) 
    (intervals-clear (windowPair-i1 wp)))
  (setf (windowPair-i2 wp) 
    (intervals-clear (windowPair-i2 wp)))
  wp
  ;;(make-windowPair :w1 () 
	;;	   :w2 () 
	;;	   :i1 (intervals-clear (windowPair-i1 wp)) 
	;;	   :i2 (intervals-clear (windowPair-i2 wp)) 
  ;;	   :n (windowPair-n wp))
  )

;;;returns list l with value at location n removed
(defun remove-at (n l)
  (if l
      (if (= n 0) (rest l) (cons (first l) (remove-at (- n 1) (rest l))))
    nil))

;;;helper for list shuffle
(defun shuffle-helper (l newl)
  (if l
      (let ((index (random (list-length l))))
	(shuffle-helper (remove-at index l)
			(cons (nth index l) newl)))
    newl))

;;;returns a shuffled version of list l
(defun list-shuffle (l)
  (shuffle-helper l ()))


;;; The following shuffles a sequence including a list. 
;;; Got this code off the internet. [mcox 3apr]
;;;
(defun seqrnd (seq)
  "Randomize the elements of a sequence. Destructive on SEQ."
  (sort seq #'> :key (lambda (x) (random 1.0))))


;;;runs one iteration of the epsilon computing function; returns largest epsilon
;;; 
;;; Major changes to this function. Because we initialize wp before
;;; calling largest-epsilon, we no longer have the condition where
;;; window is not full. [mcox 5apr12]
;;; 
(defun largest-epsilon (wp data 
		      &optional
		      (largest 0))
  (cond (data
	 (add-data wp (first data))
	 (largest-epsilon wp 
			  (rest data) 
			  (max largest 
			       ;; a-dist should be called 
			       ;; with t not 1 [mcox 4 apr12]
			       (a-dist wp t))))
	(t
	 largest))
  )


;;;runs n iterations of epsilon computing function; returns list of results
;;; 
;;; Changed local variable wp to local-wp to remove the ambiguity
;;; Changed n to num-iterations so as not to confuse with n the window
;;; width. [mcox 4apr12]
;;;
;;; Assume wp is already initialized. [mcox 5apr12]
;;; 
(defun epsilon-helper (data 
		       num-iterations
		       &optional
		       debug)
  (let* ((shuffled 
	  ;; Substituted another shuffle but call it on a copy of data.
	  ;; Otherwise side effects occur because seqrnd is destructive 
	  ;; [mcox 3Apr12]
	  (seqrnd (copy-seq data))) 
	 (local-wp (make-wp shuffled .05 0.5 100)))
    ;; Initialize wp with the first n data. [mcox 6apr12]
    (init-wp local-wp 
	     (subseq shuffled
		     0 
		     (windowPair-n local-wp)))
    (if debug
	(format t 
		"local-wp = ~s~%shuffled data = ~S~%iteration number = ~S~%"
		local-wp
		shuffled
		num-iterations))
    (if (= num-iterations 0)
	nil
      (cons (largest-epsilon local-wp	;Use copy passed [mcox 5apr12]
			     ;;Trim the first n data. [mcox 6apr12]			   
			     (subseq shuffled
				     (windowPair-n local-wp) 
				     (length shuffled)) 
			     ;;epsilon-helper should not have to know the initial largest [mcox 6apr12]
			     ;;0 
			     )
	    (epsilon-helper data 
			    (- num-iterations 1)
			    debug))))
  )


;;;returns the epsilon value at cutoff p after num-iterations iterations of epsilon computer
;;; 
;;; Function compute-epsilon no longer receives a wp as
;;; input. epsilon-helper creates it for each iteration. [mcox 6apr12]
;;; 
;;; Changed the function name compute-alpha to compute-epsilon.
;;; Changed parameter p to alpha. Epsilon is the threshold the
;;; function should compute. Alpha is the largest false positive rate
;;; to tolerate. See Dredze, Oates, & Piatko [mcox 23apr12]
;;; 
(defun compute-epsilon (data 
			alpha 
			num-iterations
			&optional
			debug)
  (let ((maxDists 
	 (sort (epsilon-helper ;;wp - no longer pass wp
		data
		num-iterations
		debug) 
	       #'<)))
    (nth (floor (* num-iterations (- 1 alpha))) maxDists)))

;;;helper for find change
(defun change-helper (wp data epsilon)
  (if data
      (let ((wpNew (add-data wp (first data))))
	;; Should initialize wp and remove the window-full test 
	;; as with largest-epsilon [mcox 7apr12]
	(if (window-full (windowPair-w1 wpNew) (windowPair-n wpNew))
	    (if (> (a-dist wpNew t)	;1 -> t [mcox 5apr12]
		   epsilon)
		(list-length data)
	      (change-helper wpNew (rest data) epsilon))
	  (change-helper wpNew (rest data) epsilon)))
    -1))

;;;adds data to given wp. If change is detected, prints the location. 
;;;Otherwise, prints that no change is detected.
;;;Note: this function does not change the input wp. If you want to
;;;permanently add the data, call (setq wp (add-all-data wp data)).
;;; 
;;; Local variable is really a location, so I changed the name from
;;; change to change-location. [mcox 5apr12]
;;; 
(defun find-change (wp data epsilon)
  (let ((change-location 
	 (change-helper wp data epsilon)))
    (cond ((> change-location -1)
	   (print			;Added [mcox 20apr12]
	    (format nil 
		    "change detected. Location: ~A" 
		    (- (list-length data)
		       change-location)))
	   (- (list-length data)
	      change-location))
	  (t
	   (print "no change detected")
	   -1))
    )		;return change location [mcox 19apr12]
  )



;;;; 
;;;; New set of functions to work on plan lists such as *normal-pool*.
;;;; For example the following call creates a stream of predicate
;;;; changes on the fourth predicate. [mcox 18-19apr12]
;;;; 
;;;; (trans2diffs (mapcar #'fourth  (collapse-lists *normal-pool*)))
;;;; 


;;; 
;;; Function trans2diffs takes a seq of at least size two and
;;; translates it into a seq of the differences between subsequent
;;; elements. Thus (trans2diffs '(1 2 3 5 8 0)) --> (1 1 2 3 -8).
;;; 
(defun trans2diffs (seq)
  (cond ((or (null seq)
	     (null (rest seq)))
	 nil)
	(t 
	 (cons (- (second seq) (first seq))
	       (trans2diffs (rest seq)))))
  )


(defun collapse-lists (seq)
  "Collapse a list of lists into a single appended list."
  (cond ((null seq)
	 nil)
	(t (append (first seq)
		   (collapse-lists (rest seq)))))
  )


;;; 
;;; Function plan2step computes the step at which plan number plan-num
;;; begins. So if the 3rd plan in the sequence is anomalous, then the
;;; step at which the anomaly begins is (length (first seq)) + (length
;;; (second seq)) + 1 or (plan2step seq 3).
;;; 
(defun plan2step (seq plan-num)
  (cond ((null seq)			;If t something is wrong
	 most-negative-fixnum)
	((eql 1 plan-num)
	 1)
	(t 
	 (+ (length (first seq))
	    (plan2step (rest seq)
		       (- plan-num 1)))))
  )


;;; 
;;; Function step2plan is the converse of plan2step. It takes a step
;;; number in a flattened vector representation of plans and returns
;;; the plan number in the non-flattened representation. Thus if
;;; find-change returns step 5 and the plan list was ((x x x)(x X)(x x
;;; x)), step2plan will return 2.
;;; 
(defun step2plan (plan-seq 
		  step-num
		  &optional
		  (result 1))
  "Returns the number of the plan in which the anomaly is located."
  (cond ((null plan-seq)
	 nil)
	((>= (length (first plan-seq))
	     step-num)
	 result)
	(t
	 (step2plan (rest plan-seq)
		    (- step-num
		       (length (first plan-seq)))
		    (+ result 1))))
  )
