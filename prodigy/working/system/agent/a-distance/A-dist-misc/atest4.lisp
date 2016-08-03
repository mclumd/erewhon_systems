(in-package :user)

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
;;; a single list. The first vector is also extracted and passed to be
;;; used with the list of accessors within the call to find-anomalies.
;;; The function returns two values. The first value is a list of
;;; anomaly starting locations with -1 indicating no anomaly. The
;;; second value is the time the function took to compute the first
;;; value.
;;; 
(defun detect-anomalies (data
			 &optional
			 epsilon 
			 &aux
			 (initial-time 
			  (get-internal-run-time)))
  (values
   (find-anomalies (collapse-lists 
		    data) 
		   ;; first vector
		   (first 
		    ;; first plan
		    (first data))
		   *accessor-list*
		   epsilon)
   (- (get-internal-run-time)
      initial-time))
  )


(defparameter *false-positive-probability*
    0.05 "Alpha")


;;; 
;;; Function find-anomalies uses the first vector simply to determine
;;; the number of predicates in a vector. Using the accessors list,
;;; the function then performs a (first collapsed-data), (second
;;; collapsed-data), ... up to the size of the vector. The calls
;;; create a stream for the current invocation to look for a change.
;;; 
(defun find-anomalies (collapsed-data
		       first-vector
		       accessors
		       &optional
		       ;;epsilon may be passed or computed
		       epsilon
		       &aux
		       stream
		       (compute-epsilon
			(null epsilon)))
  "For each of the predicate streams in the collapsed plans, find the first anomaly."
  (cond ((null first-vector)
	 nil)
	((null accessors)
	 (format 
	  t 
	  "Find-anomalies currently works only for vectors of size 10 or less.~%")
	 nil)
	(t
	 (setf stream				
	   (trans2diffs 
	    (mapcar (first accessors) 
		    collapsed-data)))
	 (format t 
		 "~%epsilon: ~s"
		 (or epsilon
		     (setf epsilon
		       (compute-epsilon 
			;;(subseq stream 0 3400)
			stream
			*false-positive-probability*
			100))))
	 (cons (find-change (make-wp stream
				     .05 
				     0.5 
				     100) 
			    stream 
			    epsilon)
	       (find-anomalies
		collapsed-data
		(rest first-vector)
		(rest accessors)
		(if compute-epsilon
		    nil
		  epsilon)))
	 ))
  )

