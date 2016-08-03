;;   The PSM data structures

(in-package "PSM")

;;   The problem solving state is maintained as a series of task-trees that
;;   maintain a linear history of the development of the task throughout the
;;   dialogue.  If nothing else, this provides us with an unlimited UNDO operation,
;;   but I expect it to be useful for other uses as we move along.

;;   The TASK-TREE structure  

(defstruct TASK-TREE
  root                 ;;  the root node
  focus                ;;  the focus node of the tree
  leaf-cache           ;;  cache for leaf nodes
  symbol-table         ;;  symbol table for node reference
)


;;   The TASK-NODE structure
 
(defstruct TASK-NODE
  name                 ;;  this task node's symbol table name
  content              ;;  a task structure
  decomposition        ;;  an ordered list of subtask node names (if any)
  parent               ;;  the supertask node name
)


;;   The TASK structure

(defstruct task
  plan-id             ;;  the unique name for this task
  objective           ;;  the goal being pursued (an act-type and the hard constraints)
  filter              ;;  global plan constraints that must be satisfied
  preference-function ;;  the evaluation criteria
  key-objects        ;;  list of important objects involved in this task (currently just the engine)
  Soft-Constraints    ;;  list of violatable constraints (i.e., preferences)
  solution            ;;  a solution set structure 
  status              ;;  problem solving status: must be one of :achieved, :impossible, :unsolved, :solved
  goal-Dstatus        ;;  goal discourse status: must be one of :goal-proposed, :goal-accepted, :goal-provate
  soln-Dstatus        ;;  solution discourse status: only relevant when status=:solved
                      ;;       must be one of :agreed, :proposed, :private
  )

(defun task-duration (task)
  (if (solution-set-p (task-solution task))
      (schedule-duration (solution-set-execution-trace (task-solution task)))))

(defun task-cost (task)
  (if (solution-set-p (task-solution task))
      (schedule-cost (solution-set-execution-trace (task-solution task)))))

;; SOLUTION SETS 
;;    encode a structured set of abstract solutions to a problem

(defstruct solution-set ;; a set of solutions, typically associated with a task
  name
  agents ;; the agent of the act, and default agent of all subacts
  action-type ;;  the action e.g., (:GO g123 (:FROM ATLANTA) (:TO CHICAGO))
  filters ;; additional constraints on solutions (but not part of primary goal statement)
  preference-function ;; the criteria used to order solutions
  decomposition ;; a list of subactions that is the current solution
  execution-trace ;; a simulation of the plan, a schedule
  domain-info) ;;  domain specific encoding of the act for use by specialized reasoners. e.g., a ROUTE-SOLN structure

;;   SCHEDULEs
;;    encode the results of simultation/evaluation runs

(defstruct SCHEDULE ;; an execution trace
  duration
  cost
  states) ;; a list of SCHEDULE-ITEMs
  
(defstruct SCHEDULE-ITEM
  state			                ; a state, e.g., (DOING (GO g1 ...)) or (AT AVON)
  start-time				; offset from start of schedule (in hours) for earliest time at location
  end-time				; offset from start of scedule (in hours) for latest time at location
  cost					; costs associated with the state
  plan-id				; the plan-id whose execution caused the state
  delay-flag				; a record of delays, e.g., (:CROSSING PLAN4545)
 )

(defun schedule-item-duration (si)
  (- (schedule-item-end-time si) (schedule-item-start-time si)))

;;==========================================================================================
;;
;;  DATA STRUCTURES FOR THE ROUTE PLANNER
;;



;;  ROUTE-PLAN REPRESENTATION

(defstruct (route-soln
	    (:print-function
	     (lambda (p s k)
	       (if *PSM-TRACE-VERBOSE*
		   (format s "<ROUTE: CURRENT:~A, ALTERNATES:~A, REJECTS:~A>" (route-soln-current p) (route-soln-alternates p) (route-soln-rejects p))
		 (format s "<route suppressed>")))))
  current ;; the current instantiated route
  alternates ;; a list of other routes satisfying the constraints
  rejects) ;; routes rejected

