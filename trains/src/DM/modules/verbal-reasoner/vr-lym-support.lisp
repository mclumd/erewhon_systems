;; Time-stamp: <Mon Jan 20 14:34:39 EST 1997 ferguson>

(when (not (find-package :verbal-reasoner))
  (load "verbal-reasoner-def"))
(in-package verbal-reasoner)

(eval-when (load eval)
  (define-rulebase :focus)
  (define-rulebase :vr :focus)
  )


(defun match-input (input)
  (let (                                ; environment for lym rules.
        (*engine-synonyms* (kb-request-kqml (create-evaluate :world-kb '( :engine-synonyms))))
        (*discourse-context* (kb-request-kqml (create-evaluate  :context-manager
                                                              '( :discourse-context))))
        (*all-engines* (kb-request-kqml (create-request :world-kb
                                                        '( :find-engines)))))
    (declare (ignorable *engine-synonyms* *discourse-context* *all-engines*))
    
    ;; for now, we invoke lymphocyte on each sa separately, as before. Eventually
    ;; we want to rewrite the rules to match across multiple speech-acts if possible, and otherwise
    ;; segement and handle each separately.
    
    ;; these variables are set for the entire utterance, vs. a specific commm act (if compound)
    ;; used to generate a response
    (clear-kb)
    ;; right now, we're just getting fragments from the parser. guess what's going on, and
    ;; update our internal state and return something to be generated (e.g. to draw something).
    (clear-output-queue)
    
    (cond
     ((compound-communications-act-p input)
      ;; First pass to handling multiple speech acts: combine evidence
      (let ((acts (vr-combine-evidence (acts input))))
        (set-remaining-acts acts)
        (while (remaining-acts-p)
          (match-input-one (pop-remaining-acts)))))
     (t
      (match-input-one input)))
    (generate-output)))

(defun match-input-one (input)
  (let ((*current-input* input))        ; in case we invoke a rule, and still fail, we can check our parse (wazzawump)
    (close-prior-output)                ; handle prior output this VR.
    (clear-best-trashed-response)       ; clear the trashed response cache
    ;; deal with social issues
    (when (eqmemb :polite (social-context input))
      (kb-request-kqml (create-request :self-model-kb
                                       '( :decf-frustration-level "Polite"))))
    ;; don't worry about costs for now (most rules don't use cost yet anyway).
  
    (complete-lymphocyte :focus input)  ; update the focus. Maybe this should move to reference.
  
    (complete-lymphocyte :vr input)))   ; ok, now invoke verbal reasoning rules

;; actions/queries

(defun engine-position (engine)
  (cond
   ((and (engine-p engine)
         (eq (basic-name engine) t))
    (or (mobile-at engine)
        :unknown))
   ((engine-p engine)
    (get-engine-position engine))
   (t
    (mentioned-predicate *from-pred* engine))))

(defun user-mentioned-engine (engines positions)
  (and engines
       (some #'(lambda (eng pos)
                 (if (predicate-prop-p eng)
                     (basic-predicates eng)
                   pos))
             engines
             positions)))

(defun match-spec (engine focus)
  (debug-log :prince :prince "Match-spec called on engine ~S and focus ~S" engine focus)
  (progfoo (cond
            ((vari-p focus)
             (variable-match-p focus engine))
            ((vari-p engine)
             (variable-match-p engine focus))
            (t
             nil))
    (when (consp foo)
      (setq foo (make-collection :terms foo))
      (setf (collection-disjunct-p foo) nil))))

(defun get-object-for-what (semantics)
  (mlet (success subject object) (perf-be-p :what nil semantics)
    subject ;; so no complaints
    (if success
        object)))

(defun ground-engine-p (eng)
  (and (basic-kb-object-p eng)
       (not (basic-for-reference-p (car eng)))
       (endp (cdr eng))))

(defun resolved-existance-p (eng sem)
  (and (perf-prop-p :exists sem)
       (equal (car eng) (rperf-prop-p :lsubj sem)))) ; asking if the train exists, AND resolved by reference.

(defun vr-handle-apology ()
  (let ((mood (kb-request-kqml (create-evaluate :self-model-kb '( :frustration-level)))))
    (cond
     ((> mood 15)                       ; pissed off
      (vr-expressive :apology-refusal)
      (kb-request-kqml (create-request :self-model-kb '( :incf-frustration-level :apology-refused))))
     (t
      (vr-expressive :apology-acceptance)
      (kb-request-kqml (create-request  :self-model-kb '( :decf-frustration-level :apology-accepted)))))))

(defun vr-handle-reject-with-semantics (path sem)
  ;; have to deal with the semantics slot intelligently., but not yet. unless it's :instead

  (cond
   ((eq (car sem) :instead)
    (let ((instead-do (second sem))
          (instead-do-not (third sem)))
      (when (proposition-p instead-do)
        (log-warning :prince "Vr-handle-reject-with-instead has complex instead-do: ~S, ignoring." instead-do)
        (setq instead-do nil))          ; can't handle it.
      (when (proposition-p instead-do-not)
        (log-warning :prince "Vr-handle-reject-with-instead has complex instead-do-not: ~S, ignoring." instead-do-not)
        (setq instead-do-not nil))

      (cond
       ((null path)
        (vr-handle-reject-with-instead instead-do instead-do-not))
       ((and (path-quantum-p instead-do-not)
             (not (eq instead-do-not path))) ; path substitution
        (execute-ps-strategies `( :modify-current-and-stack) *current-plan* path instead-do-not))
       ((or (city-p instead-do-not)
            (collection-p instead-do-not))
        (execute-ps-strategies `( :modify-current-and-stack) *current-plan* path `((:use ,instead-do-not))))
       ((null instead-do-not) ;; check to see if we can guess.
        (execute-ps-strategies `( :modify-current-and-stack-hacking-instead-of) *current-plan* path))
       (t
        (log-warning :prince "Didn't handle reject-with-semantics (doing modify) path: ~S sem: ~S" path sem)
        (execute-ps-strategies `( :modify-current-and-stack) *current-plan* path instead-do-not)))))
   (t
    (log-warning :prince "Didn't handle reject-with-semantics (doing redo/reject) path: ~S sem: ~S" path sem)
    (if path
        (execute-redo-extension path)
      (execute-reject-solution *current-plan*)))))
  
(defun vr-handle-reject-with-instead (instead-do instead-do-not)
  (when (proposition-p instead-do)
    (log-warning :prince "Vr-handle-reject-with-instead has complex instead-do: ~S, ignoring." instead-do)
    (setq instead-do nil))              ; can't handle it.
  (when (proposition-p instead-do-not)
    (log-warning :prince "Vr-handle-reject-with-instead has complex instead-do-not: ~S, ignoring." instead-do-not)
    (setq instead-do-not nil))
  (if (or instead-do instead-do-not)
      (execute-modify *current-plan* 
                      (if (or (city-p instead-do)
                              (engine-p instead-do)
                              (collection-p instead-do))
                          `((:use ,instead-do))
                        (if instead-do
                            (list instead-do)))
                      (cond
                       ((or (city-p instead-do-not)
                            (engine-p instead-do-not)
                            (collection-p instead-do-not))
                        `((:use ,instead-do-not)))
                       (instead-do-not
                        (list instead-do-not))))
    (simple-undo)))                     ; at least it's something.

(defun vr-add-new-goal ()
  ;; we were't sure the user wanted to add a new goal the last time, but he confirmed it.
  (let ((attempt (get-attempted-route)))
    (cond
     (attempt
      (retry-ps-command attempt))
      ;; did something else in between, so (for now) it's lost.
     ;; might be a good idea to attach the context to the prior huh, and get it from there.
     (t
      (log-warning :prince "Add new goal lost context: ~S" (new-goal-frame-p))
      (wazzawump :prince)))))

(defun future-act-p (act-pred)
  (some act-pred (get-remaining-acts)))

(defun future-request-p ()
  (or (future-act-p #'id-goal-p)
      (future-act-p #'sa-request-action-p)
      ;; kind of a hack, but we have to handle the city stuff.
      (some #'(lambda (x) 
                (or (paths x)
                    (city-p (semantics x))
                    (engine-p (semantics x))
                    (sa-id-goal-p x)
                    (sa-request-action-p x)))
            (get-remaining-acts))))

(defun future-focus-shift-p ()
  (future-act-p #'(lambda (x) (and (sa-tell-p x) (eq (car (defs x)) :new-focus)))))

(defun vr-show-wh (thingo)
  (cond
   ((map-object-p thingo)
    (vr-point thingo))))

;; instead of match-spec to handle peculiarities of goals
(defun vr-goal-p (goal-spec focus)
  (labels ((damn ()
             (log-warning :prince "Unhandled goal match: goal-spec ~S, focus ~S" goal-spec focus)
             (return-from vr-goal-p nil))
           (where-be-the-goals ()
             (if (and (quantifier-prop-p goal-spec)
                      (eql (name (quantifier goal-spec)) :every)
                      (eql (vclass (variable goal-spec)) :goal))
                 ;; asking about all the goals that match the predicate.
                 (let ((preds (propositions goal-spec)))
                   (if (sa-defs:tt-assert (null (cdr preds)) () "Beyond current capabilities")
                       (damn))
                   (let ((pred-name (name (predicate (car preds)))))
                     (cond ((and (equalp pred-name '( :goal :of))
                                 (vari-p (car (terms (car preds)))))
                            (delete nil (ps-ask-all `(:goal hack::?action hack::?plan) '(hack::?action))))
                           (t
                            (damn)))))
               (damn))))
    (cond
     ((or (eq focus :what)              ; a bug, really
          (and (vari-p focus)
               (member (name focus) '( :where :what))))
      (where-be-the-goals))
     (t
      (damn)))))

;; is there a faster route
;;#1=#<OPERATOR-PROP PERF #<PREDICATE-PROP EXISTS #1#> 
;;   #<PREDICATE-PROP LSUBJ #2=#<ROUTE T NIL:NIL->NIL 
;;                             Predicates: (#<PREDICATE-PROP (LESS TIME-DURATION) #2# (:*PRO :ROUTE)>)
;;    Noise: (:DESCRIPTION (:STATUS :INDEFINITE) (:VAR :V11703) (:CLASS :ROUTE)
;;        (:SORT :INDIVIDUAL)
;;        (:CONSTRAINT
;;         ((:LESS :TIME-DURATION) :V11703
;;                                 (:*PRO :ROUTE))))
;;  Color: :BLACK (plan: NIL)>>>, routes (#2#)

(defun nonspecific-route-p (route)
  (and (null (engine route))
       (null (segment-list route))
       (null (from (path route)))
       (null (to (path route)))))

(defun vr-question-route (semantics routes)
  ;; asking a question about a route.
  (flet ((damn ()
           (log-warning :prince "Unhandled question-match: semantics ~S, routes ~S" semantics routes)
           (vr-huh nil :unknown *current-plan*)
           (return-from vr-question-route nil)))
    (cond
     ((null (cdr routes))               ; asking about a specific route
      (let ((route (car routes)))
        (cond
         ;; really only handles "is there a faster route"
         ((and (nonspecific-route-p route)
               (basic-predicates route))     ; asking a question about/comparing the displayed route, presumably.
          (let* ((pred (predicate (car (basic-predicates route))))
                 (pred-name (name pred))
                 (ss (get-plan-solution-set *current-plan*))
                 (preferred-ss (get-preferred-solution-set ss (translate-preference pred-name))))
            (if (compare-solutions-equal ss preferred-ss)
                ;; equal
                (return-from vr-question-route (vr-reject t)) ; no, the best is this one.
              (return-from vr-question-route (vr-confirm t))))) ; yes there is.
         (t
          (damn)))))
     (t
      (let* ((route (car routes))
             (predicates (basic-predicates route)))
        ;; user is presumably trying to compare some route to another.
        (if (sa-defs:tt-assert (null (cdr predicates)) () "Beyond current capabilities")
            (damn))
        (unless predicates
          (damn))                       ; no idea what they're doing.
        (let* ((pp (car predicates))
               (pred (predicate pp))
               (path1 (car (terms pp)))
               (path2 (cadr (terms pp))))
          (if (sa-defs:tt-assert (eq path1 route) () "Beyond current capabilities")
              (damn))

          ;; asking about a route (pred) than this one. Specific?
          (if (sa-defs:tt-assert (vari-p path2) () "Beyond current-capabilities")
              (damn))
        
          (let*-non-null ((plan-solution-set (get-plan-solution-set *current-plan*))
                          (question-solution-set (get-preferred-solution-set plan-solution-set 
                                                                             (proc-ss-pred-for-ps (name pred)))))
            ;; don't I need to check the sense? "Is there a faster route" and "Is that the fastest route" are different, no?
            (if (compare-solutions-equal plan-solution-set question-solution-set)
                ;; equal
                (return-from vr-question-route (vr-confirm t))
              (return-from vr-question-route (vr-reject t))))
          ;; dropped through let
          (vr-huh nil :unknown *current-plan*)))))))

(defun fixup-paths (paths)
  ;; if the path object refers to a funny quantifier, turn it into something reasonable since PS can't deal with it.
  ;; right now, only case is probably engine, so check there "Send the trains to avon and bath"
  (let ((new-paths))
    (dolist (path paths)
      (let ((engine (engine path)))
        (cond
         ((collection-p engine))        ; probably ok.
         ((and engine
               (not (engine-p engine)))
          ;; something like #<QUANTIFIER-PROP #<QUANTIFIER EVERY> #<VARI ELEM6885 vclass: :TRAIN vsort: NIL>>
          (setq path (copy-path-quantum path)) ;fresh, so we can modify.
          (cond ((and (quantifier-prop-p engine)
                      (eq (quantifier engine) (find-quantifier :forall))
                      (null (propositions engine)))
                 (setf (engine path) (progfoo (make-collection :terms (get-all-engines))
                                       (setf (collection-disjunct-p foo) nil))))
                ((and (quantifier-prop-p engine)
                      (eq (quantifier engine) (find-quantifier :every))
                      (null (propositions engine)))
                 ;; same as not having a specific engine in mind "send the engines to ..."
                 (if (collection-p *current-focus*)
                     (setf (engine path) *current-focus*)
                   (setf (engine path) nil)))
                (t
                 (log-warning :prince "Engine spec too complex, ignoring: ~S" engine)
                 (setf (engine path) nil)))) ; didn't understand (yet), so delete it.
         ((and engine
               (eql (basic-name engine) t))
          ;; didn't know which engine, so just remove it.
          (log-warning :prince "Engine spec braindead , ignoring: ~S" engine)
          (setf (engine path) nil))))                          
      (push path new-paths))
    (nreverse new-paths)))


(defun good-eval-p (sem)
  (if (eq (car sem) :very)              ; (:very ((:hi :acceptablity) :*pro*)) is "very good"
      (good-eval-p (second sem))
    (and (eq (cadr sem) :*PRO*)
         (eq (cadar sem) :acceptability)
         (member (caar sem) '( :hi :medium)))))

(defun valid-replan-object-p (ob)
  "Return non-nil if the object can be used by replan-route"
  (or (city-p ob)
      (engine-p ob)
      (and (collection-p ob)
           (every #'city-p (terms ob)))))

(defun vr-prop-of-path (properties route)
  (let ((solution-set (if (symbolp route) ; plan
                          (ps-ask-one `( :solution-set hack::?solution-set ,route) '(hack::?solution-set))
                        (create-solution-set route)))) ; route or path structure
    (cond
     ((null solution-set)
      (pop-all-recognized-objects)
      (vr-huh nil :unknown *current-plan*))
     ((member :distance properties)
      (vr-question-answer 
       route
       (list :distance (ps-ask-one `( :distance hack::?distance ,solution-set) '(hack::?distance)))))
     (t
      (log-warning :prince "vr-question-route - no option for property: ~S" properties)
      (vr-huh nil :unknown *current-plan*)))))

(defun current-rulebase-p (rulebasename)
  (equal (lymi::rulebase-name lymi::*current-rulebase*) rulebasename))
