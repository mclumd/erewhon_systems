;;   DOMAIN REASONER 

(in-package "PSM")

;;
;;
;;   Speech acts in calls to the domain reasoner are of the form
;;                 (<speech-act-name> :CONTENT (<act-name> <constraint>*))
;;
;;   There may be other keyword arguments to the speech act but they are ignored
;;   The speech acts currently recognize are
;;      :ID-GOAL  - specify a new subgoal  (must be relative to ROOT at present)
;;      :REFINE   - refine current task with new constraints. The new constraints
;;                 cannot contradict the current constraints with the one exception that
;;                 the destination can be updated with a new TO constraint.
;;      :MODIFY  - revises the current task, remove all constraints that conflict with the
;;                 new constraints

;;  The acts recognized, and their constraints, are as follows
;;   :GO  
;;        (:FROM loc)  go from indicated location
;;        (:TO loc)    go to indicated location
;;        (:VIA loc1 loc2 ... locn)  go via indicated locations in order specified
;;        (:AVOID loc)        don't go through loc, same as (:NOT (:VIA loc))
;;        (:DIRECTLY loc1 loc2)  go directly from loc1 to loc2
;;        (:DIRECTLY <from-or-to-constraint>*)  - e.g., (:DIRECTLY (:TO CHICAGO))
;;        (:NOT <constraint>) ensure that the constraint does not hold
;;        (:STAY-AT loc)  loc should be end of route, this is transient in current implementation
;;                 and gets converted into a TO

;;    :STAY
;;         (:LOC loc)  stay at loc
;;         (:DURATION n) stay for n hours    (currently ignored)
;;
;;   The result returned is an ANSWER structure


(defvar *tracedomain* t)

;; PROCESS-DOMAIN-SA handles all domain-relates speech acts (an SA) wrt a specific context (a TASK)

(defun interpret-domain-SA (SA Context plan-id ST)
  (let* ((sa-type (sa-type SA))
	 (content (find-arg-in-act SA :content))
	 (constraints (sort-constraints (get-constraints-from-act content))))
    (if (constraints-p constraints)
	(let*
	    ((filters (valid-filter-fn (find-arg-in-act SA :filter)))
	     (preference (find-arg-in-act SA :preference))
	     (ans
	      (case sa-type
		(:NEW-SUBPLAN
		 (do-id-goal content constraints context filters preference))
		
		(:REFINE
		 (do-refine plan-id content constraints context ST filters preference))

		(:EXTEND
		 (do-extend plan-id content constraints context filters preference))
             
		(:MODIFY
		 (let* ((sa-add (find-arg-in-act SA :add))
			(content (if (consp sa-add)
				     (if (symbolp (car sa-add))
					 (cons (car sa-add) 
					       (cons (second sa-add)
						     (cddr sa-add)))
				       sa-add)
				   ;; special case of add being a bare city name, just pass it on
				   sa-add))
			(sa-delete (find-arg-in-act SA :delete)))
		   (do-modify content sa-delete context plan-id filters preference)))
	    
		(:CANCEL
		 (do-cancel plan-id content context))
		
		(:DO-WHAT-YOU-CAN
		    (do-what-you-can content constraints filters preference))
	    
		(:SPLIT-PLAN
		 (PSM-warn "Split-plan not implemented yet: ~S" SA))
		(otherwise
		 (make-error-msg (Format nil "Unknown action request: ~S" SA))))))
         
	  ans)
      constraints
      )
    ))


;; INSTANTIATE ACTION
;; Given a set of constraints, it finds an instantiation. There are three possible
;;  types of value returned
;;  an ANSWER structure if a solution is found
;;  an ERROR performative (e.g., (ERROR :COMMENT "No location found for agent"))
;;  an UNSOLVED message, possible with a reason structure e.g, (UNSOLVED)
;;  a FAILURE message - indicated ill-formed constraints e.g., (FAILURE :NO-AGENT-AT-ORIGIN)

