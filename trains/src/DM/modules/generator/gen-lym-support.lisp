;; Time-stamp: <Mon Jan 20 15:22:02 EST 1997 ferguson>

(when (not (find-package :generator))
  (load "generator-def"))
(in-package generator)

(eval-when (load eval)
  (define-rulebase :generate))

(defvar *input* nil)

(defun gen-handle-input (input)
  (let ((*input* input))                ; for debugging
    
    ;; for now, we invoke lymphocyte on each sa separately, as before. Eventually
    ;; we want to rewrite the rules to match across multiple speech-acts if possible, and otherwise
    ;; segement and handle each separately.
    
    ;; by default, all objects get highlighted.
    (mapc #'(lambda (x) (add-highlight x)) (objects input))
    (shift-last-evaluative)              ; so we can tell what was done last pass.
    (complete-lymphocyte :generate input)))

(defun gen-handle-new-focus (focus redundant-p remaining-input-p future-huh-p)
  ;; we generate new focus pretty easy, and don't necessarily need to ack. Esp. if we will be doing a reject.
  (let ((nack (or (did-nack-p) (did-huh-p) future-huh-p)))
    (unless nack
      (cond
       ((and redundant-p (null remaining-input-p))
        (gen-evaluative-qualification)
        (gen-sayformat nil :redundant "I already know you are talking about ~A" (refer focus t))
        (gen-handle-annoyance "redundant focus"))))
    (if (null focus)
        (log-warning :actualization "generation: no focus for elaboration"))
    (unless (or redundant-p
                (null focus))
      (add-highlight focus)             ; make sure we highlight it as mentioned.
      (add-gen :focus nil focus)
      (unless future-huh-p
        (gen-ack nil)))))

(defun gen-handle-correction ()
  (gen-nack nil)
  (log-warning :actualization "Generator: :correction not yet handled"))

(defun gen-handle-route-extension (focus elab-args redundant-p remaining-input-p future-huh-p)
  (let ((nack (or (did-nack-p) (did-huh-p) future-huh-p))) ; we might be trying to recover.
    (let* ((current-route-object
            (kb-request-kqml (create-ask-if :display-kb `( :route-with-feature :engine ,(object-name focus)))))
           (oldcolor (if current-route-object
                         (color current-route-object)))
           (color (or oldcolor
                      (progfoo (kb-request-kqml (create-ask-if :display-kb `(:new-color nil ,*just-picked-colors*)))
                        (push foo *just-picked-colors*)))))
      (cond
       ((and redundant-p oldcolor (not nack))
        (gen-evaluative-qualification)
        (gen-sayformat nil :redundant "That route is already displayed. It's the ~(~A~) one." oldcolor)
        (gen-handle-annoyance "redundant display"))
       ;; sometimes elab-args will be a spec of what was redundant
       ((and redundant-p
             (null (second elab-args)))
        ;; got a redundant constraint list.
        (gen-sayone-refuser :redundant *redundant-constraint-texts*))
       (t
        (let* ((route (first elab-args))
               (posn (second elab-args))
               (start (or (get-sslot :from (first route))
                          posn))
               (destination (if (consp (car (last route)))
                               (get-sslot :to (car (last route))) ;destination
                             (progfoo (identify (car (last route)))
                               (if (track-p foo)
                                   (setq foo (caar (do-ps-find `(:at-loc ,focus hack::?loc)
                                                     '(hack::?loc))))))))) ;; better be the current posn
          (setf (defined-route-p) t)         ; remember that we defined a route
          (add-gen :define-route
                   nil
                   (object-name focus)   ; engine
                   color
                   route
                   start
                   destination
                   *current-plan*)      ; remember route plans
          (unless current-route-object
            ;; recreate the train as colored.
            (add-gen :color-engine nil (object-name focus) color start)
            ;; since we're making progress, I'm happy.
            (gen-handle-appeasement "progress: new route"))

          (gen-ack-request (and (first-output-p) (not remaining-input-p) (not redundant-p)))

          (if (and route nack)
              (gen-request-ack))))))))         ; we aren't doing an undo ( I don't think :-), and we're correcting.

(defun gen-handle-goal (elab-args redundant-p remaining-input-p future-huh-p)
  (let ((nack (or future-huh-p (did-nack-p) (did-huh-p)))) ; we might be trying to recover.
    (remove-highlight (object-name (car elab-args))) ; don't highlight it as mentioned.
    (cond
     ((and redundant-p
           (not nack)
           (not remaining-input-p))
      (gen-sayformat nil :redundant (pick-by-character *redundant-goal-texts*) (refer (car elab-args) t))
      (gen-handle-annoyance "redundant goal"))
     ((not redundant-p)
      (add-gen :highlight nil :goal (car elab-args) *current-plan*)
      (gen-handle-appeasement "told me the goal")))
    (cond
     ((not nack)
      (gen-ack (and (first-output-p) (not remaining-input-p) (not redundant-p)))) ; ack comes after highlight
     ((and nack
           (or (not remaining-input-p)  ; should say something.
               (future-content-p)))
      (gen-waffly-ack)))))

(defun gen-handle-qa (focus yn-p elab-args redundant-p negative-p)
  (when redundant-p
    (gen-sayone :redundant *redundant-prelude-texts*)
    (gen-handle-annoyance "redundant question"))
  (cond
   (negative-p
    (gen-nack nil)
    (when focus
      (gen-sayformat nil :huh "~A~A~{ ~A~}." 
                     (format nil (pick-one '("There is not "
                                             "I can't find "))) ;; should check for vowel, too.
                     (refer focus nil)
                     (mapcar #'refer elab-args))))
   (elab-args                           ; can get empty qa's on indirect speech acts.
    (when yn-p
      (gen-ack nil))
    (when redundant-p
      (gen-sayone :redundant *redundant-prelude-texts*)
      (gen-handle-annoyance "redundant question"))
    (when focus
      (cond
       ((eq (car elab-args) :cost)
        (gen-sayone :answer *route-prop-cost-texts* (cadr elab-args)))
       ((eq (car elab-args) :time)
        (gen-sayone :answer *route-prop-time-texts* (cadr elab-args)))
       ((eq (car elab-args) :distance)
        (gen-sayone :answer *route-prop-distance-texts* (cadr elab-args)))
       ((proposition-p (car elab-args))
        (gen-sayformat nil :answer "~{ ~A~}." (mapcar #'refer elab-args)))
       (t
        (let ((refs (mapcar #'refer elab-args)))
          (gen-sayformat nil :answer "~{ ~A~}." 
                         (refer focus t)
                         (if (endp (cdr refs))
                             "is"
                           "are")
                         refs))))))))

(defun gen-apology ()
  "Kind of like a nack, but doesn't make it sound like we are rejecting the user's plan."
  (set-deferred-speech (pick-by-character *apology-texts*))
  (set-just-did-evaluative :reject))

(defun gen-evaluative-qualification ()
  (if (member (get-last-evaluative) '( :confirm :positive))
      (gen-prepend-one "But,")
    nil))

(defun gen-ambiguous (expected-type object)
  (unless (gen-evaluative-qualification)
    (gen-apology))
  (setf (did-huh-p) t)                  ; specialized says won't set this.
  ;; if it's a goal, we probably put up a solution anyway.
  (case object
    ( :goal
      (gen-sayformat t :ambiguous "I had problems picking between ~A as your goal." (say-list object)))
    ( t
      (gen-sayformat t :ambiguous "I don't know which ~A you are talking about. The ~As are ~A."
                     (string-downcase (string expected-type))
                     (string-downcase (string expected-type))
                     (say-list object))))
  (gen-handle-annoyance "ambiguous"))

(let ((congestion-warnings nil)
      (cross-warnings nil))
  (defun gen-warn (action objects delay-time defer-processing)
    ;; if there are more warnings, defer.
    (cond
     ((member action *congestion-reasons*)
      (push (list* action delay-time objects) congestion-warnings))
     ((eq action :cross)
      (push (list* action delay-time objects) cross-warnings)))
    (unless defer-processing
      (if congestion-warnings
          (handle-congestion congestion-warnings))
      (if cross-warnings
          (handle-cross cross-warnings))
      (setq congestion-warnings nil
            cross-warnings nil))))      ; clear for next time

(defun congestion-type (thingo inputs)
  (let ((res (find-if #'(lambda (x) (member thingo (cddr x))) inputs)))
    (values (first res) (second res))))

;; this is really ugly, eh? Needs to be rewritten - bwm
(defun handle-congestion (action-cities)
  ;; objects are congested cities/tracks.
  ;; remove any objects already mentioned to be congested.
  (debug-log :actualization :actualization ";; handle-congestion: ~S" action-cities)
  (let*-non-null ((congested 
                   (delete-duplicates 
                    (remove-if 
                     #'(lambda (ob)
                         (kb-request-kqml (create-request :self-model-kb
                                                          `( :told-about-p :congested ,ob))))
                     (flatten (mapcar #'cddr action-cities)))
                    :test #'equalp)))
    
    ;; don't mention them as congested again
    (mapc #'(lambda (ob)
              (kb-request-kqml (create-request :self-model-kb
                                               `( :tell-about :congested ,ob)))
              ;; probably will want to avoid by default in the future
              (if (city-p ob)           ; should avoid track too, but don't currently handle that.
                  (unless (member ob (kb-request-kqml (create-request :user-model-kb
                                                                      '( :avoided-cities))))
                    (kb-request-kqml (create-request :user-model-kb
                                                     `( :add-avoided-city ,ob))))))
          congested)

    ;; this should be handled generally (reference to sets of objects.)
    ;; (wait until it comes up again! :-)
    
    ;; base on (defs input)
    (when congested 
      (gen-evaluative-qualification)
      (mapc #'(lambda (congested-item)
                (destructuring-bind (congestion-type delay &rest locations) congested-item
                  ;; locations include those we filtered out from cingested, so refilter.
                  (setq locations (intersection locations congested))
                  (when locations
                    (let* ((track-congestion-keyword (make-keyword (format nil "TRACK-~A" congestion-type)))
                           (city-congestion-keyword  (make-keyword (format nil "CITY-~A" congestion-type))))
                      (debug-log :actualization :actualization ";; hc: congested: ~S, congested-item: ~S, congestion-type: ~S" congested congested-item congestion-type)
                      (sa-defs:tt-assert congestion-type () "bogus congestion type")
                      (gen-handle-appeasement "I know about congestion") ; I like to know more than the user.

                      (dolist (location locations)
                        (setq congested (delete location congested)) ; in case we hear about it >1ce.
                        (add-gen :highlight nil congestion-type location)
                        (typecase location
                          (track
                           (gen-sayone :congested (cdr (assoc track-congestion-keyword *congested-intro-texts*))
                                       (refer location))
                           (unless (kb-request-kqml (create-request :self-model-kb
                                                                    `( :told-about-p ,track-congestion-keyword)))
                             (kb-request-kqml (create-request :self-model-kb
                                                              `( :tell-about ,track-congestion-keyword)))
                             (gen-sayone :congested-x (cdr (assoc track-congestion-keyword *congested-texts*))
                                         (if (kb-request-kqml (create-request :self-model-kb
                                                                              `( :told-about-p ,city-congestion-keyword)))
                                             "As with congested cities, there will be a delay. "
                                           "")
                                         delay
                                         "there"
                                         )))
                          (city
                           (gen-sayone :congested (cdr (assoc city-congestion-keyword *congested-intro-texts*)) 
                                       (refer location))                     
                           (unless (kb-request-kqml (create-request :self-model-kb
                                                                    `( :told-about-p ,city-congestion-keyword)))
                             (kb-request-kqml (create-request :self-model-kb
                                                              `( :tell-about ,city-congestion-keyword)))
                             (gen-sayone :congested-x  
                                         (cdr (assoc city-congestion-keyword *congested-texts*))
                                         (if (kb-request-kqml (create-request :self-model-kb
                                                                              `( :told-about-p ,track-congestion-keyword)))
                                             "As with congested tracks, there will be a delay. "
                                           "")
                                         delay
                                         (if (endp (cdr congested))
                                             "there"
                                           (flet ((same-congestion-p (c)
                                                    (and (city-p c)
                                                         (eq congestion-type (congestion-type c action-cities)))))
                                             (cond
                                              ((every #'same-congestion-p congested)
                                               "them")
                                              (t
                                               (refer-list (remove-if-not #'same-congestion-p congested)))))))))))))))
            action-cities))))

(defun check-for-crossed-routes ()
  (mapcar #'(lambda (x)
              (cons (kb-request-kqml (create-request :world-kb `( :identify ,(car x))))
                    (cdr x)))
          (do-ps-find '(:problem :crossed-route hack::?eng hack::?loc hack::?delay hack::?other-eng)
            '(hack::?loc hack::?delay))))

(defun handle-cross (crossed)
  ;; don't mention routes that already cross.
  (setf (did-handle-cross-p) t)
  (let* ((crossed-items (delete-duplicates (mapcar #'third crossed)))
         (old-crosses (kb-request-kqml (create-ask-about :display-kb '( :current-highlights :cross))))
         (no-longer-crossed (delete nil (set-difference old-crosses crossed-items)))
         (new-crosses (delete nil (set-difference crossed-items old-crosses)))
         (unfixed-crosses (intersection crossed-items old-crosses)))
    (mapc #'(lambda (crossed-item)
              (add-gen :highlight nil :cross crossed-item))
          new-crosses)
    (mapc #'(lambda (uncrossed-item)
              (add-gen :unhighlight nil :cross uncrossed-item))
          no-longer-crossed)

    (when new-crosses
      (gen-evaluative-qualification)
      (gen-sayformat nil  :cross "Your routes cross at ~A." (refer-list new-crosses))
      (cond
       ((and (some #'track-p new-crosses)
             (not (kb-request-kqml (create-request :self-model-kb
                                                   '( :told-about-p :crossed-tracks)))))
        (gen-handle-appeasement "I know about cross")        ; I like to know more than the user.
        (kb-request-kqml (create-request :self-model-kb
                                         '( :tell-about :crossed-tracks)))
        (gen-sayformat t  :cross-x "Trains will take an additional ~D hours to move through each crossed tracks." world-kb::*congested-track-delay*)))
       
      (cond
       ((and (some #'city-p new-crosses)
             (not (kb-request-kqml (create-request :self-model-kb
                                                   '( :told-about-p :crossed-cities)))))
        (gen-handle-appeasement "I know about cross")        ; I like to know more than the user.
        (kb-request-kqml (create-request :self-model-kb
                                         '( :tell-about :crossed-cities)))
        (gen-sayformat t :cross-x "Trains will take an additional ~D hours to move through each crossed city." world-kb::*congested-city-delay*))))
    (when unfixed-crosses
      (gen-handle-annoyance "didn't fix some old cross")))) ; I already told him this was a problem. Doh!

(defun gen-bad-route (object error)
  (gen-handle-annoyance "bad route")
  (if (null object)
      (gen-wazzawump)
    (let* ((path-quantum (if (consp object) (car object) object)) ; handle multiple bad routes later.
           (from (from path-quantum))
           (not-from (not-from path-quantum))
           (to (to path-quantum))
           (not-to (not-to path-quantum))
           (via (via path-quantum))
           (not-via (not-via path-quantum))
           (use (use path-quantum))
           (engine (engine path-quantum)))
      (gen-evaluative-qualification)
      (cond
       ((eq error :bad-delete)
        (cond
         ((setq from (or from not-from))
          (setf (did-huh-p) t)
          (gen-sayone :huh *not-going-from-texts* (refer from t)))
         ((setq to (or to not-to))
          (gen-sayone :huh *not-going-to-texts* (if (consp to) (refer-list to t) (refer to t))))
         ((setq via (or via not-via))
          (setf (did-huh-p) t)
          (gen-sayone :huh *not-going-via-texts* (if (consp via) (refer-list via t) (refer via t))))
         (use
          (setf (did-huh-p) t)
          (gen-sayone :huh *not-going-using-texts* (if (consp use) (refer-list use t) (refer use t))))
         (t
          (log-warning :actualization "Unhandled bad-delete on object: ~S" object)
          (gen-wazzawump))))
       ((and (null to) from)
        (setf (did-huh-p) t)            ; specialized says won't set this.
        (gen-sayone :huh *no-destination-texts* (say-name :engine) (say-name from)))
       ((and (null from) (null engine) to)
        (setf (did-huh-p) t)            ; specialized says won't set this.
        (gen-sayone :huh *no-engine-texts* (say-name :engine) (say-name to)))
       ((and from to (eq from to))
        (setf (did-huh-p) t)            ; specialized says won't set this.
        (gen-sayone :huh *circular-route-texts* (say-name from)))
       ((and (or from engine)
             to
	     (eq error :no-route))
        (setf (did-huh-p) t)            ; specialized says won't set this.
        (gen-sayone :huh *insufficient-route-texts* (say-name from) (say-name to)))
       ((and from to)
        (setf (did-huh-p) t)            ; specialized says won't set this.
        (gen-sayone :huh *bad-route-texts* (say-name from) (say-name to)))
       (t
        ;; just do a huh; hard to say if there really was a route.
        (gen-huh))))))

(defun gen-bad-engine-location (object)
  (gen-handle-annoyance "bad engine location")
  (unless (gen-evaluative-qualification)
    (gen-apology))
  ;; gave a city, but nothing there
  (setf (did-huh-p) t)          ; specialized says won't set this.
  (let* ((ename (say-name :engine))
         (eart (if (eql (char ename 0) #\e) ; engine, or train?
                   "an"
                 "a")))
    (cond
     ((consp object) ;; descrption
      (gen-sayformat t :huh "~?~{ ~A~}." 
                     (pick-by-character *bad-engine-location-prefix*)
                     (list eart ename)
                     (mapcar #'say-name object)))
     ((and object (not (eq 't object))) ; t if it was a engine-matcher.
      (gen-sayformat t  :huh "~? at ~A." (pick-by-character *bad-engine-location-prefix*) 
                     (list eart ename)
                     (say-name object)))
     (t
      (gen-sayformat t :huh "~?." (pick-by-character *bad-engine-location-prefix*) (list eart ename))))))

(defun gen-reused-engine (object)
  (gen-handle-annoyance "engine in too many plans")
  (unless (gen-evaluative-qualification)
    (gen-apology))
  (setf (did-huh-p) t)                  ; specialized says won't set this.
  (gen-sayone :huh *multiple-use-of-engine* (refer object t)))

(defun gen-bad-goal (focus)
  (gen-handle-annoyance "bad goal")
  (gen-nack nil)
  ;; no destination city.
  (setf (did-huh-p) t)          ; specialized says won't set this.
  (if focus
      (gen-sayformat nil :huh (pick-by-character *bad-goal-texts*) (refer focus t))
    (gen-sayone :huh *no-plan-texts*)))

(defun gen-bad-constraint (focus)
  (gen-handle-annoyance "bad constraint")
  (cond
   (focus
    (gen-nack nil)
    (setf (did-huh-p) t)
    (gen-sayformat nil :huh (pick-by-character *bad-constraint-texts*) (refer focus t)))
   (t
    (gen-huh))))

(defun gen-unknown-answer (&optional thingo unimplimented)
  (gen-handle-annoyance "unknown answer")
  (cond
   (unimplimented
    (gen-sayformat nil :answer (pick-by-character *unimplimented-texts*) (refer thingo t) (refer unimplimented t)))
   (thingo
    (gen-sayformat nil :answer (pick-by-character *unknown-thingo-texts*) (refer thingo nil)))
   (t
    (gen-sayformat nil :answer (pick-by-character *unknown-answer-texts*)))))

(defun gen-too-hard-answer (type)
  (gen-handle-annoyance "too hard for me")
  (case type
    ( :question-elipsis-too-hard
      (gen-sayone :answer *eliptical-question-too-hard-texts*))))

(defun gen-restart (&optional new-scenario)
  ;;(kb-request-kqml (create-request :self-model-kb '( :clear))) ; done by vr now
  (throw 'generator-toplevel (create-request nil ; filled in later
                                             (list :restart new-scenario)))) ;; non-local exit

(defun future-act-p (pred &optional plan (ri *remaining-input*))
  (some #'(lambda (x) (or (funcall pred x)
                          (and (compound-communications-act-p x)
                               (or (null plan)
                                   (eq plan (plan x)))
                               (future-act-p pred plan (acts x)))))
        ri))

(defun future-content-p (&optional (ri *remaining-input*))
  (flet ((pred (x) (or (sa-huh-p x) (sa-nolo-comprendez-p x))))
    (notevery #'(lambda (x) 
                  (or (pred x)
                      (and (compound-communications-act-p x)
                           (not (future-content-p (acts x)))))) ;flip t value.
              ri)))

(defun future-blarfo-p ()
  (future-act-p #'(lambda (x) (or (sa-huh-p x) (sa-nolo-comprendez-p x)))))

(defun future-huh-p ()
  (future-act-p #'sa-huh-p))

(defun future-nolo-p ()
  (future-act-p #'sa-nolo-comprendez-p))

(defun future-progress-p ()
  (future-act-p #'sa-confirm-p))

(defun future-warn-p  ()
  (future-act-p #'sa-warn-p))

(defun future-reject-p ()
  (future-act-p #'(lambda (x) (or (sa-reject-p x) (sa-huh-p x) (sa-nolo-comprendez-p x)))))

(defun future-close-p ()
  (future-act-p #'(lambda (x) (and (sa-yn-question-p x) (eq (semantics x) :quit)))))

(defun future-restart-p ()
  (future-act-p #'(lambda (x) (and (sa-yn-question-p x) (eq (semantics x) :restart)))))

(defun sa-route-p (act)
  "True if the act will put up (not clear) a route"
  (and (sa-elaborate-p act)
       (if (consp (car (semantics act)))
           (some #'(lambda (x)
                     (and (eq (car x) :route-extension)
                          (cadr x)))    ; non-nil extension (not erasing)
                 (semantics act))
         (and (eq (car (semantics act)) :route-extension)
              (cadr (semantics act))))))

(defun future-route-p (plan)
  (future-act-p #'sa-route-p plan))

(defun gen-ask-about-new-goal (goals)
  (gen-sayformat t :question (pick-by-character *ask-about-new-goal-texts*) (refer-list goals)))

(defun gen-prompt ()
  (gen-sayone-refuser :question *general-prompt-texts*))

(defun gen-point (thingo)
  (add-gen :highlight nil :point thingo)
  (gen-sayone :answer *point-texts* (refer thingo t)))
