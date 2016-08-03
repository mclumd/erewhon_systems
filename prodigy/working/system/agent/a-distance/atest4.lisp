(in-package :user)

;;; Turning off the default warning messages from the garbage collector
(setf excl:*global-gc-behavior* :auto) 

;;; ||||| NEED TO COMMENT THE FOLLOWING TWO BETTER.

(defparameter *false-positive-probability*
    0.05 "Alpha")

(defparameter *number-iterations*
    100 "Number of candidate epsilons computed to get a candidate.")


#|

(setf alpha				;find alpha. 10 iterations because this function is slow.
  (compute-alpha 
   (setf data				
     (sample-helper 1000 0 100))	;n=1000
   .4 10))

(find-change (make-wp data		;wp using data as sample
		      .05 
		      0.5 
		      100) 
	     data 
	     alpha)			;any change?




(find-change (make-wp data		;wp using data as sample
		      .05 
		      0.5 
		      100)
	     (setf data1 
	       (append 
		data 
		(sample-helper 1000 50 150))) ;data from a different distribution
	     alpha)			;should find a change
|#
 

(defconstant *accessor-list*
    '(first second third fourth fifth sixth seventh eighth ninth tenth))


;;; 
;;; Function detect-anomalies takes as input a sequence of data and an
;;; optional epsilon value and searches for aberant values in the
;;; sequence. The data are composed of a series of plans, each of
;;; which is represented by state predicate vectors. The plan
;;; boundaries in the data are removed by collapsing the vectors into
;;; a single list. THIS IS NO LONGFER DONE. The first vector is also
;;; extracted and passed to be used with the list of accessors within
;;; the call to find-anomalies.  The function returns two values. The
;;; first value is a list of anomaly starting locations with -1
;;; indicating no anomaly. The second value is the time the function
;;; took to compute the first value.
;;; 
(defun detect-anomalies (data
			 &optional
			 epsilon 
			 &aux
			 (initial-time 
			  (get-internal-run-time)))
  (values
   (find-anomalies data
		   ;; first vector
		   (first 
		    ;; first plan
		    (first data))
		   *accessor-list*
		   epsilon)
   (- (get-internal-run-time)
      initial-time))
  )


;;; 
;;; Function find-anomalies uses the first vector simply to determine
;;; the number of predicates in a vector. Using the accessors list,
;;; the function then performs a (first data), (second data), ... up
;;; to the size of the vector. The calls create a stream for the
;;; current invocation to look for a change.
;;; ||||| COMMENT OUT OF DATE.
;;; 
(defun find-anomalies (data
		       first-vector
		       accessors
		       &optional
		       ;;epsilon may be passed or computed
		       epsilon
		       &aux
		       stream
		       (will-compute-epsilon
			(null epsilon)))
  "For each of the predicate streams in the plans, find the first anomaly."
  (cond ((null first-vector)
	 nil)
	((null accessors)
	 (format 
	  t 
	  "Find-anomalies currently works only for vectors of size 10 or less.~%")
	 nil)
	(t
	 (setf stream				
	   (collapse-lists
	    (mapcar  #'(lambda (x) 
			 (trans2diffs 
			  (mapcar (first accessors) x)))
		     data)))
	 (format t 
		 "~%~%epsilon: ~s"
		 (or epsilon
		     (setf epsilon
		       (compute-epsilon 
			;;(subseq stream 0 3400)
			stream
			*false-positive-probability*
			*number-iterations*))))
	 (cons (find-changes (make-wp stream
				     .05 
				     0.5 
				     100) 
			    stream 
			    epsilon)
	       (find-anomalies
		data
		(rest first-vector)
		(rest accessors)
		(if will-compute-epsilon
		    nil
		  epsilon)))
	 ))
  )


(defun detect-change-from-num (plan num pos)
  "Return t if any element of plan in the pos position differs from the num value."
  (if (null plan)
      nil
    (if (not (eql num (nth pos (first plan))))
	(nth pos (first plan))
      (detect-change-from-num 
	 (rest plan) 
	 num 
	 pos)))
  )


;;; Wrote this quickly to test if particular predicate streams were
;;; unchanging (i.e., static predicates).
;;; 
(defun detect-c-f-n (plan-list 
		     num 
		     pos
		     &aux 
		     found 
		     current)
  (dolist (plan plan-list)
    (if (setf current
	  (detect-change-from-num plan num pos))
	(setf found current))
    )
  found)