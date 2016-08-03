;  ROUTE-PLANNER

(in-package "PSM")

;;  MAXIMUM ROUTE SIZE

;;  Set this to the maximum route that can be found without intermediate constraints

(defvar *max-jump-length* 4)
;;=================================================================
;;
;;  DATA STRUCTURES
;;

;;  LOCATION/CITIES
;;(defstruct (location 
;;	    (:print-function
;;	     (lambda (p s k)
;;	       (format s "<~A>" (location-name p)))))
;;	    name
;;	    loc				;  (x . y) coordinates
;;    delay			;  number of hours to pass through city - default is 0
;;    direct-tracks		;  list of all outgoing routes
;;	    )

;;  TRACKS

;;(defstruct track name 
;;		  from			; tracks are directional
;;		  to			; between the two specified cities
;;		  delay			; number of hours to traverse the track
;;	  )

;;  PRIMITIVE ROUTES

;;(defstruct (route 
;;	    (:print-function
;;	     (lambda (p s k)
	       ;;   (format s "<~A, ~A miles, ~A hours, ~A>" (route-name p) (route-distance p) (route-time-to-travel p) (route-cities p)))))
;;  name
;;  color
;;  number-of-hops
;;  distance
;;  time-to-travel
;;  cities
;;  tracks)

;; SOLUTION SETS 


;;(defstruct solution-set ;; a set of solutions, typically associated with a task
;;  name
;;  agents ;; the agent of the act, and default agent of all subacts
;;  action-type ;;  the action e.g., (:GO g123 (:FROM ATLANTA) (:TO CHICAGO))
;;  filters ;; additional constraints on solutions (but not part of primary goal statement)
;;  preference-function ;; the criteria used to order solutions
;;  decomposition ;; a list of subactions that is the current solution
;;  domain-info) ;;  domain specific encoding of the act for use by specialized reasoners


;;============================================================
;;  MAINTAINING THE MAP AND ROUTE INFORMATION
;;  Functions to set up the map
;;
;;  a map is a graph where nodes are cities and arcs are direct routes
;;;;   SETTING UP THE MAP