(defun instantiate-action (action filters preference)
  (let* ((fta (get-from-to-agent-from-act action))
	 (from (fta-from fta))
	 (agent (fta-agent fta))
	 (new-act (fill-in-from-and-agent from agent action)))
    (if (member  (car new-act) '(error unsolved failure))
      ;; If an Error, we simply return it
	new-act
      (let ((answer (instantiate-route new-act filters preference)))
	(if (solution-set-p answer)
	    (let ((agent (car (find-constraint (get-constraints-from-act new-act) :AGENT))))
	      (if agent (setf (solution-set-agents answer) agent))
	      answer)
	  '(UNSOLVED :no-solution))))))

;;  For :GO actions  the FROM and AGENT slot are intimately related.
;;  This function adds one to be consistent with the other if necessary

(defun fill-in-from-and-agent (from agent action)
  (cond
   ;;  an AGENT but not FROM - set From based on location of agent
   ((and agent (null from))
    (let ((inferred-from (find-loc-of-engine agent)))
      (if inferred-from
	  (append action `((:FROM ,inferred-from)))
	'(failure :unknown-agent)
	)))
   ;;  FROM specified but no agent, find an agent
   ((and from (null agent))
    (let ((possible-agents (find-engines-originally-at from)))
      (if possible-agents
	  (append action `((:AGENT ,(car possible-agents))))
	(list 'Failure :NO-AGENT-AT-ORIGIN))))
   ;; regular case
   ((and from agent)
    (if (domain-query `(:AT-loc ,agent ,from))
	action
      '(failure :inconsistent-agent)))
   ;; no agent or from specified
   (t
    '(unsolved :no-agent))))

;;  This is the possibly domain specific version of build answer - computing the result from 
;;  the update

(defun build-route-answer (recognition-score answer-score update &optional reason-type reason-info)
  (build-answer recognition-score 
		answer-score 
		update 
		(extract-result-from-update update)
		reason-type 
		reason-info))

(defun extract-result-from-update (update)
  "This extracts out the information required for the DM 
   from the update specification"
  (let* ((type (car update)))
    (case type
      ((update decomp noop delete-goal)
       (let* 
	   ((args (cdadr update))
	    (goal (find-arg args :objective))
	    (soln (find-arg args :solution))
	    (agents (if soln (solution-set-agents soln)
		      (car (find-constraint-in-act goal :agent))))
	    (objects
	     (find-objects-in-constraints (get-constraints-from-act goal)))
	    (plan-actions (if soln (solution-set-decomposition soln)))
	    (plan-id (find-arg args :plan-id)))
	
	 (cons (convert-type type)
	       (if plan-id
		   (list :objects
			 objects
			 :plan
			 (list plan-id
			       :goal goal
			       :agent agents
			       :actions plan-actions))
		 (list :objects objects)))))
      (otherwise 
       (list (convert-type type))))))

(defun convert-type (type)
  (case type
    ((decomp plan-updated) :new-subplan)
    (update :plan-updated)
    (confirm :plan-confirmed)
    (noop :plan-not-updated)
    (delete-plan :delete-plan)
    (otherwise (PSM-warn "Unknown update type: ~S" type)
	       type)))

(defun find-objects-in-constraints (constraints)
  (when constraints
    (union
     (if (eq (caar constraints) :AND)
	 (find-objects-in-constraints (cdar constraints))
       (mapcan #'(lambda (x) (if (symbolp x) (list x)))
	       (cdar constraints)))
     (find-objects-in-constraints (cdr constraints)))))

;;===============================================================================================
;;   DO-ID-GOAL - Process speech acts that introduce a new ACTION as a goal in a specified CONTEXT

(defun do-id-goal (action constraints context filter preference)
  (let* ((act-type (car action))
	 (combined-filters (combine-filters filter (constraints-filters constraints)))
	 (combined-preference (combine-preference preference (constraints-preferences constraints)))
	 (objective (if (task-p context) (task-objective context) context)))
    ;; inherit filter and preference if not specified: use the info in the parent task
    (when (task-p context)
      (if (null combined-filters) 
	  (setq combined-filters (task-filter context)))
      (if (null combined-preference) 
	  (setq combined-preference (task-preference-function context))))
    ;;  currently only allow new goals under the root node
    (cond ((not (eq (car objective) 'ROOT))
	   (make-sorry-msg (format nil "New subplans only supported for ROOT node:~s" action)))
	  ((find-constraint (constraints-general constraints) :stay-at)
	    (build-impossible-answer :new-subplan-with-stay-at action))
	  (t (case act-type
	       (:GO (do-id-goal-GO (cadr action) (append (constraints-general constraints) (constraints-specific constraints))
				   combined-filters combined-preference))
	       (otherwise
		(make-sorry-msg (format nil "Actions of type ~S are not currently supported" act-type))))))))
  
(defun do-id-goal-GO (act-id constraints filter preference)
  "Process the introduction of a :GO goal, possible a conjunctive goal"
  (let*
      ((destinations (remove-if-not #'(lambda (x) (eq (car x) :TO)) constraints)))
    
    (if (< (length destinations) 2)
	(do-one-new-GO-goal (cons :GO (cons act-id constraints)) filter preference)
      ;; deal with conjunctive goal
      (let* ((constraint-splits (split-constraints-at-TO  nil nil constraints))
	     (answers
	      (mapcar #'(lambda (c) (do-one-new-GO-goal (cons :GO (cons (gensymbol 'G) c)) filter preference))
		      constraint-splits))
	     (plan-id (gensymbol 'plan))
	     (objective (cons :and (mapcar #'(lambda (x) (cons :GO (cons (gensymbol 'g) x)))
					   constraint-splits)))
	     (worst-answer (car (find-worst-answers answers)))
	     (best-recognition-score (answer-recognition-score worst-answer))
	     (psm-updates (mapcar #'(lambda (x) (answer-psm-update x))
					       answers))
	     (decomp (mapcar #'cadr psm-updates))
	     (objects (mapcan #'(lambda (x) (find-arg (cdr x) :key-objects)) decomp)))
	 (make-answer :recognition-score best-recognition-score 
		      :answer-score :good
		      :psm-update (list 'decomp `(task :key-objects ,objects 
						       :filter ,filter
						       :preference-function ,preference
						       :plan-id ,plan-id 
						       :objective ,objective
						       :decomp ,decomp))
		      :reason (answer-reason worst-answer)
		      :result `(:new-subplan :objects ,objects :plan (,plan-id :goal ,objective)))))))
	

(defun split-constraints-at-TO (answer newc  constraints)
  " Divide a list of constraints into a list of lists, breaking at each :TO constraint"
  (if (null constraints) 
      (if newc (append answer (list newc)) answer)
    (if (eq (caar constraints) :TO)
	(split-constraints-at-TO (append answer (list (append newc (list (car constraints))))) nil (cdr constraints))
      (split-constraints-at-TO answer (append newc  (list (car constraints))) (cdr constraints)))))


(defun do-one-new-GO-goal (action filter preference)
      "Process a single :GO goal"
      (let* ((fta (get-from-to-agent-from-act action))
	     (suggested-from (fta-from fta))
	     (suggested-to (fta-to fta))
	     (suggested-agent (fta-agent fta))
	     (possible-agents (if suggested-from (find-engines-originally-at suggested-from)))
      
	     (objects (remove-if #'null (list suggested-agent suggested-from suggested-to))))
      
	(cond
	 ;; if agent is in use, we fail
	 ((if suggested-agent 
	      (agent-in-use suggested-agent)
	    (if (and suggested-from possible-agents) (every #'agent-in-use possible-agents)))
	  (build-impossible-answer :multiple-use-of-agent suggested-agent))
	 ;; if agent is not at origin, we fail
	 ((and suggested-agent suggested-from (not (member suggested-agent possible-agents)))
	  (build-impossible-answer :inconsistent-agent suggested-agent))
	 ;;  if suggested-from is specified, a train has to be there for this to be an ID-GOAL
	 ((and suggested-from (null possible-agents))
	  (build-impossible-answer :NO-AGENT-AT-ORIGIN suggested-from))
	 ;; if agent specified is unknown, we fail
	 ((and suggested-agent
	       (null (find-loc-of-engine suggested-agent)))
	  (build-impossible-answer :unknown-agent suggested-agent))
    
     ;; if suggested-to is not specified, then id-goal is unlikely
     ((null suggested-to)
      (build-route-answer :BAD :OK
			  `(decomp (task :key-objects ,objects
					 :plan-id ,(gensymbol 'Plan)
					 :objective ,action
					 :filter ,filter
					 :preference-function ,preference
					 :status :unsolved))
			  :NO-DESTINATION nil))
      ;; cases that probably will work
     (t 
      (let ((recognition-score :GOOD)
	    (reason nil))
	;;  If there are several possible agents, we downgrade the recognition 
	;;   score because of the ambiguity
	(when (and (null suggested-agent)
		   (and (consp possible-agents)
			(> (length possible-agents) 1)))
	  (setq recognition-score :OK)
	  (setq reason (make-reason :TYPE :ambiguous-agent :info possible-agents)))
	
	;;  check for unlikely interpretations
	
	(let ((check-result 
	       (check-reasonableness-of-goal suggested-agent action recognition-score)))
	  (when check-result
	    (setq recognition-score (car check-result))
	    (setq reason (cadr check-result))))
	;;  now construct solutions and answers
	
	(cond
	    ;; if from/agent and to specified, and we try to use a solution
	    ((and (or suggested-from suggested-agent) suggested-to)
	     (let* ((instance (instantiate-action action filter preference)))
	
	       (cond
		((solution-set-p instance)
		 (build-route-answer recognition-score
				     :GOOD
				     `(decomp (task :key-objects ,objects
						    :plan-id ,(gensymbol 'plan)
						    :objective ,(solution-set-action-type instance)
						    :filter ,filter
						    :preference-function ,preference
						    :solution ,instance
						    :status :solved))
				     reason))
                      
		((eq (car instance) 'unsolved)
		 (build-route-answer recognition-score :BAD
				     `(decomp (task :key-objects ,objects
						    :plan-id ,(gensymbol 'plan)
						    :objective ,(if suggested-from
								    (if suggested-agent action
								      (append action (list (list :AGENT (first possible-agents)))))
								  action)
						    :filter ,filter
						    :preference-function ,preference
						    :status :unsolved))
				     (if reason
					 (make-reason :type :AND :info (list reason (make-reason :type :no-solution)))
				       (make-reason :type :no-solution))))
		(t instance))))
       
	  ;; with underspecifed goal (i.e., not from), it is OK we don't solve the problem, is OK.
	  ((null suggested-from)
	   (build-route-answer recognition-score :GOOD
			       `(decomp (task :key-objects ,objects
					      :plan-id ,(gensymbol 'plan)
					      :objective ,action
					      :filter ,filter
					      :preference-function ,preference
					      :status :unsolved))
			       reason))
     
	  (t *impossible-answer*)))))
    )
  )

(defun  check-reasonableness-of-goal (agent goal recognition-score)
  "Checks if goal is already in goal tree or agent is otherwise occupied.
Returns a list consisting of the new recognition score and a reason (if applicable)"
  (if (and agent (quick-query 'ask-one `(:agent ,agent ?plan) '?plan))
    (list :IMPOSSIBLE (make-reason :type :agent-overcommitted))
    ;; now we know either that there is no agent specified or the agent is free
    (let* ((current-goals (quick-query 'ask-all '(:goal ?goal ?plan) '?goal))
	   (conflict (some #'(lambda (act)
			       (or (check-goal-subsumption goal act)
				   (check-goal-subsumption act goal)))
			       current-goals)))
      ;;  if problems found, just return the first for now
      (if conflict 
	  (list :BAD (make-reason :type :goal-redundant?))
      ;;; otherwise all is fine
	(list recognition-score nil)))))
       

(defun check-goal-subsumption (act1 act2)
  "returns T is act1 is a specialization of act2"
  (if (eq (car act1) (car act2))
      (case (car act1)
	(:GO
	 (let ((fta1 (get-from-to-agent-from-act act1))
	       (fta2 (get-from-to-agent-from-act act2)))
	   (and (or (null (fta-agent fta2))
		    (eq (fta-agent fta1) (fta-agent fta2)))
		(or (null (fta-to fta2))
		    (eq (fta-to fta2) (fta-to fta1)))
		(or (null (fta-from fta2))
		    (eq (fta-from fta2) (fta-from fta1))))))
	(otherwise nil))))
	

;;================================================================================================
;;  DO-REFINE
;;  refines a prior action with new constraints, creating a new solution
;;  Note: this does not allow prior constraints to be removed as with do-modify.

(defun  do-refine (plan-id action constraints context ST filter preference)
  (if (is-action action)
      (let* ((objective (task-objective context))
	     (prior-soln (task-solution context))
	     (combined-filters (combine-filters filter (constraints-filters constraints)))
	     (combined-preference (combine-preference preference (constraints-preferences constraints)))
	     (agents (if prior-soln (solution-set-agents prior-soln)
		       (task-key-objects context))))
	(if (symbolp agents)  (setq agents (list agents)))
	
	;;  merge inherited filter and new
	(setq combined-filters (refine-filter (task-filter context) combined-filters))
	(if (null combined-preference)
	    (setq combined-preference (task-preference-function context)))
	
	;;  Main Code
	(cond 
	 ((eq (car combined-filters) 'error)
	  (build-impossible-answer :incompatible-new-filter))
	 
	 ((and (task-preference-function context)
	       combined-preference
	       (not (equal combined-preference (task-preference-function context))))
	  (build-impossible-answer (make-reason :type :incompatible-preference-function 
						:info (list combined-preference (task-preference-function context)))))
	 
	 ((eq (car objective) 'ROOT) 
	  ;; The root node cannot be refined, so treat as a new subgoal if a TO is specified
	  (let ((ans 
		 (downgrade-recognition-score (do-id-goal action constraints objective filter preference) 
					      (make-reason :type :created-new-subgoal)))
		)
	    (if (no-solution-in-answer ans)
		(downgrade-answer-score ans	
					(make-reason :type
						     (if (or (find-constraint (constraints-specific constraints) :FROM)
							     (find-constraint  (constraints-specific constraints) :AGENT))
							 :no-solution :no-agent)))
	      ans)))
	 (t
	  ;;  THE USUAL CASES      
	  (case (car objective)
	    (:GO
	     (case (car action)
	       (:GO (refine-GO plan-id action objective prior-soln agents 
			       (append (constraints-general constraints) (constraints-specific constraints))
			       combined-filters combined-preference))
	       (otherwise
		(make-sorry-msg (format nil "~S Actions not yet supported" (car action))))))
	    
	    (:AND 
	     (try-refining-a-subgoal 
	      (mapcar #'(lambda (x) (get-node-by-name x st))
		      (task-node-decomposition (get-node-by-name plan-id st)))
	      action constraints ST filter preference))
	     
	    ) ;; end CASE
	  )))
    (make-error-msg (format nil "Illegal action: ~S" action))))
 
(defun try-refining-a-subgoal (decomposition action constraints ST filter preference)
  (let*
      ((results (find-best-answers
		 (mapcar #'(lambda (node)
			     (do-refine (task-plan-id (task-node-content node))
			       action constraints (task-node-content node) ST filter preference))
			 decomposition)))
       (destinations (mapcar #'(lambda (x)
				 (if (answer-p x)
				     (car (find-constraint-in-act 
				       (find-arg (cdadr (answer-psm-update x)) :objective)
				       :to))))
			     results)))
    (if (answer-p (car results))
	(if (or (= (length results) 1) 
		(member (answer-recognition-score (car results)) '(:BAD :IMPOSSIBLE)))
	    (modify-result-for-push-to-subgoal (car results))
	  (make-answer :recognition-score :OK
		       :answer-score :BAD
		       :reason (make-reason :type :ambiguous-goal
					    :info (cons :TO destinations))))
      (car results))))
    

(defun refine-filter (old new)
  "combines two filter specification only if new is consistent with old"
  ;; currently we allow multiple filters only if they are different scales
  (cond ((null new) old)
	((null old) new)
	((not (eq (cadr new) (cadr old)))
	 (list new old))
	(t (list 'false :Incompatible-new-filter old))))

(defun refine-preference (old new)
  "combines two preference specification only if new is consistent with old"
  ;; currently we allow multiple preferences only if they are different scales
  (cond ((null new) old)
	((null old) new)
	((not (eq (cadr new) (cadr old)))
	 (list new old))
	(t (list 'false :Incompatible-new-preference old))))

(defun refine-list (old-list new fn)
  (if (member new old-list :test #'equal) 
      old-list
    (if (some #'(lambda (c)
		  (eq (car (apply fn (list  c new))) 'false))
	      old-list)
	(list 'false :Incompatible-new-filter new)
	(cons new old-list))))

(defun refine-lists (old-list new-list fn)
  (if (null new-list) 
      old-list
    (refine-lists (refine-list old-list (car new-list) fn) (cdr new-list) fn)))

;;  Other utilities

(defun no-solution-in-answer (ans)
  "returns true if the answer does not involve a solution"
  (and (answer-p ans)
       (let
	   ((update (answer-psm-update ans)))
	 (case (car update)
	   (decomp
	    (not (solution-set-p (find-arg (cdadr update) :SOLUTION))))
	   ))))

(defun modify-result-for-push-to-subgoal (answer)
  (setf (answer-result answer) 
    (cons 'new-subplan (cdr (answer-result answer))))
  answer)
     
(defun refine-GO (plan-id action objective prior-soln agents new-constraints filter preference)
  (let ((new-agent (car (find-constraint new-constraints :AGENT)))
	(old-task-type (car objective))
	(old-agent (car (find-constraint-in-act objective :AGENT)))
	(constraints (simplify-GO-constraints new-constraints)))
    (Cond
     ;;  We can only handle refining :GO objectives with :GO actions
     ((not (eq old-task-type :GO))
      (build-impossible-answer (make-reason :type :cant-refine-act-of-type :info old-task-type)))
     ;; Check for anomalous constraint specs (e.g., multiple FROMs or AGENTs)
     ((check-for-anomalous-GO-constraints constraints)
      (build-impossible-answer (make-reason :type :too-complicated-constraints :info constraints :msg "multiple FROM or AGENT")))
     ((and new-agent (null old-agent) (agent-in-use new-agent))
      (build-impossible-answer (make-reason :type :multiple-use-of-agent)))
     ;; Case where agents are consistent
     ((or (null new-agent)
	  (null old-agent)
	  (eq new-agent old-agent))
      (let* 
	  ((update (merge-constraints constraints
				      (get-constraints-from-act objective)
				      prior-soln #'resolve-refine-conflict))
	   (merged-constraints (report-merged-constraints update))
	   (old-constraints (get-constraints-from-act objective))
	   (old-fta (get-from-to-agent old-constraints))
	   (old-from (fta-from old-fta))
	   (old-to (fta-to old-fta)))
	(if (report-consistent? update)
	       ;; If the new constraints already hold on the existing solution, we downgrade 
	    ;;  the recognition score
	    (if (and prior-soln 
		     (all-GO-constraints-redundant prior-soln merged-constraints)
		     (or (null preference) (eq preference (solution-set-preference-function prior-soln)))
		     (or (null filter) (eq filter (solution-set-filters prior-soln))))
		(build-route-answer :OK :GOOD
				    `(noop (task :key-objects ,agents
						 :plan-id ,plan-id
						 :objective ,objective
						 :filter ,filter
						 :preference ,preference 
						 :solution ,prior-soln
						))
				    :REDUNDANT new-constraints)
	      ;; Otherwise, we have the typical refine with consistent new constraints to add
	      (let* ((new-action (construct-action :GO merged-constraints))
		     (new-fta (get-from-to-agent merged-constraints))
		     (new-to (fta-to new-fta))
		     (new-from (fta-from new-fta))
		     ;;(new-agent (fta-agent new-fta))
		     (recognition-score :GOOD)
		     (reason nil)
		     (answer
		      (if (null prior-soln)
			  (instantiate-action  new-action filter preference)
			
			;;  check if the route was extended or not.
			(if (and (eq new-from old-from) (eq new-to old-to))
			    (modify-act-instance prior-soln merged-constraints filter preference)
			  (list 'failure :changed-goal)
			  ))))
		;; downgrade recognition score is destination changed
		(if (or (null old-to) (eq new-to old-to))
		    (create-answer-with-answer-score answer recognition-score reason agents plan-id new-action prior-soln filter preference)
		  answer)
	  
		))
	  ;; New constraints were not consistent
	  (build-impossible-answer (report-reason update)))))
     
     (t (build-impossible-answer :inconsistent-agent new-agent)))))

(defun all-constraints-redundant (act-type soln constraints)
  (case act-type
    (:go (all-Go-constraints-redundant soln constraints))
    ;; GO is default for now
    (otherwise (all-Go-constraints-redundant soln constraints))))

(defun all-GO-constraints-redundant (soln constraints)
  (let ((prior-route (if soln (route-soln-current (solution-set-domain-info soln))))
	(old-agent (solution-set-agents soln)))
    (if prior-route
    (every #'(lambda (c) (apply-GO-constraint old-agent prior-route 
					      (if (eq (car c) :TO)
						  (cons :VIA (cdr c))
						c)))
	   constraints)
    (psm-warn "all-GO-constraints-redundant: no route in ~S" soln))))

(defun remove-constraints-that-dont-hold (route constraints old-agent)
  (if route
      (remove-if-not
       #'(lambda (c) (apply-GO-constraint old-agent route c))
       constraints)
    (psm-warn "remove-constraints-that-dont-hold: no route found" nil)))
	

;;  Checking the well-formedness of constraints
;; currently we just check for obvious problems like multiple FROMs or AGENTs
;;  multiple TOs are allowed as they are coerced into VIAS.

(defun check-for-anomalous-GO-constraints (constraints)
  (let* ((froms (remove-if-not #'(lambda (x) (eq (car x) :FROM)) constraints))
	 (agents (remove-if-not #'(lambda (x) (eq (car x) :AGENT)) constraints)))
    (or (> (length froms) 1) (> (length agents) 1))))

(defun create-answer-with-answer-score (answer recognition-score reason objects plan-id new-action prior-soln filter preference)
  (cond
   ((solution-set-p answer)
    (build-route-answer recognition-score :GOOD
			`(update (task :key-objects ,objects
				       :plan-id ,plan-id
				       :objective ,(solution-set-action-type answer)
				       :filter ,filter
				       :preference-function ,preference
				       :solution ,answer
				       :status :solved))
			reason))
   ((answer-p answer)
    answer)
   ((listp answer)
   ;; No solution found
    (case (car answer) 
      (unsolved
       ;;  instantiate the agent if the FROM is known but agent is unspecified (This is for Brad and could be deleted in 3.0)
       (let* ((fta (get-from-to-agent-from-act new-action))
	      (new-from (fta-from fta))
	      (new-agent (fta-agent fta)))
	 (if (and (null new-agent) new-from)
	     (let ((possible-agents (find-engines-originally-at new-from)))
	       (if (eq (length possible-agents) 1)
		   (setq new-action (append new-action (list (list :agent (car possible-agents))))))))
	  
	 (build-route-answer (if prior-soln :BAD :OK)  ;;If we had a solution before but now don't, then its a bad interp.
			     :BAD 
			     `(update (task :key-objects ,objects
					    :plan-id ,plan-id
					    :objective ,new-action
					    :filter ,filter
					    :preference-function ,preference
					    :solution nil
					    :status :unsolved))
			     (if reason (list :and (make-reason :type (second answer)) reason)
			       (make-reason :type (second answer)))
			     new-action)))
   
      (failure
       (build-impossible-answer (cadr answer)))
      ;; Errors
      (error answer)
      (otherwise  (make-sorry-msg (Format nil "Bad answer in Instantiate-action: ~S" answer)))))
   ;;
   (t
    (make-sorry-msg (Format nil "Bad answer in Instantiate-action: ~S" answer)))
   ))

;;  predicate returns true if city is in the instantiated route
(defun in-route (answer city)
  (if answer
      (member city (get-cities-in-route answer))))

(defun in-route-not-origin (answer city)
  (if answer 
      (member city (cdr (get-cities-in-route answer)))))
    
(defun get-cities-in-route (Answer)
  (let ((route (if (solution-set-p answer)
		   (route-soln-current (solution-set-domain-info answer))
		 answer)))
    (if (route-p route)
        (mapcar #'location-name (route-cities route))
      (PSM-warn "Illegal argument to get-cities-in-route:~S" answer))))

;;  The functions for resolving contraint conflicts for refine acts.
;;   Basically, we allow route extensions (i.e., new TOs), 
;;    or DIRECTLY constraints that otherwise conflict.

(defun resolve-refine-conflict (new-constraint 
				remaining-constraints
                                old-constraints
                                route)
                                                            
  (let ((fn
         (case (car new-constraint)
	   ((:FROM :TO) #'resolve-refine-from-to)
	   ;;(:DIRECTLY #'resolve-refine-directly)   don't think there's anything we can do - old code was same as resolve-extend-directly
	   (:USE #'resolve-refine-use)
           (otherwise nil))))
    (if fn
      (apply fn (list new-constraint
                      (cons new-constraint remaining-constraints)
                      old-constraints
                      route))
      (make-report :unresolvable-new-constraint new-constraint :REASON :inconsistent-constraint))))

(defun resolve-refine-from-to (new-constraint remaining-cs old-cs route)
  (let* ((new-fta (get-from-to-agent remaining-cs))
	 (new-from (fta-from new-fta))
         (new-to (fta-to new-fta))
	 (new-agent (fta-agent new-fta))
	 (old-fta (get-from-to-agent old-cs))
	 ;;(old-from (fta-from old-fta))
         (old-to (fta-to old-fta))
	 (old-from (fta-from old-fta))
	 (old-agent (fta-agent old-fta)))
    (cond 
     
     ((and new-from (eq new-from new-to))
      (make-report :unresolvable-new-constraint (list (list :from new-from) (list :to new-to))
		   :reason (make-reason :type :makes-circular-route)))
     
      ;;  can't change the destination
     ((and old-to (not (eq old-to new-to)))
      (make-report :unresolvable-new-constraint  new-constraint :reason (make-reason :type :cant-change-destination)))
     
     ;; if destination is OK, and from and agent not specified
     ((and (null new-from) (or (null new-agent) (null old-agent) (eq new-agent old-agent)))
      (let* ((c1 (if new-to (list (list :to new-to))))
	     (c2 (if new-agent (cons (list :agent new-agent) c1)
		   c1)))
	    
      (merge-constraints (remove-fta remaining-cs)
			 (append c2 old-cs)
			 route
			 #'resolve-refine-conflict)))

     ;;  NEW-FROM is in route, but not origin. allow as a modification to route only if new-to is in route
     ((in-route route new-from)
      (if (domain-query `(:connected ,new-from ,new-to))
	  (merge-constraints
	   (remove-from-to remaining-cs) (cons (list :DIRECTLY new-from new-to) old-cs) route
	   #'resolve-refine-conflict)
	;; if not connected, make into a via
        (merge-constraints
         (remove-from-to remaining-cs) (cons (list :VIA new-from new-to) old-cs) route
         #'resolve-refine-conflict)))
     
     ;; NEW-FROM inconsistent
     ((and new-from old-from (not (eq new-from old-from)))
      (make-report :unresolvable-new-constraint new-constraint :reason (make-reason :type :inconsistent-origin)))
                 
     ;; NEW-FROM not present in route at all.
     (t 
	(make-report :unresolvable-new-constraint new-constraint :reason (make-reason :type :let-me-know-if-this-happens)))
     ))
  ) ;; end RESOLVE-FROM-TO

    



;;============================================================================================
;;
;;   DO WHAT YOU CAN
;;
;;  tries to find the best interpretation it can in any current plan
;;
;;   Basically - it only tries REFINEs as other acts are more dangerous.

(defun do-what-you-can (action constraints filter preference)
   (if (is-action action)
      (let* ((combined-filters (combine-filters filter (constraints-filters constraints)))
	     (combined-preference (combine-preference preference (constraints-preferences constraints)))
	     (route-constraints (append (constraints-specific constraints) 
					(constraints-general constraints)))
	     (nodes (task-tree-leaf-cache (current-pss)))
	     (ST (task-tree-symbol-table (current-pss)))
	     (fta (get-from-to-agent route-constraints))
	     (suggested-from (fta-from fta))
	     (suggested-to (fta-to fta))
	     (stay-city  (car (find-constraint route-constraints :stay-at)))
	     (suggested-agent (fta-agent fta))
	     (possible-agents (if suggested-from (find-engines-originally-at suggested-from)))
	     (leaf-nodes  (mapcar #'(lambda (name) (get-node-by-name name ST))
				      nodes)))
	(cond 
	 ((and suggested-agent suggested-from (not (member suggested-agent possible-agents)))
	  (build-impossible-answer (make-reason :type  :inconsistent-agent :info suggested-agent)))
	 ;; if agent specified is unknown, we fail
	 ((and suggested-agent
	       (null (find-loc-of-engine suggested-agent)))
	  (build-impossible-answer (make-reason :type :unknown-agent :info suggested-agent)))
	   
	 (t
	  ;;  Try to REFINE any leaf plan node
	  (let ((best  (try-refining-a-subgoal leaf-nodes action constraints ST filter preference)))
	    (if (answer-p best)
		(if (eq (answer-recognition-score best) :good)
		    best
		  ;; The other options only work if both FROM and TO are defined, a stay-at constraint is defined,
		  ;;     or we have a directly constraint
		  (if (or (and (or suggested-from suggested-agent)
			       suggested-to)
			  stay-city
			  (find-constraint (constraints-specific constraints)  :directly))
		      ;; Try to extend any leaf plan node
		      (let* ((results
			      (mapcar #'(lambda (node)
					  (do-extend (task-plan-id (task-node-content node))
					    action constraints (task-node-content node) filter preference))
				      leaf-nodes))
			     (best-extend  (car (find-best-answers results))))
			(if (and (answer-p best) 
				 (eq (answer-recognition-score best-extend) :good ))
			    (setq best best-extend)
			  ;; Finally, if we haven't found a good interpretation yet,
			  ;;  try to modify any leaf plan node for any route that goes through the FROM
			  ;; city, i.e., the FROM constraint cannot be changed except by do-what-you-can.
			  (if (or suggested-from suggested-agent)
			      (let* ((results
				      (mapcar #'(lambda (node)
						  (let* ((ss (task-solution (task-node-content node)))
							 (objective (task-objective (task-node-content node)))
							 (old-agents (find-constraint-in-act objective :agent))
							 (old-from (car (find-constraint-in-act objective :from))))
						    (if (or (and suggested-agent (member suggested-agent old-agents))
							    (and (solution-set-p ss) (or (in-route ss suggested-from)
											 (eq suggested-from old-from))))
							(do-modify action nil (task-node-content node)
								   (task-plan-id (task-node-content node))
								   filter preference)
						      (build-impossible-answer :unknown))))
					      leaf-nodes))
				     (best-modify (car (find-best-answers results))))
				(if (and (answer-p best) 
					 (eq (answer-recognition-score best-modify) :good))
				    (setq best best-modify)
				  (setq best (car (find-best-answers (list best best-extend best-modify))))))
			    (setq best (car (find-best-answers (list best best-extend))))))
			
			;;  modify REASON codes if necessary
			(when (eq (answer-recognition-score best) :IMPOSSIBLE)
			  ;;  if suggested-from is specified, a train has to be there for this to be an ID-GOAL
			  (setf (answer-reason best)
			    (if (and suggested-from (null possible-agents))
				(make-reason :type :NO-AGENT-AT-ORIGIN :info suggested-from)
			      (make-reason :type :no-interpretation-found))))
			(modify-result-for-push-to-subgoal best))
		    (modify-result-for-push-to-subgoal best)))
	      best)))))))
	
	     
	
;;============================================================================================
;;
;;   DO-EXTEND - adds an additional goal to achieve after the current PLAN-ID
;;
;;   In TRAINS - this is typically extending a route.

(defun do-extend (plan-id action constraints context filter preference)
  (let* ((objective (task-objective context))
	 (combined-filters (combine-filters filter (constraints-filters constraints)))
	 (combined-preference (combine-preference preference (constraints-preferences constraints)))
	 (prior-soln (task-solution context)))
    
    ;;  merge inherited filter and new
    (setq combined-filters (refine-filter (task-filter context) combined-filters))
    (if (null combined-preference)
	(setq combined-preference (task-preference-function context)))
    
    ;;  Main Code
    (cond 
     ((eq (car combined-filters) 'error)
      (build-impossible-answer :incompatible-new-filter))
     
     ((and (task-preference-function context)
	   combined-preference
	   (not (equal combined-preference (task-preference-function context))))
      (build-impossible-answer (make-reason :type :incompatible-preference-function 
					    :info (list combined-preference (task-preference-function context)))))
     ;;  filter and preference functions were not changed
     ((eq (car objective) 'ROOT) 
      ;; The root node cannot be extended. Call ID-GOAL. But simplify constraints first to prevent goal splitting
      (downgrade-recognition-score (do-id-goal action
				     (make-constraints :general (constraints-general constraints)
						       :specific (simplify-constraints (car action) (constraints-specific constraints))
						       :filters (constraints-filters constraints)
						       :preferences (constraints-preferences constraints))
				     objective
				     filter preference) 
				   (make-reason :type :created-new-subgoal)))
     
      ((null prior-soln)
      (build-impossible-answer (make-reason :type :cant-extend-empty-solution)))
	 
      (t (case (car action)
	  (:GO (extend-GO plan-id objective 
			  (append (constraints-general constraints)
				  (constraints-specific constraints))
			  prior-soln combined-filters combined-preference))
	  (otherwise
	   (make-sorry-msg (format nil "~S Actions not yet supported" (car action)))))))))

(defun extend-GO (plan-id objective constraints prior-soln filter preference)
  (let* ((old-fta (get-from-to-agent (get-constraints-from-act objective)))
	 (old-agent (fta-agent old-fta))
	 (old-from (fta-from old-fta))
	 (old-to (fta-to old-fta))
	 (action-constraints (simplify-GO-constraints constraints))
	 (new-fta (get-from-to-agent action-constraints))
	 (spec-new-agent (fta-agent new-fta))
	 (new-agent (if spec-new-agent spec-new-agent old-agent))
	 (spec-new-from (fta-from new-fta))
	 (new-from (if spec-new-from spec-new-from old-to))
	 (new-to (fta-to new-fta))
	 (recognition-score :good)
	 (reason-code nil)
	 (directly-condition (find-constraint action-constraints :directly)))
    
    ;;  use  directly conditions as defaults
    (if directly-condition
	(if (null new-to)
	    (setq new-to (second directly-condition))))
 
    (cond
     ((or (null old-from) (null old-to) (null old-agent))
      (setq recognition-score :impossible)
      (setq reason-code :cant-extend-unsolved-plan))
     ((not (eq new-from old-to))
      (setq recognition-score :impossible)
      (setq reason-code :must-extend-from-old-destination))
     ((not (eq old-agent new-agent))
      (setq recognition-score :impossible)
      (setq reason-code :inconsistent-agent))
     ((eq old-to new-to)
      (setq recognition-score :BAD)
      (setq reason-code :redundant))
     ((null new-to)
      (setq recognition-score :impossible)
      (setq reason-code :no-new-destination))
     ((in-route prior-soln new-to)
      (setq recognition-score :bad)
      (setq reason-code :creating-circular-route))
     )
    
    (if (eq recognition-score :impossible)
       (build-impossible-answer (make-reason :type reason-code))
      
      (let
	  ((reason (if reason-code (make-reason :type reason-code)))
	   ;; (new-action (append `((:to ,new-to) (:from ,new-from) (:agent ,new-agent))
	   ;;		    (remove-fta action-constraints)))
	   (update (merge-constraints 
		    action-constraints 
		    (get-constraints-from-act objective)
		    prior-soln
		    #'resolve-extend-conflict)))
	;;(answers (instantiate-action new-action))
	(if (report-consistent? update)
	    (let* ((new-action  (cons :GO (cons (gensymbol 'G)  (report-merged-constraints update))))
		  (answer (if prior-soln 
			      (do-route-extension
				  prior-soln
				action-constraints
				(report-merged-constraints update))
			    (instantiate-action new-action filter preference))))
	      (create-answer-with-answer-score 
	       (or answer '(unsolved :no-solution))
	       recognition-score 
	       reason 
	       new-agent 
	       plan-id 
	       new-action
	       prior-soln nil nil))
	  (build-impossible-answer (report-reason update)))
	  
	  
       ))))

;;    RESOLVING EXTEND CONFLICTS

(defun resolve-extend-conflict (new-constraint 
				remaining-constraints
                                old-constraints
                                route)
                                                            
  (let ((fn
         (case (car new-constraint)
	   ((:FROM :TO) #'resolve-extend-from-to)
           (:DIRECTLY #'resolve-extend-directly)
           (otherwise nil))))
    (if fn
      (apply fn (list new-constraint
                      (cons new-constraint remaining-constraints)
                      old-constraints
                      route))
      (make-report :unresolvable-new-constraint new-constraint :reason :inconsistent-constraint))))

(defun resolve-extend-from-to (new-constraint remaining-cs old-cs route)
  (let* ((new-fta (get-from-to-agent remaining-cs))
	 (new-from (fta-from new-fta))
         (new-to (fta-to new-fta))
	 (new-agent (fta-agent new-fta))
         (old-fta (get-from-to-agent old-cs))
         (old-from (fta-from old-fta))
         (old-to (fta-to old-fta))
	 (old-agent (fta-agent old-fta)))
    (cond 
     
     ((and new-from (eq new-from new-to))
      (make-report :unresolvable-new-constraint (list (list :from new-from) (list :to new-to))
		   :reason (make-reason :type :makes-circular-route)))
     
     ;;  if NEW-TO is not specified, then we can't update
     ((null new-to)
      (make-report :unresolvable-new-constraint new-constraint :reason (make-reason :type :no-new-to)))
     
     ;;  NEW-FROM or OLD-FROM is not specified, or NEW-FROM = OLD-FROM or OLD-TO - update as an extension
     ((or (null new-from) (null old-from)
	  (eq new-from old-from)
	  (eq new-from old-to))
      (extend-to new-to 
		 (or old-from new-from)
		 (or old-agent new-agent)
		 old-to 
		 remaining-cs 
		 old-cs
		 route))
            
     ;;  NEW-FROM is in route, but not origin. allow as a modification to route only if new-to is in route
     ((in-route route new-from)
      (if (domain-query `(:connected ,new-from ,new-to))
        (merge-constraints
         remaining-cs (cons (list :DIRECTLY new-from new-to) old-cs) route
         #'resolve-extend-conflict)
        ;; if not connected, make into a via
        (merge-constraints
         remaining-cs (cons (list :VIA new-from new-to) old-cs) route
         #'resolve-extend-conflict)))
                 
     ;; NEW-FROM not present in route at all.
     (t 
	(make-report :unresolvable-new-constraint new-constraint :reason (make-reason :type :cant-change-destination)))
     ))
  ) ;; end RESOLVE-FROM-TO

    
(defun resolve-extend-directly (new-constraint remaining-cs old-cs route)
  (let* ((new-from (second new-constraint))
         (new-to (third new-constraint))
         (old-fta (get-from-to-agent old-cs))
         (old-from (fta-from old-fta))
         (old-to (fta-to old-fta)))
             
    
     ;;  can only handle directly TO X, or directly from <old-dest> to X.
    (if (and (or (null new-from) 
		 (eq new-from old-to))
	     (domain-query `(:CONNECTED ,old-to ,new-to)))
	(merge-constraints (cdr remaining-cs)
			   (append `((:directly ,old-to ,new-to) (:to ,new-to))
				   (remove-constraint old-cs :to))
			   route 
			   #'resolve-extend-conflict)
      (make-report :unresolvable-new-constraint new-constraint))))
   

;; EXTEND-TO replaces the TO constraint, and makes the old TO a VIA

(defun extend-to (new-destination new-from new-agent old-destination remaining-cs old-cs route)
  (if (in-route route new-destination) 
      ;; don't allow route that circles back on itself
      (make-report :unresolvable-new-constraint (List :to new-destination) :reason (make-reason :type :makes-circular-route))
    ;; If NEW-TO not already in route, we treat as an extention
    (merge-constraints
     (remove-fta remaining-cs)
     (append `((:TO ,new-destination)
	       (:VIA ,old-destination)
	       (:FROM ,new-from)
	       (:AGENT ,new-agent))
	     (remove-fta old-cs))
     route 
     #'resolve-extend-conflict)
    ))
  
	
;;===================================================================================
;;  MODIFY can be identical to REFINE but allows for removal of constraints
;;    (whereas the only removal extend allows is updating the destination)
;;
;;  refines a prior action with new constraints, creating a new solution
;;  ADDS should be an action spec, or an atom if trying to handle a fragment.

(defun  do-modify (adds deletes context plan-id filter preference) 
  (if (and (listp adds) (listp deletes))
      (let* ((objective (task-objective context))
	     (prior-soln (task-solution context))
	     (add-constraints (sort-constraints
			       (if (is-action adds) (simplify-constraints (car adds) (get-constraints-from-act adds))
				(simplify-constraints nil adds))))
	     (del-constraints (sort-constraints
			       (if (is-action deletes) (get-constraints-from-act deletes) deletes))))
	(cond
	 ((not (constraints-p add-constraints))
	  add-constraints)
	 ((not (constraints-p del-constraints))
	  del-constraints)
	 (t
	  (let*
	      ((new-constraints (append (constraints-general add-constraints) 
					(constraints-specific add-constraints)))
	       ;;  we transform delete (TO X) into (VIA X) as this is a more robust treatment
	       (delete-constraints (mapcar #'clean-up-deletes
					   (append (constraints-general del-constraints)
						   (constraints-specific del-constraints))))
	       (act-type (or (if (is-action adds) (car adds)) (if (is-action deletes) (car deletes))))
	       (objects (if prior-soln (solution-set-agents prior-soln)
			  (task-key-objects context))))
	    ;; check that for any (NOT X) constraints being added, X currently holds. 
	    (if (not (verify-not-constraints act-type prior-soln objective new-constraints))
		(build-impossible-answer :deletes-dont-hold deletes)
	    (let nil
	      ;;  inherit filter and preferences if not specified, replace if they are specified.
	      (setq filter (modify-filter (task-filter context) 
					  (combine-filters filter (constraints-filters add-constraints))
					  (mapcar #'second (constraints-filters del-constraints))))
	      (setq preference (modify-preference (task-preference-function context)
						  (combine-preference preference (constraints-preferences add-constraints))
						  (mapcar #'second (constraints-preferences del-constraints))))
	
	    (cond 
	     ;; filter or preference conflict
	     ((or (eq (car filter) 'false))
	      (build-impossible-answer (cadr filter) (third filter)))
	     ((or (eq (car preference) 'false))
	      (build-impossible-answer (cadr preference) (third preference)))
	 
	     ;; The root node cannot be modified
	     ((eq (car objective) 'ROOT) 
	      (build-impossible-answer :cant-modify-root plan-id))
	     ((eq (car objective) :AND)
	      (modify-conjunctive-goal objective prior-soln new-constraints objects plan-id))
	     ;;  No "instead of .." constraint  
	     ((null deletes)
	      (modify-action objective prior-soln new-constraints objects plan-id 
			     filter (task-filter context) preference (task-preference-function context)))
	  ;; the deletes must hold on the plan
	     ((if prior-soln 
		     (not (all-constraints-redundant act-type prior-soln delete-constraints))
		   (not (constraints-subsumed act-type delete-constraints (get-constraints-from-act objective))))
		(build-impossible-answer :deletes-dont-hold deletes))
	     ;; we have deletes, as in  "instead of buffalo" constraint where DM could not identify the constraint relation
	     ;;   we treat as an :AVOID constraint
	     (t 
	   
	      (let* 
		  ((uses-deletes (mapcan #'cdr (remove-if-not #'(lambda (x) (eq (car x) :USE)) delete-constraints)))
		   (other-deletes  (remove-if  #'(lambda (x) (eq (car x) :USE)) delete-constraints))
		   (uses-adds  (mapcan #'cdr (remove-if-not #'(lambda (x) (eq (car x)
									    :USE)) new-constraints)))
		   ;;  try to convert generic "Uses" constraints into something more specific
		   (converted-uses (if uses-deletes
				       (mapcan #'(lambda (c)
						   (identify-role-for-abbreviated-delete c uses-adds objective prior-soln))
					       uses-deletes)))
		   ;;  simply negate the remaining constraints to be deleted
		   (constraints-from-deletes 
		    (append 
		     converted-uses
		     (simplify-GO-constraints 
		      (mapcar #'(lambda (x) (list :NOT x))
			      other-deletes)))))
		;;  check for errors
		(let ((error (find-if #'answer-p constraints-from-deletes)))
		  (if error
		      error
		 
		    (modify-action objective
				   prior-soln
				   (append constraints-from-deletes
					   (remove-if #'(lambda (x) (eq (car x) :USE)) new-constraints)
					   (mapcar #'(lambda (x) (list :use x)) uses-adds)) ;; put the USE constraints in adds last as they may have been satisfied earlier
				   objects plan-id filter (task-filter context) preference (task-preference-function context))))
	
	
		)))))))))
	(make-error-msg (Format nil "Illegal modify: ~S must be an action or constraint list" adds))
	)
       
  )

(defun clean-up-deletes (c)
  "This simplifies delete constraints so they can be better handled."
    (case (car c)
      ;; changing a TO to a VIA will have same effect as TO and bve robust agsinat THROUGH/TO problems
      (:to (cons :via (cdr c)))
      (:via (cons :via (if (> (length (cdr c)) 1)
			      ;; if more than 1, just take the cities
			      (remove-if-not #'(lambda (n)
						 (lookup-city n))
					     (cdr c))
			      ;; if only one, we transform  a track into its destination
			      (cond ((lookup-city (cadr c)) (cdr c))
				    ((lookup-track (cadr c))
				     (list (location-name (track-to (lookup-track (cadr c))))))))))
      (otherwise c)))

;; VERIFY-NOT-CONSTRAINTS - checks that X already holds for each constraint of form (NOT X)
(defun verify-not-constraints (act-type prior-soln objective constraints)
  (every  #'(lambda (c)
	      (or (not (eq (car c) :not)) 
		  (if prior-soln (all-constraints-redundant act-type prior-soln (subst :via :to (cdr c)))
		    (constraints-subsumed act-type (cdr c) (get-constraints-from-act objective)))))
	  constraints))
			     

;;  MODIFYING FILTER AND PREFERENCE SPECIFICATIONS

(defun modify-filter (old-filter add-filter del-filter)
  "tries to delete and add filter modifications"
  (if (null old-filter) 
      (if del-filter
	  (list 'false :deleting-non-existant-filter del-filter)
	add-filter))
  (let ((ans (remove-equals old-filter del-filter)))
    (if (eq (car ans) 'false)
	(list 'false  :deleting-non-existant-filter del-filter)
      (refine-lists ans add-filter #'refine-filter))))

(defun remove-equals (old del)
  (if (null del)
      old
    (if (member (car del) old :test #'equal)
	(remove-equals (remove-if #'(lambda (x) (equal x (car del))) old) (cdr del))
      (list 'false))))

(defun modify-preference (old-preference add-preference del-preference)
  "tries to delete and add preference modifications"
  (if (null old-preference) 
      (if del-preference
	  (list 'false :deleting-non-existant-preference del-preference)
	add-preference))
  (let ((ans (remove-equals old-preference del-preference)))
    (if (eq (car ans) 'false)
	 (list 'false :deleting-non-existant-preference del-preference)
      (refine-lists ans add-preference #'refine-preference))))

(defun modify-conjunctive-goal (objective prior-soln new-constraints objects plan-id)
  "This handles attempts to modify a conjunctive goal"
  (build-impossible-answer 
   (make-reason :type :cant-modify-root :msg "Modifying conjuctive goals not yet supported")))

(defun identify-role-for-abbreviated-delete (object adds objective prior-soln)
  "Try to identify role of OBJECT in OBJECTIVE, so as to interpret an 'instead of OBJECT' constraint.
This returns a new constraint that is more specific"
  (case (car objective)
    (:GO
     (let ((prior-route (if prior-soln (route-soln-current (solution-set-domain-info prior-soln))))
	   (destination (car (find-constraint-in-act objective :TO)))
	   (origin (car (find-constraint-in-act objective :FROM))))
       (case (find-type object)
	 ;;  a city - must be modifying a route
	 (:CITY
	  (cond
	   ((eq object destination) 
	    (let ((new-destination (find-an-object-of-type adds :CITY)))
	      (if new-destination (list (list :TO new-destination))
		(list (list :NOT (list :TO object))))))
	   ((eq object origin)
	    (list (list :FROM (find-an-object-of-type adds :CITY))))
	   ((in-route prior-route object)
	      (if (null adds)
		  ;;  there is no info in add to help interpretation, we simply map it to an AVOID
		  (list (list :avoid object))
		;; here we have the special case: "avon instead of bath"
		(append (substitute-one-city-for-another adds object objective)
			(list (list :avoid object)))))
	   (t (list (build-impossible-answer :NOT-IN-ROUTE object)))))
	      ;; an ENGINE - changing the agent
	  (:ENGINE
	   (if (member object (find-constraint (get-constraints-from-act objective) :AGENT))
	       (let ((new-agent (find-an-object-of-type adds :ENGINE)))
		 (if new-agent
		     `((:AGENT ,new-agent))
		   `((:NOT (:AGENT ,object)))))
	     (list (build-impossible-answer :NOT-AGENT-OF-PLAN object))))
	  (t `((:USE ,object))))))
     (otherwise
      (make-sorry-msg (Format nil "~S acts not supported yet" (car objective))))))

(defun find-an-object-of-type (objects type)
  "returns first object that is of indicated type"
  (find-if #'(lambda (x) (eq (find-type x) type)) objects))

;; Modify action adds all the new constraints, removing any old ones that 
;;  become inconsistent.
(defun modify-action (objective prior-soln new-constraints objects plan-id filter old-filter preference old-preference)
  (case (car objective)
    (:GO
     (if (listp new-constraints)
	 (let* ((update (merge-constraints new-constraints (get-constraints-from-act objective)
					   prior-soln #'modify-constraints))
		(merged-constraints (if (report-p update)
					(report-merged-constraints update))))
	   (if (and (report-p update) (report-consistent? update))
	       ;; If the new constraints already hold on the existing solution, this was
	       ;;  not a correction.
	       (if
		   (and prior-soln
			(equal filter old-filter)
			(equal preference old-preference)
			(find-constraint merged-constraints :to) ;; TO must be present in revised constraints for next test to make sense
			(every #'(lambda (c) (constraint-holds prior-soln c)) merged-constraints))
		   (build-impossible-answer :constraint-already-true new-constraints)
		
		       		   		       
		 ;; Otherwise, we have the typical modify - see if we can find a route
		 
		 (let ((old-to (car (find-constraint-in-act objective :to)))
		       (new-to  (car (find-constraint new-constraints :to)))
		       (new-from (car (find-constraint new-constraints :from))))
		   (if (and new-to 
			    (in-route-not-origin prior-soln new-to)
			    (not (eq new-to old-to)))
		       
		       ;; if changing TO to a city already in the route, do a truncate
		       
		       (truncate-route-at new-to objective prior-soln plan-id)
		     
		     ;;  otherwise, compute a new route - if new destination is used, we remove all old VIA's 
		     ;;         but keep (:via x) if x was explicitly specified in the correction (as a FROM)
		     
		     (let* ((new-action (construct-action :GO (if new-to 
								  (if (and new-from 
									   (member new-from (find-constraint merged-constraints :via)))
								      (cons (list :via new-from)
									    (remove-constraint merged-constraints :via))
								    (remove-constraint merged-constraints :via))
								merged-constraints)))
			    (answer    (instantiate-action new-action filter preference))
			    (new-agent (car (find-constraint new-constraints :agent)))
			    (recognition-score :GOOD)
			    (reason nil))
		   
		       ;; if we failed to find an answer, delete any old VIA constraints and retry
		       (when (not (solution-set-p answer))
			 (let ((new-objective 
				(construct-action :GO 
						  (report-merged-constraints
						   (merge-constraints new-constraints 
								  (remove-constraint (get-constraints-from-act objective) :via)
								  prior-soln
								  #'modify-constraints)))))
		       (setq answer (instantiate-action new-objective
							filter preference))
		       (if (solution-set-p answer)
			   (setq new-action new-objective))))

		  
		   ;; if  agent was modified, must check for lots of bad things
		   (if new-agent
		       (let
			   ((old-from (find-constraint-in-act objective :from))
			    (new-from (find-constraint merged-constraints :from))
			    (old-agents (find-constraint-in-act objective :agent)))
			
			 (cond
			  ((and (not (member new-agent old-agents))
				(agent-in-use new-agent))
				 ;;  agent is already in use in some other plan!
			   (setq recognition-score :BAD)
			   (setq reason (make-reason :type :multiple-use-of-agent :info new-agent)))
			  ((and old-from new-from (not (equal old-from new-from)))
			   (setq recognition-score :OK)
			   (setq reason (make-reason :type :changed-origin)))
			  
			  )))
		   
		   ;; check for deleting a destination e.g., I don't want to go to Toronto.
		   (if (and (null (find-constraint merged-constraints :to))
			    (find-constraint-in-act objective :to))
		       (let nil
			 (setq recognition-score :OK)
			 (setq reason (if reason (list :and reason (make-reason :type :no-destination))
					(make-reason :type :no-destination)))))
		       
		   ;; compute answers
		   (cond
		    ((solution-set-p answer)
		     (build-route-answer recognition-score
					 :GOOD
					 `(update (task :key-objects ,objects
							:plan-id ,plan-id
							:objective ,new-action
							:filter ,filter
							:preference-function ,preference
							:solution ,answer
							:status :solved))
					 reason
					 ))
		    ((eq (car answer) 'unsolved)
		     (downgrade-recognition-score
		      (build-route-answer recognition-score :BAD
					  `(update (task :key-objects ,objects
							:plan-id ,plan-id
							:objective ,new-action
							:filter ,filter
							:preference-function ,preference
							:solution nil
							:status :unsolved))
					  reason)
		      (make-reason :type :NO-SOLUTION)))
		    ((eq (car answer) 'failure)
		     (build-impossible-answer (cadr answer)))
		    (t answer))))))
	     ;; New constraints were not consistent
	     (build-impossible-answer
	      (if (report-reason update)
		  (report-reason update)
		(make-reason :TYPE :INCONSISTENT 
			     :INFO (report-unresolvable-new-constraint update))))))
       ;;  Bad input format
       (Make-error-msg (Format nil "Illegal list of constraints to modify-action: ~S" new-constraints))))
    (otherwise 
     (make-sorry-msg (Format nil "~S acts not supported yet" (car objective))))))


;;  This replaces one city with another in the constraints, as in "Avon instead of Bath"
;;  If the city to delete is not in the constraints, we add (:AVOID BATH) (:VIA AVON)
(defun substitute-one-city-for-another (new-cities old-city objective)
  (let ((constraints (get-constraints-from-act objective)))
    (mapcar #' (lambda (city)
		 (substitute-city-for-city city old-city constraints))
	       new-cities)))
	

(defun substitute-city-for-city (new old constraints)
  (if constraints
      (if (member old (cdar constraints))
	  (replace-city-in-constraint new old (car constraints))
	(substitute-city-for-city new old (cdr constraints)))
      ;; old wasn't found, use VIA as a default
    (list :VIA new)))

(defun replace-city-in-constraint (new old constraint)
  (case (car constraint)
    ;; if constraint is of form (:DIRECTLY x y) where one of x and y is a city
    ;;  we change to a VIA constraint
    (:DIRECTLY 
     (if (member old (cdr constraint))
	 (list :VIA (substitute new old (cdr constraint)))))
    ;; In all others, we just substitute (at least, i think so at the moment)
    (otherwise
     (substitute new old constraint))))
	      

       
;;  The "switching" function to involve the modify handlers

(defun modify-constraints (new-constraint 
			   remaining-constraints
                           old-constraints
                           route)
  
  (let ((fn 
         (case (car new-constraint)
           (:FROM #'modify-from-to)
	   (:TO #'modify-from-to)
           (:DIRECTLY #'modify-directly)
           (:INSTEAD #'modify-route-with-instead)
	   ((:VIA :AVOID) #'modify-via-avoid)
	   (:AGENT #'modify-agent)
	   (:NOT #'modify-not)
	   (:STAY-AT #'modify-stay-at)
           (otherwise nil))))
	   
    (if fn
      (apply fn (list new-constraint
                      (cons new-constraint remaining-constraints)
                      old-constraints
                      route))
      (make-report :reason (make-reason :type :unknown-constraint :info new-constraint :msg "In modify-constraints")))))

;;  new FROM was specified but TO remained the same

(defun modify-from-city (new-from-city remaining-cs old-cs route)
  (let ((possible-agents (find-engines-originally-at new-from-city)))
      ;;  If there's a train at new-from, this is a correction of origin
    (if possible-agents
	(merge-constraints 
         remaining-cs
         (append `((:FROM ,new-from-city)
		   (:AGENT ,(car possible-agents)))
		 (remove-from-agent old-cs))
         route 
	 #'modify-constraints)
      ;; Otherwise, can't interpret
      (make-report :unresolvable-new-constraint `(:FROM ,new-from-city)
		   :reason (make-reason :type :NO-TRAIN-AT :info new-from-city)))
    )
 )


(defun modify-agent (new-constraint remaining-cs old-cs route)
  (let* ((new-agent (cadr new-constraint))
         (old-fta (get-from-to-agent old-cs))
	 (old-from (fta-from old-fta))
	 (new-from (find-original-loc-of-agent new-agent)))
    (cond 
     ;; if new agent doesn't have a location, we fail
     ((null new-from)
       (make-report :unresolvable-new-constraint new-constraint
                     :reason (make-reason :type :UNKNOWN-ENGINE :info new-from)))
     ;; If new agent is at old-from as well, then simple change of agent
     ((eq old-from new-from)
      (merge-constraints (cdr remaining-cs)
			 (cons new-constraint
			       (remove-constraint old-cs :AGENT))
			 route #'modify-constraints))
     ;; OLD-from has to go as well
     (t
      (modify-from-city new-from
		   remaining-cs
		   (remove-from-agent old-cs)
		   route)))))

(defun modify-not  (new-constraint remaining-cs old-cs route)
  "removes conflicting info"
  ;; but doesn't add new-constraint as can't handle things like (NOT (TO x)) well. 
  ;;    NOTs that should be kept, like (NOT (VIA x)) have already been mapped to (AVOID X).
  (let ((prop (cadr new-constraint)))
    (merge-constraints (cdr remaining-cs)
		       (remove-if #'(lambda (x) 
				      (constraints-overlap prop x))
				  old-cs)
		       route
		       #'modify-constraints)))


(defun modify-stay-at (new-constraint remaining-cs old-cs route)
  "This is just like a modify TO constraint, except that the new-to must be
     currently in the route"
  (let* ((stay-city (cadr new-constraint))
	(new-fta (get-from-to-agent remaining-cs))
	(new-to (fta-to new-fta)))
    (if (and (in-route route stay-city)
	     (or (null new-to) (eq new-to stay-city)))
	;; convert to TO
	(modify-from-to new-constraint (if new-to remaining-cs (cons (list :to stay-city) remaining-cs)) old-cs route)
      (make-report :unresolvable-new-constraint new-constraint
		    :reason (make-reason :type :city-not-on-route)))))
	
(defun modify-from-to (new-constraint remaining-cs old-cs route)
  "To handle a correction possibly indicating a FROM and/or TO.
   If both are different then the FROM must be in route, and the request is treated as correction of the TO"
  (let* ((new-fta (get-from-to-agent remaining-cs))
	 (new-to (fta-to new-fta))
	 (new-from (fta-from new-fta))
	 (old-fta (get-from-to-agent old-cs))
	 (old-to (fta-to old-fta))
	 (old-agent (fta-agent old-fta))
	 (old-from (fta-from old-fta)))
    (cond
     ((and new-from (eq new-from new-to))
      (make-report :unresolvable-new-constraint (list (list :from new-from) (list :to new-to))
		   :reason (make-reason :type :makes-circular-route)))
     
     ;;  updating FROM, and probably AGENT
     ((or (null new-to) (eq old-to new-to))
      (modify-from-city new-from 
			(remove-from-agent remaining-cs)
			(remove-constraints-mentioning-city old-cs new-from)
			route))
     ;;  updating TO, leaving FROM and AGENT untouched
     ((and (or (null new-from) (eq old-from new-from))
	   (not (eq new-to old-from)))
      (merge-constraints
       (remove-fta remaining-cs) 
       ;; If OLD-FORM=NEW-FROM  we clean out the remaining constraints - hopefully a good heurstic when stuck
       (cons (list :to new-to)
	     (if (and old-from new-from)
		 (if old-agent 
		     `((:from ,old-from) (:agent ,old-agent))
		   `((:from ,old-from)))
	       (remove-constraint
		(remove-constraints-mentioning-city old-cs new-to) :to)))
       route #'modify-constraints))
     ;; Complex correction of both FROM and TO: NEW-FROM must be in existing route.
     ;;     and new-to is not in route (or we'd get a circular route)
     ((in-route route new-from) 
      (if (not (in-route route new-to))
	  (merge-constraints
	   (remove-fta remaining-cs)
	   (append `((:FROM ,old-from)
		     (:TO ,new-to)
		     (:VIA ,new-from))
		   (remove-constraints-mentioning-city (remove-fta old-cs) new-from))
	   route
	   #'modify-constraints)
	;; both NEW-FROM and NEW-TO are in the route, just put them in a remove everything else
	
	  (merge-constraints
	   (remove-fta remaining-cs)
	   (append `((:FROM ,new-from)
		     (:TO ,new-to)))
	   route
	   #'modify-constraints))
      )
     (t 
      (make-report :unresolvable-new-constraint new-constraint)))))


;;  To add a constraint (:AVOID x), we must delete all other constraints
;;  involving x 

(defun modify-via-avoid (new-constraint remaining-cs old-cs route)
  (let* ((cities (cdr new-constraint)))
    (merge-constraints
     (cdr remaining-cs) 
     (cons new-constraint
	   (remove-constraints-mentioning-city old-cs (car cities)))
     route
     #'modify-constraints)))

(defun get-route-constraints-from-act (action)
  "Get constraints that apply to route (i.e., not the agent)"
  (remove-if #'(lambda (x) (eq (car x) :AGENT))
	  (get-constraints-from-act action)))


;;  This is identical to resolve-extend-directly, except for passed in conflict resolution fn
(defun modify-directly (new-constraint remaining-cs old-cs route)
  (let* ((new-from (second new-constraint))
         (new-to (third new-constraint))
         (old-fta (get-from-to-agent old-cs))
         (old-from (fta-from old-fta))
         (old-to (fta-to old-fta)))
    
   
    (cond
      ;;  the extend case:  directly TO X, or directly from <old-dest> to X.
     ((and (or (null new-from) 
		 (eq new-from old-to))
	     (domain-query `(:CONNECTED ,old-to ,new-to))
	  (merge-constraints (cdr remaining-cs)
			     (append `((:directly ,old-to ,new-to) (:to ,new-to))
				     (remove-constraint old-cs :to))
			     route 
			     #'resolve-extend-conflict)))
     ;; the modify case, new-from is in-route         
     ((and new-to (in-route route new-from))
      ;;   treat as an extension, with constraint either a DIRECTLY or VIA depending on map
      (let ((reln (if (domain-query `(:CONNECTED ,new-from ,new-to)) :DIRECTLY :VIA)))
	(merge-constraints
	 (cdr remaining-cs)
	 (append `((:TO ,new-to)
		   (,reln ,new-from ,new-to))
		 (remove-if #'(lambda (c) ;;  remove any conflicting directly constraints
				(and (eq (car c) :directly) 
				     (or (eq (second c) new-from)
					 (eq (third c) new-to))))
			    (remove-constraint old-cs :TO)))
	 route
	 #'modify-constraints)))
	
     (t (make-report :unresolvable-new-constraint new-constraint)))))

;;=============================================================================================
;;
;;  CANCEL

(defun do-cancel (plan-id content context)
  (let ((sort (car content))
	(info (cadr content)))
    (case sort
      (:object
       (if (eq (car (task-objective context)) 'root)
	   (build-impossible-answer :cant-modify-root plan-id)
	 (cancel-object plan-id info context (current-pss))))
      ;; to cancel a goal we may searach the entire tree
      (:goal 
       (cancel-goal plan-id info (current-pss)))
      (otherwise
       (make-error-msg (Format nil "Illegal content to cancel: ~S" content))))))

(defun cancel-goal (plan-id info task-tree) 
  (case (car info)
    (:go
     (let* ((constraints (simplify-GO-constraints (cddr info)))
	    (nodes (task-tree-leaf-cache task-tree))
	    (ST (task-tree-symbol-table task-tree))
	    (results (mapcan #'(lambda (n)
				 (try-to-cancel constraints 
						(task-node-content (get-node-by-name n ST))))
			     nodes)))
       
       (cond
	((not (find-constraint constraints :TO))
	 (build-impossible-answer :no-destination-in-goal-spec))
	(results
	 (car results)))))
    
    (otherwise
     (make-sorry-msg (format nil "Unable to cancel goals of form ~S" info)))))

(defun try-to-cancel (constraints node)
  (if (constraints-subsumed :GO constraints (get-constraints-from-act (task-objective node)))
      (list (build-route-answer :GOOD :GOOD
				`(delete-goal (task :plan-id ,(task-plan-id node)))))))

(defun cancel-object (plan-id info context task-tree)
  "Cancelling part of a plan- typically part of a route"
  (let ((result (cancel-object-in-plan plan-id info context)))
    (if (eq (answer-recognition-score result) :good)
	result
      (let*
	  ((nodes (task-tree-leaf-cache task-tree))
	   (ST (task-tree-symbol-table task-tree))
	   (new-result 
	     (car (find-best-answers
		   (mapcar #'(lambda (n)
			       (cancel-object-in-plan n info
						      (task-node-content (get-node-by-name n ST))))
			   nodes)))))
	(car (find-best-answers (list result new-result)))))))
	

(defun cancel-object-in-plan (plan-id info context)
  (case (car info)
    ((:route :path :go)
     (let ((deletes (third info)))
       (if (listp deletes)
	   (let* ((objective (task-objective context))
		  (prior-soln (task-solution context))
		  (delete-constraints (if deletes
					  (if (is-action deletes) (get-constraints-from-act deletes) 
					    (simplify-GO-constraints (list deletes)))))
		  (delete-from (if delete-constraints (car (find-constraint delete-constraints :FROM))))
		  (act-type (if (is-action deletes) (car deletes)))
		  )
	     (cond 
	      ;; null cancel - delete the solution of the current plan
	      ((null deletes)
	        (build-route-answer :GOOD :GOOD
				    `(update (task :plan-id ,plan-id
						   :objective ,(remove-constraint-from-act objective :VIA)
						   :solution nil
						   :status :unsolved))))
	      ;; no prior-soln, this could be deleting part of the goal, or it doesn't apply
	      ((null prior-soln)
	       (if (constraints-subsumed act-type delete-constraints (get-constraints-from-act objective))
		   (build-route-answer :GOOD :GOOD
				  `(update (task :plan-id ,plan-id
						 :objective ,(remove-constraint-from-act objective delete-constraints)
						 :solution nil
						 :status :unsolved)))
		 (build-impossible-answer :deletes-dont-hold delete-constraints)))
	      ;; FROM present, may be removing part of the route
	      (delete-from
	       (cond 
		;;  DELETE-FROM is the origin, just delete the current answer
		((eq delete-from (car (find-constraint (get-constraints-from-act objective) :FROM)))
		 (build-route-answer :GOOD :GOOD
				     `(update (task :plan-id ,plan-id
						    :objective ,(remove-constraint-from-act objective :VIA)
						    :solution nil
						    :status :unsolved))))
		 
		;;  DELETE-FROM is in the route, truncate the route so it ends there.
		((in-route prior-soln delete-from)
		 (truncate-route-at delete-from objective prior-soln plan-id))
		;; Otherwise, it can't apply to this plan
		(t (build-impossible-answer :deletes-dont-hold delete-constraints))
		))
	       
	      ;; no FROM, see if the constraints hold on the route.
	      ((not (all-constraints-redundant act-type prior-soln delete-constraints))
	       (build-impossible-answer :deletes-dont-hold deletes))
	      ;;  constrains apply, just delete the solution
	      (t 
	       (build-route-answer :GOOD :GOOD
				   `(update (task :plan-id ,plan-id
						  :solution nil
						  :status :unsolved))))
	   
	      ))
	 (make-error-msg (Format nil "Illegal cancel: ~S must be an action or constraint list" deletes))
	 )))
    ) ;; end CASE
  )

(defun truncate-route-at (city objective prior-soln plan-id)
  "This truncates a route at the indicated city and returns the new route"
  (let*
      ((new-action (cons (car objective)
			 (cons (second objective)
			       (cons `(:TO ,city)
				     (remove-constraint
				      (remove-constraints-mentioning-city (get-constraints-from-act objective) city)
				      :TO))))))
    (if prior-soln
	(let*
	    ((new-route (truncate-route-info-at city (route-soln-current (solution-set-domain-info prior-soln))))
	     (old-agent (car (find-constraint-in-act objective :agent)))
	     (new-action
	      (cons (car objective)
		    (cons (second objective)
			  (cons `(:TO ,city)
				(remove-constraints-that-dont-hold new-route (get-constraints-from-act objective) old-agent)))))
	     (new-soln (make-solution-set :agents (solution-set-agents prior-soln)
					  :action-type new-action
					  :decomposition (gen-plan-from-route new-route)
					  :domain-info (make-route-soln :current new-route))))
	  (build-route-answer :GOOD :GOOD
			      `(update (task :plan-id ,plan-id
					     :objective ,new-action
					     :solution ,new-soln
					     :status :solved))))
      ;; no prior soln, so just update objective
      (build-route-answer :GOOD :GOOD
			  `(update (task :plan-id ,plan-id
					 :objective ,new-action))))))


;;=============================================================================================
;;  UTILITY FUNCTIONS
;;  Managing the FROM, TO and AGENT as a unit

(defun get-from-to-agent (constraints)
  (let ((answer (make-FTA)))
    (get-FTA constraints answer)
    answer))
  
(defun get-FTA (constraints answer)
  (when constraints
    (let ((c (car constraints)))
      (case (car c)
	(:TO (setf (FTA-to answer) (second c)))
	(:FROM (setf (FTA-from answer) (second c)))
	(:AGENT (setf (FTA-agent answer) (second c))))
      (get-FTA (cdr constraints) answer))))


(defun get-from-to-agent-from-act (action)
  (get-from-to-agent (cddr action)))

(defun from-to-both-specified (from-to)
  (and (car from-to) (cadr from-to)))

(defun get-agent-in-act (action)
  (car (find-constraint-in-act action :AGENT)))

(defun remove-fta (constraints)
  (remove-if #'(lambda (x) (member (car x) '(:TO :FROM :AGENT))) constraints))

(defun remove-from-agent (constraints)
  (remove-if #'(lambda (x) (member (car x) '(:FROM :AGENT))) constraints))

(defun remove-from-to (constraints)
  (remove-if #'(lambda (x) (member (car x) '(:FROM :TO))) constraints))

(defun gen-fta-constraints (fta)
  (let ((to (if (fta-to fta) `(:TO ,(fta-to fta))))
	(from (if (fta-from fta) `(:FROM ,(fta-from fta))))
	(agent (if (fta-agent fta) `(:AGENT ,(fta-agent fta)))))
    (remove-if #'null (list to from agent))))

;;;    KB Querys

(defun find-engines-at (city)
  (quick-query 'ask-all 
	       `(:and (:at-loc ?eng ,city) (:type ?eng :engine))
	       '?eng))

;;  optimized query on original locations
(defun find-engines-originally-at (city)
  (let ((original-at-locs (remove-if-not
			   #'(lambda (p) (and (eq (car p) :at-loc)
					      (eq (third p) city)))
				     (get-KB))))
    (mapcar #'second original-at-locs)))
   
(defun find-loc-of-engine (engine)
  (quick-query  'ask-one 
		`(:at-loc ,engine ?city) 
		'?city))

(defun find-original-loc-of-agent (agent)
  (third
   (car
    (remove-if-not
   #'(lambda (p) (and (eq (car p) :at-loc)
		      (eq (second p) agent)))
   (get-KB)))))
 
(defun find-type (object)
  (quick-query  'ask-one 
		`(:type ,object ?type) 
		'?type))
  
(defun quick-query (op prop var)
  "Finds values for a single variable in a query"
  (let ((ans (find-arg (cdr (handle-psm-query op
				      prop (list var)))
		       :result)))
    (if ans
	(case op
	  (ask-all
	   (mapcar #'car ans))
	  (ask-one (car ans))
	  (t  ans)))))

;;==============================================================================
;;
;;   COMBINING SOLUTIONS
;;
;;  Computes a plan given a set of plans for subgoals

;;  for GO actions

(defun combine-GO-subplans (node subplans)
  "computes solution for NODE given the solution sets SUBPLANS"
  (let* ((plans (mapcar #'(lambda (x)
			    (cons (solution-set-name x) (solution-set-decomposition x)))
			subplans))
	 (combined-schedules (assess-interaction plans)))
    ;;(format t "~%Combined solution is ~S" combined-schedules)
    (let 
	((old-solution (task-solution (task-node-content node))))
      (if (solution-set-p old-solution)
	  (setf (solution-set-execution-trace old-solution)
	    combined-schedules)
	(setf (task-solution (task-node-content node))
	  (make-solution-set :decomposition (reduce-with-append (mapcar #'cdr plans))
			     :execution-trace  combined-schedules
			     :domain-info (make-route-soln)))))))

