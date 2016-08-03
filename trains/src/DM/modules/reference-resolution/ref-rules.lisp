;; Time-stamp: <Mon Jan 20 14:30:05 EST 1997 ferguson>

(when (not (find-package :reference-resolution))
  (load "reference-resolution-def"))
(in-package :reference-resolution)

;; eventually, I hope to turn these into lymphocyte rules.

(defun eval-constraint (constraint &optional disjunct)
  (if (consp constraint)
      (progfoo (case (car constraint)
                 (:set-of
                  (make-collection :terms
                                   (find-ref-if-needed (delete :list
                                                               (flatten (cdr constraint))))))
                 (t
                  (log-warning :reference ";; reference, unknown constraint: ~S" constraint)
                  (return-from eval-constraint nil)))
        (if disjunct
            (setf (collection-disjunct-p foo) t)
          (setf (collection-disjunct-p foo) nil)))
    (log-warning :reference ";; reference, bad constraint: ~S" constraint)))

(defun handle-class (object &aux arg)
  (let ((class (get-sslot :class object)))
    (if (and (consp class)
             (eq (car class) :pred))
        (progfoo (make-quantifier-prop :quantifier (make-quantifier :every)
                                       :variable (setq arg (make-vari :name (get-sslot :arg class)))
                                       :propositions (force-list 
                                                      (let ((preds (handle-pred (cdr class) arg)))
                                                        (if (and (operator-prop-p preds)
                                                                 (eq (name (operator preds)) :and))
                                                            (propositions preds)
                                                          preds))))
          (let*-non-null ((type-pred (find-type-predicate (propositions foo))))
            (setf (vclass (variable foo)) (name (predicate type-pred)))
            (setf (propositions foo)
              (delete type-pred (propositions foo)))))
      
      class)))

(defun handle-pred (object argob)
  (let ((var (get-sslot :var object))
        (arg (get-sslot :arg object))
        (predclass (handle-class object))
        (constraints (get-sslot :constraint object))
        predicates)
    
    (when constraints
      (let (eq-to at)
        (msetq (eq-to at predicates)
          (handle-constraint constraints object nil (or var arg) predclass))
        (if at
            (push (list :at at) predicates))
        (if eq-to
            (push (list :eq-to eq-to) predicates))))

    (when (predicate-prop-p predclass)
      (push (handle-prop object) predicates)
      (if (endp (cdr predicates))
          (return-from handle-pred (car predicates))))
    
    (flet ((type-pred ()
             (create-predicate (make-type-predicate predclass) 
                               (list (or argob (get-sslot :arg object))) var)))
      (let ((preds (mapcar #'(lambda (pred)
                               (create-predicate
                                (make-predicate (car pred)
                                                (list-length (cdr pred)))
                                (if (and (eq (cadr pred) arg)
                                         argob)
                                    (cons argob (cddr pred))
                                  (cdr pred))))
                           predicates)))
      (progfoo (cond 
                ((null preds)
                 (if predclass (type-pred)))
                ((and (endp (cdr preds)) (null predclass))
                 (car preds))
                (t
                 (make-operator-prop :operator (find-operator :and)
                                     :noise object ; makes it easier to debug too
                                     :parser-token var
                                     :propositions (if predclass
                                                       (cons (type-pred) preds)
                                                     preds))))
        (if var
            (add-ref object foo)))))))

;; hc- functions are part of handle-constraint, separated by case for clarity
(defun hc-and (pred-entry object input var obtype)
  (let (eq-to at predicates)
    (mapc #'(lambda (x) 
              (mlet (leq lat lpred)
                  (handle-constraint x object input var obtype)
                (setq eq-to (combine-evidence leq eq-to))
                (setq at (combine-evidence lat at))
                (setq predicates (nconc lpred predicates)))) 
          (cdr pred-entry))
    (values eq-to at predicates)))