(let ((cities nil) ;; the list of cities indexed by name
      (tracks nil)) ;; a list of tracks indexed by destination
     
  
  ;; the list of all cities
  (defun reset-map nil
    (setq cities nil)
    (setq tracks nil))
   
  
  (defun get-cities nil cities)
  
  ;;  finding a city given its name
  (defun lookup-city (name)
    (let ((city (assoc name cities)))
      (if city (cdr city)))) 
  
  ;; the list  of all tracks
  (defun get-tracks nil tracks)
  
   ;;  finding a track given its name
  (defun lookup-track (name)
    (find-if #'(lambda (x) (eq (track-name x) name))
	  tracks))
  
  ;; create a city entry - soon to be obsolete
  (defun DR-setup-city (name x y)
    (let ((city (make-location :name name
			       :loc (cons x y)
			       :delay 0)))
      (setq cities (cons (cons name city) cities))
      city))
  
  (defun define-city (name)
    (setq cities (cons (cons name (make-location :name name :delay 0)) cities)))
  
  ;;  create a route: NB cities should be defined first
  ;; since tracks a bidirectional, each call creates two unidirectional tracks
  ;;  DR-setup-track soon to be obsolete
  (defun DR-setup-track (from to)
    (let* ((sorted-names (sort (list from to) #'string-lessp))
           (name (intern (format nil "~A-~A" (car sorted-names) (cadr sorted-names))))
	   (from-city (lookup-city from))
	   (to-city (lookup-city to)))
      (if (and to-city from-city)
	  (let ((track1 (make-track :name name :from from-city :to to-city :distance 100 :time 2))
		(track2  (make-track :name name :from to-city :to from-city :distance 100 :time 2)))
	    (setq tracks (cons track1 (cons track2 tracks)))
	    (setf (location-direct-tracks to-city) (cons track2 (location-direct-tracks to-city)))
	    (setf (location-direct-tracks from-city) (cons track1 (location-direct-tracks from-city)))
	    )
	(let ((city (if to-city from-city to-city)))
	  (Dr-warn "City ~S must be defined before it is used in a track:" city))
	)))
  
  (defun Define-track (name from to class distance exp-travel-time)
    (let* ((from-city (lookup-city from))
	   (to-city (lookup-city to)))
      (if (and to-city from-city)
	  (let ((track1 (make-track :name name :from from-city :to to-city :class class  :distance distance :time exp-travel-time))
		(track2  (make-track :name name :from to-city :to from-city :class class  :distance distance :time exp-travel-time)))
	    (setq tracks (cons track1 (cons track2 tracks)))
	    (setf (location-direct-tracks to-city) (cons track2 (location-direct-tracks to-city)))
	    (setf (location-direct-tracks from-city) (cons track1 (location-direct-tracks from-city)))
	    )
	(let ((city (if to-city from to)))
	  (Dr-warn "City ~S must be defined before it is used in a track:" city))
	)))
  )

;;  Interface to User added delays with the :PROBLEM predicate

(defun check-for-route-info (prop)
  (let ((error-msg nil))
    (case (car prop)
      (:DELAY
       (let* ((city (lookup-city (third prop)))
	      (track1 (lookup-track (third prop)))
	      (track2
	       (when track1
		 (find-if #'(lambda (tr)
			      (and (eq (location-name (track-from tr))
				       (location-name (track-to track1)))
				   (eq (location-name (track-to tr))
				       (location-name (track-from track1)))))
			  (get-tracks))))
	      (delay (fourth prop)))
	 (cond ((location-p city)
		(setf (location-delay city) delay))
	       ((track-p track1)
		(setf (track-time track1)
		  (+ (track-time track1) delay))
		(setf (track-time track2)
		  (+ (track-time track2) delay)))
	       (t (setq error-Msg (format nil "Delay asserted for unknown object ~S in ~S" (third prop) prop))))))
      (:CONNECTION
       (if (eq (length prop) 7)
	   (apply #'define-track (cdr prop))
	 (setq error-msg (make-error-msg (format nil "Wrong number of arguments in ~S" prop)))))
      (:TYPE
       (if (eq (length prop) 3)
	   (if (eq (third prop) :CITY)
	       (define-city (second prop)))
	 (setq error-msg (make-error-msg (format nil "Wrong number of arguments in ~S" prop)))))
      
      )
    (if error-msg (PSM-Warn error-msg nil))
    prop))
  

(defun clear-route-temp-info nil
  (mapcar #'(lambda (c)
	      (setf (location-delay (cdr c)) 0))
	  (get-cities)))

;;  GENERIC PLAN/SPECIFIC PLAN INTERFACE


(defun gen-plan-from-route (instance)
  "This takes a ROUTE structure and creates a list of :GO actions"
   (let ((route (route-tracks  instance)))
     (mapcar #'(lambda (r)
              (list :GO (gensymbol 'go)
                    (list :FROM (location-name (track-from r)))
                    (list :TO (location-name (track-to r)))
                    (list :TRACK (track-name r))))
          route)))
  

;;========================================================================
;;   ROUTE GENERATION
;;

;;  NOT CURRENTLY USED
;;   main function - takes a route sketch - a sequence of cities
;;   and returns all complte routes that link them

(defun gen-routes-from-sketch (route-sketch)
  (gen-from-sketch route-sketch nil))

(defun gen-from-sketch (sketch routes-so-far)
  (let* ((from (car sketch))
	 (to (second sketch))
	 (rest (cddr sketch))
	 (extensions (gen-basic-routes from to 4)))
    (if extensions
	(if rest
	    (gen-from-sketch (cons to rest) (extend-routes routes-so-far extensions))
	  (extend-routes routes-so-far extensions)))))

(defun gen-routes (from to filters preference)
  (let* ((routes (gen-basic-routes from to 9))
	 (routes1 (or routes
		    (gen-basic-routes from to 11)))
	 (routes2 (if filters
		      (filter-list-of-solutions routes filters)
		    routes1)))
    (sort-by-preference-fn routes2 preference)))
 	 

;; Basic Routine for generating all routes from X to Y in  N steps or less
;;  This generates the candidate set. Generally, other constraints will filter the
;;  solutions

(defun gen-basic-routes (X Y N)
  (let ((X-city (if (location-p X) X (lookup-city X)))
	(Y-city (if (location-p Y) Y (lookup-city Y))))
    (if (and X-city Y-city)
	(let ((routes
	       (mapcar #'(lambda (r)
			   (let ((length-info (calc-length r))
				 (name (intern (gensym (format nil "~A-~A" X Y)))))
			     (make-route :name name
					 :number-of-hops (first length-info)
					 :distance (second length-info)
					 :time-to-travel (third length-info)
					 :cities (cons X-city
						       (mapcar #'(lambda (x)
								   (track-to x))
							       r))
					 :tracks r)))
					 ;; :schedule (list (cons name (tracks-to-sched r))))))
		       (find-routes X-city Y-city N (list X-city) nil))))
	  routes)
      
      ;;  error message
      (let ((city (if X-city Y X)))
	(DR-warn "Unknown city: ~S used in route specification" city)))))

