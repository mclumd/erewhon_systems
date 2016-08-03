;; SOLUTIONS.LISP
;; Calculates a decent(?) solution for the route scheduler

(in-package "PSM")

(defparameter *max-route-length* 10 "To limit the number of hops
in the maximum path we search")
(defparameter *num-indiv-routes* 3 "The number of *best* individual
routes we'll use")
(defparameter *MaxInt* 99999)

;; KQML Call:
;; e.g.,
;; (REQUEST :RE 2 :REPLY-WITH RQ159 :SENDER PRINCE :RECEIVER PS :CONTENT
;;  (:find-solution :content (:and (:go g1 (:to toronto)) (:go g3 (:to
;; richmond)))))
;; 
;; 'solve' gets the list beginning with :and, or possibly just a single :go.
;; 
;; Returns
;; 
;; (:time <time>
;; :distance <distance>
;; :cost <cost>
;; :hops <number of hops>
;; :routes ((:agent <agent> :actions <list of actions>)*))
;;
;; note: we use 'reduce' instead of 'apply' so we can give an initial value
;; (in the case where there are no non-trivial solutions).
(defun solve (goal)
  (let* ((both (parse-and-solve goal))
	 (ans (caar both))
	 (empties (cdr both)))
    (append
     (list
      :time (round-off (reduce 'max (mapcar 'route-time-to-travel ans)
			       :initial-value 0) 
		       2)
      :distance (round-off (reduce '+ (mapcar 'route-distance ans)
				   :initial-value 0) 
			   2)
      :cost (round-off (reduce '+ (mapcar 'route-cost-fn ans)
			       :initial-value 0) 
		       2)
      :hops (reduce '+ (mapcar 'route-number-of-hops ans)
		    :initial-value 0)
      :routes)
     (list
      (append
       (mapcar #'(lambda (r)
		   (list
		    :agent (car (find-engines-originally-at
				 (location-name (car (route-cities r)))))
		    :actions (gen-plan-from-route r)))
	       ans)
       empties)))))

;; 'goal' is a possibly complex goal structure.
;; if it is complex (i.e. the conjunct of smaller goals), we recurse
;; and then apply the constraints for the conjunct to what we got from
;; the recursion.  Note that there may be any number of conjuncts.
;; if it is a primitive, we do an exhaustive search
;;
;; We assume there is ONE :to and ZERO :from's for each goal.
;;
;; Input format is the same as that of 'solve'
;;
;; returns a consp of a list of solutions (each is a list of routes), 
;; and a list of null routes (that is, 0-hop routes)
;;
;; So we kluge in the possibility of a city being both a dest and an orig
;; by removing it from our list of goals
(defun parse-and-solve (goal)
  (case (car goal)
    (:AND
     (let* ((goals (find-all-if #'(lambda (g)
				    (eq (car g) :go))
				(cdr goal)))
	    (globals (find-all-if #'(lambda (g)
				      (not (eq (car g) :go)))
				  (cdr goal)))
	    (to-list (get-tos goals))

	    ;; vacuous is a list of dests that already have engines there
	    (vacuous (intersection to-list (get-origins)))
	    (to-list (remove-all vacuous to-list))
	    (pairs (matchem to-list (remove-all vacuous (get-origins))))


	    (goals (remove-if #'(lambda (g)
				  (member (get-dest g) vacuous))
			      goals)))
       (cons
	;; find the solutions for the non-trivial cases
	(find-sols
	 (cons :and
	       (append 
		(mapcar 'structify-goal
			(mapcar #'(lambda (gl to)
				    (append gl (list (list :from (cdr (assoc to pairs))))))
				goals to-list))
		(list (sort-constraints globals)))))

	;; make the list of dummy routes for the trivial cases
	(mapcar #'(lambda (c)
		    (list
		     :agent (car (find-engines-originally-at c))
		     :actions nil))
		vacuous))))

    (:GO
     (parse-and-solve (list :and goal)))
    (otherwise
     (PSM-warn "Unsupported act type: ~A" (car goal)))))