(defun hc-other (pred-entry object input var obtype)
  (declare (ignorable input var pred-entry))
  (let ((objects (get-objects-of-type obtype))
        eq-to)
    (case obtype
      (( :engine :train)
       (setq objects (remove (object-name *current-focus*) objects :test #'equal :key #'object-name))
       (cond
        ((null (cdr objects))
         (ref-update-focus (car objects) input)
         (kb-request-kqml 
          (create-request :user-model-kb
                          `( :set-reference-pattern ,(object-name *current-focus*) ,object :engine)))
         (setq eq-to *current-focus*))
        (t
         (ref-ambiguous objects obtype))))
      (( :destination :goal)
       (let ((current-positions (get-engine-positions)))
         (setq eq-to (make-collection :terms  (remove-if #'(lambda (x)
                                                             (member x current-positions :test #'eq))
                                                         objects)))
         (setf (collection-disjunct-p eq-to) nil)))
      (t
       (log-warning :reference "Reference: :other not handled on type ~S" obtype)))
    eq-to))

(defun hc-lambda (pred-entry object input var obtype)
  (declare (ignore var input))
  (let ((current-const  (find-ref-if-needed (caddr pred-entry)))
        eq-to at predicates)
    (case (car pred-entry)
      ( :eq ;; definition.
        (setq eq-to (eval-constraint current-const)))
      (( :assoc-with :at :at-loc :poss-by) ;; e.g. the montreal train
        (cond
         ((member obtype (kb-request-kqml (create-request :world-kb '( :engine-synonyms))))
          (let (result-engs)
            (labels ((handle-eng (current-const)
                       (cond-binding-predicate-to foo
                         ((engines-at-location current-const)
                          (setq result-engs (nconc result-engs foo)))
                         ((engines-originally-at-location current-const)
                          (setq result-engs (nconc result-engs foo)))
                         (t
                          (push (cons (car pred-entry) (find-ref-if-needed (cddr pred-entry))) predicates)))))
              (if (collection-p current-const)
                  (mapc #'handle-eng (terms current-const))
                (handle-eng current-const))
              (when result-engs
                (if (and (consp result-engs) (endp (cdr result-engs)))
                    (setq eq-to (car result-engs))
                  (setq eq-to (make-collection :terms result-engs :flags 0)))))))

         ((member obtype '( :congestion :problem))
          (setq at current-const))
         (t
          (log-warning :reference ";;RR: don't know how to handle ~S on ~S, obtype ~S:" pred-entry object obtype)
          (setq at current-const))))
      ( :from
        (unless at ; don't override an existing at.
          (setq at current-const)))
      ( :one-of
        ;; hmm. Member. Check to see if the second arg is a list, and if so process it.
        (setq eq-to (eval-constraint (caddr pred-entry) t)))
      (t
       (cond
        ((consp (car pred-entry)) 
         ;; comparative?
         (cond
          ((member (caar pred-entry) '( :less :more :equal :min :max))
           (push pred-entry predicates))
          ;; special case some disjunctions
          ((equalp (car pred-entry) '( :or :previous :final)) ;; "the last train", "the last city", etc.
           (push pred-entry predicates))
          (t ;; ignore it, it's ill-formatted
           (log-warning :reference ";;Reference: Ignoring ill-formatted predicate entry~%;; ~S of object ~S" pred-entry object))))
        ((and (consp (caddr pred-entry)) ; third, e.g. (:lcomp <var> (:pred ...))
              (eq :pred (caaddr pred-entry)))
         (push (list (car pred-entry) (cadr pred-entry) (handle-pred (caddr pred-entry) (cadr pred-entry))) predicates))
        (t
         (push pred-entry predicates)))))
    (values eq-to at predicates)))

(defun handle-constraint (pred-entry object input var obtype)
  (cond
   ((not (consp pred-entry))
    (log-warning :reference ";;Reference: Bogus entry ~S~%;; of object ~S~%;; ignoring it" pred-entry object))
     
   ((eq (car pred-entry) :and)
    (hc-and pred-entry object input var obtype))

   ((and (eq (car pred-entry) :other)
         (eq (cadr pred-entry) var))
    (hc-other pred-entry object input var obtype))
     
   ((and (consp (car pred-entry))
         (eq (second (car pred-entry)) :of)) ; e.g. :goal-of, :destination-of
    ;;((:DESTINATION :OF) (:*PRO* (:OR :ROUTE :TRANS-AGENT)) :V5517)
    ;; we can safely ignore for now... captured by other if present.
    (values nil nil (list pred-entry)))

   ((and (or (eq var (cadr pred-entry))  ;; car is a predicate.
             (eq (car object) :var-substitution))) ; really a lambda
    (hc-lambda pred-entry object input var obtype))
   ((eq (car pred-entry) :preference)
    ;; need to slap it onto the paths
    (let ((pref (proc-ss-pred-for-ps (cadr pred-entry)))
          (lcomp (get-sslotn :lcomp (get-sslot :constraint (cdr object)))))
      ;; path quantum should be on the object we're dealing with
      ;;  (:PROP (:VAR :V9550) (:CLASS :GO-BY-PATH) (:CONSTRAINT (:AND #1# (:LSUBJ :V9550 :*YOU*) 
      ;;      (:LCOMP :V9550 #<PATH-QUANTUM #<CITY BURLINGTON> -> #<CITY CHARLOTTE> >)))
      (if (path-quantum-p (second lcomp))
          (setf (preferences (second lcomp))
            (nconc (list pref) (preferences (second lcomp)))))))
   (t
    (log-warning :reference ";;Reference: don't really know how to handle entry~%;; ~S of object ~S" pred-entry object)
    (values nil nil (list pred-entry)))))

(let (deferred-routes)
  (defun clear-deferred-routes ()
    (setq deferred-routes nil))
  (defun fixup-route (route)
    (push route deferred-routes))
  (defun fixup-deferred-routes ()
    (dolist (route deferred-routes)
      (fixup-route-later route))
    (setq deferred-routes nil))
  (defun fixup-route-later (route)
    ;; is it funny?
    (let ((pathob))
      (cond
       ((some #'(lambda (x) (and (eq (name (predicate x)) :path)
                                 (setq pathob (find-ref-if-needed (cadr (terms x))))
                                 (or (setf (basic-predicates route)
                                       (delete x (basic-predicates route)))
                                     t))) ; force or to t
              (basic-predicates route))
        (setf (path route) pathob))
       (t
        (let* ((to-pred (find-predicate 'to))
               (to-pred-prop (find-if #'(lambda (prop) (eq (predicate prop) to-pred)) (basic-predicates route)))
               (from-pred (find-predicate 'from))
               (from-pred-prop (find-if #'(lambda (prop) (eq (predicate prop) from-pred)) (basic-predicates route))))
          ;; if we are creating a route, and one of the predicates is TO, then stuff it in.
          ;; (#<PREDICATE-PROP TO #2# #3#>)
          (when (or to-pred-prop from-pred-prop)
            (setq pathob (make-path-quantum))
            (when to-pred-prop
              (setf (to pathob) (second (terms to-pred-prop)))
              (setf (basic-predicates route) (delete to-pred-prop (basic-predicates route))))
            (when from-pred-prop
              (setf (from pathob) (second (terms from-pred-prop)))
              (setf (basic-predicates route) (delete from-pred-prop (basic-predicates route))))
            (setf (path route) pathob)))))
      route)))


(defun handle-reference-common (object input caller-name)
  (flet ((barf ()
           (log-warning :reference "~A: object ~S not handled" caller-name object)))
    (catch :no-such-object
      (let ((constraint (get-sslot :constraint object))
            (var (get-sslot :var object))
            (obtype (handle-class object)))
        (mlet (eq-to at predicates)
            (when constraint
              (handle-constraint constraint object input var obtype))
          (case (get-sslot :sort object)
            (:individual
             (cond
              ((and (member obtype '( :engine :plane :train))
                    (not (or eq-to at predicates))
                    (ref-get-focus)
                    (or (null (paths input))
                        (not (get-sslot :from (get-sslotn :constraint (car (paths input))))))) ; let that override
               (add-ref object (ref-get-focus))
               (ref-get-focus)) ; just return the focused engine
              ((and eq-to (if (consp eq-to) (null (cdr eq-to)) t))
               (add-ref object (if (consp eq-to) (car eq-to) eq-to))
               (if (consp eq-to) (car eq-to) eq-to))
              (t
               (let* ((itype (object-type-for-obtype obtype))
                      (new (make-instance itype
                             (if (eq itype 'route)
                                 :start ; routes are funny
                               :at) (let ((r (find-ref-if-needed at)))
                                      (unless (and (consp r) (eq (car r) '*pro*))
                                        r))
                               :predicates (mapcar #'(lambda (x) (create-predicate
                                                                  (make-predicate (car x) (list-length (cdr x)))
                                                                  (cdr x)))
                                                   (nconc (find-ref-if-needed predicates)
                                                          (if eq-to
                                                              (list (list :member eq-to)))))
                               :noise object)))
                 (if (eq itype 'route)
                     (setq new (fixup-route new)))
                 (kb-request-kqml (create-request :user-model-kb
                                                  `( :set-reference-pattern ,(object-name new) ,object ,itype)))
                 (add-ref object new)
                 new))))
          
            (:set
             (cond
              (eq-to
               (add-ref object eq-to)   ; simple collection
               eq-to)                     
              ((eq (car (get-sslot :class object)) :pred)
               (add-ref object obtype)
               obtype)
              (t
               (barf))))
          
            (:stuff                     ; mass noun
             (cond-binding-predicate-to time
              (eq-to
               (add-ref object eq-to)
               eq-to)
              (at
               ;; see if we can find the object at the location
               (log-warning :reference "No way to query PS for ~S at ~S" object at)
               (add-ref object obtype)) ; eh, not so hot, but it's something.
              ((some #'(lambda (c) (if (eq (car c) :time-duration) c)) predicates)
               ;; setting a time duration, so use that.
               (add-ref object (list :time-duration (third time))))
              (t
               (add-ref object obtype)
               obtype)))
          
            (t
             (barf))))))))

