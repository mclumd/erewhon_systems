;; Time-stamp: <Mon Jan 20 14:32:37 EST 1997 ferguson>

(when (not (find-package :verbal-reasoner))
  (load "verbal-reasoner-def"))
(in-package verbal-reasoner)

;; new ps interface
(defvar *ps-request* nil "Temporary hack for manual ps-update")

(defvar *temp-plan* nil "Plan under discussion")

(defparameter *reasons-that-may-be-reported*
    '( :no-agent :no-destination :no-solution :redundant :not-in-route :unknown-agent :cant-identify-role-in-plan 
      :inconsistent-agent :multiple-use-of-agent :too-complicated-constraints :inconsistent-origin
      :inconsistent-constraint :no-agent-at-origin :makes-circular-route)
  "List of reason types that may indicate problems with the user's interaction rather than an internal error. E.g. not
having a destination might be a problem with the user's plan, but extending an unsolved plan is probably due to the 
choice of strategy. The first error generated on this list will be saved, and used to report an error to the user should 
we find no reasonable strategy (as opposed to reporting on the problem with the last strategy we happen to try.)")

(defun execute-new-goal (plan goal)
  (execute-ps-strategy :new-subplan plan goal))
             
(defun execute-refine (plan constraints)
  (execute-ps-strategy :refine-current plan constraints))

(defun execute-extend (plan constraints)
  (execute-ps-strategy :extend-current plan constraints))

(defun execute-do-what-you-can (plan constraints)
  (execute-ps-strategy :do-what-you-can plan constraints))

(defun execute-undo (ps-state)
  (mlet (summary result rec ans ps-state ror agent)    
      (handle-ps-request :undo nil
                         `(,@(if ps-state `(:ps-state ,ps-state)))
                         t)             ; should update ps-state
    (declare (ignore summary result rec ans ps-state agent))
    (if ror
        (while ror
          (destructuring-bind (actions . agentx) (pop ror)
            (report-on-route-i actions agentx))) ; fixup display
      )))

(defun execute-modify (plan add-constraints &optional delete-constraints (modify :modify-current))
  (unless (sa-defs:tt-assert (not (and delete-constraints 
                               (consp delete-constraints)
                               (null (car delete-constraints))))
                     () "bad execute-modify call")
    (execute-ps-strategy modify plan add-constraints delete-constraints)))

(defun execute-reject-solution (plan)
  (execute-ps-strategy :reject-solution plan nil))

(defun execute-confirm (plan)
  (execute-ps-strategy :confirm plan nil t))

(defun execute-update-pss (request result-key plan ps-state reason)
  (set-ps-state ps-state)

  (transcribe-and-log :prince "Committing to last strategy (~A) ~a ps-state: ~A" request reason ps-state)

  (commit-proposed-state)
  (setq *focus-changed* nil)            ; just for us.
  (prog1 (handle-ps-request :update-pss nil `(:ps-state ,ps-state))
    (set-last-extension *ps-request*)
    (set-attempted-route (pop-request-error)) ; clears if there was none.
    (close-prior-output)
    (if (member result-key '( :new-subplan :plan-updated))
        ;; about to return success, clear prior errors, if any
        (kb-request-kqml (create-request :context-manager `( :clear-error-frame ,plan))))))

(defun execute-delete-plan (plan)
  (execute-ps-strategy :delete-plan plan nil))

;(defun execute-split-plan (plan action-spec)
;  (handle-ps-request :split-plan plan `( :content ( :go ,(gentemp "GO" user::*hack-package*)
;                                                   ,(if (endp (cdr action-spec))
;                                                        (car action-spec)
;                                                      `(:and ,@action-spec))))))

;; old ps interface
(defun execute-plan-route (plan path-quantaa)
  (unless (sa-defs:tt-assert plan (plan) "Execute-plan-route must be wrt a plan")
    (execute-extend plan path-quantaa)))

(defun execute-handle-paths (plan paths)
  ;; if the plan is acheived, then extend it.
  (execute-ps-strategy :refine-extend-current plan paths))

(defun execute-redo-extension (paths)
  (execute-modify nil paths nil))

(defun execute-redo-extension-with-backup (paths)
  ;; got a no, then a new path. The new path might not be related to the old one.. Try as a modify, if that fails, 
  ;; do an undo and a new subplan.
  (execute-modify nil paths nil :modify-backup))

(defun execute-reject-and-handle-alternatives (plan)
  (execute-reject-solution plan))