;; given a goal (:go g1 (:from a) (:via b)...)
;; pull out the :to slot
(defun get-dest (goal)
  (car (find-constraint-in-act goal :to)))

;; give a goal as a list, return it with the third (and last non-nil) elem
;; of the list being a constraint structure
(defun structify-goal (goal)
  (list (first goal)
	(second goal)
	(sort-constraints (cddr goal))))

;; get a list of destinations from a goallist
(defun get-tos (goallist)
  (mapcar 'get-dest goallist))

;; given 2 lists of cities, a list of dests and a list of origs, 
;; match them up so pairs have the fewest number of hops separating
;; them.  Note that we don't look for a globally fewest numer of hops,
;; so order *really* matters.
;;
;; should perhaps revise this to lost for cheapest cost.  Should probably
;; *not* use a heuristic to get a little bit of interaction, because we would
;; likely end up exploiting the small size of the problem
;;
;; note that even though we issue a warning, the code in fact will crash if there
;; are more dests then origs.  
(defun matchem (tos froms)
  (when tos
    (cond ((null froms)
	   (PSM-warn "More destinations than engines" nil)
	   nil)
	  (t
	   (let ((orig (find-closest (car tos) froms)))
	     (cons (cons (car tos) orig)
		   (matchem (cdr tos)
			    (remove orig froms))))))))

;; given a city and a list of cities, returns the city in 'citylist'
;; the fewest number of hops from 'city'
(defun find-closest (city citylist)
  (cdr (first (assoc-N-smallest
	       (mapcar #'(lambda (c)
			   (cons (num-hops c city) c))
		       citylist)
	       1))))

;; returns a list of cities with engines in them
;; (1 city for each engine)
;; 
;; First get every prop of the KB which specifies a :type, 
;; then pull all the :engine ones out of that list
;; then grab the engine names
;; then for each name, query for the city
;; then grab the city names
(defun get-origins nil
  (mapcar 
   'cdar 
   (mapcar 
    #'(lambda(e)
	(domain-query (list ':at-loc e '?loc)))
    (mapcar 
     'second 
     (find-all-if #'(lambda (p)
		      (eq (third p) :engine))
		  (get-props-from-KB :type))))))

;; this function is written recursively, but currently will only work for one
;; level of :and's.  (combine-subgoal-solns will have problems.)
(defun find-sols (goal)
  (cond ((eq (car goal) :AND)
	 (combine-subgoal-solns
	  (mapcar #'(lambda (g)
		      (first-N (find-sols g) *num-indiv-routes*))
		  (cdr (butlast goal)))	; the last thing is the global constr struct.
	  (constraints-filters (car (last goal))) ; we'll use it here and
	  (constraints-preferences (car (last goal))))) ; here
	((eq (car goal) :GO)
	 (find-and-sort-valid-routes
	  (constraints-specific (third goal))
	  (constraints-filters (third goal))
	  (constraints-preferences (third goal))))
	(t
	 (make-sorry-msg (format nil "Unknown action type: ~S" (car goal))))))

;; we can't use "instantiate-action" for 2 reasons.  One is that we always
;; want some kind of answer, even if all get filtered out.  (That is easily
;; kluged around).  the other is that "Instantiate-action" automatically
;; filters out routes greater then 4 hops or sthg like that, and our scoring
;; module shouldn't have that limitation
;;
;; so after generating a list of possibilities (wrt from-to), if the filtering
;; leaves any, we sort those and return.  If the filtering didn't leave any, we
;; sort and return only the first one.
;;
;; Note that we override prefs (for now) with a "decreasing COST" preference.
(defun find-and-sort-valid-routes (spec filters prefs)
  (sort-by-preference-fn 
   (funcall (lambda (x)
	      (or (filter x spec filters)
		  (list (car (sort-by-preference-fn x (car prefs))))))
	    (gen-basic-routes 
	     (cadr (assoc :from spec))
	     (cadr (assoc :to spec))
	     *max-route-length*))
   '(< COST)))

;; run our list of routes through *both* kinds of filters.
(defun filter (routes spec filters)
  (filter-list-of-solutions 
   (filter-by-constraints routes spec)
   filters))

;; given a list of sorted lists of routes and some constraints to be evaluated
;; over them both, return a sorted list (by prefs) after satisfying
;; filter conditions.
;;
;; pain in the ass bc we must convert them to routename-schedule pairs before handing
;; them to 'assess-interaction', them convert them back to routes before filtering.
(defun combine-subgoal-solns (routes filters prefs)
  (filter-and-sort (mapcar 'routify (mapcar #'assess-interaction2 
					    (all-combos 

					     ;; 2 lambdas because we have a list of
					     ;; lists of routes
;					     (mapcar 
;					      #'(lambda (rts)
;						  (mapcar 
;						   #'(lambda (r)
;						       (cons 
;							(route-name r)
;							(tracks-to-sched (route-tracks r))))
;						   rts))
					      routes)))
		   filters prefs))