(defun handle-definite-reference (object input)
  (handle-reference-common object input "definite reference"))

(defun handle-indefinite-reference (object input)
  (handle-reference-common object input "indefinite reference"))

;; mpp because it does make-predicate-prop
(defun mpp (pred object var class)
  (mlet (eq-to at predicates) (handle-constraint pred object nil var class)
    (if at
        (push (list :at nil at)
              predicates))
    (if eq-to
        (push (list :eq-to nil eq-to)
              predicates))
    (mapcar #'(lambda (x) (create-predicate (make-predicate (car x) (list-length (cddr x)))
                                            (cddr x)))
            (find-ref-if-needed predicates))))

(defun mpp-be (pred object var class)
  (mlet (eq-to at predicates) (handle-constraint pred object nil var class)
    (if at
        (push (list :at at)
              predicates))
    (if eq-to
        (push (list :eq-to eq-to)
              predicates))
    (mapcar #'(lambda (x) (create-predicate
                           (make-predicate (car x) (list-length (cdr x)))
                           (if (and (eq (car x) :lcomp) (consp (third x)))
                               (list (create-predicate (make-predicate (caaddr x)
                                                                       (list-length (cdaddr x)))
                                                       (cdaddr x)))
                             (cddr x)))) ; was (if be-p (cdr x) (cddr x))
            (find-ref-if-needed predicates))))

