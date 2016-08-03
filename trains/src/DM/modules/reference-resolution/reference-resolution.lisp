;; Time-stamp: <Mon Jan 20 14:30:41 EST 1997 ferguson>

(when (not (find-package :reference-resolution))
  (load "reference-resolution-def"))
(in-package :reference-resolution)

(eval-when (load eval)
  (add-initialization "Register :reference"
                      '(register :reference #'reference-resolution::process-reference-resolution-request)
                      () 'kqml::*register-initializations*))

(defun get-engine-goal (engine)
  (when engine
    (let ((plan (caar (do-ps-find `(:and (:agent ,(fix-pkg (object-name engine)) hack::?plan)
                                         (:goal hack::?action hack::?plan))
                        '(hack::?action)))))
      (unless (tt-assert (and (consp plan) (eq (car plan) :go)) () "Bad plan result from PS: ~S on engine: ~S" plan engine)
        (let*-non-null ((to-slot (get-sslot :to (cddr plan))))
          (identify to-slot))))))
;;(kb-request-kqml (create-request :plan-kb `( :engine-goal ,engine)))

(defun get-last-extension ()
  (kb-request-kqml (create-request :user-model-kb '( :last-extension))))

(defun get-attempted-route ()
  (kb-request-kqml (create-request :user-model-kb '( :attempted-route))))

(defun get-objects-of-type (obtype)
  (if (eq obtype :train)
      (setq obtype :engine))
  (mapcar #'(lambda (x) (identify (car x)))
          (do-ps-find `(:type hack::?object ,obtype) '(hack::?object))))
  ;;(kb-request-kqml (create-request :plan-kb `( :find-objects-of-type ,obtype)))

(defun get-engine-positions ()
  (mapcar #'(lambda (x)
              (identify (car (do-ps-find `(:at-loc ,(fix-pkg (object-name x)) hack::?loc)
                               '(hack::?loc)))))
          (kb-request-kqml (create-request :world-kb '( :find-engines)))))
;;(kb-request-kqml (create-request :plan-kb '( :engine-positions)))

;;(REPLY :CONTENT
;; (ANSWER :RESULT (ANSWER :RESULT ((ENGINE1)) :VARS (?ENGINE)))
;; :RECEIVER REFERENCE-RESOLUTION :IN-REPLY-TO AA877)

(defun engines-at-location (at-restriction)
  (cond
   ((collection-p at-restriction)
    (mapcan #'engines-at-location (terms at-restriction)))
   ;; if the reference is just plain bogus, we get called, e.g.
   ;; (REF::ENGINES-AT-LOCATION (:DESCRIPTION (:STATUS :DIRECT) (:VAR :V11144) (:CLASS :TIME-LOC) (:SORT :INDIVIDUAL)))
   ((consp at-restriction)
    (log-warning :reference "Bogus engine restriction (engines-at-location): ~W" at-restriction)
    nil)
   (t
    (mapcar #'identify (car (do-ps-find `(:and ( :at-loc hack::?engine ,(fix-pkg (object-name at-restriction)))
                                               ( :type hack::?engine :engine))
                              '( hack::?engine)))))))

(defun engines-originally-at-location (at-restriction)
  (cond
   ((collection-p at-restriction)
    (mapcan #'engines-originally-at-location (terms at-restriction)))
      ;; if the reference is just plain bogus, we get called, e.g.
   ;; (REF::ENGINES-AT-LOCATION (:DESCRIPTION (:STATUS :DIRECT) (:VAR :V11144) (:CLASS :TIME-LOC) (:SORT :INDIVIDUAL)))
   ((consp at-restriction)
    (log-warning :reference "Bogus engine restriction (engines-originally-at-location): ~W" at-restriction)
    nil)
   (t
    (force-list (kb-request-kqml (create-request :world-kb `( :find-engine ,at-restriction)))))))

(defun cleanup-objects (input)
  ;; any path objects should be moved to the paths slot. Originally parser put it there, but this was a LF cleanup.
  ;; Eventually we should handle on the objects slot, but this is a quick hack that lets work proceed independantly.
  ;; 9/3/96 BWM
  (let (pathless-objects
        paths)
    (mapc #'(lambda (ob) (if (and (consp ob)
                                  (eq (car ob) :path)) ; found a path
                             (push ob paths)
                           (push ob pathless-objects)))
          (objects input))
    
    (setf (paths input)
      (nconc (paths input) (nreverse paths))) ; add to paths any we just found
    
    (setf (objects input)
      (mapcar #'(lambda (object)
                  (fixup-object object input))
              (nreverse pathless-objects)))))

(defun cleanup-paths (input)
  (let* (procd-paths                    ; these are for recovery of info if we find :lex-and
         current-path
         current-var
         path-list; remember the thrown value
         (engine-focus (car (member-if #'engine-ref-p (objects input))))) 
    (labels ((proc-path-entry (path-entry)
               (if (sa-defs:tt-assert (eq (car path-entry) :path) (path-entry) "Bad path entry")
                   (return-from proc-path-entry nil))
               (let ((converted-path (convert-parser-path-to-quanta
                                      (setq current-var (get-sslot :var (cdr path-entry)))
                                      (setq current-path
                                        (find-ref-if-needed (get-sslot :constraint (cdr path-entry))))
                                      engine-focus)))
                 (if (and (consp converted-path)
                          (null (cdr converted-path)))
                     (add-ref path-entry (car converted-path))
                   (add-ref path-entry converted-path))
                 (progfoo (force-list converted-path)
                   (push foo procd-paths))))) ; for recovery
      
      ;; simplify quantifiers like #<QUANTIFIER-PROP
      ;; #<QUANTIFIER EVERY> #<VARI ELEM7430 vclass: :TRAIN vsort: NIL> #<PREDICATE-PROP EQ-TO #<ENGINE ENGINE2>>>
      (progfoo (and engine-focus 
                    (set-quantifier-p engine-focus))
        (if foo
            (setq engine-focus foo)))   ; now the conjunction/disjunction specified instead of the quantifier.
               
      (setq path-list 
        (catch :split-sas               ; thrown by convert-parser-path-to-quanta if the quanta (sas) need split.
          (progn
            (setf (paths input)
              (mapcan #'proc-path-entry 
                      (paths input)))
            (ref-record-paths (paths input))
            ;; fix deferred routes that refer to these paths
            (fixup-deferred-routes)
            (return-from cleanup-paths input)))) ; return it. (normal return)
      ;; must have detected a split needed (i.e. :lex-and rule)
      (split-sas input path-list (nreverse procd-paths) current-path current-var))))

(defun split-sas (input path-list processed-paths current-path current-var)
  "the input sa has a :lex-and in a path - we want to cut at that point into multiple sas each with the partial path"
  ;; right now, path-parser only handles correctly at outermost level, so check
  
  ;; input was the original sa
  ;; path-list is where the path parser sez we should split a path
  ;; current-path is the path it was working on.
  ;; processed-paths are the paths (in the sa) that it handled without problems.
  ;; current-var is the var for the current-path
  
  (sa-defs:tt-assert (eq path-list (cdr current-path)) () "Bad assumption on placement of :lex-and")
  
  (let (result
        (remaining-paths (nthcdr (+ (list-length processed-paths) 1) (paths input))))
    
    ;; are there any paths preceeding the split?
    (when processed-paths
      ;; first guy has the ones we know about.
      (let ((new-sa (sa-defs:copy-sa input))
            (new-path (gen-path (pop path-list) current-var)))
        (push new-sa result)
        (setf (paths new-sa) (nconc processed-paths (list new-path)))
        (setf (semantics new-sa) (sub-var (semantics new-sa) current-var (get-sslot :var new-path)))))

    (while (cdr path-list)              ; handle middle paths
      (let ((new-sa (sa-defs:copy-sa input))
            (new-path (gen-path (pop path-list) current-var)))
        (push new-sa result)
        (setf (paths new-sa) (list new-path))
        (setf (semantics new-sa) (sub-var (semantics new-sa) current-var (get-sslot :var new-path)))))

    ;; pick up paths after the split, and the last one in the split.
    (let ((new-sa (sa-defs:copy-sa input))
          (new-path (gen-path (pop path-list) current-var)))
      (push new-sa result)
      (setf (paths new-sa) (cons new-path remaining-paths))
      (setf (semantics new-sa) (sub-var (semantics new-sa) current-var (get-sslot :var new-path)))
      (nreverse result))))

(defun sub-var (l old-var new-var)
  (cond
   ((eq l old-var)
    new-var)
   ((consp l)
    (mapcar #'(lambda (x) (sub-var x old-var new-var)) l))
   (t
    l)))

(defun gen-path (path-stub path-var)
  ;; take the constraint and turn into a path entry with a new var.
  
  ;; this is what a path should look like:
  ;; (:PATH (:VAR :V6456) (:CONSTRAINT (:LEX-AND (:TO :V6456 :V6464) (:TO :V6456 :V6505))))
  (let ((new-var (make-keyword (gensym "V"))))
    (labels ()
      `(:path (:var ,new-var) (:constraint ,(sub-var path-stub path-var new-var))))))

(defun cleanup-defs (input)
  (setf (defs input)
    (mapcar #'(lambda (action-entry)
                (cond
                 ((and (consp action-entry)
                       (eq (car action-entry) :prop))
                  (handle-prop action-entry))
                 ((and (consp action-entry)
                       (eq (car action-entry) :var-substitution))
                  (handle-var-substitution action-entry))
                 (t
                  action-entry)))
            (find-ref-if-needed (defs input)))))
  
(defun cleanup-semantics (input)
  (progfoo (find-ref-if-needed (semantics input))
    (setf (semantics input)
      (if (and (consp foo)
               (eq (car foo) :prop))
          (handle-prop foo)
        foo))))

(defun cleanup-speechact (input)
  (cleanup-objects input)               ; maps parser objects to kb objects. OK if already has internal objects, though.
  (let ((path-clean-input (cleanup-paths input))) ; turn path slot into path-quantaa. May split input into >1 sa!! Check.
    (cond
     ((consp path-clean-input)
      ;; just return the list, our caller will call us separately on each one (it checks)
      path-clean-input)
     (t
      (cleanup-defs path-clean-input)
      (setf (focus path-clean-input)
        (find-ref-if-needed (focus path-clean-input)))
  
      (cleanup-semantics path-clean-input)
      (setf (setting path-clean-input)
        (find-ref-if-needed (setting path-clean-input)))
      (setf (syntax path-clean-input)
        (find-ref-if-needed (syntax path-clean-input)))
      path-clean-input))))                            ; return it, it's "clean".

(defun generate-output ()
  (let ((output-sa (pop *output-sas*)))
    (cond
     ((and *output-sas* (compound-communications-act-p output-sa))
      ;; the easy case
      (setf (acts output-sa) (nconc (nreverse *output-sas*) (acts output-sa)))
      (setq *output-sas* nil))
     (*output-sas*
      (setf output-sa (make-compound-communications-act
                       :acts (nconc (nreverse *output-sas*) (list output-sa))))
      (setq *output-sas* nil)))           ; processed.
    (debug-log :reference :reference ";;Reference output: ~S" output-sa)
    (create-reply output-sa)))

(defun ref-bad (sa bad-object expected-type)
  (push (make-instance sa
          :focus *current-focus*
          :object bad-object
          :expected-type expected-type
          :initiator :me)
        *output-sas*)
  nil)

(defun ref-ambiguous (objects type)
  (ref-bad 'sa-ambiguous objects type))

(defun ref-huh (bad-object expected-type)
  (ref-bad 'sa-huh bad-object expected-type))

(let (updated-focus)
  (defun reset-focus-update-flag ()
    (setq updated-focus nil))
  (defun ref-new-focus (focus input)
    (if updated-focus
        (sa-defs:tt-assert (eq *current-focus* focus) () "Two foci from input?")
      (push (make-sa-tell :focus focus
                          :reliability (reliability input)
                          :mode (mode input)
                          :objects (list focus)
                          :defs `( :new-focus)
                          :initiator :me)
            *output-sas*))
    (setq updated-focus t)
    nil))

(defun ref-update-focus (focus input)
  (when focus
    (unless (sa-defs:tt-assert (not (consp focus)) () "bad focus: ~S" focus)
      (when (not (eq focus *current-focus*))
        (kb-request-kqml (create-request :user-model-kb `( :set-engine-focus ,focus)))
        (setq *current-focus* focus)
        (ref-new-focus focus input)))))

(defun warning-frames ()
  (let* ((entry (kb-request-kqml (create-ask-all :context-manager '( :frame-type :warning) nil)))
         (sa (third entry))
         (focus (focus sa)))
    (if (city-p focus)
        (list focus))))

(defun hack-instead-do-not-slot (instead-do-not input slot default)
  (cond
   ((city-p instead-do-not)
    (debug-log :reference :reference ";;hacking instead-do-not city as not-~A: ~S" slot instead-do-not)
    (setf (third (semantics input)) 
      (setq instead-do-not
        (make-path-quantum slot instead-do-not))))
   (instead-do-not
    (log-warning :reference ";;Didn't parse instead-not clause: ~S" instead-do-not))
   (default
       (Setf (semantics input) (list (first (semantics input))
                                     (second (semantics input))
                                     (make-path-quantum slot default))))))

(defun hack-instead (input)
  (let* ((sem (semantics input))
         (instead-do (second sem))
         (instead-do-not (third sem)))
    (unless (sa-reject-p input)
      (log-warning :reference ";;Reference: Parser screwup: :instead semantics not embedded in reject:~%;; ~S~%" input)
      (change-class input 'sa-reject))
    ;; was only the negative part specified? If so, negate.
    (when (and (null instead-do)
               (eq instead-do-not (paths input)))
      (debug-log :reference :reference ";;hacking paths to only appear on instead-do-not")
      ;;(mapc #'invert-path (paths input))
      ;;(setq instead-do (paths input))
      ;;(setq instead-do-not nil)
      ;;(setf (semantics input) (list :instead instead-do nil))
      (setf (paths input) nil))
    ;; did the user say instead of what? If not, we might have a clue from generation, or old paths.
    (when (paths input)
      ;; only handle path for now.
      (if (and instead-do-not
               (path-quantum-p instead-do-not))
          (setf (paths input) (delete instead-do-not (paths input)))
        ;; do this in ps instead, where we can make it dependant on the plan.

;        (case (path-slot-name (car (paths input)))
;          (:to
;           ;; use prior goal for this engine, if no not part
;           (hack-instead-do-not-slot instead-do-not input :to 
;                                     (unless (not-to (car (paths input)))
;                                       (unless (eq (setq temp (get-engine-goal *current-focus*)) (to (car (paths input))))
;                                         temp))))
;          (:from
;           (hack-instead-do-not-slot instead-do-not input :from
;                                     (unless (not-from (car (paths input)))
;                                       (unless (eq (setq temp (find-slot-from-history :from)) (from (car (paths input))))
;                                         temp))))
;          (:via
;           (hack-instead-do-not-slot instead-do-not input :via 
;                                     (unless (not-via (car (paths input)))
;                                       (or (warning-frames)
;                                           (find-slot-from-history :via)
;                                           (let*-non-null ((just-told-about (kb-request-kqml
;                                                                             (create-request
;                                                                              :self-model-kb
;                                                                              '( :just-told-about)))))
;                                             (mapcar #'cdr just-told-about)))))
           ))

    (when (and (not instead-do-not)
               *current-focus*
               (perf-prop-p :use instead-do)
               (engine-p (car (terms (rperf-prop-p :lobj instead-do)))))
      ;; using a different engine
      (setf (cddr sem) (list *current-focus*)))))

(defun find-slot-from-history (slotname)
  (flet ((handle-history (le)
           (if le
               (progfoo (some (case slotname
                                ( :from
                                  #'from)
                                ( :via
                                  #'via))
                              (remove-if-not #'path-quantum-p (flatten le)))
                 (when foo
                   (return-from find-slot-from-history foo))))))
    (handle-history (get-last-extension))
    (handle-history (get-attempted-route))))

(defun fix-parser-bugs (input)
  (when (and (null (focus input))
             (sa-question-p input))
    ;; question token should be the focus
    (if (sa-wh-question-p input)
        (or (setf (focus input)
              (find-if #'(lambda (x) (eq (get-sslot :status x) :wh)) (objects input)))
            (log-warning :reference
                         ";;Reference: couldn't find appropriate object to fix parser bug on unfocused wh question. (objects: ~S" (objects input)))
      (log-warning :reference ";;Reference: no rule for fixing parser bug on unfocused non-wh question."))))

(defun fixup-partial-parses ()
  "Scan the output (This is the last thing we do before returning) and see if we can collapse some acts that weren't parsed."
  ;; remember that *output-sas* is "reversed", that is, the last sa is the CAR.
  (do* ((input-sas *output-sas* (cdr input-sas))
        (current-sa (car input-sas) (car input-sas))
        (prior-sa (cadr input-sas) (cadr input-sas))
        (prior-prior-sa (caddr input-sas) (caddr input-sas))
        (output-sas nil output-sas))
      ((null input-sas) (setq *output-sas* (nreverse output-sas)))
    
    ;; if the current sa wasn't parsed, but the prior one was, append it.
    (cond 
     ((and (eq (type-of current-sa) 'speech-act)
           prior-sa
           (paths current-sa)            ; unparsed, there's a path
           (paths prior-sa))             ; there's a path there too
      (transcribe-and-log :reference "Ref: Coalescing SAs: current unparsed w/path, prior has path.")
      ;; don't record the current-sa, just modify the prior to include the path.
      (setf (paths prior-sa) (nconc (paths prior-sa) (paths current-sa))))
     ((and (eq (type-of current-sa) 'speech-act)
           prior-sa
           (paths current-sa)
           (engine-p (semantics prior-sa))) ; said an engine, then gave a path. Coalesce.
      (transcribe-and-log :reference "Ref: Coalescing SAs: current unparsed w/path, prior has engine.")
      (setf (engine (car (paths current-sa))) (semantics prior-sa))
      (setf (cdr input-sas) (cddr input-sas)) ; splice out prior
      (push current-sa output-sas))
     ((and (paths current-sa)
           prior-sa
           (eq (type-of prior-sa) 'speech-act)
           (null prior-prior-sa))       ; first sa wasn't parsed.
      (transcribe-and-log :reference "Ref: Coalescing SAs: prior unparsed w/path, current has path. No prior-prior")
      ;; record the current-sa, modifying it first.
      (setf (paths current-sa) (nconc (paths prior-sa) (paths current-sa)))
      (setf (cdr input-sas) (cddr input-sas)) ; splice it out, we're done with it.
      (push current-sa output-sas))
     ;; of course, there should be other rules here too, e.g. "I want to go to A B", 
     ;; which probably parses as the id-goal path to A, then a tell of the city B. These can be combined, but we have to
     ;; figure out the slot to attach B to, in that case (easy when it's only one, and probably can default to VIA.) 
     ;; Defer.
     (t
      (push current-sa output-sas)))))

(defvar *last-output* nil)

(defun proc-rrr-internal (input)
  (when (compound-communications-act-p input)
    ;; insert a break, before and after
    (if (and *output-sas*
             (not (sa-break-p (car *output-sas*))))
        (push (make-sa-break) *output-sas*))
    (mapc #'proc-rrr-internal (acts input))
    (push (make-sa-break) *output-sas*)
    (return-from proc-rrr-internal (values)))
  
  ;; flag noise for analysis
  (if (noise input)
      (log-warning :reference 
                   ";; ***~%;; *** WARNING: ~{~W~^, ~} are flagged as NOISE by the parser!!~%;; ***" 
                   (noise input)))
  ;; preprocess the objects in the input. This might potentially remap the input into >1 sa, so check. The resulting sa
  ;; might NOT have been completely cleaned, so call it again on the result.
  (let ((clean-input (cleanup-speechact input)))
    (cond
     ((consp clean-input)
      (mapc #'proc-rrr-internal clean-input))
     (t
      ;; fix some parser bugs
      (fix-parser-bugs clean-input)
             
      ;; handle some semantics issues that require path generation.
      (update-path-from-semantics clean-input)
             
      ;; combine setting into path, if possible.
      (update-paths-from-setting clean-input)
             
      ;; ok, that handled the cleanup, now deal with focus update
      (update-focus clean-input)
      
      ;; handle reject/request to make life easier for VR. (eventually, VR should deal with this directly).
      (if (and (sa-reject-p *last-output*)
               (symbolp (semantics *last-output*))
               (null (paths *last-output*)) ; simple reject
               (member (type-of clean-input) '(speech-act sa-tell sa-request sa-suggest sa-elaborate))) ; reject/tell.
          (change-class clean-input 'sa-reject)) ; make it a reject too... really the reject semantics (easier to track in prince).
          
      (push clean-input *output-sas*)     ; pass it on.
      (setq *last-output* clean-input)
      (values)))))

(defun process-reference-resolution-request (input)
  (debug-log :reference :reference "Command: ~W" input)
  (reset-focus-update-flag)
  (let ((*obalist* nil)
        (content (content input))         ; kqml
        (*current-focus* (ref-get-focus))
        (*last-output* nil))
    (kb-request-kqml (create-request :user-model-kb
                                     `( :set-last-mode ,(make-keyword (mode content)))))
    (if (compound-communications-act-p content)
        (mapc #'proc-rrr-internal (acts content))
      (proc-rrr-internal content))
    
    ;; check the list of SAs and combine partials when we can.
    (fixup-partial-parses)
    
    (generate-output)))