;; routify takes a list of id-schedule pairs and returns a list of routes
;; Note: a schedule is assumed to be 'city-track-city-track-city'
(defun routify (rt-sch-list)
  (mapcar #'(lambda (rt-sch)
	      (let ((tracks (sched-to-tracks (cdr rt-sch))))
		(make-route
		 :name (car rt-sch)
		 :number-of-hops (/ (- (length (cdr rt-sch)) 1) 2)
		 :distance (calc-distance tracks)
		 :time-to-travel (itin-item-end-time (car (last (cdr rt-sch))))
		 :cities (find-all-if 'location-p 
				      (mapcar 'itin-item-location (cdr rt-sch)))
		 :tracks tracks
		 )))
	  rt-sch-list))


;; given a list of list of 2 routes (with interaction costs already assessed), 
;; and some filters and prefs, filter and then sort the remaining, making sure
;; to return at least one possibility.
;;
;; Note: only uses the first pref
(defun filter-and-sort (llr filters prefs)
  (sort-them-by-preference-fn 
   (or (filter-lists-of-solutions llr filters)
       (list (car (sort-them-by-preference-fn llr (car prefs)))))
   (car prefs)))


;; struct used for calculating interaction
(defstruct itinerary
  id
  next-event-time			; the time at which the next item on the 
					; schedule is completed
  schedule				; the list of remaining itin-items
  )

(defstruct itin-item
  location				;where we are right now
  start-time				;when we got here
  end-time				;when we expect to leave
  delay-flag				;whether we have been delayed
					; (and if so, by whom)
  actionID				;right now, either nil or the
					;id of the go action
  )
;; takes a list of planID-actionlist pairs.
;;
;; figures out when they're using the same track
;; at the same time and penalizes the routes
;;
;; the return value is a "schedule" struct
;;
;; top-level function for the rest of the PSM
(defun assess-interaction (plans)
  (schedulify
   (id-delays (simulate (mapcar #'(lambda (id-actlist)
				    (let ((itinerary (actions-to-itin (cdr id-actlist))))
				      (make-itinerary
				       :id (car id-actlist)
				       :next-event-time (itin-item-end-time (car itinerary))
				       :schedule itinerary)))
				plans)
			nil))))

;; version used by the "solver".  
;; like the one above, but accepts a list of route structures, and returns
;; a list of routename-itinitemlist pairs
(defun assess-interaction2 (routes)
  (id-delays (simulate (mapcar #'(lambda (r)
				   (let ((itinerary 
					  (actions-to-itin 
					   (gen-plan-from-route r))))
				     (make-itinerary
				      :id (route-name r)
				      :next-event-time (itin-item-end-time (car itinerary))
				      :schedule itinerary)))
			       routes)
		       nil)))

