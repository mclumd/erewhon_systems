;; Time-stamp: <Mon Jan 20 14:33:29 EST 1997 ferguson>

(when (not (find-package :verbal-reasoner))
  (load "verbal-reasoner-def"))
(in-package verbal-reasoner)

(eval-when (load eval)
  (add-initialization "Register :prince"
                      '(register :prince #'verbal-reasoner::process-verbal-reasoner-request)
                      () 'kqml::*register-initializations*))

(defun generate-output ()
  ;; if there is output waiting, generate it.
  (if (or (did-undo-p) (new-state-p) (proposed-state-p) (proposed-sas-p))
      (close-prior-output))

  (let* ((output (get-output-sas))
         (wrapper-p (compound-communications-act-p (car output))))
    (cond
     ((null output)
      ;; generate something...
      (vr-expressive :ah)
      (generate-output))
     (wrapper-p                         ; multiple interactions with multiple outputs
      ;; check to see if we can supercede any of the earlier outputs (same plan, later guy contains a route).
      (let (plans-with-routes
            new-output)
        (mapc #'(lambda (cc)
                  (cond
                   ((member (plan cc) plans-with-routes) ; already saw it.
                    nil)                ;ignore earlier version.
                   ((find-if #'(lambda (act)
                                 (and (sa-elaborate-p act)
                                      (paths act)))
                             (acts cc))        ; one of the sas in this compound is a path
                    (push (plan cc) plans-with-routes)
                    (push cc new-output)) ;; build up reversed form of output
                   (t
                    (push cc new-output))))
              output)
        (create-reply (make-compound-communications-act :initiator :self
                                                        :acts new-output))))
     (t ;; single interaction, generate a wrapper to capture ps-state and plan.
      (create-reply (make-compound-communications-act :initiator :self
                                                      :ps-state (get-ps-state)
                                                      :plan (get-plan)
                                                      ; not reversed yet so inverse order to user's utterance.
                                                      :acts (nreverse output))))))) 

(defun no-prior-output-p (&optional (sas (get-output-sas)))
  (or (null sas)
      (compound-communications-act-p (car sas))))

