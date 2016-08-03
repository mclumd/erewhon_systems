
;;;A window is a list, an empty window is an empty list
(defun make-window ()
	())

;;;removes the last item in a list. Used for inserting into full windows.
(defun remove-last (front back)
	(butlast (cons front back)))
	;(if front
	;	(if back
	;		(cons front (remove-last (first back) (rest back)))
	;		())
	;	()))
	

;;;add val to window, if window at capacity, remove last item
(defun add-to-window (window val capacity)
	(if (< (list-length window) capacity)
		(cons val window)
		(cons val (remove-last (first window) (rest window)))))

;;;essentially a wrapper for list-length
(defun window-full (window n)
	(= n (list-length window)))

;;;an interval is a length 3 list (min max numItems)
(defun create-interval (min max)
	(list min max 0))

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

;;;I do not believe this is used, but returns the number of items in interval
(defun interval-size (interval)
	(third interval))

;;;adds a value to every interval in a list
(defun add-to-all (val list)
	(if list
		(cons (add-to-interval (first list) val) (add-to-all val (rest list)))
		list))

;;;removes from every interval in a list
(defun remove-from-all (val list)
	(if list
		(cons (remove-from-interval (first list) val) (remove-from-all val (rest list)))
		list))

;;;the only data structure, contains two windows, two lists of intervals,
;;;and the max size of the windows.
(defstruct windowPair w1 w2 i1 i2 n)

;;;creates a windowPair with
;;; data = data sample to base intervals on
;;; p = proportion of total data set each interval covers
;;; o = overlap between intervals
;;; n = size of windows
(defun make-wp (data p o n)
	(make-windowPair :w1 () :w2 () :i1 (create-proportional-intervals (copy-list data) p o) :i2 (create-proportional-intervals (copy-list data) p o) :n n))

;;;add one data element to a window pair
(defun add-data (wp value)
	(if (window-full (windowPair-w1 wp) (windowPair-n wp))
		
		(make-windowPair :n (windowPair-n wp) :w1 (windowPair-w1 wp) :w2 (add-to-window (windowPair-w2 wp) value (windowPair-n wp)) :i1 (windowPair-i1 wp) :i2 (add-to-all value (remove-from-all (nth (- (windowPair-n wp) 1) (windowPair-w2 wp)) (windowPair-i2 wp))))
		
		(make-windowPair :n (windowPair-n wp) :w1 (add-to-window (windowPair-w1 wp) value (windowPair-n wp)) :w2 (add-to-window (windowPair-w2 wp) value (windowPair-n wp)) :i1 (add-to-all value (windowPair-i1 wp)) :i2 (add-to-all value (windowPair-i2 wp)))))
		
;;;add an entire data list to a window pair
(defun add-all-data (wp data)
	(if (not data) wp
		(add-all-data (add-data wp (first data)) (rest data))))

;;;returns the part of a list after n elements
(defun restN (l n)
	(if (= 0 n) l
		(restN (rest l) (- n 1))))

;;;helper function for creating intervals for a given dataset
(defun proportional-helper (data width offset)
	(if data
		(if (<= (list-length data) width)
			(cons (create-interval (first data) (nth (- (list-length data) 1) data)) (proportional-helper () width offset))
			
			(cons (create-interval (first data) (nth width data)) (proportional-helper (restN data offset) width offset)))
		
		()))