;; takes a list of "itineraries", where an itinerary is as defstructed
;; "schedule" is only the remaining schedule items (including the one currently happening)
;; "next-event-time" is the time when the next "event" happens (the event of the current event).
;;	if the first thing on the schedule is a track, it represents the time
;;	   we will complete that track.
;;	if the first thing on the schedule is a city, it represents the time
;;	   we will leave that city
;;
(defun simulate (itineraries res)
  (cond ((every 'mynull (mapcar 'itinerary-schedule itineraries))
	 res)
	(t
	 (let ((next-itin (get-next-itin itineraries)))
	   (simulate (mapcar #'(lambda (itin)
				 (cond ((null (itinerary-schedule itin))
					itin)
				       ((eq (itinerary-id itin) (itinerary-id next-itin))
					(advance next-itin itineraries))
				       (t
					(process next-itin itin))))
			     itineraries)
		     (update-schedules next-itin res))))))

;; given a list of itineraries, returns the one itinerary
;; which happens next.
(defun get-next-itin (itineraries)
  (find
   (apply 'min (mapcar #'itinerary-next-event-time itineraries))
   itineraries
   :key 'itinerary-next-event-time))

;; given a track name and originating city name, return the track
;; structure
;; (remember there are 2 tracks for each name)
(defun find-track (tname orig)
  (find-if #'(lambda (tr)
	       (and (eq tname (track-name tr))
		    (eq orig (location-name (track-from tr)))))
	   (get-tracks)))

;; given a changing event (about to happen) and a "holding" event, returns the adjusted
;; "holding" event.  
;; 
;; an "event" is the same as an "itinerary", as described in simulate.
;;
;; Of course, the holding event is unchanged if the changing event has nothing to do
;; (no interaction) with the "holding" event.
;;
;; if the train that is holding is currently waiting in a city, it won't be affected
;; by the changing event, regardless of what the changing event is.
;;
;; If the train that is holding is on a track, it will be affected either if the changing
;; train is leaving a city and getting on that track, or if it is getting off that
;; track.
;; 
;; We don't update :CROSSING lists here because a train might be getting off a track
;; *exactly* as the changing one is getting on (so they don't actually :CROSS for any
;; nonzero period of time)
(defun process (changing holding)
  (cond 

   ;; if "holding" is in a city, it's not affected
   ((location-p (itin-item-location (car (itinerary-schedule holding))))
    holding)

   ;; if "changing" is in a city other than the last (i.e. getting on a track)
   ;; (and we know that "holding" is on a track, because of the earlier branch)
   ((and (location-p (itin-item-location (car (itinerary-schedule changing))))
	 (cdr (itinerary-schedule changing)))

    ;; if "changing" is getting on a track which "holding" is currently on, update
    ;;   "holding"'s itinerary in "next-event-time"
    ;; otherwise, don't change "holding"
    (if (eq (track-name (itin-item-location (first (itinerary-schedule holding))))
	    (track-name (itin-item-location (second (itinerary-schedule changing)))))
	(make-itinerary
	 :id (itinerary-id holding)
	 :next-event-time (extend (itinerary-next-event-time changing) 
				  (itinerary-next-event-time holding))
	 :schedule 
	 (let ((old-item (car (itinerary-schedule holding))))
	   (cons (make-itin-item
		  :location (itin-item-location old-item)
		  :start-time (itin-item-start-time old-item)
		  :end-time nil
		  :delay-flag nil
		  :actionID (itin-item-actionID old-item))
		 (cdr (itinerary-schedule holding)))))
      holding))

   ;; if "changing" is on a track (i.e. leaving that track)
   ;; (and we know that "holding" is on a track, because of the earlier branch)
   ((track-p (itin-item-location (car (itinerary-schedule changing))))
    
    ;; if "changing" is getting off a track which "holding" is currently on, update
    ;;   "holding"'s itinerary in "next-event-time".
    ;; otherwise, don't change "holding"
    (if (eq (track-name (itin-item-location (car (itinerary-schedule holding))))
	    (track-name (itin-item-location (car (itinerary-schedule changing)))))
	(make-itinerary
	 :id (itinerary-id holding)
	 :next-event-time (shorten (itinerary-next-event-time changing) 
				   (itinerary-next-event-time holding))
	 :schedule (itinerary-schedule holding))
      holding))
   
   ;; "changing" must be in the last city on its schedule
   (t
    holding)))