(defun execute-replan-route (spec error)
  (let* ((attempt (third (extract-keyword :content (get-attempted-route))))
         (attempted-plan (sa-defs:nc-plan error))
         (spec-as-pathq (cond 
                         ((path-quantum-p spec)
                          spec)
                         ((engine-p spec)
                          (make-path-quantum :engine spec))
                         (t
                          (make-path-quantum :via spec)))))
    (flet ((deal-with-prior-attempt ()
             (mlet (summary result recognition answer ps-state)
                 (execute-ps-strategies '( :extend-current :refine-extend-stack :do-what-you-can :new-subplan-root)
                                        *current-plan*
                                        (list spec-as-pathq attempt)) ; addressing the problem from last time? merge
               (cond
                ((eq summary :success)
                 (values summary result recognition answer ps-state))
                (t
                 (trash-response (member summary *reasons-that-may-be-reported*))
                 (execute-ps-strategies '( :extend-current :refine-extend-stack :do-what-you-can :new-subplan-root)
                                        *current-plan*
                                        spec-as-pathq)))))) ; maybe a replacement
             
      (debug-log :prince :prince ";;Execute-replan-route spec: ~S error: ~S attempt: ~s" spec error attempt)
      (case (expected-type error)
        (( :no-route :destination :engine) ; probably a refine
         ;; use the attempted route, if we need to.
         (cond
          ((eql attempted-plan *current-plan*) ; we committed to this extension, and it's current.
           (execute-ps-strategies '( :refine-extend-current 
                                    :refine-extend-stack ; not what we thought it was
                                    :do-what-you-can
                                    :new-subplan-root) ; maybe really a new guy
                                  *current-plan*
                                  spec-as-pathq)) ; no need to repeat the attempt
          (attempt
           (deal-with-prior-attempt))
          (t
           (execute-ps-strategies '( :extend-current :refine-extend-stack :do-what-you-can :new-subplan-root)
                                  *current-plan*
                                  spec-as-pathq))))
        (nil 
         ;; not an error, 
         (execute-ps-strategies '( :modify-current :modify-backup :do-what-you-can) *current-plan* spec-as-pathq))
        (t
         (cond
          (attempt
           (deal-with-prior-attempt))
          (t
           (execute-ps-strategies '( :extend-current :refine-extend-stack :do-what-you-can :new-subplan-root)
                                  *current-plan*
                                  spec-as-pathq))))))))

(defun handle-ps-result-1 (request dm-result recognition-score answer-score)
  ;; deal with most of the results from problem solver (other than problems)
  (let (no-update goal agent confirm-p did-ror agent-standin
        (result (extract-keyword :result dm-result))
        (ps-state (extract-keyword :ps-state dm-result)))
    (let ((result-key (car result)))

      (cond
       ((eq (car result) :cleared)
        (let ((plan (extract-keyword :plan-id dm-result)))
          (debug-log :prince :prince "PS Cleared. New root plan: ~S, New root ps-state: ~S")
          (set-plan plan)
          (kb-request-kqml 
           (create-request :self-model-kb `( :set-root-plan (,ps-state ,plan)))))
        (setq no-update t))
       
       ((eq result-key :pss-update)
        (unless (sa-defs:tt-assert (eq (second result) :success) () "Bad result from pss-update")
          (let ((plan (extract-keyword :plan-id dm-result)))
            (debug-log :prince :prince "Changing current plan to ~S" plan)
            (set-plan plan)
            (setq *temp-plan* (setq *current-plan* plan)))) ; for subsequent rules
        (throw :impossible (values nil result recognition-score answer-score))) ; don't do anything more about pss-updates.
       ((eq result-key :undone)
        ;; note that undo is not undoable from the ps end, so we should go ahead and modify things here.
        (let ((changed-plans (extract-keyword :changed-plans result))
              (deleted-plans (extract-keyword :deleted-plans result))
              agents
              ror)
          (set-ps-state ps-state)
          ;; for each deleted plan, have to request display to delete associated paths, and we have to delete from context.
          (dolist (dp deleted-plans)
            (remove-display-objects-for-plan dp)
            (kb-request-kqml (create-request :context-manager `( :clear-plan ,dp))))
          
          ;; current plan may have changed (for the sake of subsequent rules)
          (setq *temp-plan* (setq *current-plan* (kb-request-kqml (create-evaluate :context-manager '( :current-plan)))))
          
          ;; for each plan, push actions/agent pair on ror for report-on-route
          (dolist (cp changed-plans)
            (let*-non-null ((aforp (set-difference
                                    (kb-request-kqml (create-request :context-manager `( :agents-for-plan ,cp)))
                                    agents)))
              (setq agents (nconc agents aforp))
              (dolist (agent aforp)
                (push (cons (get-engine-route agent) agent) ror))))

          ;; we must have just done some internal state thing. 11/6/96 bwm
          (if (null ror)
              (vr-confirm))
          
          ;; (summary result rec ans ps-state ror agent)
          (throw :impossible (values :success result :good :good ps-state ror agents))))
        
       (t
        (do-pairs (key value (cdr result))
          (case key
            ( :plan
              (setq *temp-plan* (car value))
              (set-plan (car value))
              (kb-request-kqml (create-request :context-manager `( :defplan ,(car value) ,value))) ; so we can retrieve later if needed

              (setq goal (extract-keyword :goal value))
              (setq agent (extract-keyword :agent value))

              (let ((actions (extract-keyword :actions value)))
                (when (or (member request '( :new-subplan :new-subplan-maybe :extend :extend-maybe :do-what-you-can)) ; update of goal
                          (and (eq request :refine)
                               (null actions)))
                  ;; check for conjunctive goal
                  (labels ((handle-goal (g)
                             (let*-non-null ((to (get-sslot :to (cddr g)))) ; skip the action.
                               (setq agent-standin (get-sslot :from (cddr g))) ; in case there isn't an agent, this is almost as good.
                               (set-action (list (car g) (cadr g))) ; the action
                               (push-proposed-state (list :goal to))
                               (setq confirm-p t))))
                    (cond
                     ((and (member request '( :extend-maybe :new-subplan-maybe))
                           (member recognition-score '( :good :ok))) ; would have worked
                      ;; ask about it instead, then fake a success that won't commit anything.
                      (set-attempted-route *ps-request*)
                      (vr-ask-yn-question :new-goal (list (cons :goal goal)) *ps-request*) ; put the request on the setting
                      (throw :impossible (values :success result recognition-score answer-score)))
                     ((eq (car goal) :and)
                      (mapc #'handle-goal (cdr goal)))
                     (t
                      (handle-goal goal)))))
                
                ;; if an agent was not identified, but we have a :from in our goals, then assume we've changed focus.
                (cond
                 ((and (null agent) agent-standin)
                  (vr-clear-focus))
                 (actions
                  (push (cons actions (or agent *current-focus*)) did-ror)))))
            
            ( :objects
              (if (consp value)
                  (mapcar #'push-recognized-objects value)
                (push-recognized-objects value)))))
        ;; agent, actions
        (if (and agent
                 (or (null *current-focus*)
                     (not (equal (object-name agent) (basic-name *current-focus*)))))
            (vr-update-focus agent))))
      (values no-update goal agent confirm-p did-ror))))

(defun handle-ps-result-2 (dm-result goal recognition-score answer-score ps-state did-ror agent new-plan)
  (declare (ignorable agent))
  ;; any problems may mean we really need to backtrack, but for now, just handle directly.
  (flet ((handle-reasons (reason-entry)
           (let ((reason-type (extract-keyword :type reason-entry))
                 (reason-info (extract-keyword :info reason-entry)))

             (flet ((huh (key &optional throw-p)
                      (let ((ob (cond
                                 (reason-info
                                  (convert-ps-goal-to-quanta reason-info))
                                 (goal
                                  (convert-ps-goal-to-quanta goal))
                                 (t
                                  (convert-ps-goal-to-quanta (get-sslot :content *ps-request*))))))
                        (if (and (null ob)
                                 (member key '( :no-route :bad-route)))
                            (wazzawump :prince) ; assume it's my fault (I'm so modest)
                          (vr-huh ob key new-plan))
                        (if throw-p
                            (throw :impossible 
                              (values reason-type answer-score recognition-score answer-score ps-state did-ror reason-info))))))
               (case reason-type
                 ( :no-destination
                   (set-request-error *ps-request*)
                   (vr-missing-required-object :destination new-plan))
                 (( :unknown-agent)
                   (set-request-error *ps-request*)
                   (vr-huh reason-info :engine new-plan))
                 
                 ( :multiple-use-of-agent
                   (set-request-error *ps-request*)
                   (vr-huh reason-info :unique-engine new-plan))
                 
                 ( :no-solution
                   (set-request-error *ps-request*)
                   (huh :no-route))
                 ( :no-more-solutions
                   (set-request-error *ps-request*)
                   (if new-plan
                       (setq goal (get-plan-goal new-plan))) ; for the error report
                   (huh :no-route))

                 ( :redundant
                   ;; if we had a low parse score, just complain
                   (cond
                    ((< (reliability *current-input*) 40)
                     (wazzawump nil))
                    (t
                     (push-new-state `( :route-extension ,reason-info))
                     (vr-repeated-info)))) ; gets the new state
                 
                 ( :inconsistent
                   (huh :bad-route))
                 
                 (( :makes-circular-route :creating-circular-route) ; these are caught by the handler and may be retried
                   (huh :bad-route t))
                 
                 ( :deletes-dont-hold
                   (vr-huh (convert-ps-goal-to-quanta (get-sslot :delete *ps-request*)) :bad-delete new-plan)
                   (throw :impossible 
                     (values reason-type answer-score recognition-score answer-score ps-state did-ror reason-info)))
                 
                 (( :no-new-destination :cant-change-destination)
                  (huh :destination t)) ; probably just the wrong strategy
                 
                 (( :no-agent-at-origin)
                  (set-request-error *ps-request*)
                  (vr-huh reason-info :engine new-plan))
                 
                 ( :no-interpretation-found
                   (wazzawump :prince)) ; might be my fault
                 
                 (( :i-cant-handle-disjunctions :too-complicated-constraints)
                   (wazzawump :ps)) ;; not MY fault.
                 
                 ( :cant-undo-initial-state
                   (wazzawump nil))          ; user's fault
                 
                 ( :ambiguous-goal
                   (vr-ambiguous (cdr reason-info) :goal) 
                   (let ((commit-p (member recognition-score '( :good :ok))))
                     (debug-log :prince :prince "Ambiguous-goal, commit-p: ~S" commit-p)
                     (throw :impossible 
                       (values (if commit-p
                                   :success ; force us to take this one, but don't commit it (throw)
                                 reason-type) 
                               answer-score recognition-score answer-score ps-state did-ror reason-info))))
                 
                 ;; these mean the strategy is bad, and there may be an alternate strategy
                 (( :cant-extend-unsolved-plan :changed-goal :not-agent-of-plan :must-extend-from-old-destination
                   :cant-reject-non-solution :cant-extend-root :changed-origin :inconsistant-origin 
                    :inconsistant-agent)
                  (huh :bad-route t)) ; in case parent doesn't handle
                    
                 ( :created-new-subgoal
                   )                    ; ignore

                 ( :no-agent
                   (if *current-focus*  ; try with that.
                       (throw :impossible 
                         (values :no-agent answer-score recognition-score answer-score ps-state did-ror reason-info))
                     (progn
                       (set-request-error *ps-request*)
                       (vr-huh reason-info :engine new-plan)))) ; expected an engine
                 
                 ( :cant-identify-role-in-plan
                   (huh :unknown))

                 ( :not-in-route        ; may mean focus shift
                   (set-request-error *ps-request*)
                   )
                 
                 ( :unknown-plan-id     ; pretty serious
                   (wazzawump :prince)  ; definitely my fault
                   (throw :impossible
                     (values :impossible :impossible recognition-score answer-score ps-state did-ror reason-info)))
                 )))))
    (let ((r (extract-keyword :reason dm-result)))
      (if (eq (car r) :and)
          (mapc #'handle-reasons (cdr r))
        (handle-reasons r)))))
       
(defun handle-bail (answer-score recognition-score ps-state did-ror agent request result-key plan)
  (cond
    ((or (member recognition-score '( :bad :impossible))
         (eq answer-score :impossible))
     (transcribe-and-log :prince "Bailing from this strategy")
     (throw :impossible (values :bailed answer-score recognition-score answer-score ps-state did-ror agent)))
    ((and (eq answer-score :bad)
          (get-plan-actions plan))      ; we used to have some actions.
     ;; don't commit it, but use it.
     (transcribe-and-log :prince "Accepting this strategy w/o commit")
     (handle-ps-result-ror request result-key did-ror agent plan)
     (throw :impossible (values :success recognition-score recognition-score answer-score ps-state did-ror agent)))))

(defun handle-ps-result-ror (request result-key did-ror agent plan)
  (if (member result-key '( hack::new-subplan :new-subplan :plan-updated hack::plan-updated))
      (cond ((not (or did-ror           ; one of our interpreters already did it.
                      (and (eq request :new-subplan)
                           (null agent)
                           (equal (object-name (get-plan-agent plan)) (object-name *current-focus*)))))
             (report-on-route))
            (did-ror
             ;; now we can ror, since the update has occured.
             (while did-ror
               (destructuring-bind (actions . agent) (pop did-ror)
                 (report-on-route-i actions agent)))))
    (if (handling-question-p)
        (vr-reject-and-elaborate t *current-focus*))))

(defun handle-ps-result-confirm (request result-key no-update auto-update ps-state dm-result plan)
  (declare (ignore dm-result auto-update))
  (cond
   (no-update)
;   (auto-update
   (t
    (execute-update-pss request result-key plan ps-state :automatic))
;   (t
;    (unless user::*debug-interactive* (error "Unhandled PSS Update"))
;    (format *error-output* "PS Request: ~S~%PS Result: ~S~%" *ps-request* dm-result)
;    (when (y-or-n-p "Update PSS? (~S)" ps-state)
;      (execute-update-pss request result-key plan ps-state :manual)))
   ))

(defun process-ps-result (dm-result auto-update request plan)
  ;; treat a sorry as impossible result.
  (catch :impossible
    (when (and (kqml-problem-p dm-result)
               (eq (perf dm-result) 'kqml:sorry))
      ;; log it
      (log-warning :prince "Got a SORRY result from PS: ~S" dm-result)
      (hack:mail-log-file :ps :sorry)
      (return-from process-ps-result (values :sorry :impossible :impossible :impossible nil nil)))
    (if (sa-defs:tt-assert (and dm-result (not (kqml-problem-p dm-result))) () "bad result")
        (return-from process-ps-result (values (values :impossible :impossible :impossible :impossible))))

    (let* ((result (extract-keyword :result dm-result))
           (result-key (car result))
           (recognition-score (extract-keyword :recognition-score dm-result))
           (answer-score (extract-keyword :answer-score dm-result))
           (ps-state (extract-keyword :ps-state dm-result))
           (*temp-plan* (extract-keyword :plan-id dm-result)))

      (mlet (no-update goal agent confirm-p did-ror)
          (handle-ps-result-1 request dm-result recognition-score answer-score) ; might update *temp-plan*

        ;; deal with reason codes
        (handle-ps-result-2 dm-result goal recognition-score answer-score ps-state did-ror agent *temp-plan*)
        
        ;; should we bail before committing? This lets us try alternatives.
        (handle-bail answer-score recognition-score ps-state did-ror agent request result-key plan)

        (unless (eq request :undo)      ; undos don't need to be confirmed.
          (handle-ps-result-confirm request result-key no-update auto-update ps-state dm-result plan))
        
        (if confirm-p
            (vr-reply 'sa-confirm))     ; generate this to capture any state we pushed.

        (handle-ps-result-ror request result-key did-ror agent plan) ; report on route, if needed
        
        (commit-proposed-state)         ; commit the ror.
        
        (values :success result recognition-score answer-score ps-state nil nil))))) ; do this last, we might have changed focus

(defun execute-ps-strategies (strategy-list plan args &rest more-args)
  "Given a list of strategies to execute, execute them in order until a :good or :ok recognition is given, 
then commit to that result (if an error, generate appropriate response"
  (let (result summary recognition answer ps-state)
    (while-not (or (null strategy-list)
                   (eq :success 
                       (msetq (summary result recognition answer ps-state)
                         (apply #'execute-ps-strategy (pop strategy-list) plan args more-args))))
      (if strategy-list                 ; another try
          (trash-response (member summary *reasons-that-may-be-reported*))))
    (values summary result recognition answer ps-state)))                                  

(defun execute-ps-strategy (strategy plan args &rest more-args)
  "Turn a strategy into a particular request on the plan with the args"
  (transcribe-and-log :prince "Executing strategy ~S, plan ~S" strategy plan)
  (ecase strategy
    ( :refine-current
      (handle-ps-request :refine plan (proc-constraints-for-ps-w-content args) t))
    
    ( :extend-current
      (handle-ps-request :extend plan (proc-constraints-for-ps-w-content args) t))
    
    ( :extend-root
      (execute-ps-strategy :extend-current (root-plan) args))
    
    ( :extend-root-maybe
      (handle-ps-request :extend-maybe (root-plan) (proc-constraints-for-ps-w-content args) nil))
    
    ( :new-subplan-root-maybe
      (handle-ps-request :new-subplan-maybe (root-plan) (proc-constraints-for-ps-w-content args) nil))

    ( :refine-extend-current
      ;; if the current plan is the root plan, then do a new-subgoal on the root instead.
      (cond 
       ((eq plan (root-plan))
        (execute-ps-strategy :new-subplan-root (root-plan) args))
       (t
        (mlet (s r rec a ps)
            (execute-ps-strategy :refine-current plan args)
          (cond
           ((eq s :success)
            (values s r rec a ps))
           (t
            (trash-response (member s *reasons-that-may-be-reported*))
            (execute-ps-strategy :extend-current plan args)))))))
    
    ( :do-what-you-can
        (handle-ps-request :do-what-you-can plan (proc-constraints-for-ps-w-content args) t))

    ( :refine-extend-current-using-status
      (mlet (s r rec a ps)
          (unless (eq (get-plan-status plan) :solved)
            (execute-ps-strategy :refine-current plan args))
        (cond
         ((eq s :success)
          (values s r rec a ps))
         (t
          (trash-response (member s *reasons-that-may-be-reported*))
          (execute-ps-strategy :extend-current plan args)))))
          
    ( :refine-extend-stack              ; try refine on the next plan in the discourse stack., then extend, etc.
      (let ((context-plans (remove (root-plan) (remove plan (all-context-plans)))) ; plan needent be retried.
            current-plan
            s r rec a ps)
        (while-not (or (null context-plans)
                       (eq :success
                           (msetq (s r rec a ps) (execute-ps-strategy :refine-extend-current-using-status
                                                                      (setq current-plan (pop context-plans))
                                                                      args))))
          (if context-plans             ; going around loop again?
              (trash-response (member s *reasons-that-may-be-reported*))))
        ;; if we picked on, we should tell CM
        (if current-plan
            (kb-request-kqml (create-request :context-manager `( :pop-discourse-context-to-plan ,current-plan))))
        (values s r rec a ps)))
    
    ( :refine-stack
      (let ((context-plans (remove (root-plan) (remove plan (all-context-plans)))) ; plan needent be retried.
            current-plan
            s r rec a ps)
        (while-not (or (null context-plans)
                       (eq :success
                           (msetq (s r rec a ps) (execute-ps-strategy :refine-current
                                                                      (setq current-plan (pop context-plans))
                                                                      args))))
          (if context-plans             ; going around loop again?
              (trash-response (member s *reasons-that-may-be-reported*))))
        ;; if we picked on, we should tell CM
        (if current-plan
            (kb-request-kqml (create-request :context-manager `( :pop-discourse-context-to-plan ,current-plan))))
        (values s r rec a ps)))
    
    ( :reject-solution
      (handle-ps-request :reject-solution plan () t))

    ( :confirm
      (handle-ps-request :confirm plan () t))

    ( :new-subplan
      (handle-ps-request :new-subplan plan (proc-constraints-for-ps-w-content args) t))
    
    ( :new-subplan-root
      (execute-ps-strategy :new-subplan (root-plan) args))
    
    ( :modify-current
      (handle-ps-request :modify plan `(,@(if args
                                              `(:add ,(proc-constraints-for-ps args)))
                                        ,@(if more-args
                                              `(:delete ,(proc-constraints-for-ps (car more-args)))))
                         t))
    
    ( :modify-current-hacking-instead-of
      ;; originally in reference, moved here to handle PLAN basis.
      (let* ((relevant-warnings (if (eq plan *current-plan*)
                                    (warning-frames plan)))
             (pathqs-in-args (remove-if-not #'path-quantum-p (flatten args)))
             delete-list
             temp)
        (if (and (some #'via pathqs-in-args)
                 (notany #'not-via pathqs-in-args))
            (let*-non-null ((instead-of (or relevant-warnings (find-slot-from-history :via plan))))
              (do-log :prince "Hacking instead-of to be via ~S" instead-of)
              (setq delete-list (make-path-quantum :via instead-of))))
        (if (and (setq temp (some #'from pathqs-in-args))
                 (notany #'not-from pathqs-in-args))
            (let*-non-null ((instead-of (find-slot-from-history :from plan)))
              (unless (eq instead-of temp)
                (do-log :prince "Hacking instead-of to be from ~S" instead-of)
                (if delete-list
                    (setf (from delete-list) instead-of)
                  (setq delete-list (make-path-quantum :from instead-of))))))
        (if (and (setq temp (some #'to pathqs-in-args))
                 (notany #'not-to pathqs-in-args))
            (let*-non-null ((instead-of (or (find-slot-from-history :to plan)
                                            (get-engine-goal (or (some #'engine pathqs-in-args))))))
              (unless (eq instead-of temp)
                (do-log :prince "Hacking instead-of to be to ~S" instead-of)
                (if delete-list
                    (setf (to delete-list) instead-of)
                  (setq delete-list (make-path-quantum :to instead-of))))))

        (handle-ps-request :modify plan `(,@(if args
                                                `(:add ,(proc-constraints-for-ps args)))
                                            ,@(if delete-list
                                                  `(:delete ,(proc-constraints-for-ps delete-list))))
                           t)))
    
    ( :modify-stack
      (let ((context-plans (remove (root-plan) (remove plan (all-context-plans)))) ; plan needent be retried.
            current-plan
            s r rec a ps)
        (while-not (or (null context-plans)
                       (eq :success
                           (msetq (s r rec a ps) (apply #'execute-ps-strategy 
                                                        :modify-current
                                                        (setq current-plan (pop context-plans))
                                                        args
                                                        more-args))))
          (if context-plans             ; going around loop again?
              (trash-response (member s *reasons-that-may-be-reported*))))
        ;; if we picked on, we should tell CM
        (kb-request-kqml (create-request :context-manager `( :pop-discourse-context-to-plan ,current-plan)))
        (values s r rec a ps)))
    
    ( :modify-stack-hacking-instead-of
      (let ((context-plans (remove (root-plan) (remove plan (all-context-plans)))) ; plan needent be retried.
            current-plan
            s r rec a ps)
        (while-not (or (null context-plans)
                       (eq :success
                           (msetq (s r rec a ps) (apply #'execute-ps-strategy 
                                                        :modify-current-hacking-instead-of
                                                        (setq current-plan (pop context-plans))
                                                        args
                                                        more-args))))
          (if context-plans             ; going around loop again?
              (trash-response)))
        ;; if we picked on, we should tell CM
        (kb-request-kqml (create-request :context-manager `( :pop-discourse-context-to-plan ,current-plan)))
        (values s r rec a ps)))
    
    ( :modify-current-and-stack
      (mlet (s r rec a ps)
          (apply #'execute-ps-strategy :modify-current plan args more-args)
        (if (eq :success s)
            (values s r rec a ps)
          ;; make sure we have stacked plans
          (when (remove (root-plan) (remove plan (all-context-plans)))
            (trash-response)
            (apply #'execute-ps-strategy :modify-stack plan args more-args)))))
    
    ( :modify-current-and-stack-hacking-instead-of
      (mlet (s r rec a ps)
          (apply #'execute-ps-strategy :modify-current-hacking-instead-of plan args more-args)
        (if (eq :success s)
            (values s r rec a ps)
          ;; make sure we have stacked plans
          (when (remove (root-plan) (remove plan (all-context-plans)))
            (trash-response)
            (apply #'execute-ps-strategy :modify-stack-hacking-instead-of plan args more-args)))))
    
    ( :modify-backup
      ;; strategis here probably should be broken out and separated.
      (mlet (s r rec a ps)
          (apply #'execute-ps-strategy :modify-stack plan args more-args)
        (cond
         ((eq s :success)
          (values s r rec a ps))
         (t
          (trash-response)
 	  ;; ***
	  ;; gf and jfa: Is this simple-undo needed? We think not...
 	  ;; ***
          (simple-undo)
          (when (null more-args)
            ;; try spec alone
            (if (eq :success
                    (msetq (s r rec a ps) (apply #'execute-ps-strategies
                                                 `( :refine-extend-current-using-status
                                                    :refine-extend-stack
                                                    :do-what-you-can
                                                    :new-subplan-root)
                                                 *current-plan* ;; instead of plan, which might be deleted by undo
                                                 args more-args)))
                (values s r rec a ps)
              (let* ((last-extension (get-last-extension))
                     (last-action (or (extract-keyword :content last-extension)
                                      (extract-keyword :add last-extension)))
                     (new-args (if (and (keywordp (car args)) 
                                        (member (car args) '( :go :stay)))
                                   (cddr args) 
                                 args)))
                (debug-log :prince :prince "Modify backup last resort; last-extension: ~S last-action: ~S args: ~S new-args: ~S" last-extension last-action args new-args)
                
                (execute-ps-strategy :new-subplan-root plan 
                                     (cond
                                      ((null last-action)
                                       args)
                                      ((eq (car args) :and)
                                       (cons :and (append new-args last-action))) ; rescope :and
                                      (t
                                       `(:and ,@new-args ,@(cddr last-action))))))))))))

    ( :delete-plan
      (handle-ps-request :delete-plan plan nil)) ; not ready for auto-commit
    
    ( :cancel
      (handle-ps-request :cancel plan `(:content (:object ,(proc-constraints-for-ps args)))))
    ))

(defun retry-ps-command (attempt)
  ;; if we retry *ps-request*
  (handle-ps-request (car attempt) (extract-keyword :plan-id attempt) (list :content (extract-keyword :content attempt)) t))

(defun handle-ps-request (request plan args &optional auto-update)
  (debug-log :prince :ps ";; PS request (plan ~S): ~S~{ ~S~}~%" plan request args)
  (let* ((ps-request (if plan
                         `(,(cond ((eq request :extend-maybe) ; hack to avoid commitment. Probably a better way to do this
                                   :extend)
                                  ((eq request :new-subplan-maybe)
                                   :new-subplan)
                                  (t
                                   request))
                              :plan-id ,plan ,@args)
                       (cons request args)))
         (*ps-request* ps-request))
    (do-log-timestamp :perf "calling PS")
    (mlet (summary result rec ans ps-state ror agent)    
        (process-ps-result (prog1 (kb-request-kqml (create-request :ps ps-request))
                             (do-log-timestamp :perf "PS done"))
                           auto-update
                           request
                           plan)
      (cond
       ((eq summary :success)
        (values summary result rec ans ps-state ror agent)) ; just get out if we already committed it.

       ((eq summary :no-agent)
        ;; have a focused agent, try that.before failing
        (unless (if (eq (car (second args)) :go)
                    (get-sslot :agent (cddr (second args)))  ; specified an agent already?
                  (get-sslot :agent (second args)))
          (let ((old-args args)
                (new-args (copy-list args)))
            ;; was something like (:content (:go go123 <pq> ...))
                                        
            (if (eq (car (second old-args)) :go)
                (setf (cddr (second new-args))
                  `((:and (:agent ,*current-focus*) ,@(cddr (second old-args)))))
              (setf (second new-args)
                `(:and (:agent ,*current-focus*) ,(second old-args))))
            (handle-ps-request request plan new-args auto-update))))
       
       ((member summary '( :creating-circular-route :makes-circular-route))
        ;; if we weren't doing a modify, try that.
        (unless (member request '( :modify-current :modify))
          (handle-ps-request :modify plan `(:add ,@(cdr args)) t)))
       
       ((member summary '( :bailed :impossible :bad))
        (wazzawump :prince)
        (values summary result rec ans ps-state ror agent))

       ((eq summary ':sorry)
        (wazzawump :ps)
        (values summary result rec ans ps-state ror agent))
       
       (t
        (values summary result rec ans ps-state ror agent))))))

#||
;; needed only when we have code to compare results.

(defconstant +ratings+ '((:impossible . 0) (:bad . 1) (:ok . 2) (:good . 3)))
  
(defun rating-better-p (rating1 rating2)
  (> (cdr (assoc rating1 +ratings+)) (cdr (assoc rating2 +ratings+))))

(defun finish-partial-ps (request ps-state ror agent &optional 
                                                     (pb-proposed-state (get-proposed-state))
                                                     (pb-proposed-sas (get-proposed-sas))
                                                     (pb-request-error (get-request-error)))
  (debug-log :prince :prince "finish-partial-ps called on: ~S ~S ~S ~S ~S ~S ~S" 
             request ps-state ror agent pb-proposed-state pb-proposed-sas pb-request-error)
  (set-proposed-state pb-proposed-state)
  (set-proposed-sas pb-proposed-sas)
  (set-request-error pb-request-error)
  (execute-update-pss request result-key nil ps-state :finish-partial)
  (if ror
      (while ror
        (destructuring-bind (actions . agentx) (pop ror)
          (report-on-route-i actions agentx)))
    (if (or agent (neq request :new-subplan))
        (report-on-route))))
||#

(defun fixup-constraint-for-ps (constraint)
  ;; delete time terms, since ps doesn't yet handle
  (cond
   ((and (not (consp constraint))
         (or (vari-p constraint)
             (member constraint '( :this :that :where :who :what :why :how :use))))
    (log-warning :prince "Stripping constraint: ~S" constraint)
    nil)
   ((not (consp constraint))
    constraint)
   ((member (car constraint) '( :and :or))
    (cons (car constraint) (mapcar #'fixup-constraint-for-ps (cdr constraint))))
   ((eq (car constraint) :time-duration)
    (log-warning :prince "Stripping constraint: ~S" constraint)
    nil)
   (t
    constraint)))                       ; dunno what to do, hope it's legal

(defun proc-constraints-for-ps-w-content (constraints)
  (let*-non-null ((x (proc-constraints-for-ps constraints)))
    `( :content ,x)))

(defun proc-constraints-for-ps (constraints)
  (setq constraints (if (consp constraints)
                        (delete nil (mapcar #'fixup-constraint-for-ps constraints))
                      (fixup-constraint-for-ps constraints)))
  (unless (null constraints)
    (proc-constraints-for-ps-i constraints)))

(defun proc-constraints-for-ps-i (constraints)
  (cond
   ((route-p constraints)
    constraints)
   ((and (consp constraints) (route-p (car constraints)))
    (if (cdr constraints)
        `(:and ,@constraints)
      (car constraints)))
   (t
    `(:go ,(gentemp "GO" user::*hack-package*)
          ,(cond
            ((and (consp constraints)
                  (endp (cdr constraints)))
             (car constraints))
            ((consp constraints)
             `(:and ,@constraints))
            (t
             constraints))))))

;; solution sets (new)

(defun create-solution-set (path)
  (ps-ask-one `(:solution-set-by-constraints hack::?solution-set-id ,(proc-constraints-for-ps path))
              '(hack::?solution-set-id)))

(defun translate-preference (pref &optional filter-p)
  (if (consp pref)
      (mapcar #'(lambda (x) (translate-preference x filter-p)) pref)
    (case pref
      ( :time-duration
        :duration)
      ( :less
        (if filter-p
            :<
          :<=))
      ( :greater
        (if filter-p
            :>
          :=>))
      ( :equal
        :=)
      (t
       (log-warning :prince "unhandled pref (translate-preference): ~S (filter-p: ~S)" pref filter-p)
       :<=))))
        