;;;given data list, creates a list of intervals, each of which covers a
;;;proportion p of the data set and overlaps o of the next interval
(defun create-proportional-intervals (data p o)
	(let ((sortedData (sort data #'<)))
		(proportional-helper sortedData (max 1 (floor (* (list-length sortedData) p))) (max 1 (floor (* (floor (* (list-length sortedData) p)) (- 1 o)))))))

;;;finds the min value in a list of intervals
(defun min-all-ints (ints)
	(if ints
		(min (first (first ints)) (min-all-ints (rest ints)))
		1e20))

;;max value in a list of intervals
(defun max-all-ints (ints)
	(if ints
		(max (second (first ints)) (max-all-ints (rest ints)))
		-1e20))

;;;helper funct for finding a uniform sample in a range. Can be used by
;;;itself to create samples without a corresponding wp.
(defun sample-helper (n low high)
	(if (> n 0)
		(cons (+ low (random (- high low))) (sample-helper (- n 1) low high))
		nil))

;;;returns a uniform sample based on the range of the input wp, with size n
;;;currently, all samples returns are integers.
(defun uniform-sample (wp n)
	(let ((low (min-all-ints (windowPair-i1 wp))) (high (max-all-ints (windowPair-i2 wp))))
		(sample-helper n low high)))

;;;relativizes a value based on Tim's code
(defun relativize (val p1 p2)
	(/ val (sqrt (min (/ (+ p1 p2) 2) (- 1 (/ (+ p1 p2) 2))))))

;;;helper funct for a-dist
(defun max-dist (n i1 i2 relativized)
	(if i1
		(if (= (/ (third (first i1)) n) (/ (third (first i2)) n))
			(max 0 (max-dist n (rest i1) (rest i2) relativized))
			
			(let ((val (abs (- (/ (third (first i1)) n) (/ (third (first i2)) n)))))
				(if relativized
					(max (relativize val (/ (third (first i1)) n) (/ (third (first i2)) n)) (max-dist n (rest i1) (rest i2) relativized))
					(max val (max-dist n (rest i1) (rest i2) relativized)))))
		-1e20))
					
				
;;;returns the a-distance between the windows in given wp. relativized is a
;;;bool value.
(defun a-dist (wp relativized)
	(max-dist (windowPair-n wp) (windowPair-i1 wp) (windowPair-i2 wp) relativized))

;;;clears all values from a list of intervals
(defun intervals-clear (intervals)
	(if intervals
		(cons (create-interval (first (first intervals)) (second (first intervals))) (intervals-clear (rest intervals)))
		nil))

;;;clears a wp
(defun wp-clear (wp)
	(make-windowPair :w1 () :w2 () :i1 (intervals-clear (windowPair-i1 wp)) :i2 (intervals-clear (windowPair-i2 wp)) :n (windowPair-n wp)))

;;;returns list l with value at location n removed
(defun remove-at (n l)
	(if l
		(if (= n 0) (rest l) (cons (first l) (remove-at (- n 1) (rest l))))
		nil))

;;;helper for list shuffle
(defun shuffle-helper (l newl)
	(if l
		(let ((index (random (list-length l))))
			(shuffle-helper (remove-at index l) (cons (nth index l) newl)))
		newl))

;;;returns a shuffled version of list l
(defun list-shuffle (l)
	(shuffle-helper l ()))

;;;runs one iteration of the alpha computing function; returns largest alpha
(defun largest-alpha (wp data largest)
	(if data
		(let ((wpNew (add-data wp (first data))))
			(if (window-full (windowPair-w1 wpNew) (windowPair-n wpNew))
				(largest-alpha wpNew (rest data) (max largest (a-dist wpNew 1)))
				(largest-alpha wpNew (rest data) largest)))
		largest))
		
;;;runs n iterations of alpha computing function; returns list of results
(defun alpha-helper (wp data n)
	(let ((wp (wp-clear wp)) (shuffled (list-shuffle data)))
		(if (= n 0)
			()
			(cons (largest-alpha wp shuffled 0) (alpha-helper wp data (- n 1))))))

;;;runs n iterations of alpha computing function; returns list of results
(defun no-shuffle-alpha (wp data n)
	(let ((wp (wp-clear wp)))
		(if (= n 0)
			()
			(cons (largest-alpha wp data 0) (no-shuffle-alpha wp data (- n 1))))))

;;;returns the alpha value at cutoff p after n iterations of alpha computer
(defun compute-alpha (wp data p n)
	(let ((maxDists (sort (alpha-helper wp data n) #'<)))
		(print maxDists)
		(nth (floor (* n (- 1 p))) maxDists)))
		
(defun compute-alpha-ns (wp data p n)
	(let ((maxDists (sort (no-shuffle-alpha wp data n) #'<)))
		(nth (floor (* n (- 1 p))) maxDists)))

;;;helper for find change
(defun change-helper (wp data alpha)
	(if data
		(let ((wpNew (add-data wp (first data))))
			(if (window-full (windowPair-w1 wpNew) (windowPair-n wpNew))
				(if (> (a-dist wpNew 1) alpha)
					(list-length data)
					(change-helper wpNew (rest data) alpha))
				(change-helper wpNew (rest data) alpha)))
		-1))

;;;adds data to given wp. If change is detected, prints the location. 
;;;Otherwise, prints that no change is detected.
;;;Note: this function does not change the input wp. If you want to
;;;permanently add the data, call (setq wp (add-all-data wp data)).
(defun find-change (wp data alpha)
	(let ((change (change-helper wp data alpha)))
		(if (> change -1)
			(format nil "change detected. Location: ~A" (- (list-length data) change))
			(print "no change detected"))))
			
;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Multi-element vector methods:
;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
(defun make-const-list (length val)
	(if (= length 0)
		nil
		(cons val (make-const-list (- length 1) val))))
	
;;;creates a set of windowPairs of size num with
;;; data = data sample to base intervals on
;;; p = proportion of total data set each interval covers
;;; o = overlap between intervals
;;; n = size of windows
(defun create-window-pairs (num data p o n)
	(if (= num 0) nil
		(cons (make-wp (mapcar #'nth (make-const-list (list-length data) (- num 1)) data) p o n) (create-window-pairs (- num 1) data p o n))))

(defun compute-alphas (num wps data p n)
	(if (= num 0) nil
		(cons (compute-alpha (first wps) (mapcar #'nth (make-const-list (list-length data) (- num 1)) data) p n) (compute-alphas (- num 1) (rest wps) data p n))))
		
(defun find-change-v (num wps data alphas)
	(if (= num 0) nil
		(cons (change-helper (first wps) (mapcar #'nth (make-const-list (list-length data) (- num 1)) data) (first alphas)) (find-change-v (- num 1) (rest wps) data (rest alphas)))))
		
(defun list-concat (lists)
	(if lists
		(append (first lists) (list-concat (rest lists)))
		nil))

(defun subtract-next (data)
	(if (rest data)
		(mapcar #'- (first data) (second data))
		nil))

(defun get-differences (data)
	(if data
		(cons (subtract-next data) (get-differences (rest data)))))
		

		
;;;Tests:

;;(setq data (append difs1 difs2))

;;(setq wps (create-window-pairs 8 difs1 .05 .5 40))
;;(setq alphas (compute-alphas 8 wps difs1 .1 20))
;;(find-change-v 8 wps data falphas)
;;(setq falphas '(0.76167777 0.82761797 0.3914555 0.39426407 0.29637773 0.79999998 0.76668138 0.76666664))