;; given the current time (current) and when we *thought* we were going to get there
;; (original), revise the estimate by doubling the eta.
(defun extend (current original)
  (+ current
     (* 2 (- original current))))

;; given the current time (current) and when we *thought* we were going to get there
;; (original), revise the estimate by halving the eta.
(defun shorten (current original)
  (+ current
     (/ (- original current) 2)))


;; given an itinerary (which is the route that's about to move along)
;; return an updated itinerary which reflect the move
;;
;; 'allother' is a list of *all* itineraries
;;
;; remember that waiting in cities is unaffected by other trains being there.
;; only sharing tracks causes problems.
(defun advance (thisone allother)
  (cond

   ;; if we're leaving a city, revise the thisone to reflect that we're on the
   ;; ensuing track (or nil, if it was the last city) and update the "next-event-time".
   ;; calculate the travel-time to be a function of how many other trains are on the same
   ;; track.
   ((location-p (itin-item-location (car (itinerary-schedule thisone))))
    (if (cdr (itinerary-schedule thisone))
	(let ((others (other-trains thisone allother)))
	  (make-itinerary
	   :id (itinerary-id thisone)
	   :next-event-time (+ (itinerary-next-event-time thisone)
			       (* (track-time (itin-item-location
					       (second (itinerary-schedule thisone))))
				  (expt 2 (length others))))
	   :schedule
	   (cons
	    (make-itin-item
	     :location (itin-item-location (cadr (itinerary-schedule thisone)))
	     :start-time (itinerary-next-event-time thisone)
	     :end-time nil
	     :delay-flag nil
	     :actionID (itin-item-actionID (cadr (itinerary-schedule thisone))))
	    (cddr (itinerary-schedule thisone)))))
      ;; that was the last city, so put in a dummy node
      (make-itinerary
       :id (itinerary-id thisone)
       :next-event-time *MaxInt*
       :schedule nil)))
   

   ;; if we're leaving a track, revise the thisone as above, except any number of
   ;; trains may reside in the same city simult.
   ;; NOTE: we assume that a track can't be the last thing in a schedule
   ((track-p (itin-item-location (car (itinerary-schedule thisone))))
    (make-itinerary
     :id (itinerary-id thisone)
     :next-event-time (+ (itinerary-next-event-time thisone)
			 (location-delay (itin-item-location
					  (second (itinerary-schedule thisone)))))
     :schedule (cons
		(make-itin-item
		 :location (itin-item-location (cadr (itinerary-schedule thisone)))
		 :start-time (itinerary-next-event-time thisone)
		 :end-time nil
		 :delay-flag nil
		 :actionID (itin-item-actionID (cadr (itinerary-schedule thisone))))
		(cddr (itinerary-schedule thisone)))))
   
   ;; shouldn't get here
   (t
    (make-error-msg 
     (format nil "Can't handle object type ~S" 
	     (type-of (itin-item-location (car (itinerary-schedule thisone)))))))))


;; takes an itinerary and a list of itineraries
;; 'this' is an itinerary, where the schedule starts at a city
;; 'all' is a list of all the itineraries
;; returns a list of trains (ids) using the track that 'this' is about to use
;; (besides 'this' itself).
;; NOTE: here also, we assume a schedule cannot end with a track
(defun other-trains (this all)
  (when all
    (if (itinerary-schedule (car all))
	(let ((oth-track (itin-item-location (car (itinerary-schedule (car all))))))
	  (if (and (track-p oth-track)
		   (eq (track-name oth-track)
		       (track-name (itin-item-location (second (itinerary-schedule this)))))
		   (not (eq (itinerary-id this)
			    (itinerary-id (car all)))))
	      (cons (itinerary-id (car all))
		    (other-trains this (cdr all)))
	    (other-trains this (cdr all))))
      (other-trains this (cdr all)))))



;; given an itinerary where the first event is used-up and an alist of id-schedule pairs, 
;; we update and return the alist
(defun update-schedules (itin scheds)
  (let* ((used-up-sch-item (car (itinerary-schedule itin)))
	 (already-there (assoc (itinerary-id itin) scheds))
	 (new-sch-item (make-itin-item
			:location (itin-item-location used-up-sch-item)
			:start-time (itin-item-start-time used-up-sch-item)
			:end-time (itinerary-next-event-time itin)
			:delay-flag nil
			:actionID (itin-item-actionID used-up-sch-item))))
    (if already-there
	(cons (append already-there (list new-sch-item))
	      (remove already-there scheds))
      (cons (list (itinerary-id itin) new-sch-item)
	    scheds))))

;; just like "filter-list-of-solutions" but it works
;; on lists of lists of solutions, checking that the filter holds
;; for each soln
(defun filter-listS-of-solutions (soln-listS filters)
  (if (null filters)
      soln-listS
    (let* ((first-filter (car filters))
	   (op (car first-filter)))
      (case op
	(:constraint (filter-listS-of-solutions 
		      (filter-them-by-constraints soln-listS (cdr first-filter)) (cdr filters)))
	(:and
	 (filter-listS-of-solutions 
	  (filter-listS-of-solutions soln-listS (cdr first-filter))
	  (cdr filters)))
	(otherwise
       	 (let* ((filter-op (get-operator (caar first-filter)))
		(filter-arg (cadar first-filter))
		(filter-scale (cadr first-filter))
		(access-fn (get-access-fn filter-scale))
		(aggreg-fn (if (eq filter-scale 'DURATION)
			       'max
			     '+)))
	   (filter-listS-of-solutions

	    (remove-if-not #'(lambda (soln-list)
			       (funcall filter-op 
					(apply aggreg-fn soln-list)
					filter-arg))
			   soln-listS
			   :key (lambda (x) (mapcar access-fn x)))
	    (cdr filters))))))))

;; *under construction*
(defun filter-them-by-constraints (objects constraints)
  (if (null constraints) objects
    (let* ((c (first constraints))
	   (subset (remove-if #'null
			      (mapcar #'(lambda (r)
					  (apply-GO-constraint nil r c))
				      objects))))
      (if subset
	  (filter-them-by-constraints subset (cdr constraints))))))


;; how to deal with aggregating attributes?  
;; we just take the max, except in the case of COST, whichi is a sum
(defun sort-them-by-preference-fn (routes pref)
  (if pref
      (let ((pref-op (get-operator (car pref)))
	    (access-fn (get-access-fn (cadr pref)))
	    (aggreg-fn (if (eq (cadr pref) 'DURATION)
			   'max
			 '+)))
	(stable-sort (copy-list routes)
		     pref-op 
		     :key #'(lambda (rl)
			      (apply aggreg-fn (mapcar #'(lambda (r)
							   (funcall access-fn r))
						       rl)))))
    ;; if no preference function provided, use COST as default
    (stable-sort (copy-list routes) #'<= 
		 :key #'(lambda (rl)
			  (apply #'+ (mapcar #'(lambda (r)
						 (route-cost-fn r))
					     rl))))))


;; takes a schedule == a lists of itin-items.
;; returns the list of tracks that corresponds.
(defun sched-to-tracks (schedule)
  (remove-if-not 'track-p 
		 (mapcar 'itin-item-location schedule)))

;; convert a list of actions to a list of itin items
;; note city delays aren't taken into account here, as they are
;; expected to be simulated later on.
(defun actions-to-itin (actionList &optional (start 0))
  (when actionList
    (cons (make-itin-item
	   :location (cdr (assoc
			   (car (find-constraint-in-act (car actionList) :from))
			   (get-cities)))
	   :start-time start
	   :end-time start
	   :delay-flag nil
	   :actionID nil)
	  (actions-to-itin-aux actionList start))))

(defun actions-to-itin-aux (actionList start)
  (when actionList
    (let* ((thistrack (find-track
		       (car (find-constraint-in-act (car actionList) :track))
		       (car (find-constraint-in-act (car actionList) :from))))
	   (end (+ start (track-time thistrack))))
      (cons (make-itin-item
	     :location thistrack
	     :start-time start
	     :end-time end
	     :delay-flag nil
	     :actionID (second (car actionList)))
	    (cons (make-itin-item
		   :location (track-to thistrack)
		   :start-time end
		   :end-time end
		   :delay-flag nil
		   :actionID nil)
		  (actions-to-itin-aux (cdr actionList) end))))))

;; takes a list of tracks.
;; returns the schedule which corresponds.
;; Note: to be consistent with the interaction stuff, we only count
;; city delays upon *arriving* at a city.
;; 'start' is the point in time when this route starts
(defun tracks-to-itin (tracks &optional (start 0))
  (when tracks
    (cons (make-itin-item
	   :location (track-from (car tracks))
	   :start-time start
	   :end-time start
	   :delay-flag nil)
	  (tracks-to-itin-aux tracks start))))

(defun tracks-to-itin-aux (tracks start)
  (when tracks
    (let ((end (+ start (track-time (car tracks)))))
      (cons (make-itin-item
	     :location (car tracks)
	     :start-time start
	     :end-time end
	     :delay-flag (if (eq (track-time (find (track-name (car tracks))
						   (get-tracks)
						   :key 'track-name))
				 (track-time (car tracks)))
			     nil
			   :CROSSING))
	    (cons (make-itin-item
		   :location (track-to (car tracks))
		   :start-time end
		   :end-time end
		   :delay-flag nil)

		  (tracks-to-itin-aux (cdr tracks) end))))))

;; given a list of (planID . itin-item list) pairs, constructs
;; a big "schedule" structure
(defun schedulify (itineraries)
  (let ((ans (schedulify-aux itineraries)))
    (make-schedule
     :duration (apply 'max (mapcar 'schedule-item-end-time ans))
     :cost (apply '+ (mapcar 'schedule-item-cost ans))
     :states ans)))

(defun schedulify-aux (itineraries)
  (when itineraries
    (append (mapcar #'(lambda (itin)
			(schedule-item-ify itin (caar itineraries)))
		    (cdar itineraries))
	    (schedulify-aux (cdr itineraries)))))

(defun schedule-item-ify (itin planID)
  (let ((loc (itin-item-location itin)))
    (make-schedule-item
     :state (cond ((location-p loc)
		   (list 'at (location-name loc)))
		  ((track-p loc)
		   (list 'doing
			 (list :go (itin-item-actionID itin)
			       (list :from (location-name (track-from loc)))
			       (list :to (location-name (track-to loc)))
			       (list :track (track-name loc))))))
     :start-time (itin-item-start-time itin)
     :end-time (itin-item-end-time itin)
     :cost (- (itin-item-end-time itin)
	      (itin-item-start-time itin))
     :plan-id planID
     :delay-flag (itin-item-delay-flag itin)
     )))
;; given a list of (id-schedule) pairs, return a list of same, 
;; updated with the info of who their routes cross with.
;;
;; remember, a schedule is a list of itinerary-items
(defun id-delays (schedules)
  (mapcar #'(lambda (x) (id-delays-aux x schedules))
	  schedules))

;; for each track in the 'thisroute' schedule, check if its time
;; overlaps with the same track in any of the other routes.
;; return the updated 'thisroute'.
(defun id-delays-aux (thisroute allroutes)
  (cons (car thisroute)
	(mapcar #'(lambda (itin)
		    (make-itin-item
		     :location (itin-item-location itin)
		     :start-time (itin-item-start-time itin)
		     :end-time  (itin-item-end-time itin)
		     :actionID (itin-item-actionID itin)
		     :delay-flag 
		     (when (track-p (itin-item-location itin))
		       (let ((conflicts 
			      (find-all-if #'(lambda (other-rte)
					       (crowds (cdr other-rte) itin))
					   (remove (car thisroute) allroutes :key 'car))))
			 (when conflicts
			   (cons :CROSSING (mapcar 'car conflicts)))))))
		(cdr thisroute))))


;; 'route' is a consp of a route name and a schedule
;; 'sch-item' is a itin-item of a track
;; 'crowds' returns t (non-nil, actually) iff something on route conflics with
;; sch-item.
(defun crowds (route sch-item)
  (find-if
   #'(lambda (x)
       (and (track-p (itin-item-location x))
	    (eq (track-name (itin-item-location sch-item))
		(track-name (itin-item-location x)))
	    (overlaps sch-item x)))
   route))

;; do these 2 schedule items overlap?
;; (either one item's start-time or end-time must lie within the other window,
;; or they must be the same interval)
(defun overlaps (si1 si2)
  (or
   (and (> (itin-item-start-time si1) (itin-item-start-time si2))
	(< (itin-item-start-time si1) (itin-item-end-time si2)))
   (and (> (itin-item-end-time si1) (itin-item-start-time si2))
	(< (itin-item-end-time si1) (itin-item-end-time si2)))
   (and (= (itin-item-start-time si1) (itin-item-start-time si2))
	(= (itin-item-end-time si1) (itin-item-end-time si2)))))

;; how many hops from one city to another
(defun num-hops (from to &optional (num 0))
  (cond ((eq from to)
	 0)
	((gen-basic-routes from to num)
	 num)
	(t
	 (num-hops from to (1+ num)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; UTILITIES
;;

;; just like find-if except it returns a list of *all* things satisfying the
;; pred and doesn't handle the special keyword args
(defun find-all-if (pred list)
  (when list
    (if (funcall pred (car list))
	(cons (car list)
	      (find-all-if pred (cdr list)))
      (find-all-if pred (cdr list)))))

;; returns a list of the N smallest things in the alist l. (checks small-ness by key)
;; Returns l if its length is less than N.
(defun assoc-N-smallest (l N)
  (cond ((or (zerop N)
	     (null l))
	 nil)
	(t
	 (let ((smallest (assoc (apply 'min (mapcar 'car l)) l)))
	   (cons smallest
		 (assoc-N-smallest (remove smallest l :test 'equal)
				   (- N 1)))))))

;; takes a list of lists and returns a list of every possibly combination
;; of their elements, in order.
;; i.e. (all-combos '((1 2) (x y))) => ((1 x) (1 y) (2 x) (2 y))
(defun all-combos (ll)
  (cond ((null (cdr ll))
	 (mapcar 'list (car ll)))
	(t
	 (apply 'append			; this flattens one level
		(mapcar
		 #'(lambda (e)		; e is our elem of the first list
		     (mapcar #'(lambda (lists) (cons e lists))
			     (all-combos (cdr ll))))
		 (car ll))))))

;; returns  a list of the first n elems of l, or l if n > length(l)
(defun first-N (l n)
  (if (or (eq n 0)
	  (null l))
      nil
    (cons (car l)
	  (first-N (cdr l) (- n 1)))))

;; takes a unary predicate as arg and returns a predicate which is true of a tree
;; iff the orig predicate was true of everything in the tree.
(defun maptree (pred)
  (lambda (tr)
    (cond ((null tr)
	   t)
	  ((atom tr)
	   (funcall pred tr))
	  (t
	   (and (funcall (maptree pred) (car tr))
		(funcall (maptree pred) (cdr tr)))))))

;; is t for nil and nil for all else.  But doesn't crash on structs, just
;; returns nil.
(defun mynull (x)
  (and (typep x 'sequence)
       (null x)))


;; takes a list and returns a list of elements with freq > 1
(defun find-common (lst)
  (cond ((<= (length lst) 1)
	 nil)
	((member (car lst) (cdr lst))
	 (cons (car lst)
	       (find-common (remove (car lst) (cdr lst)))))
	(t
	 (find-common (cdr lst)))))


;; remove every element of the 'bad' list from 'list'
;; no check or error if sthg in 'bad' not in 'list'
(defun remove-all (bad list)
  (if bad
      (remove-all (cdr bad) (remove (car bad) list :test 'equal))
    list))

;; rounds 'n' off to 'sig' sig figs (positive is right of decimal,
;; negative is left)
;; returns a float
(defun round-off (n &optional (sig 0))
  (/ (fround n (expt 10 (- sig)))
     (expt 10 sig)))