(defun handle-equal (object)
  (let ((constraint (get-sslot :constraint object))
        (var (get-sslot :var object)))
    (if (tt-assert constraint () "Bad constraint for handle-equal")
        (return-from handle-equal nil))
    (progfoo (make-operator-prop :operator (make-operator :perf 2)
                                 :noise object
                                 :parser-token var
                                 :propositions (list
                                                (make-operator-prop :operator (make-operator :and 2)
                                                                    :propositions 
                                                                    (mpp constraint object var :equal))))
      (if var
          (add-ref object foo)))))

(defun mop (condpred var be-p object class operator-args)
  (list (make-operator-prop :operator condpred
                            :parser-token var
                            :propositions (mapcan #'(lambda (x) (if be-p
                                                                    (mpp-be x object var class)
                                                                  (mpp x object var class)))
                                                  operator-args))))

(defun handle-prop (object)
  (let* ((constraint (get-sslot :constraint object))
         (class (handle-class object))
         (var (get-sslot :var object))
         (be-p (eq class :be)))
    
    ;; deal with equal specially
    (if (eq class :equal)
        (handle-equal object)
      (progfoo (make-operator-prop :operator (make-operator :perf 2)
                                   :noise object
                                   :parser-token var
                                   :propositions (list*
                                                  (or (predicate-prop-p class)
                                                      (create-predicate (make-type-predicate class) nil))
                                                  (cond-binding-predicate-to condpred
                                                    ((null constraint)
                                                     (return-from handle-prop (handle-pred object nil)))
                                                    ((find-operator (car constraint))
                                                     ;; yep
                                                     (mop condpred var be-p object class (cdr constraint)))
                                                    (be-p
                                                     (mpp-be constraint object var class))
                                                    (t
                                                     (mpp constraint object var class)))))
        (setf (terms (car (propositions foo))) (list foo)) ; self reference for event-state predicate.
        (if var
            (add-ref object foo))))))

