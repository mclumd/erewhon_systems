;; Time-stamp: <Mon Jan 13 17:25:46 EST 1997 ferguson>

(when (not (find-package :context-manager))
  (load "context-manager-def"))
(in-package :context-manager)

;; Manages context related issues for the discourse manager; handles anaphoric referece and generation tasks
;; for the reference and actualization modules.

;; services: Associate NPs with list of candidate antecedents, sorted by likelihood.

;;           History list of introduced objects

;;           Sortal list for current discourse foci

;;;;;;;;;;

(defvar *cm-cf-vector* (make-array '(30) :element-type t :initial-element nil :adjustable t :fill-pointer 0))

(defvar *dc* nil "Discourse Context, used in some of the map fns to give predicate access to it.")

(eval-when (load eval)
  (add-initialization "Register :context-manager"
                      '(register :context-manager 'context-manager::process-context-manager-request)
                      () 'kqml::*register-initializations*))

(defun init-context-manager ()
  (simple-clear)
  (setf (fill-pointer *cm-cf-vector*) 0)) ; fill pointer is also uttnum (as far as we're concerned).

(defun process-context-manager-request (input)
  (debug-log :context-manager :context-manager "Command: ~W" input)
  (let* ((command (car (content input)))
         (perf (perf input))
         (args (cdr (content input)))
         (arg1 (first args))
         (arg2 (second args)))
    (progfoo (create-reply (ecase command
                             ;; true queries
                             ( :warning-frames
                               ;; arg1 is the plan
                               (tt-assert (member perf '( kqml::ask-all)) (perf)
                                          "Don't support performatives other than Ask-All on this query (yet)")
                               (unless arg2
                                 (setq arg2 :self))
                               (check-frames #'(lambda (level) (and
                                                                (or (null arg1) ; no specific plan
                                                                    ;; *dc* is the whole discourse context 
                                                                    ;; above this level.
                                                                    (equal (third (current-plan-frame *dc*)) arg1))
                                                                (or (eqmemb 'sa-defs:sa-warn level)
                                                                    (eqmemb :sa-warn level))))
                                             arg2))
                             ( :frame-type
                               (unless arg2
                                 (setq arg2 :self))
                               (let ((single-frame-search-fn
                                      (if (member perf '( kqml::ask-if kqml::ask-about))
                                          #'check-frame-one
                                        #'check-frame))
                                     (multi-frame-search-fn
                                      (if (member perf '( kqml::ask-if kqml::ask-about))
                                          #'check-frame
                                        #'check-all-frames)))

                                 (case arg1
                                   ( :warning
                                     (funcall single-frame-search-fn
                                              #'(lambda (level) (or (eqmemb 'sa-defs:sa-warn level)
                                                                    (eqmemb :sa-warn level)))
                                              arg2))
                                   ( :existance
                                     (funcall single-frame-search-fn
                                              #'(lambda (level) (and (or (eqmemb :sa-yn-question level)
                                                                         (eqmemb 'sa-defs:sa-yn-question level))
                                                                     (eqmemb :existance level)))
                                              arg2))
                                   (( :quit :restart :new-goal) ; require confirm
                                    (funcall single-frame-search-fn
                                             #'(lambda (level) (and (or (eqmemb :sa-yn-question level)
                                                                        (eqmemb 'sa-defs:sa-yn-question level))
                                                                    (eqmemb arg1 level)))
                                             arg2))
                                   ( :greet
                                     (funcall single-frame-search-fn
                                              #'(lambda (level) (eqmemb :sa-greet level))
                                              arg2))
                                   ( :error
                                     (funcall multi-frame-search-fn
                                              #'(lambda (level) (eqmemb :sa-huh level))
                                              arg2))
                                   ( :question
                                     (funcall single-frame-search-fn
                                              #'(lambda (level) (member-if #'sa-question-p level))
                                              arg2
                                              t)) ; skip last interaction
                                   ( :goal
                                     (funcall multi-frame-search-fn
                                              #'(lambda (level) (and (eqmemb :sa-elaborate level)
                                                                     (some #'(lambda (x) (and (consp x) ; not a simpler elaborate
                                                                                              (eq :goal (car x))
                                                                                              (second x)))
                                                                           (second level)))) ; semantics
                                              arg2)))))
                             ( :clear
                               (init-context-manager))
                    
                             ( :clear-error-frame
                               (clear-error-frame arg1)
                               nil)
                    
                             ( :clear-plan
                               (clear-plan arg1)
                               nil)
                    
                             ( :set-discourse-context
                               (let ((key (make-keyword (subseq (string command) 4))))
                                 (simple-replace key arg1)
                                 (simple-find key)))
                             (( :discourse-context :plandef)
                               (simple-find command))
                             ( :current-discourse-frame
                               (current-discourse-frame))
                             ( :current-plan
                               ;; find plan in the current discourse frame
                               (let ((pf (current-plan-frame)))
                                 (if pf
                                     (third pf) ; plan frame is (:plan-frame-marker ps-state plan)
                                   (cadr (kb-request-kqml (create-evaluate :self-model-kb `( :root-plan))))))) ; ps-state plan
                             ( :all-plans
                               (delete-duplicates (mapcar #'third (all-plan-frames))))
                    
                             ( :current-ps-state
                               (let ((pf (current-plan-frame)))
                                 (if pf
                                     (second pf) ; plan frame is (:plan-frame-marker ps-state plan)
                                   (car (kb-request-kqml (create-evaluate :self-model-kb `( :root-plan))))))) ;ps-state plan
                    
                             ( :plan-for-ps-state
                               (plan-for-ps-state arg1))
                    
                             ( :agents-for-plan
                               (agents-for-plan arg1))
                    
                             ( :defplan
                                 (simple-replace arg1 arg2)
                                 nil)

                             ( :push-discourse-context
                               (simple-replace :discourse-context
                                               (append (list arg1) (simple-find :discourse-context)))
                               (simple-find :discourse-context))
                    
                             ( :pop-discourse-context-to-plan
                               ;; pop the discourse context until the passed plan is current.
                               ;; unimplimented (for now)
                               )

                             (:new-sa
                              ;; update Cf and Cb
                              (vector-push-extend 
                               (nps arg1)
                               *cm-cf-vector*))))
      (unless (eq command :discourse-context) ; too big for log
        (debug-log :context-manager :context-manager "response: ~W" foo))
      )))

(defun nps (input)
  ;; objects sorted by obliqueness of grammatical relation of the subcategorized functions of the main verb
  ;; (huh? Well, see Brennan, et. all "A Centering Approach to Pronouns"
  (if (compound-communications-act-p input)
      (mapcan #'nps (acts input)) 
    (let ((obs (objects input))
          (syntax (syntax input)))
      (let ((subject (cdr (assoc :subject syntax)))
            (object (cdr (assoc :object syntax))))
        ;; make sure objects on the syntax slots we care about come first then the other obs.
        (list subject
              object
              (remove-if #'(lambda (x) (or (eq x subject) (eq x object))) obs))))))

(defun plan-frame-p (frame-entry)
  (and (consp frame-entry)
       (eq (car frame-entry) :plan-frame-marker)))

(defun current-discourse-frame ()
  (let ((context (simple-find :discourse-context))
        result
        temp)
    (block foo
      (while-not (eq (setq temp (pop context)) :frame-marker)
        (push temp result)
        (if (null context)
            (return-from foo nil))))
    (nreverse result)))

(defun current-plan-frame (&optional (dc (simple-find :discourse-context)))
  (find-if #'plan-frame-p dc))

(defun all-plan-frames ()
  (remove-if-not #'plan-frame-p (simple-find :discourse-context)))

(defun plan-for-ps-state (ps-state)
  (let ((apf (all-plan-frames))) ; plan frame is (:plan-frame-marker ps-state plan)
    (third (find ps-state apf :key #'second))))

;; plandef looks like:
#||                           (PLAN153 :GOAL
                            (:GO GO294 (:TO BOSTON) (:VIA BALTIMORE)
                             (:FROM CINCINNATI) (:AGENT ENGINE2))
                            :AGENT ENGINE2 :ACTIONS
                            ((:GO GO295 (:FROM CINCINNATI) (:TO CHARLESTON)
                              (:TRACK CHARLESTON-CINCINNATI))
                             (:GO GO296 (:FROM CHARLESTON) (:TO PITTSBURGH)
                              (:TRACK CHARLESTON-PITTSBURGH))
                             (:GO GO297 (:FROM PITTSBURGH) (:TO SCRANTON)
                              (:TRACK PITTSBURGH-SCRANTON))
                             (:GO GO298 (:FROM SCRANTON) (:TO BALTIMORE)
                              (:TRACK BALTIMORE-SCRANTON))
                             (:GO GO299 (:FROM BALTIMORE) (:TO SCRANTON)
                              (:TRACK BALTIMORE-SCRANTON))
                             (:GO GO300 (:FROM SCRANTON) (:TO NEW_YORK)
                              (:TRACK NEW_YORK_CITY-SCRANTON))
                             (:GO GO301 (:FROM NEW_YORK) (:TO BOSTON)
                              (:TRACK BOSTON-NEW_YORK_CITY)))) ||#
(defun agents-for-plan (plan)
  (let ((plandef (simple-find plan))
        temp
        result)
    (if (setq temp (extract-keyword :agent plandef))
        (push temp result))
    (dolist (e (extract-keyword :actions plandef))
      (if (setq temp (get-sslot :agent e))
          (pushnew temp result)))
    result))

;; skipone is used to keep us from matching what the user just said (if needed)
(defun check-frame (pred initiator &optional skipone)
  (some #'(lambda (level)
            (when (eq level :frame-marker)
              (return-from check-frame nil))
            (when (eq (car (last level)) initiator)
              (if skipone
                  (setq skipone nil)
                (and (funcall pred level)
                     level))))
        (simple-find :discourse-context)))

(defun check-frame-one (pred initiator &optional skipone)
  (dolist (entry (simple-find :discourse-context))
    (cond
     ((eq entry :frame-marker)
      (return-from check-frame-one nil))
     ((eq (car (last entry)) initiator)
      (if skipone
          (setq skipone nil)
        (return-from check-frame-one (and (funcall pred entry)
                                          entry)))))))

(defun check-frames (pred initiator)
  (let (result
        (*dc* (simple-find :discourse-context))) ;; do it this way so pred gets access to the current discourse context.
    (while *dc*
      (let ((entry (car *dc*)))
        (cond
         ((eq entry :frame-marker)
          (return-from check-frames (nreverse result)))
         ((and (eq (car (last entry)) initiator)
               (funcall pred entry))
          (push entry result))))
      (pop *dc*))                       ; try the next frame
    (nreverse result)))

(defun check-all-frames (pred initiator)
  (let (result)
    (dolist (entry (simple-find :discourse-context))
      (cond
       ((and (eq (car (last entry)) initiator)
             (funcall pred entry))
        (push entry result))))
    (nreverse result)))

(defun plan-error-frame-p (frame plan)
  (and (consp frame)
       (eq :sa-huh (first frame))
       (eq plan (nc-plan (third frame)))))
  
(defun clear-error-frame (plan)
  "Find any error frame(s) for the plan, and clear them. We fixed the error."
  (if (check-frame #'(lambda (f) (plan-error-frame-p f plan)) :self)
      (let* ((dc (simple-find :discourse-context))
             (current-frame (car dc)))
        (pop dc)                        ; won't be the current frame, this is what the user told us now.
        (loop
          (unless (tt-assert (not (eq (car dc) :frame-marker)) () "Bad logic in clear-error-frame, dc: ~S" dc)
            (if (plan-error-frame-p (car dc) plan) ; found it
                (return-from clear-error-frame (simple-replace :discourse-context (cons current-frame (cdr dc))))
              (pop dc)))))))            ; not it, keep trying

;; deal with discourse stack an entire meta-frame at a time.
(defmacro pop-frame (stack)
  "like pop, but pops off everything to the last frame marker as a thunk"
  (let ((result (gensym))
        (last (gensym)))
    `(progn 
       (let (( ,result ,stack)
             (,last ,stack))
         (while (and ,stack (and (not (eq (car ,stack) :frame-marker))
                                 (if (consp (car ,stack))
                                     (not (eq (caar ,stack) :frame-marker)))))
           (setq ,stack (cdr ,stack)))  ; step down stack
         ;; ok, found the breakpoint.
         (when ,stack
           (setq ,last ,stack)
           (setq ,stack (cdr ,stack))
           (setf (cdr ,last) nil))      ; break it, last entry in popped portion is the frame marker.
         ,result))))


(defun clear-plan (plan)
  "Find any frames associated with plan, and destroy them. We've undone the plan."

  ;; delete the defplan
  (simple-replace plan nil)
  
  (let ((dc (simple-find :discourse-context))
        result)
    ;; what's the current plan?
    (while dc
      (if (eq plan (third (current-plan-frame dc))) ; found it.
          (pop-frame dc)
        ;; no
        (setq result (nconc result (pop-frame dc)))))
    ;; remove any errors that snuck into the wrong frame
    (simple-replace :discourse-context (delete-if #'(lambda (frame) (plan-error-frame-p frame plan)) result))))

#||
(defun cp-test (plan dc)
  (let ((dc (copy-list dc))
        result)
    (while dc
      (if (eq plan (third (current-plan-frame dc)))
          (format t "popped: ~S" (pop-frame dc))
        (progfoo  (pop-frame dc)
          (format t "popped and saved: ~S" foo)
          (setq result (nconc result foo)))))
    result))
    ||#
