
(in-package "PSM")

;;==================================================================================
;;
;;  CONSTRAINT MANAGEMENT

;;  Constraints divide up into several categories
;;        General Constraints - apply to any action: AGENT, DURATION, AT-LOC
;;        Filters - bounds for cost and other measures: e.g., ((<= 20) DURATION)
;;        Preferences - infor for ordering solutions: e.g., (<= COST)
;;        Specific Constraints - action specific constraints, e.g., with GO: TO, FROM, ...

;;  (defstruct constraints
;;        general filters preferences specific)
;; 

;;   DECLARATION OF DOMAIN SPECIFIC CONSTRAINT NAMES

(defconstant *DOMAIN-SPECIFIC-CONSTRAINT-NAMES*
    '(:to :from :via :avoid :directly))

;;  SORTING CONSTRAINTS
;;    takes a list of constraints and builds a constraints structure

(defun sort-constraints (constraint-list)
  (setq constraint-list (simplify-each-GO-constraint constraint-list))
  (cond
   ((eq (car constraint-list) 'error)
    constraint-list)
   ((> (length (remove-if-not #'(lambda (x) (eq (car x) :agent)) constraint-list)) 1)
    (list 'failure :inconsistent-agent))
   (t
    (let* ((ans (make-constraints))
	   (result-codes
	    (mapcar #'(lambda (c)
			(classify-constraint c ans)) ;; NB: ANS constructed by side effect
		    (if (eq (car constraint-list) :and) (cdr constraint-list) constraint-list))))
      (or (find-if #'(lambda (x) 
		       (member (car x) '(error failure))) result-codes)
	  (reverse-constraints ans))))))

(defun reverse-constraints (ans)
  (when (constraints-p ans)
    (setf (constraints-specific ans)
      (reverse (constraints-specific ans)))
    (setf (constraints-general ans)
      (reverse (constraints-general ans))))
  ans)

(defun classify-constraint (c answer)
  "Classifies a constraint and setf's answer - building the result by side effect.
   What is returned is ignored except for error messages"
  (if (consp c)
    (case (car c)
      ((:AGENT :DURATION :AT-LOC :USE :STAY-AT)
       (if (and (consp (second c)) (eq (caadr c) :and))
	   (list 'failure :inconsistent-agent)
	 (setf (constraints-general answer)
	   (cons c (constraints-general answer)))))
      (:preference
       (if (null (constraints-preferences answer))
	   (setf (constraints-preferences answer)
	     (second c))
	 (make-error-msg (format nil "Can only have one preference constraint. Second found was ~S:" c))))
      (:filter
       (setf (constraints-filters answer)
	 (cons (second c) (constraints-filters answer))))
      (:not
       (case (caadr c)
	 ((:AGENT :DURATION :AT-LOC)
	  (setf (constraints-general answer)
	  (cons c (constraints-general answer))))
	 (:preference
	  (setf (constraints-preferences answer)
	  (cons c (constraints-preferences answer))))
	 (:filter 
	  (setf (constraints-filters answer)
	    (cons c (constraints-filters answer))))
	 (otherwise
	(if (valid-specific-constraint (cadr c))
	    (setf (constraints-specific answer)
	      (cons c (constraints-specific answer)))
	  (make-error-msg (format nil "Ill-formed or unknown constraint: ~S" c))))))
      (:and
       (mapcar #'(lambda (x)
		   (classify-constraint x answer))
	       (cdr c)))
      ;;  HACK Alert- OR is disable for now - we take the first
      (:or (list 'failure :i-cant-handle-disjunctions))
      (otherwise
       (if (valid-specific-constraint c)
	   (setf (constraints-specific answer)
	     (cons c (constraints-specific answer)))
	 (make-error-msg (format nil "Ill formed or unknown constraint: ~S" c)))))
       (make-error-msg (format nil "Ill formed constraint: ~S" c))))

(defun valid-specific-constraint (c)
  (and (member (car c) *DOMAIN-SPECIFIC-CONSTRAINT-NAMES*)
       (or (eq (car c) :directly) ;; should do a better job on directly
	   (every #'lookup-city (cdr c)))))

;;  COMBININGS FILTERS AND PREFERENCES


(defun combine-filters (filter-values filter-constraints)
  (append filter-values filter-constraints))

(defun combine-preference (preference-values preference-constraints)
  (append preference-values preference-constraints))
  
      
;;
;; SIMPLIFY-GO-CONSTRAINTS maps constraints to a canonical form that is easier to handle
;;  Specifically:
;;       All :TOs eacept the last are conmverted to :VIAs
;;       All :VIAs are merged to form a single sequence
;;       :NOT constraints are converted to their complement forms
;;       :DIRECTLY constraints are converted to their canonical form

(defun simplify-constraints (act-type constraints)
  (case act-type
    (:GO (simplify-GO-constraints constraints))
    ;; GO is the default
    (otherwise (simplify-GO-constraints constraints))))

(defun simplify-GO-constraints (constraints)
  "Simplifies arbitrary lists of constraints"
  (let ((ans (simplify-each-GO-constraint constraints)))
    (if (eq (car ans) 'error)
	ans
      (convert-tos ans))))

(defun convert-tos (constraints)
  "Changes all but the last :TO constraint to a :VIA"
  (when constraints
    (if (and (eq (caar constraints) :TO)
             (find-constraint (cdr constraints) :TO))
      (cons (cons :VIA (cdar constraints))
            (convert-tos (cdr constraints)))
      (cons (car constraints) 
            (convert-tos (cdr constraints))))))

(defun simplify-each-GO-constraint (constraints)
  "Checks each constraint individually"
  (cond
   ((null constraints) nil)
   ((atom constraints) (make-error-msg (format nil "Ill-formed constraint: ~S" constraints)))
   ((eq (car constraints) :and)
    (simplify-each-Go-constraint (cdr constraints)))
   ;; catch embedded ands and flatten them
   ((and (consp (car constraints))
	 (not (eq (caar constraints) :directly))
	 (consp (cadar constraints))
	 (not (eq (caar constraints) :and))  
	 (eq (caadar constraints) :and))
    (let ((c (caar constraints)))
      (simplify-each-Go-constraint
       (append
	(mapcar #'(lambda (v)
		    (list c v))
		(cdr (cadar constraints)))
	(cdr constraints)))))
   ((atom (car constraints)) (make-error-msg (format nil "Ill-formed constraint: ~S" constraints)))
   (t 
    (let* ((c (car constraints))
	   (c-type (car c))
	   (c-args (cdr c)))
        (case c-type
	  (:NOT
           (let* ((arg-c (car c-args))
                  (arg-c-args (cdr arg-c))
                  (new-c
                   (case (car arg-c)
		     (:VIA (cons :AVOID arg-c-args))
                     (:AVOID (cons :VIA arg-c-args))
		     (:NOT (car arg-c-args))
                     (otherwise c))))
             (cons new-c (simplify-each-GO-constraint (cdr constraints)))))
          (:DIRECTLY
	
	   (if (every #'symbolp c-args)
	       (if (eql (length c-args) 2)
		   (cons c (simplify-each-GO-constraint (cdr constraints)))
                 (PSM-Warn "Cannot handle constraint ~" c))
	     ;; c-args will be a list of constraints
	     ;;  we strip out the TO and FROM and append any others outside the scope of the directly
	     ;;  e.g., ... (:DIRECTLY (:AND (:TO CHICAGO) (:VIA BATH) (:FROM AVON))) ... 
	     ;;    would be turned into ... (:DIRECTLY AVON CHICAGO) (:VIA BATH) ...
             (let* ((d-constraints (simplify-GO-constraints c-args))
		    (from (find-constraint d-constraints :FROM))
                    (to (find-constraint d-constraints :TO))
		    (remaining-constraints
		     (remove-constraint (remove-constraint d-constraints :TO) :FROM)))
	       (if remaining-constraints
		   (append (simplify-each-GO-constraint remaining-constraints)
			   (cons `(:DIRECTLY ,(if from (car from)) ,(if to (car to)))
				 (simplify-each-GO-constraint (cdr constraints))))
		 (cons `(:DIRECTLY ,(if from (car from)) ,(if to (car to)))
		       (simplify-each-GO-constraint (cdr constraints))))
	       )))
	  ;;  AND is simply flattened out
	  (:AND
	   (append (simplify-each-GO-constraint c-args)
		   (simplify-each-GO-constraint (cdr constraints))))
	  ;; The rest are left as is
	  ((:VIA :AVOID :LOC :DURATION :AGENT :TO :FROM :USE)
           (cons c (simplify-each-GO-constraint (cdr constraints))))
	  
	  (otherwise
	   (if (and (consp (car c)) (eq (length c) 1))
	       (append (simplify-each-GO-constraint (car c))
		       (simplify-each-GO-constraint (cdr constraints)))
	     (let nil
	       (Format nil "Unknown constraint type: ~S" c)
	       (cons c (simplify-each-GO-constraint (cdr constraints))))))
          )  ;; end CASE C-TYPE
      ))))
 
      
(defun gather-constraints (c-type constraints)
  "gathers all the values of the indicated c-type into a single list
      returns a pair (<merged constraints of type c-type> . <other constraints>)"
  (let* ((other-constraints 
          (remove-if-not #'(lambda (x) (eq (car x) c-type)) 
                                           constraints))
         (remaining-constraints 
          (remove-if #'(lambda (x) (eq (car x) c-type)) 
                         constraints)))
    (cons (cons c-type (append-values other-constraints))
          remaining-constraints)))

(defun append-values (constraints)
  (when constraints
    (append (cdar constraints)
            (append-values (cdr constraints)))))
     

;;=====================================================================================
;;  MERGE CONSTRAINTS
;;
;; This function checks consistency between constraints (wrt a route) 
;;   and constructs a merged list. In the case of conflicts, it invokes
;;   the passed in conflict resolution function
;;  it returns a report structure defined below

(defstruct report
  consistent?                   ; =NIL means the constraints weren't consistent
  unresolvable-new-constraint       ; nonNIL means the inconsistency was not resolvable, the value is
  unresolvable-old-constraint       ; the unresolvable old constraint
  merged-constraints                ; The final set of constraints if consistent
  reason)                           ; a reason structure
;;
;;   NB: when updating a TO constraint for a route extension is considered consistent, even
;;     though the old-constraints must be changed, the prior solution does not

(defun merge-constraints (new-cs old-cs route conflict-resolution-fn)
  (if (null new-cs) 
   ;;   if there are no more constraints to resolve, we're done
    (make-report :consistent?  T
                 :merged-constraints old-cs)
    ;; otherwise, process the next constraint
    (let* ((constraint (car new-cs))
           (args (cdr constraint)))
      (case (car constraint)
	((:TO :FROM)  
         (check-from-to new-cs old-cs route conflict-resolution-fn))
	
	(:STAY-AT
	 (check-stay-at (car args) new-cs old-cs route conflict-resolution-fn))
        
	(:VIA
         (check-for-conflicts constraint :AVOID 
                              new-cs old-cs route conflict-resolution-fn)
         )
        (:AVOID 
         (check-for-conflicts constraint :VIA 
                              new-cs old-cs route conflict-resolution-fn)
         )
        (:DIRECTLY
         (check-directly args new-cs old-cs route conflict-resolution-fn))
	
	(:AGENT 
	 (check-agent args new-cs old-cs route conflict-resolution-fn))
	
	(:NOT
	 (check-not (car args) new-cs old-cs route conflict-resolution-fn))
        
	(:USE
	 (check-use (car args) new-cs old-cs route conflict-resolution-fn))
	
	(:AND (merge-constraints (append args (cdr new-cs)) old-cs route conflict-resolution-fn))
	
	(otherwise (make-report :reason (make-reason :type :unknown-constraint :info constraint))))
       )))

(defun check-from-to (new-cs old-cs route conflict-resolution-fn)
  (let* ((new-fta (get-from-to-agent new-cs))
	 (new-from (fta-from new-fta))
         (new-to (fta-to new-fta))
	 (new-agent (fta-agent new-fta))
         (old-fta (get-from-to-agent old-cs))
         (old-from (fta-from old-fta))
         (old-to (fta-to old-fta)))
    (cond 
     ;;  No old FROM and TO, or they are the same
     ((or (and (null old-from) 
	       (or (null old-to) (eq new-to old-to)))
	  (and (null old-to) (eq new-from old-from)))
      (merge-constraints (remove-fta new-cs)
			 (append (gen-fta-constraints new-fta)
				 (remove-fta old-cs))
			 route conflict-resolution-fn))
      ;;  new FROM and TO are redundant
     ((and (or (null new-to) (eq old-to new-to)) 
	   (or (eq old-from new-from) (null new-from)))
      (merge-constraints (remove-fta new-cs) old-cs route conflict-resolution-fn))
     ;;  FROM and TO constraints are disjoint
     ((or (and (null old-from) (null new-to))
	  (and (null old-to) (null new-to) (null new-agent)))
      (merge-constraints (remove-fta new-cs) (append (gen-fta-constraints new-fta) old-cs)
			 route conflict-resolution-fn))
     ;;  inconsistency
     (t (apply-fn conflict-resolution-fn 
		  (car new-cs) 
		  (cdr new-cs)
		  old-cs
		  route)))))
   

;;  CHECK AGENT

(defun check-agent (args new-cs old-cs route conflict-resolution-fn)
  (if (check-if-true `(:type ,(car args) :engine))
      (let* ((new-agent (car args))
	     (new-from (find-original-loc-of-agent (car args)))
	     (old-fta (get-from-to-agent  old-cs))
	     (old-from (fta-from old-fta))
	     (old-agent (fta-agent old-fta)))
	(cond 
	 ((null old-from)
	  (merge-constraints (cdr new-cs) 
			     (cons (list :AGENT new-agent)
				   (cons (list :FROM new-from)
					 old-cs))
			     route conflict-resolution-fn))
	 ((eq new-agent old-agent)
	  (merge-constraints (cdr new-cs) old-cs route conflict-resolution-fn))
	 ;;((eq new-from old-from)
	 ;; (merge-constraints (cdr new-cs) 
	 ;;	     (cons (list :AGENT new-agent) (remove-constraint old-cs :AGENT))
	 ;;	     route conflict-resolution-fn))
	 (t (apply-fn conflict-resolution-fn 
                  (car new-cs) 
		  (cdr new-cs)
                  old-cs
                  route))))
    (make-report :reason `(:REASON :TYPE :UNKNOWN-AGENT :INFO ,args))))


;; CHECK STAY-AT - consistent in general only if agrees with TO constraint
;;    in which case it is ignored
(defun check-stay-at (stay-city new-cs old-cs route conflict-resolution-fn)
  "checks that prop is not present or implied by existing constraints"
  (let* ((new-fta (get-from-to-agent new-cs))
	 (new-to (fta-to new-fta))
	 (old-fta (get-from-to-agent old-cs))
         (old-to (fta-to old-fta)))
	   
    (if (not (if new-to (eq new-to stay-city)
	     (eq old-to stay-city)))
	(apply-fn conflict-resolution-fn 
		  (car new-cs)
		  (cdr new-cs)
		  old-cs
		  route)
      ;;  ignore if OK
      (merge-constraints (cdr new-cs) old-cs
			 route conflict-resolution-fn))))

;; CHECK NOT

(defun check-not (prop new-cs old-cs route conflict-resolution-fn)
  "checks that prop is not present or implied by existing constraints"
  (if (some #'(lambda (x) (constraints-overlap prop x)) old-cs)
      (apply-fn conflict-resolution-fn 
		(car new-cs)
		(cdr new-cs)
		old-cs
		route)
    (merge-constraints (cdr new-cs) (cons (car new-cs) old-cs)
		       route conflict-resolution-fn)))

;; CHECK USE

(defun check-use (object new-cs old-cs route conflict-resolution-fn)
  "checks that prop is present or implied by existing constraints"
  (if (some #'(lambda (x) (member object (cdr x))) old-cs)
      ;;  if the object is already used, we ignore this constraint
      (merge-constraints (cdr new-cs) old-cs
			 route conflict-resolution-fn)
    ;; otherwise, we need to find a way to incorporate it
    (let ((role (find-most-likely-role-for-object object)))
      (if (not (eq role :use))
	  (merge-constraints (cons (list role object) (cdr new-cs))
			     old-cs
			     route
			     conflict-resolution-fn)))))

(defun find-most-likely-role-for-object (object)
  (case (find-type object)
    (:engine :agent)
    (:city :via)))
   
;; CHECK DIRECTLY

(defun check-directly (args new-cs old-cs route conflict-resolution-fn)
  (let* ((new-from (car args))
         (new-to (cadr args))
         (old-fta (get-from-to-agent old-cs))
         (old-from (fta-from old-fta))
         (old-to (fta-to old-fta)))       
    (if (and old-to old-from)
      (cond 
       ;; Condition 1: NEW-FROM is not specified (e.g., go directly to pittsburgh)
       ((null new-from) 
        ;; find earliest city in route that connects to NEW-TO
        (let ((earliest-connection (find-connection route new-to)))
          (if earliest-connection
            ;; if a connection found, check if route modification or extension
            (if (in-route route new-to)
              ;;  we're just shortening the current route
              (merge-constraints (cdr new-cs) 
                                 (cons `(:DIRECTLY ,earliest-connection ,new-to) old-cs) 
                                 route
                                 conflict-resolution-fn)
              ;; NEW-TO not in route
	      (apply-fn conflict-resolution-fn
		     `(:DIRECTLY ,earliest-connection ,new-to)
			   (cdr new-cs)
			   old-cs
			   route))
            ;;  no direct connection found
            (apply-fn conflict-resolution-fn 
		      (car new-cs) (cdr new-cs) old-cs route))))

       ;; Condition 2: both NEW-FROM and NEW-TO are specified and connect to each other
       ((and new-to
	     (domain-query `(:CONNECTED ,new-from ,new-to))
             (in-route route new-from))
        (if (and (in-route route new-to) (not (find-if #'(lambda (c) 
							   (and (eq (car c) :directly)
								(or (eq (second c) new-from)
								    (eq (third c) new-to))))
						       old-cs)))
          ;; if both the FROM and TO are in the route, we just want a direct route between them
            (merge-constraints (cdr new-cs) 
                               (cons `(:DIRECTLY ,new-from ,new-to) old-cs) 
                               route
                               conflict-resolution-fn)
            (apply-fn conflict-resolution-fn 
		      (car new-cs) (cdr new-cs) old-cs route)))

       ;;  Condition 4: Various uninterpretable conditions
       (t (make-report 
             :unresolvable-new-constraint (car new-cs)
             :merged-constraints old-cs)))
        
      ;;  at least one of OLD-FROM or OLD-TO not specified. just add the constraint if they connect
      (if (and new-from new-to (domain-query `(:CONNECTED ,new-from ,new-to)))
        (if old-to
          (merge-constraints (cdr new-cs) 
                             (cons `(:DIRECTLY ,new-from ,new-to) old-cs) 
                             route
                             conflict-resolution-fn)
          ;; OLD-TO not specified
          (if old-from
            ;;  OLD-FROM specified, OLD-TO not - set destination
            (merge-constraints (cdr new-cs) 
                               (append `((:DIRECTLY ,new-from ,new-to) 
					 (:TO ,new-to))
				       old-cs)
                               route
                               conflict-resolution-fn)
            ;; NEITHER OLD-FROM or OLD-TO specified, set both
            (merge-constraints (cdr new-cs) 
                               (append `((:DIRECTLY ,new-from ,new-to) 
					 (:FROM ,new-from)
					 (:TO ,new-to))
				       old-cs) 
                               route
                               conflict-resolution-fn)))
        (make-report 
         :unresolvable-new-constraint (car new-cs)
         :merged-constraints old-cs))
    ))
  ) ;; check-directly

    

(defun apply-fn (fn conflict-new remaining-constraints old-constraints route)
  (apply fn
         (list conflict-new
	       remaining-constraints
               old-constraints
               route)))
        

(defun find-connection (answer city)
  "Find the earliest city on the route that directly connects to the city"
  (if answer
    (let ((route (route-soln-current (solution-set-domain-info answer))))
      (if route
        (check-each-city-for-direct-connection (route-cities route) city)))))

(defun check-each-city-for-direct-connection (cities city)
  (when cities
    (let ((first-city-name (location-name (car cities))))
      (if (domain-query (list :CONNECTED first-city-name city))
        first-city-name
        (check-each-city-for-direct-connection (cdr cities) city)))
    ))


;;  This function checks conflicting constraints (of type conflict-pred)
;;  before continuing

(defun check-for-conflicts (constraint conflict-pred new-cs old-cs route fn)
  (let ((args (cdr constraint)))
    (if (some #'(lambda (x) (and (eq (car x) conflict-pred) 
					 (intersection (cdr x) args))) 
	      old-cs)
      ;; conflict detected
      (apply-fn fn constraint
                (cdr new-cs) old-cs route)
      ; no conflict
      (merge-constraints
       (cdr new-cs) (cons constraint old-cs) route fn))))

;; Predicate returns a "residue" or T if constraints conflict
(defun constraints-conflict (c1 c2)
  (let ((p1 (car c1))
	(p2 (car c2)))
    (cond
     ((equal c1 c2) nil)
     ;; if predicates are the same, a conflict exists for constraints that must
     ;;  occur only once.
     ((eq p1 p2)
      (if (member p1 '(:TO :FROM))
	  T))
     ;; now we're down to specific conflicts
     (t
      (case (car p1)
	;; VIA and AVOID conflict
	(:VIA
	 (and (eq p2 :AVOID) (intersection (cdr c1) (cdr c2))))
	(:AVOID
	 (and (eq p2 :VIA) (intersection (cdr c1) (cdr c2))))))
     )))

;;  True if constraint c1 "overlaps" constraint c2 - i.e., they share some content
(defun constraints-overlap (c1 c2)
  (cond 
   ((equal c1 c2) T)
   ((equal (car c1) (car c2))
    (if (eq (car c1) :VIA)
	(intersection (cdr c1) (cdr c2))))
   (t 
    (case (car c1)
      (:DIRECTLY
       (and (eq (car c2) :VIA) (intersection (cdr c1) (cdr c2))))
     (:VIA
      (and (eq (car c2) :DIRECTLY) (intersection (cdr c1) (cdr c2)))))
    ))) 

;;  True if every constraint in C1 is implied by a constraint in c2

(defun constraints-subsumed (act-type c1 c2)
  (case act-type
    (:GO (every #'(lambda (c) (GO-constraint-implied c c2)) c1))
    ;; GO is the default as usual
    (otherwise (every #'(lambda (c) (GO-constraint-implied c c2)) c1))))

(defun GO-constraint-implied (c constraints)
  (or (member c constraints :test #'equal)
      (and (eq (car c) :use)
	   (let ((obj (cadr c)))
	     (some #'(lambda (x) (eq obj (cadr x))) constraints)))))
  
	
(defun constraints-mentioning-city (city constraints)
  (some #'(lambda (x) (member city (cdr x))) constraints))

(defun remove-constraints-mentioning-city (constraints city)
  (remove-if #'null
	     (mapcar #'(lambda (x)
			 (if (member city (cdr x))
			     (if (> (length x) 2)
				 (cons (car x) (remove-if #'(lambda (x) (eq x city))
							  (cdr x))))
			   x))
		     constraints)))

;; remove-constraint removes constraints that that the arg. 
;;  It allows a constraint name such as :TO (and removes all :to constraints)
;;    or full constraints like (:VIA BUFFALO)
(defun remove-constraint (c-list c)
  (if (symbolp c)
    (remove-if #'(lambda (x) (eq (car x) c)) c-list)
    (remove-if #'(lambda (x) (equal x c)) c-list)))

(defun remove-constraint-from-act (act c)
  (cons (car act)
	(cons (second act)
	      (remove-constraint (get-constraints-from-act act) c))))
      
;;==============================================================
;; Ultities for Speech Act representation
;;   speech act format: (sa-name :slot1 value1 ... slotn valuen)

(defun sa-type (sa)
  (and (listp sa) (car sa)))

(defun find-arg-in-act (sa argname)
  (if (listp sa)
      (find-arg (cdr sa) argname)))

(defun find-arg (sv-list argname)
  (if sv-list
      (if (eq (car sv-list) argname)
	  (cadr sv-list)
	(find-arg (cddr sv-list) argname))))

;;  find the constraint in a list of constraints
;;  CONSTRAINT lists are of the form ((constraint1 arg1) ... (constraintn argn))
;;  so that we can express complex constraints like ANDs and ORs in a reasonable fashion.
(defun find-constraint-in-act (act constraint)
  (cdr (assoc constraint (cddr act))))

(defun get-constraints-from-act (act)
  (let ((constraints (cddr act)))
    (mapcan #'(lambda (c)
		(if (and (consp c) (eq (car c) :and))
		    (cdr c)
		  (list c)))
	    constraints)))
	
(defun find-constraint (clist constraint)
  (cdr (assoc constraint clist)))

;;(defun domain (SA context)
;;  (let ((ans (process-SA SA context)))
;;    (if ans ans *impossible-answer*)))

(defun construct-action (act-type constraints)
  (cons act-type 
	(cons (gensymbol (symbol-name act-type))
	      constraints)))

;;  Checking constraints

(defun constraint-holds (soln constraint)
  (case (car constraint)
    (:agent 
     (eq (cadr constraint) (solution-set-agents soln)))
    (t (case (car (solution-set-action-type soln))
	 (:GO
	  (apply-GO-constraint (solution-set-agents soln)
			       (route-soln-current 
				(solution-set-domain-info soln))
			       constraint))
	 (otherwise
	  (PSM-warn "Acts of type ~S not supported." (solution-set-action-type soln))
	  nil)))))

(let ((known-act-types '(:GO)))
  (defun is-action (act)
    (and (consp act)
	 (member  (car act) KNOWN-ACT-TYPES)
	 (atom (cadr act))
	 (or (null (cddr act)) (listp (caddr act))))))