(defun handle-name (object)
  (progfoo (kb-request-kqml (create-request :world-kb `( :identify ,(get-sslot :lex object))))
    (cond
     ((null foo)
      (debug-log :reference :ref "Reference: no such foo in world: ~S" object)
      (setq foo  (get-sslot :lex object))
      (add-ref object foo))             ; add it anyway (robust!)
     (t
      (add-ref object foo)
      (setf (basic-noise foo) object))))) ; yeah, destructive. Don't count on it's having a particular value!

(defun handle-wh (object)
  (progfoo (make-vari :vsort (get-sslot :sort object)
                      :vclass (get-sslot :class object)
                      :name (get-sslot :lex object))
    (add-ref object foo)))

(defun handle-pro (object)
  (progfoo (find-ref-if-needed (get-sslot :lex object))
    (add-ref object foo)))

(defun fixup-object (object input)
  "Called on each object in the objects slot: these are the NPS the parser found"
  (if (consp object)
      (case (get-sslot :status object)
        (( :definite :this :that) ;; definite reference
         (handle-definite-reference object input)) ; may need to recover other info.
        ( :name
          (handle-name object))
        ( :pro
          (handle-pro object))
        ( :wh
          (handle-wh object))
        (( :indefinite :existential)
         (handle-indefinite-reference object input))
        (t
         (cond
          ((equal (get-sslot :status object) '( :how :much))
           ;; treat it like a :wh, e.g. "how far is it X" is like "what is the distance X"
           (handle-wh object))
          (t
           (add-ref object object)
           object))))                   ; couldn't simplify
    ;; already processed, presumably, due to splitting
    object))

(defun handle-var-substitution (entry)
  (mlet (eq-to at predicates)
      (handle-constraint (get-sslot :value entry) entry nil (get-sslot :var entry) (handle-class entry))
    (if at
        (setq predicates (list :at at)))
    (if eq-to
        (setq predicates (list :eq-to eq-to)))
    (add-ref entry predicates)
    predicates))

(defun handle-naked-np (input)
  (let ((sem (semantics input)))
    (let*-non-null ((discourse-frame (kb-request-kqml (create-request :context-manager
                                                                      '( :current-discourse-frame))))
                    (huh-sa (find-if #'sa-huh-p discourse-frame)))
      ;; if there's a huh in the first frame, consider this the answer.
      (debug-log :reference :ref ";;reference: found sa-huh frame for role filler: ~S" huh-sa)
      ;; if we asked it as a question, then turn it into a tell.
      (if (sa-question-p input)
          (change-class input 'sa-suggest))
      (case (expected-type huh-sa)
        (:no-route
         (let ((path-q (car (object huh-sa))))
           (cond ((and (null (to path-q))
                       (city-p sem))
                  ;; missing the to slot.
                  (setf (paths input) (list (copy-path-quantum path-q)))
                  (setf (to (car (paths input))) sem))
                 ((and (null (from path-q))
                       (null (engine path-q))
                       (city-p sem))
                  ;; missing from slot.
                  (setf (paths input) (list (copy-path-quantum path-q)))
                  (setf (from (car (paths input))) sem))
                 ((and (null (from path-q))
                       (null (engine path-q))
                       (engine-ref-p sem))
                  ;; missing engine slot.
                  (setf (paths input) (list (copy-path-quantum path-q)))
                  (setf (engine (car (paths input))) sem))
                 ((city-p sem)
                  ;; must be a via (insufficient route).
                  (setf (paths input) (list (copy-path-quantum path-q)))
                  (push sem (via (car (paths input)))))
                 (t
                  (log-warning :reference ";;Reference: unresolved naked object (nonresponsive), huh from route.: ~S" sem)))))
        (:engine
         ;; gave a city, but nothing was there. Alternate city?
         (cond
          ((city-p sem)
           (setf (paths input) (list (make-path-quantum :from sem))))
          ((engine-ref-p sem)
           (setf (paths input) (list (make-path-quantum :engine sem))))
          (t
           (log-warning :reference ";;Reference: unresolve naked object (nonresponsive), huh from engine.: ~S" sem)))) ;; hmm, is this right?
        (:goal
         ;; no destination.
         (cond
          ((city-p sem)
           (setf (paths input) (list (make-path-quantum :to sem))))
          (t
           (log-warning :reference ";;Reference: unresolve naked object (nonresponsive), huh from goal.: ~S" sem))))
        (t
         (log-warning :reference ";;Reference: unresolved naked object (nonresponsive), huh from back end.: ~S" sem))))))

(defun update-path-from-semantics (input)
  (let ((sem (semantics input)))
    (cond
     ((and (basic-kb-object-p sem)      ; just mentioned a city, or an engine.
           (null (paths input)))
      ;; see if it was an answer to a question, and if so, turn it into something more complete.
      (handle-naked-np input))
     ((symbolp sem))                    ; nothing to do
     ((and (consp sem) (eq (car sem) :instead))
      (hack-instead input))
                
     ((perf-prop-p :restart sem)
      (unless (perf-prop-p :not sem)
        (change-class input 'sa-restart)))
                
     ((or (perf-prop-p '( :again :start) sem) ; try again
          (perf-prop-p '( :again :try-solve) sem))
      (unless (perf-prop-p :not sem)
        (change-class input 'sa-reject)))
                
     ((perf-be-p :welcome :you sem)     ; you're welcom
      (change-class input 'sa-expressive)
      (if (perf-prop-p :not sem)
          (setf (semantics input) :not-be-welcome)
        (setf (semantics input) :be-welcome)))
                
     ((perf-be-p :at-loc nil sem)
      ;; fill in the at slot for the refereced train, if it's possible.
      (mlet (ignore at-loc args) (perf-be-p :at-loc nil sem)
        (declare (ignorable ignore at-loc))
        (destructuring-bind (engine location) args
          (when (engine-p engine)
            (unless (tt-assert (null (mobile-at engine)) () "Reference: Bad engine NP for be-at")
              (setf (mobile-at engine) location))))))
                
     ((or (and (perf-prop-p :not sem)
               (perf-prop-p :depart sem))
          (some #'not-beyond  (paths input))
          (and (perf-prop-p :not sem)
               (some #'beyond (paths input))))
      (log-warning :reference "Changing semantics as a temporary hack to cancel on ~S" input)
      (change-class input 'sa-reject)
      (setf (paths input) nil)
      (setf (semantics input) :cancel))

     ((and (perf-prop-p :not sem)
           (or (perf-prop-p :move sem)
               (perf-prop-p :go-by-path sem)
               ;; may be insufficient, since "I don't want to go on from new york" 
               ;; really means we have to match with the route, and undo the specific extensions. 
               ;; So, try to update the verbal reasoner too (reminder).
                          
               ;; not to mention "don't go by avon" might not be marked as a reject, we need to check to
               ;; see if we are currently going via avon.
               (and (perf-prop-p :want-need sem) ;; I don't want 
                    (paths input))))
      ;; there is a path, and we are inverting it...
      (mapc #'invert-path (paths input)) ; destructive
      ;; if there are now no positives, make sure this is a reject act.
      (unless (or (some #'(lambda (p) (or (to p) (via p) (from p))) (paths input))
                  (sa-reject-p input))
        (change-class input 'sa-reject)))
     
     ;; ultimately, this should turn into a not-beyond, but for now, deal with all these as simple cancels.
                
     )))

(defun update-focus (input)
  (let* ((paths (paths input))
         (engine-np (find-if #'engine-ref-p (objects input)))
         (at-restr (when engine-np
                     (cond ((engine-p engine-np)
                            (or (mobile-at engine-np)
                                (get-sslot :from (basic-predicates engine-np))))
                           ((perf-be-p :at-loc nil (semantics input))
                            (mlet (ignore at-loc args) (perf-be-p :at-loc nil (semantics input))
                              (declare (ignorable ignore at-loc))
                              (destructuring-bind (engine location) args
                                (if (eq engine-np engine)
                                    location))))))))
    (when (and engine-np                ; ok, does the user mention an engine?
               (or (and (engine-p engine-np)
                        (basic-predicates engine-np))
                   at-restr))
      ;; yep. Change the focus. Figure out which engine.
      ;; some duplication with reference, which would have detected this for paths.
      (progfoo (or at-restr (if (engine-p engine-np) (get-sslot :from (basic-predicates engine-np))))
        (if (and foo (not (vari-p foo)))
            (let*-non-null ((engine (ref-find-engine engine-np foo input)))
              (if (tt-assert (not (consp engine)) (engine) "Bad result from ref-find-engine: ~S" engine)
                  (setq engine (car engine)))
              (ref-update-focus engine input) ;; if found
              ;; make sure focus is right. Note this assumes all paths are refering to the same engine, which may not be the case.
              ;; but the notion of focusing on one engine then referring to the other is awkward. (On the other hand, this
              ;; code currently only handles a single engine-np too :-).
              (mapc #'(lambda (x) (setf (engine x) engine)) paths)))))))

(defun update-paths-from-setting (input)
  (when (path-quantum-p (setting input))
    (let ((new-path (remove (setting input) (paths input))))
      (if (and new-path (combine-quanta (car new-path) (setting input)))
          (setf (paths input) new-path) 
        nil)))) ; can't combine, so leave alone.