(defun find-routes (start end N seen route-so-far)
 
  (if (<= N 0) nil
    (let* ((next-cities (location-direct-tracks start)) ;; find all outgoing tracks
	   (reduced-list (remove-if #'(lambda (x) (member (track-to x) seen)) next-cities)) ;; eliminate cycles
	   (lowern (- n 1))
	   (routes (mapcan #'(lambda (next)
			      (let ((destination (track-to next)))
				(if (eq destination  end)
				    (list (reverse (cons next route-so-far)))
				  (find-routes destination  end lowern (cons destination seen) (cons next route-so-far)))))
			   reduced-list)))
      routes)))

;; SORT-ROUTES - This defines the basic ordering in which routes are presented

(defun sort-routes (routes)
  (sort routes #'< :key #'route-number-of-hops))

;; appends two routes if dest of route1 is the start of route2.
;;  if LOOPS_PROHIBITED=T then the result must not contain any cycles
(defun append-routes (route1 route2 loops-prohibited)
  (let ((cities1 (route-cities route1))
        (cities2 (route-cities route2)))
  (if (and (eq (car (last cities1)) (car cities2))
           (or (not loops-prohibited) (null (intersection cities1 (cdr cities2)))))
    (make-route
     :name  (gensym (format nil "~A-~A"
                            (location-name (car (route-cities route1)))
                            (location-name (car (last (route-cities route2))))))
     :cities (append (route-cities route1) (cdr (route-cities route2)))
     :tracks (append (route-tracks route1) (route-tracks route2))
     :color (route-color route1)
     :number-of-hops (+ (route-number-of-hops route1) (route-number-of-hops route2))
     :distance (+ (route-distance route1) (route-distance route2))
     :time-to-travel (+ (route-time-to-travel route1) (route-time-to-travel route2)))
    )
  ))

;;  CALC-LENGTH returns a triple (number-of-hops distance travel-time) for a route
;;    specified by a list of tracks.

(defun calc-length (tracks)
  (list (length tracks)
	(calc-distance tracks)
	(calc-time-delay tracks)))

(defun calc-distance (tracks)
  (if (null tracks) 0
    (+ (track-distance (car tracks)) 
       (calc-distance (cdr tracks)))))

(defun calc-time-delay (tracks)
  (if (null tracks) 0
    (let ((track (car tracks)))
      (+ (track-time track)
	 (location-delay (track-to track))
	 (calc-time-delay (cdr tracks))))))

(defun calc-delay-in-city (city)
  (let ((problems (remove-if-not #'(lambda (p) (and (eq (car p) :PROBLEM)
						    (eq (third p) city)))
				 (get-KB))))
    (if problems
	(fourth (car problems))
      0)))
    

(defun reduce-with-append (x)
  (if (null x) nil
    (append (car x) (reduce-with-append (cdr x)))))


;;=================================================================
;;
;;     INDIVIDUAL CONSTRAINTS
;;  Constraints are predicates that take a route and determine if the constraint holds or not
;;


(defun filter-by-constraints (objects constraints)
  (if (null constraints) objects
    (let* ((c (first constraints))
	   (subset (remove-if #'null
			      (mapcar #'(lambda (r)
					  (apply-GO-constraint nil r c))
				      objects))))
      (if subset
	  (filter-by-constraints subset (cdr constraints))))))