;;  LOCATION/CITIES
(defstruct (location 
	    (:print-function
	     (lambda (p s k)
	       (if (> (location-delay p) 0)
		   (format s "<~A, delay=~A>" (location-name p) (location-delay p))
		 (format s "<~A>" (location-name p))))))
	    name
	    loc				;  (x . y) coordinates
	    delay			;  number of hours to pass through city - default is 0
	    direct-tracks		;  list of all outgoing routes
	    )

;;  TRACKS

(defstruct track name 
		  from			; tracks are directional
		  to			; between the two specified cities
		  class			; type of vehicle that can use track (e.g., :TRAIN, :TRUCK, :PLANE)
		  distance		; distance between cities
		  time			; average number of hours to traverse the track
		  )

;;  PRIMITIVE ROUTES

(defstruct (route 
	    (:print-function
	     (lambda (p s k)
	       (format s "<~A, ~A miles, ~A hours, ~A>" (route-name p) (route-distance p) (route-time-to-travel p) (route-cities p)))))
  name
  color
  number-of-hops
  distance				; distance in miles
  time-to-travel			; overall time to traverse route, in hours
  cities				; list of cities (LOCATION objects)  passed through
  tracks				; list of TRACKs passed through
  ;; schedule				; list of SCHEDULE-ITEM
  )


;;   FROM-TO-AGENT (FTA) structrue used for answers
(defstruct FTA
  from to agent)


;;  CONSTRAINTS

;;  Constraints divide up into several categories
;;        General Constraints - apply to any action: AGENT, DURATION, AT-LOC
;;        Filters - bounds for cost and other measures: e.g., ((<= 20) DURATION)
;;        Preferences - infor for ordering solutions: e.g., (<= COST)
;;        Specific Constraints - action specific constraints, e.g., with GO: TO, FROM, ...

  (defstruct constraints
      general filters preferences specific)



;;=============================================================================================
;;
;;   The ANSWER structure
;;
;;  All responses from the domain reasoners, and all responses generated
;;   from the problem solving manager are in terms of the ANSWER structure,
;;   which is easily accessable with the functions defined here

;;  ANSWERS are evaluated in 2 dimensions, coherence and confidence in success
;;    Recognition-score captures notions of whether the intent of the request makes sense in context
;;    Answer-score captures how well the system performed the requested act
;;       
;;  These are independent as seen in the following examples: you can combine any non-impossible
;;  example of recognition-score with any example of the answer-score. An example of each
;;  is given in response to an example request to show a weather map for an area X.

;;  Recognition-Score
;;       :GOOD e.g., displaying a weather map of X is an expected step of the current task
;;       :OK   e.g., displaying a weather map of X was not expected, but is compatible with the current task
;;       :BAD e.g., displaying a weather map is possible but serves no purpose in the current task (mapybe area X isn't involved in the current task)
;;       :IMPOSSIBLE e.g., either system does not understand what the action is begin requested,
;;                or the action does not make sense in the current task (in fact, the task might involve not doing the action)
;; Answer-score 
;;       :GOOD: e.g., returns weather map info for area X
;;       :OK    e.g., returns weather map for an area larger than X
;;       :BAD    e.g., returns map but does not cover all of desired area
;;       :IMPOSSIBLE  e.g., weather map server is down so request cannot be accomodated


(defstruct ANSWER
  Recognition-score  ;; the recognition-score
  Answer-score       ;; The answer score
  psm-update          ;;  The update act that will install this is the PSS
  Result             ;;  the result of the request, passes info back to caller about display updates, etc.
  Reason             ;;  a list of REASONS
  node-name          ;;  the name of the node that answer is based on 
  parent             ;; the name of the parent node 
)

(defstruct REASON
  Msg
  Type               ;; the type of reason 
                     ;;      one of :FAILED-PRECONDITION,:UNSATISFIED-SUBGOAL, :UNSATISFIED-CONSTRAINT
                     ;;          :NEEDS-CONFIRMATION, :IMPOSSIBLE, :UNDOES-SATISFIED-GOAL
  Info               ;; determined by the type: e.g., for FAILED-PRECONDITION it is the precondition
)