(defun close-prior-output ()
  ;; if we have output queue'd then make sure it's grouped so the generator can deal with associated output.
  (debug-log :prince :ps ";; close-prior-output (plan ~S) (ps-state ~S): ~{ ~S~}~%" (get-plan) (get-ps-state) (get-new-state))
  (when (did-undo-p)
    (report-on-route (pop-did-undo)))
  (if (proposed-state-p)
      (commit-proposed-state))
  (while (new-state-p)
    ;; uncaptured state
    (debug-log :prince :prince "Capturing new state in confirm: ~S" (car (get-new-state)))
    (vr-reply 'sa-confirm))             ; confirm, e.g. the undo.

  (if (proposed-sas-p)
      (commit-proposed-sas))
  
  (if (request-error-p)
      (set-attempted-route (pop-request-error)))

  (let ((sas (get-output-sas))
        (plan (get-plan)))
    (unless (no-prior-output-p sas)
      (let ((first-cca (position-if #'compound-communications-act-p sas :start 1)))
        (when (and plan
                   (not (eq plan *current-plan*)))
          (debug-log :prince :prince "Comitting output for plan ~S, but that hasn't been pss-updated! (current plan: ~S)"
                     plan
                     *current-plan*)
          (setq plan nil))              ; don't remember the plan, since we aren't updating to it.
        (set-output-sas
         (cons (make-compound-communications-act :initiator :self
                                                 :ps-state (get-ps-state)
                                                 :plan plan
                                                 :acts (subseq sas 0 first-cca))
               (if first-cca
                   (subseq sas first-cca))))))))

;; response handling functions
(defun vr-reply (sa)
  (push-proposed-sas (make-instance sa
                       :initiator :self
                       :paths (pop-all-response-route)
                       :Focus *current-focus*
                       :objects (pop-all-recognized-objects)
                       :action (pop-action)
                       :semantics (pop-new-state))))

(defun vr-ask-yn-question (content &optional objects (setting *ps-request*))
  (push-proposed-sas (make-sa-yn-question :initiator :self :semantics content :objects objects :setting setting)))

(defun vr-ask-wh-question (content)
  (push-proposed-sas (make-sa-wh-question :initiator :self :semantics content)))

(defun vr-point (focus)
  (push-proposed-sas (make-sa-point-with-mouse :initiator :self :focus focus)))

(defun vr-question-answer (focus elaboration)
  (push-proposed-sas (make-sa-elaborate :initiator :self
                                     :focus focus
                                     :objects (pop-all-recognized-objects)
                                     :semantics (cons :question-answer (force-list elaboration)))))

(defun vr-confirm (&optional question-answer-p)
  (push-proposed-sas (make-sa-confirm :initiator :self :semantics (if question-answer-p '( :question-answer)))))

(defun vr-reject (&optional question-answer-p)
  (push-proposed-sas (make-sa-reject :initiator :self :semantics (if question-answer-p '( :question-answer)))))

(defun vr-greet (&optional status-p)
  (if status-p
      (push-proposed-sas (make-instance 'sa-greet
                           :initiator :self
                           :semantics :status))
    (generate 'sa-greet)))

(defun vr-confirm-and-elaborate (question-answer-p focus &optional defs)
  (vr-confirm question-answer-p)
  (push-proposed-sas (make-sa-elaborate :initiator :self
                                     :paths (pop-all-response-route)
                                     :focus focus
                                     :objects (pop-all-recognized-objects)
                                     :defs defs
                                     :action (pop-action)
                                     :semantics (if question-answer-p
                                                    '( :yn-question-answer)
                                                  (pop-new-state)))))

(defun vr-reject-and-elaborate (question-answer-p focus)
  (vr-reject question-answer-p)
  (push-proposed-sas (make-sa-elaborate :initiator :self
                                     :paths (pop-all-response-route)
                                     :focus focus
                                     :objects (pop-all-recognized-objects)
                                     :defs nil
                                     :action (pop-action)
                                     :semantics (if question-answer-p
                                                    '( :yn-question-answer)
                                                  (pop-new-state)))))

(defun vr-bad (sa bad-object expected-type &optional (plan *current-plan*) special-semantics)
  (push-proposed-sas (make-instance sa
                       :initiator :self
                       :paths (pop-all-response-route)
                       :focus *current-focus*
                       :objects (pop-all-recognized-objects)
                       :defs nil
                       :object bad-object
                       :expected-type expected-type
                       :nc-plan plan
                       :semantics special-semantics))
  nil)

(defun vr-ambiguous (objects type)
  (vr-bad 'sa-ambiguous objects type))

(defun vr-huh (bad-object expected-type plan &optional special-semantics)
  (vr-bad 'sa-huh bad-object expected-type plan special-semantics))

(defun vr-missing-required-object (needed-type plan)
  (vr-huh nil needed-type plan))

(defun vr-repeated-info ()
  ;; the repeated info should still be put on new-state
  (vr-confirm-and-elaborate nil *current-focus* :redundant))

(defun vr-expressive (expressive)
  (push-proposed-sas (make-sa-expressive :initiator :self :semantics expressive)))

;; database handlers
(defun vr-find-city (city &optional (mentioned t))
  (cond
   ((and (city-p city)
         (not (basic-for-reference-p city)))
    city)
   (city
    (progfoo (kb-request-kqml (create-request :world-kb
                                              `( :find-location ,city)))
      (if foo
          (when mentioned (push-recognized-objects foo))
        (vr-huh city :city *current-plan*))))))

(defun vr-find-cities (to-cities)
  (cond
   ((null to-cities)
    nil)
   ((atom to-cities)
    (list (vr-find-city to-cities)))
   (t
    (mapcan #'(lambda (city)
                (unless (eq city :and)
                  (list (vr-find-city city))))
            (flatten to-cities)))))

(defun vr-warn (object type &optional delay-time)
  (if (consp object)
      (push-proposed-sas (make-sa-warn :initiator :self :focus (car object) :objects object :defs type :semantics delay-time))
    (push-proposed-sas (make-sa-warn :initiator :self :focus object :objects (list object) :defs type :semantics delay-time))))

(defun get-all-engines ()
  (kb-request-kqml (create-request :world-kb '( :find-engines))))

(defun get-last-extension ()
  (kb-request-kqml (create-request :user-model-kb '( :last-extension))))

(defun set-last-extension (x)
  (kb-request-kqml (create-request :user-model-kb `( :set-last-extension ,x))))

(defun get-engine-route (engine)
  (unless (sa-defs:tt-assert engine (engine) "No engine")
    (caar (do-ps-find `( :engine-route ,engine hack::?route)
            '(hack::?route)))))
;;(kb-request-kqml (create-request :plan-kb `( :engine-route ,engine)))

(defun get-engine-goal (engine)
  (when engine
    (let ((plan (caar (do-ps-find `(:and (:agent ,(fix-pkg (object-name engine)) hack::?plan)
                                         (:goal hack::?action hack::?plan))
                        '(hack::?action)))))
      (unless (tt-assert (and (consp plan) (eq (car plan) :go)) () "Bad plan result from PS: ~S on engine: ~S" plan engine)
        (let*-non-null ((to-slot (get-sslot :to (cddr plan))))
          (identify to-slot))))))

(defun get-plan-actions (plan)
  (car (ps-ask-one `( :actions hack::?list-of-actions ,plan) '(hack::?list-of-actions))))

(defun get-plan-solution-set (plan)
  (unless (sa-defs:tt-assert plan (plan) "Bad plan")
    (car (ps-ask-one `( :solution-set hack::?ss ,plan) '(hack::?ss)))))

(defun get-preferred-solution-set (ss pref)
  (car (ps-ask-one `( :solution-set-preference ,ss ,pref hack::?new-ss) '(hack::?new-ss))))

(defun compare-solutions-equal (ss1 ss2)
  (progfoo (ps-ask-if `( :and (:current-solution ,ss1 hack::?sol) (:current-solution ,ss2 hack::?sol)))
    (return-from compare-solutions-equal (values (eq foo t) foo))))


(let ((gep-cache))
  (defun reset-gep-cache ()
    (setq gep-cache nil))
  (defun get-engine-position (engine)
    (unless (sa-defs:tt-assert (or (symbolp engine)
                           (neq (basic-name engine) t))
                       () "Bad engine")
      (or (cdr (assoc engine gep-cache :test #'equal))
          (progfoo (identify (caar (do-ps-find `(:at-loc ,engine hack::?loc)
                                     '(hack::?loc))))
            (update-alist engine foo
                          gep-cache :test #'equal))))))
;;(kb-request-kqml (create-request :plan-kb `( :engine-position ,engine)))

(defun get-goals ()
  (mapcar #'(lambda (x) (identify
                         (get-sslot :to (car x))))
          (do-ps-find `(:goal hack::?goal hack::?plan)
            '(hack::?goal))))
;;  (kb-request-kqml (create-request :plan-kb '( :goal)))

(defun get-plan-goal (plan)
  (do-ps-find `(:goal hack::?action ,plan) '(hack::?action)))

(let ((glc-cache))
  (defun reset-glc-cache ()
    (setq glc-cache nil))
  (defun get-location-contents (location)
    (when location
      (or (cdr (assoc location glc-cache :test #'equal))
          (progfoo (mapcar #'identify (car (do-ps-find `(:at-loc hack::?object ,location)
                                             '(hack::?object))))
            (update-alist location foo
                          glc-cache :test #'equal))))))

;;(kb-request-kqml (create-request :plan-kb `( :location-contents ,location))))

(defun get-attempted-route ()
  (kb-request-kqml (create-request :user-model-kb '( :attempted-route))))

(defun set-attempted-route (x)
  (kb-request-kqml (create-request :user-model-kb `( :set-attempted-route ,x))))

(defun get-location-problems (location)
  (unless (sa-defs:tt-assert location (location) "Null location to get-location-problems")
    (do-ps-find `(:delay hack::?problem ,location hack::?delay-time) '(hack::?problem hack::?delay-time))))

(defun get-engine-problems (engine)
  (unless (sa-defs:tt-assert engine (engine) "Null engine for get-engine-problems")
    (do-ps-find `(:problem hack::?problem ,engine hack::?location hack::?delay-time hack::?arg) '(hack::?problem hack::?location hack::?delay-time hack::?arg ))))

(defun get-object-resolution (object)
  "Return success indication and the object"
  ;; pull the predicates out of the object, and turn it into a query.
  (cond
   ((basic-kb-object-p object)
    (mapcar #'identify (car (do-ps-find `(:and (:type hack::?object ,(cond
                                                                      ((engine-p object)
                                                                       :engine)
                                                                      ((city-p object)
                                                                       :city)
                                                                      ((track-p object)
                                                                       :track)
                                                                      (t
                                                                       (log-warning :prince "Unknown object type to resolve: ~S" object)
                                                                       (when cl-user::*debug-interactive*
                                                                         (break))
                                                                       (return-from get-object-resolution nil))))
                                               ,@(basic-predicates object))
                              '(hack::?object)))))
   ((predicate-prop-p object)
    (mapcar #'identify 
            (if (endp (cdr (terms object)))
                (car (do-ps-find `(:and ,@(terms object))
                       '(hack::?object)))
              (car (do-ps-find `(:and ,@(terms object))
                     '(hack::?object)))))) ; todo: need to splice in the var..
   
   ;; "The goals"
   ;;#<QUANTIFIER EVERY> #<VARI ELEM8392 vclass: :GOAL vsort: NIL> #<PREDICATE-PROP
   ;;               (GOAL OF) #<VARI pronoun4356 vclass: { :PLAN :AGENT}:DISJ vsort: NIL> :ELEM8392>>

   ((quantifier-prop-p object)
    (analyze-quantifier-prop object))
   (t
    (log-warning :prince "Prince: Unknown thingo to resolve: ~S" object)
    nil)))
   
(defun analyze-quantifier-prop (q)
  (let ((matcher (matcher-for-quantifier q)))
    (cond
     ((member (vclass (variable q)) (kb-request-kqml (create-request :world-kb '( :engine-synonyms))))
      (get-all-engines))
     ;; "The goals"
     ;;#<QUANTIFIER EVERY> #<VARI ELEM8392 vclass: :GOAL vsort: NIL> #<PREDICATE-PROP
     ;;               (GOAL OF) #<VARI pronoun4356 vclass: { :PLAN :AGENT}:DISJ vsort: NIL> :ELEM8392>>

     ;; note we probably want to use the vclass of the predicate to be the type of the variable in
     ;; the query, but since PS doesn't currently support disjunction...
     (t
      (let ((varname (intern (gensym "?") user::*hack-package*)))
        (car (funcall matcher `(,(vclass (variable q)) ,varname) ; current plan only?
                      (list varname))))))))

(defun get-unsolved-plans ()
  (mapcar #'car (do-ps-find '( :ps-status :unsolved hack::?plan) '(hack::?plan))))

(defun get-all-plans ()
  (mapcar #'car (do-ps-find '( :ps-status hack::?dont-care hack::?plan) '(hack::?plan))))

(defun get-plan-status (plan)
  (car (ps-ask-one `( :ps-status hack::?status ,plan) '(hack::?status))))

(defun plan-solved-p (plan)
  (progfoo (ps-ask-if `( :ps-status :solved ,plan))
    (return-from plan-solved-p (values (eq foo t) foo))))

(defun plan-confirmed-p (plan)
  (progfoo (ps-ask-if `( :ds-status :goal-accepted ,plan))
    (return-from plan-confirmed-p (values (eq foo t) foo))))

(defun get-plan-agent (plan)
  (do-ps-find `( :agent hack::?agent ,plan) '(hack::?agent)))

;;(kb-request-kqml (create-request :plan-kb `( :resolve-object ,object))))

;; where are the goals:
;; (VARIABLE-MATCH-P #<VARI WHERE vclass: :LOCATION vsort: :INDIVIDUAL>
;;      (#<QUANTIFIER-PROP #<QUANTIFIER EVERY> #<VARI ELEM6728 vclass: :GOAL vsort: NIL>>))

(defun matcher-for-quantifier (q)
  (case  (name (quantifier q))
    (( :every :forall)
     #'ps-ask-all)
    (( :the :exists :some)
     #'ps-ask-one)
    (t
     #'ps-ask-one)))

(defun variable-match-p (var thingo)
  (debug-log :prince :prince "Variable-match-p called on var ~S thingo ~S" var thingo)
  (let ((varname (intern (concatenate 'string "?" (string (name var))) user::*hack-package*))
        (varclass (vclass var))
        (matcher #'ps-ask-one))
    (cond
     ((quantifier-prop-p thingo)
      ;; should turn into call on analyze-quantifier-prop, but for now, we have more info from the var terms.
      (setq matcher (matcher-for-quantifier thingo))
      ;; asking about the trains?
      (cond
       ((member (vclass (variable thingo)) (kb-request-kqml (create-request :world-kb '( :engine-synonyms))))
        (mapcar #'(lambda (engine) (variable-match-p var engine)) 
                (get-all-engines)))
       (t
        (car (funcall matcher `(:and (:type ,varname ,varclass)
                                     (,(vclass (variable thingo)) ,varname)) ; current plan only?
                      (list varname))))))
     ;;(:AND (:TYPE ?where :LOCATION) #<ENGINE ENGINE1>)
     ((member varclass '( :location :city :track))
      (car (funcall matcher `(:at-loc ,thingo ,varname)
                    (list varname))))

     (t
      (car (funcall matcher `(:and (:type ,varname ,varclass)
                                   ,thingo)
                    (list varname)))))))
;;  (kb-request-kqml (create-request :plan-kb `( :variable-match ,var ,thingo))))

(defun remove-route-for-plan (plan)
  (let ((display-route (kb-request-kqml (create-request :display-kb `( :route-with-feature :plan ,plan)))))
    (when display-route
      (report-on-route-i nil (identify (engine display-route))))))

(defun remove-display-objects-for-plan (plan)
  ;; at least partly immediate
  (remove-route-for-plan plan)
  (push-proposed-sas (make-sa-elaborate :initiator :self
                                        :semantics (list :goal-delete plan))))

(defun report-on-route-i (response-route focus)
  (debug-log :prince :prince "Reporting on route ~S, for ~S" response-route focus)
  
  (set-response-route response-route)

  (push-new-state (list :route-extension response-route (get-engine-position focus)))
  (vr-confirm-and-elaborate nil focus) ;; clears response-route, captures above state
  
  (when response-route
    ;; check to see if cities we travel through, or tracks are congested
    (let ((problems (get-engine-problems focus))
          (posn (get-engine-position focus)))
      (dolist (problem problems)
        (destructuring-bind (type location delay-time args) problem
          (setq location (identify location))
          (cond
           ((eq type :crossed-route)
            ;;(vr-warn location :cross delay-time)
            ;; don't do anything, since the cross may be transient. Also generation checks about crosses in effect.
            )
           ((not (and (eq location posn) ; might actually depend on type, but for now this is cool.
                      (member location (get-goals))))
            (vr-warn location args delay-time)))))))
  (values))

(defun report-on-route (&optional (focus *current-focus*))
  (cond
   ((null focus)
    (log-warning :prince ";;VR: Report on route with null focus."))
   (t
    (clear-did-undo)               ; don't need to remember to report the route.
    (report-on-route-i (get-engine-route focus) focus))))

(defun vr-clear-focus ()
  "Use this when we know we're no longer talking about the old object(s)."
  (debug-log :prince :prince "Clearing focus")
  (set-focus-changed)
  (kb-request-kqml (create-request :user-model-kb '( :set-engine-focus nil)))
  (push-proposed-state (list :new-focus nil))
  (setq *current-focus* nil))

(defun vr-update-focus (focus &optional recognize-object)
  (if (sa-defs:tt-assert (not (consp focus)) () "bad focus")
      (return-from vr-update-focus nil))
  (unless (basic-kb-object-p focus)
    (setq focus (identify focus)))
  (unless (eq focus *current-focus*)
    (debug-log :prince :prince "Updating focus to ~S from ~S" focus *current-focus*)
    
    ;; this should be better integrated with state proposal stuff. Problem is we may trash the response that caused us
    ;; to update the focus.
    (setq *focus-changed* *current-focus*) ; temporary in case of backtrack
    (set-focus-changed)                 ; so regular rules will know
    (if (and recognize-object focus)
        (push-recognized-objects focus))
    (kb-request-kqml (create-request :user-model-kb
                                     `( :set-engine-focus ,focus)))
    (push-proposed-state (list :new-focus focus))
    (setq *current-focus* focus)))

(defun get-other-plans (plan request-type)
  (remove (or plan *current-plan*)
          ;; if we're doing a modify, don't restrict ourself to unsolved plans
          (if (eq request-type :modify)
              (get-all-plans)
            (get-unsolved-plans))))

(defun process-verbal-reasoner-request (main-input)
  (do-log-timestamp :perf "Prince starts")
  (reset-glc-cache)
  (reset-gep-cache)                     ; cut down request to ps by caching answers each round.
  (debug-log :prince :prince "Command: ~W" main-input)
  (let ((*current-plan* (kb-request-kqml (create-evaluate :context-manager '( :current-plan)))))
    (if (eqmemb (perf main-input) '( hack::reply :reply))
        (process-ps-result (content main-input) nil :unknown *current-plan*) ; it's really a reply to a sub-request
      (let ((*current-focus* (kb-request-kqml (create-request :user-model-kb
                                                              '( :engine-focus))))
            (*focus-changed*))          ; part of commit/abort until we clean it up.
        (prog1 (match-input (content main-input))
          (do-log-timestamp :perf "Prince done"))))))

;;; queries on context manager
(defun all-context-plans ()
  (kb-request-kqml (create-ask-about :context-manager '( :all-plans))))

(defun frame-p (type &optional user)
  (kb-request-kqml (create-ask-if :context-manager `( :frame-type ,type ,@user))))

;; copied from reference
(defun warning-frames (plan)
  (let* ((entries (kb-request-kqml (create-ask-all :context-manager `( :warning-frames ,plan) nil)))
         (sas (delete nil (mapcar #'third entries)))
         (focii (delete nil (mapcar #'focus sas))))
    (delete-duplicates focii)))

(defun find-slot-from-history (slotname plan)
  (flet ((handle-history (le)
           (if le
               (progfoo (some (case slotname
                                ( :from
                                  #'from)
                                ( :via
                                  #'via)
                                ( :to
                                  #'to))
                              (remove-if-not #'path-quantum-p (flatten le)))
                 (when foo
                   (return-from find-slot-from-history foo)))))
         (handle-plandef ()
           (let* ((plangoal (get-plan-goal plan))
                  (slotval (get-sslot slotname plangoal)))
             (if slotval
                 (return-from find-slot-from-history slotval))))
         (handle-just-spoke ()
           (progfoo (mapcar #'cdr (kb-request-kqml (create-request :self-model-kb '( :just-told-about))))
             (if foo
                 (return-from find-slot-from-history foo)))))
    (cond
     ((eq plan *current-plan*)
      (handle-history (get-last-extension))
      (handle-history (get-attempted-route))
      (handle-just-spoke)
      (handle-plandef))
     (t
      (handle-plandef)))))

(defun plandef (plan)
  (kb-request-kqml (create-request :context-manager `( :plandef ,plan))))
         
(defun existance-frame-p ()
  (frame-p :existance))

(defun quit-frame-p ()
  (frame-p :quit))

(defun greet-frame-p ()
  (frame-p :greet))

(defun error-frame-p ()
  (frame-p :error))

(defun restart-frame-p ()
  (frame-p :restart))

(defun new-goal-frame-p ()
  (frame-p :new-goal))

(defun question-frame-p ()
  (frame-p :question '( :user)))

(defun get-error-frame ()
  (kb-request-kqml (create-ask-about :context-manager '( :frame-type :error))))

(defun get-question-frame (&optional user)
  (kb-request-kqml (create-ask-about :context-manager `( :frame-type :question ,@user))))

(defun goal-frame-p ()
  (frame-p :goal))

;;; repairing structures
(defvar *subs* nil)

(defgeneric vr-substitute (new old structure))

(defmethod vr-substitute :around (new old (structure t))
  (or (cdr (assoc structure *subs*))
      (let ((*subs* (acons structure :oops *subs*))) ; will be filled in by method
        (cond
         ((eq old structure)
          new)
         (t
          (call-next-method))))))

(defmethod vr-substitute (new old (structure t))
  (declare (ignore new old))
  structure)

(defmethod vr-substitute (new old (structure operator-prop))
  (progfoo (make-operator-prop :name (name structure) :parser-token (parser-token structure)
                               :operator (operator structure))

    (setf (cdar *subs*) foo)            ; in case of recursive call
    (setf (propositions foo)
      (mapcar #'(lambda (x) (vr-substitute new old x)) (propositions structure)))))

(defmethod vr-substitute (new old (structure quantifier-prop))
  (progfoo (make-quantifier-prop :name (name structure) :parser-token (parser-token structure)
                                 :quantifier (quantifier structure)
                                 :variable (variable structure))
    (setf (cdar *subs*) foo)
    (setf (propositions foo)
      (mapcar #'(lambda (x) (vr-substitute new old x)) (propositions structure)))))

(defmethod vr-substitute (new old (structure predicate-prop))
  (progfoo (make-predicate-prop :name (name structure) :parser-token (parser-token structure)
                                :predicate (predicate structure))
    (setf (cdar *subs*) foo)
    (setf (terms foo)
      (mapcar #'(lambda (x) (vr-substitute new old x)) (terms structure)))))

(defun undo (&optional ps-state )
  (push-did-undo (execute-undo ps-state)))
              
(defun vr-find-engine (at-restriction yn-question-p)
  (debug-log :prince :prince "Looking for an engine at: ~S" at-restriction)
  (if (or (proposition-p at-restriction) ; probably a bad parse
          (vari-p at-restriction)       ; don't handle yet
          (null at-restriction))
      (return-from vr-find-engine nil))
  (let ((location-engines (remove-if-not #'engine-p (get-location-contents at-restriction))))
    (cond
     ((null location-engines)
      (unless yn-question-p
        (vr-huh (list :at at-restriction) :engine *current-plan*)))
     ((endp (cdr location-engines))
      (push-recognized-objects (car location-engines))
      (car location-engines))
     (yn-question-p
      location-engines)
     (t
      (vr-ambiguous location-engines :engine)))))

(defun other-engine (all-engines)
  (car (remove (object-name *current-focus*) all-engines :test #'equal :key #'object-name)))

(defun update-for-new-focus (paths)
  paths)
  ;; obsolete
  #||
  (progfoo (mapcar #'copy-path-quantum paths)
    (setf (engine (car foo)) *current-focus*)) ; updated focus
  ||#

(defun redo-plan-based-on-focus-shift ()
  ;; hmm. No action for problem solver that works for actor changing. Do an undo, anyway.
  (simple-undo)
  (vr-missing-required-object :destination *current-plan*)) ; pretend we don't know what to do with it (for now).

(defun respond-with-route (paths)
  (set-handling-question)
  (set-response-route paths)            ; not really a route
  (execute-handle-paths *current-plan* paths))

(defun wazzawump (fault)
  ;; if the parse was good, act different than if it was bad.
  (let ((parse-quality (sa-defs:reliability *current-input*))
        (gloss (input *current-input*)))
    (push-proposed-sas (make-instance 'sa-nolo-comprendez
                         :initiator :self
                         :Focus *current-focus*
                         :objects (pop-all-recognized-objects)
                         :action (if (> parse-quality *parser-problem-threshold*) fault)
                         :semantics gloss))))

(defun generate (act)
  (vr-reply act))

(defun vr-resolve-object (object)
  (mlet (success result) (get-object-resolution object)
    (if success
      (if (consp result)
          (make-collection :terms result)
        (or result
            :nothing)))))

(defun simple-undo ()
  (undo)
  (let*-non-null ((undo-state (car (get-did-undo)))
                  (agent (get-plan-agent undo-state)))
    (report-on-route (identify agent))))

(defun create-engine-q-from-sem (new-engine-sem)
  (let ((lobj (rperf-prop-p :lobj new-engine-sem)))
    (if (engine-p lobj)
        (make-path-quantum :engine lobj)
      (make-path-quantum :engine (car (terms lobj))))))

(defun redo-extension-new-engine (new-engine-sem)
  (execute-redo-extension (if (engine-p new-engine-sem)
                              (make-path-quantum :engine new-engine-sem)
                            (create-engine-q-from-sem new-engine-sem))))

(defun handle-paths-new-engine (new-engine-sem)
  (execute-handle-paths *current-plan* (list (create-engine-q-from-sem new-engine-sem))))

(defun replan-route (semantics)
  (execute-replan-route semantics (third (get-error-frame))))

(defun execute-restart (act)
  (generate 'sa-restart)
  (if (eqmemb :new-scenario act)
      (kb-request-kqml (create-request :world-kb '( :clear)))) ; generate new locations?
  
  ;; for new guy, we have to clear world-kb, ps won't do it.
  (clear-ps))

(defun cpsg-internal (g)
  (let ((agent (get-sslot :agent g))
        (to (get-sslot :to g))
        (from (get-sslot :from g))
        (via (get-sslot :via g))
        (use (get-sslot :use g)))
    (values agent to from via use)))
        
(defun convert-ps-goal-to-quanta (goal)
  ;; handle the easy ones for now. need to handle not, too.
  (if (eq (car goal) :and)
      (return-from convert-ps-goal-to-quanta
        (mapcar #'convert-ps-goal-to-quanta (cdr goal))))
  
  (if (keywordp (car goal))             ; skip action
      (setq goal (cddr goal))) 
  
  (if (path-quantum-p goal)
      goal                              ; if we are dealing with a goal I hand it (relying on the print function)
    (mlet (agent to from via use) (cpsg-internal goal)
      (mlet (not-agent not-to not-from not-via not-use)
          (cpsg-internal (list (get-sslot :not goal)))
        (declare (ignore not-agent not-use))
      
        (make-path-quantum :engine agent
                           :to to
                           :from (or from (and agent (get-engine-position agent)))
                           :via via
                           :use use
                           :not-to not-to
                           :not-from not-from
                           :not-via not-via)))))

;; eventually, this should be turned into LYM rules for multi-inputs.
(defun vr-combine-evidence (acts)
  "For now, we just run some simple global rules on the input, and reclassify sas, or eliminate/combine partials."
  
  (maplist #'(lambda (acts)
               (let ((act (car acts))
                     (next-act (cadr acts)))
                 ;; here we can look at each act in the context of the following acts.
                 (cond
                  
                  ;; reject/tell rule.
                  ;; if a simple reject is followed by a tell,
                  ;; the tell should be taken as the elaboration of the reject.
                  ((and (sa-reject-p act)
                        (null (paths act)) ; currect act is a unelaborated reject
                        (or (sa-request-action-p next-act)
                            (sa-elaborate-p next-act)
                            (sa-tell-p next-act)) ; next act is probably an elaboration
                        (paths next-act)) ; probably to be taken in light of the reject.
                   (change-class next-act 'sa-reject)) ; destructive.
                  )
                 ;; by default, 
                 (car acts)))
           acts))

(let (best-proposed-state
      best-proposed-sas
      best-request-error)
  (defun trash-response (&optional best-p)
    ;; clear pending response
    (debug-log :prince :prince "Trashing intermediate response: state: ~S sas: ~S rq error: ~S" 
               (get-proposed-state)
               (get-proposed-sas)
               (get-request-error))
    (when (and best-p
               (not best-request-error))
      (setq best-proposed-state (get-proposed-state)
            best-proposed-sas (get-proposed-sas)
            best-request-error (get-request-error)))
    
    ;; fix bug 8/19/96, this should be better integrated with state proposal facility.
    (when *focus-changed*
      (setq *current-focus* *focus-changed*)
      (setq *focus-changed* nil)
      (kb-request-kqml (create-request :user-model-kb
                                       `( :set-engine-focus ,*current-focus*)))) ;; change it back
             
    (clear-proposed-state)              ;trash any response
    (clear-proposed-sas)
    (clear-request-error))
  
  (defun clear-best-trashed-response ()
    (setq best-proposed-state nil
          best-proposed-sas nil
          best-request-error nil))
  
  (defun restore-best-trashed-response ()
    (when best-request-error
      (set-proposed-state best-proposed-state)
      (set-proposed-sas best-proposed-sas)
      (set-request-error best-request-error))))
        