;; Checks constraints against route. Note this doesn't handle AGENTS!! I need to fix

(defun apply-GO-constraint (agent object constraint)
  (let ((name (car constraint))
	(args (cdr constraint)))
    (if ;; check the condition and return object if it holds
	(case name
          (:FROM (from-constraint object (car args)))
	  (:TO (to-constraint object (car args)))
	  (:VIA (via-constraint object args))
	  (:AVOID (avoid-constraint object args))
	  (:DIRECTLY (directly-constraint object args))
	  (:LENGTH (length-constraint object (car args)))
	  (:USE (use-constraint agent object (car args)))
	  (:AGENT (eq agent (car args)))
	  (:NOT (not (apply-GO-constraint agent object (cadr constraint))))
	 )
	  object)))

;; FROM
(defun FROM-CONSTRAINT (route city)
  (eq city (location-name (car (route-cities route)))))

;; TO

(defun TO-CONSTRAINT (route city)
  (eq city (location-name (car (last (route-cities route))))))
    

;;      V I A

(defun VIA-CONSTRAINT (route loc-sequence)
  (subsequence loc-sequence (mapcar #'location-name (route-cities route))))

;;  SUBSEQUENCE - true only if seq1 is a subset of seq2 and the ordering is the same
(defun subsequence (seq1 seq2)
  (if (null seq1) T
    (let ((rest (member (first seq1) seq2)))
      (if rest
	  (subsequence (cdr seq1) (cdr rest))
	))))

;; get-via-cities returns all the cities mentioned in via constraints (in order mentioned)
(defun get-via-cities (constraints)
  (if constraints
      (if (eq (caar constraints) 'VIA)
	  (append (cdar constraints) (get-via-cities (cdr constraints)))
	(get-via-cities (cdr constraints)))))

;;     A V O I D 

(defun AVOID-CONSTRAINT (route city-set)
  (null (intersection (mapcar #'location-name (route-cities route)) city-set)))

;;   DIRECTLY
(defun DIRECTLY-CONSTRAINT (route loc-sequence)
  (strict-subsequence loc-sequence (mapcar #'location-name (route-cities route))))

;;  true only is the subseq occurs in seq with no intervening elements
(defun strict-subsequence (subseq seq)
  (prefix subseq (member (car subseq) seq)))

(defun prefix (pre ll)
  (or (null pre)
      (and (eq (car pre) (car ll)) (prefix (cdr pre) (cdr ll)))))
 

;;    LENGTH CONSTRAINT

(defun LENGTH-CONSTRAINT (route fn)
  (apply fn (calc-length route)))

;; USE CONSTRAINT

(defun use-constraint (agent route object)
  (or (member object (mapcar #'location-name (route-cities route)))
      (eq agent object)))

;;=================================================================
;;
;;    

;;  INSTANTIATE-ROUTE
;;  takes and action definition an attempts to instantiate it with a specific route

(defun instantiate-route (action filters preference)
  (if (listp action)
      (case (car action)
	(:GO 
	 (let* ((fta (get-from-to-agent-from-act action))
                (from (fta-from fta))
		(to (fta-to fta))
		(agent (fta-agent fta))
		(constraints (remove-fta (get-constraints-from-act action)))
		(routes (if (and from to)
			    (gen-routes from to filters preference)))
		(candidates (if constraints 
				(filter-by-constraints routes constraints) ;; now filter:  by all the constraints
                              (remove-if #'(lambda (r)
                                             (> (route-number-of-hops r) *max-jump-length*))
                                         routes)))
		(plan (when (route-p (car candidates))
			(gen-plan-from-route (car candidates))))
		(name  (gensymbol 'SS)))
	   
	   (if candidates
	       (make-solution-set 
		:name name
		:agents agent
		:action-type action
		:filters filters
		:preference-function preference
                :decomposition plan
		:execution-trace (if plan (assess-interaction (list (cons name plan))))
		:domain-info (make-route-soln :current (car candidates)
					      :alternates (cdr candidates))))))
	(otherwise
	 nil))))
 
;; MODIFY-ACT-INSTANCE - takes an instantiated action and refines it
;;     by adding additional constraints and selecting an alternate instantiation

(defun modify-act-instance (act constraints filter preference)
  (let* ((alts (route-soln-alternates (solution-set-domain-info act)))
	 (agents (solution-set-agents act))
	 (instantiation (route-soln-current (solution-set-domain-info  act)))
	 (new-candidates (filter-by-constraints alts constraints)))
    (if new-candidates
	(make-solution-set
	 :name (gensymbol 'SS)
	 :agents agents
	 :action-type (cons (car (solution-set-action-type act))
                            constraints)
	 :filters filter
	 :preference-function preference
	 :decomposition (gen-plan-from-route (car new-candidates))
	 :domain-info (make-route-soln
		       :current (car new-candidates)
		       :alternates (cdr new-candidates)
		       :rejects (cons instantiation (route-soln-rejects  (solution-set-domain-info act)))))
        ;; No routes satisfy constraint - recheck to make sure
      (instantiate-action (cons (car (solution-set-action-type act))
				(cons (gensymbol 'G)
				      constraints))
			  filter preference))
    ))

(defun get-alternate-soln (act)
  (let ((alts (route-soln-alternates (solution-set-domain-info act))))
    (if (consp alts)
	(make-solution-set
	 :name (gensymbol 'SS)
	 :agents (solution-set-agents act)
	 :action-type (solution-set-action-type act)
	 :filters (solution-set-filters act)
	 :preference-function (solution-set-preference-function act)
	 :decomposition (gen-plan-from-route (car alts))
	 :domain-info (make-route-soln
		       :current (car alts)
		       :alternates (cdr alts)
		       :rejects (cons (route-soln-current (solution-set-domain-info act))
				      (route-soln-rejects (solution-set-domain-info act))))))))
      

;; DO-ROUTE-EXTENSION - extends route with a further destination preserving
;;; the old route.

(defun do-route-extension (old-route extension-constraints merged-constraints)
  (let ((new-from (car (find-constraint-in-act (solution-set-action-type old-route) :to)))
	(new-to (car (find-constraint extension-constraints :to)))
	(old-domain-info (solution-set-domain-info old-route)))
    (if (not (eq new-from new-to))
	(let* (
	       (extension (instantiate-route 
			   (construct-action :GO (if (find-constraint extension-constraints :from)
						     extension-constraints
						   (cons (list :from new-from)
							 extension-constraints)))
			   nil nil))
	       (agents (solution-set-agents old-route))
	       ;; Try to find one that preserves the old route. Note this may allow a loop.
	       (new-instantiation (if extension
				      (append-routes (route-soln-current old-domain-info)
						     (route-soln-current (solution-set-domain-info extension)) nil))))
	  (if (and extension new-instantiation)
	      (make-solution-set
	       :name (gensymbol 'SS)
	       :agents agents
	       :action-type (construct-action :GO merged-constraints)
	       ;; NB: the constraints from the old route are dropped
	       ;;  as they may not apply to the extension. They are still
	       ;;  "implicitly" in the alternate solutions.
	       :filters (solution-set-filters old-route)
	       :preference-function (solution-set-preference-function old-route)
	       :decomposition (gen-plan-from-route  new-instantiation)
	       :domain-info (make-route-soln
			     :current new-instantiation
			     :alternates (extend-routes (cons (route-soln-current old-domain-info)
							      (route-soln-alternates old-domain-info))
							(route-soln-alternates (solution-set-domain-info  extension)))))
	    ;;  if extension mechanism failed, just try to instantiate action ignoring original route
	    (instantiate-action (construct-action :GO merged-constraints) nil nil))
	  ))))
      
;;  extend-routes simply computes the cross product using append
;;  eliminating those containing any loops.
(defun extend-routes (routes extensions)
  (if (null routes) extensions
    (reduce-with-append
     (mapcar #'(lambda (r)
                 (remove-if #'null
                            (mapcar #'(lambda (e)
			                (append-routes r e t))
			            extensions)))
                 routes))))


;;  Truncating routes

(defun truncate-route-info-at (city route)
  (let* ((new-tracks (remove-tracks-after (lookup-city city) (route-tracks route)))
	 (length-info (calc-length new-tracks))
	 (name (intern (gensym (format nil "~A-~A"  (location-name (track-from (car new-tracks))) city)))))
  (make-route :name name
	      :color (route-color route)
	      :number-of-hops (first length-info)
	      :distance (second length-info)
	      :time-to-travel (third length-info)
	      :cities (cons (track-from (car new-tracks))
			    (mapcar #'(lambda (x)
					(track-to x))
				    new-tracks))
	      :tracks new-tracks)))
	      ;; :schedule (list (cons name (tracks-to-sched new-tracks))))))

(defun remove-tracks-after (city route)
  (when route
    (when (not (eq (track-from (car route)) city))
      (cons (car route)
	    (remove-tracks-after city (cdr route))))))
	

;;========================================================================================
;;
;;  SOLUTION SETS

(defun valid-filter-fn (fn)
  "Checks for a valif filter function, or list of filter functions, and returns a corrected form if necessary"
  (cond
   ;;  cases of single constraint - must be turned into a list of constraints
   ((and (listp fn) (eq (length fn) 2)
	 (or (and (listp (car fn)) (eq (length (car fn)) 2)
		  (member (caar fn) '(< <= = >= > =/=))
		  (member (cadr fn) '(COST DURATION DISTANCE)))
	     (and (eq (car fn) :constraint)
		  (listp (cdr fn)))))
    (list fn))
   ;; conjunction - strip the :And
   ((and (consp fn) (eq (car fn) :and))
    (valid-filter-fn (cdr fn)))
   ;; else it must be a list of valid constraints
   (t (if (and (consp fn)
	       (every #'valid-filter-fn fn))
	  fn))))

(defun filter-list-of-solutions (solns filters)
  (if (null filters)
      solns
    (let* ((first-filter (car filters))
	   (op (car first-filter)))
      (case op
	(:constraint (filter-list-of-solutions 
		      (filter-by-constraints solns (cdr first-filter)) (cdr filters)))
	(:and
	 (filter-list-of-solutions 
	  (filter-list-of-solutions solns (cdr first-filter))
	  (cdr filters)))
	(otherwise
       	 (let* ((filter-op (get-operator (caar first-filter)))
		(filter-arg (cadar first-filter))
		(filter-scale (cadr first-filter))
		(access-fn (get-access-fn filter-scale)))
	   (filter-list-of-solutions
	    (remove-if-not #'(lambda (s)
			       (apply filter-op (list s filter-arg)))
			   solns :key access-fn)
	    (cdr filters))))))))

(defun filter-solution-set (filters solution-set)
  "Given a valid filter function and a solution set, returns a new solution where every solution satisfies the filter"
  (let* ((possibilities (cons (route-soln-current (solution-set-domain-info solution-set))
			      (route-soln-alternates (solution-set-domain-info solution-set))))
	 (filtered-possibilities
	  (filter-list-of-solutions possibilities filters))
	 (new-alt-list (sort-by-preference-fn filtered-possibilities (solution-set-preference-function solution-set)))
	 (plan (gen-plan-from-route (car new-alt-list)))
	 (name (gensymbol 'SS)))
    
    (if new-alt-list
	(let ((new-ss
	       (make-solution-set :name name
			   :agents (solution-set-agents solution-set)
			   :action-type (solution-set-action-type solution-set)
			   :filters (append filters (solution-set-filters solution-set))
			   :preference-function (solution-set-preference-function solution-set)
			   :decomposition plan
			   :execution-trace (assess-interaction (list (cons name plan)))
			   :domain-info (make-route-soln :current (car new-alt-list)
							 :alternates (cdr new-alt-list)))))
	  (declare-an-object (solution-set-name new-ss) :solution-set new-ss)))
    ))

(defun sort-solution-set (preference-fn solution-set)
 "Given a valid preference function and a solution set, sorts the solution-set by the preference function"
 (let* ((possibilities (cons (route-soln-current (solution-set-domain-info solution-set))
			     (route-soln-alternates (solution-set-domain-info solution-set))))
	(sorted-possibilities
	 (sort-by-preference-fn possibilities preference-fn))
	(plan (gen-plan-from-route (car sorted-possibilities)))
	(name (gensymbol 'SS)))
    
   (if sorted-possibilities
	(let ((new-ss
	       (make-solution-set :name name
			   :agents (solution-set-agents solution-set)
			   :action-type (solution-set-action-type solution-set)
			   :filters (solution-set-filters solution-set)
			   :preference-function preference-fn
			   :decomposition plan
			   :execution-trace (assess-interaction (list (cons name plan)))
			   :domain-info (make-route-soln :current (car sorted-possibilities)
							 :alternates (cdr sorted-possibilities)))))
	  (declare-an-object (solution-set-name new-ss) :solution-set new-ss)))))
    
    
(defun get-operator (op)
  "maps to lisp operator, with < being default"
  (case op
    ((:less less min :min <) #'<)
    (= #'=)
    (<= #'<=)
    (>= #'>=)
    ((:more more :max max >) #'>)
    (=/= #'neq)
    (otherwise #'<)))

	
(defun get-access-fn (scale)
  "maps to access functions on routes, with NUMBER-OF-HOPS being default"
  (case scale
    (DURATION #'route-time-to-travel)
    (COST #'route-cost-fn)
    (DISTANCE #'route-distance)
    (HOPS #'route-number-of-hops)
    ;;  default is number of hops
    (otherwise #'route-number-of-hops)))

(defun route-cost-fn (r)
  "Computes the cost of a specific route - accepts a ROUTE structure"
  ;;  (+ (* .5 (route-distance r)) (* 25 (route-time-to-travel r)) 100)
  (route-time-to-travel r)) ;; changed for 1.99 demo


;;  accepts functions of form ({<= >=} COST/DISTANCE/DURATION)
(defun valid-preference-fn (x)
  (and (listp x)
       (or (member (car x) '(<= < >= >))
	   (and (listp (car x)) (eq (length (car x)) 2)
		(eq (caar x) '=)))
       (member (second x) '(COST DURATION DISTANCE HOPS))))

(defun sort-by-preference-fn (solutions preference-fn)
  (if preference-fn
      (let ((pref-op (get-operator (car preference-fn)))
	    (access-fn (get-access-fn (cadr preference-fn))))
	(stable-sort (copy-list solutions)
		     pref-op :key access-fn))
    ;; if no preference function provided, use default
    (stable-sort (copy-list solutions) #'<= :key #'route-number-of-hops)))
	    
	
  
(defun DR-warn (s a)
  (format t s a)
  nil)

