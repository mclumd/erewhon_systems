;; Time-stamp: <Mon Jan 20 14:25:14 EST 1997 ferguson>

(when (not (find-package :generator))
  (load "generator-def"))
(in-package generator)

(eval-when (load eval)
  (add-initialization "Register :actualization"
                      '(register :actualization #'generator::process-generator-request)
                      () 'kqml::*register-initializations*))

(defun gen-priority (type)
  (cdr (assoc type *priority-alist*)))

(defun say-name (object)
  "Handle peculiarities of speech synth, and get user's name from reference module"
  (cond
   ((or (engine-p object) (eq object :engine))
    ;; user doesn't know the name of the engine
    (string-downcase (string (pick-one (kb-request-kqml (create-request :world-kb '( :engine-synonyms))))))) ; normally will get this from reference, e.g. "engine at avon."
   ((track-p object)
    (refer object))                     ; tracks don't have names.
   (t
    (substitute #\space #\_ (string-capitalize (object-name object))))))

(defun say-list (objects)
  (apply #'format nil *format-control-for-list-reference* (mapcar #'say-name objects)))

(defun definite-p (object)
  "Non-nil if we should say the foo instead of just foo. In fact, return a/an depending on vowel structure for negation."
  (cond
   ;; hack, because city names might be keywords.
   ((eq object :engine)
    "an")
   ((eq object :train)
    "a")
   ((track-p object)
    "a")
   (t
    (if (member (aref (say-name object) 0) '(#\a #\e #\i #\o #\u #\A #\E #\I #\O #\U))
        "an"
      "a"))))

(defvar *be* nil)

;;       #<OPERATOR-PROP
;;        PERF #<PREDICATE-PROP
;;               EQUAL #<OPERATOR-PROP
;;                       PERF #<PREDICATE-PROP EQUAL #> #<PREDICATE-PROP
;;                                                        AT-LOC #>>> #<PREDICATE-PROP
;;                                                                      AT-LOC { #<CITY
;;                                                                                 BURLINGTON> #<CITY
;;                                                                                               SYRACUSE>}@CONJ>>
;;      T)

(defun say-relation (relation)
  (case relation
    (( :at-loc :at)
     "at")
    ( :eq
      "")
    (t
     "related to")))

(defun say-be-quantity (object-list)
  (if (or (and (collection-p (car object-list))
               (not (endp (cdr (terms (car object-list))))))
          (not (endp (cdr object-list))))
      "are"
    "is"))

(defun refer (object &optional (referential-p t))
  (declare (optimize (speed 0) (debug 3)))
  "Generate a referring expression to the object. This should query the reference database so our expression is de dicto."
  (cond-binding-predicate-to foo
    ((collection-p object)
     (refer-list (terms object) referential-p))
    (referential-p
     (cond
      ((symbolp object)
       (format nil "~@(~A~)" (say-name object)))
      ((operator-prop-p object)
       (case (name (operator object))
         (:perf
          (mlet (success subject lcomp prop-names) (perf-be-p nil nil object)
            (cond
             (success
              (let ((*be* t))
                (format nil "~A ~A ~A ~A" 
                        (refer subject t)
                        (cond
                         ((vari-p lcomp) "is")
                         ((predicate-prop-p lcomp)
                          (say-be-quantity (terms lcomp)))
                         (t
                          (say-be-quantity (force-list lcomp))))
                        (say-relation (cadr prop-names))
                        (refer lcomp t))))
             (t
              (log-warning :actualization "Generator (perf): can't refer to ~S" object)
              "something"))))
         (t
          (log-warning :actualization "Generator (op): can't refer to ~S" object)
          "something")))
      ((predicate-prop-p object)
       (if *be*
           (format nil "~A ~A ~A"
                   (say-be-quantity (terms object))
                   (say-relation (name (predicate object)))
                   (if (endp (cdr (terms object)))
                       (refer (car (terms object)) t)
                     (refer-list (terms object) t)))
         (case (name (predicate object))
           (( :at-loc :at)
             (format nil "at ~A" (refer-list (terms object) t)))
           ( :eq
             (format nil "~A" (refer-list (terms object) t))) ; the be should already have been taken care of (??)
           (t
            (log-warning :actualization "Generator (pred): can't refer to ~S" object)))))

      ((quantifier-prop-p object)
       (case (name (quantifier object))
         ;; really need to handle differently based on distributive vs. conjunctive reading.
         (( :every :forall)
           (format nil "the ~As" (say-name (vclass (variable object)))))
         ( :exists
           (format nil "A ~A" (say-name (vclass (variable object)))))
         (t
          (log-warning :actualization "Generator (quant): can't refer to ~S" object))
         ))                             ; might be additional restrictions, but ignore for now.

      ((and (basic-kb-object-p object)
            (equal (name object) t))
       ;; need to describe it... it has no name
       (cond 
        ((eq (car (basic-noise object)) :description)
         (format nil "the ~@(~A~)" (reference-resolution::get-sslot :class (basic-noise object))))
        (t
         (format nil "the ~@(~A~)" (type-of object))))) ;; for now, hope that's enough.
      
      ((city-p object)
       (say-name object))
      
      ((engine-p object)
       ;; can introduce the name here if the user doesn't know it.
       (format nil "The engine at ~A" (refer (mobile-at object) t)))
      
      ((track-p object)
       (format nil "~@(~Atrack~) between ~@(~A~) and ~@(~A~)"
               (if (definite-p object)
                   "the "
                 "")
                  ;; say the connecting city names
               (say-name (co-loc-1 object)) (say-name (co-loc-2 object))))
      ((and (consp object)
            (eq (car object) :goal))
       (cond
        ((get-sslot :to object)
         (format nil "to ~A" (refer (get-sslot :to object) referential-p)))
        ((get-sslot :via object)
         (format nil "via ~A" (refer (get-sslot :via object) referential-p)))
        (t
         "somewhere")))
      (t
       ;; need additional information
       (log-warning :actualization "Generator: can't refer to ~S" object))))
     ((definite-p (type-of object))
      (format nil "~A ~A" foo (string-downcase (type-of object))))
     (t
      (format nil "~A" (string-downcase (type-of object))))))

(defun refer-list (objects &optional (referential-p t))
  (progfoo (cond
            ((and (consp objects)
                  (eq (car objects) :goal))
             (refer objects referential-p))
            ((> (length objects) *refer-lists-as-group*)
             (format nil "a number of ~A"
                     (cond
                      ((every #'city-p objects)
                       "cities")
                      ((every #'track-p objects)
                       "tracks")
                      ((every #'(lambda (x) (or (city-p x) (track-p x))) objects)
                       "places")
                      ((every #'engine-p objects)
                       "engines")
                      ((every #'(lambda (x) (and (consp x) (eq (car x) :goal))) objects)
                       "goals")
                      ((every #'symbolp objects)
                       (refer-list (mapcar #'(lambda (x)
                                               (kb-request-kqml (create-request :world-kb `( :identify ,x)))) 
                                           objects)
                                   referential-p))
                      (t
                       "things"))))
            (t
             (apply #'format nil
                    *format-control-for-list-reference*
                    (mapcar #'(lambda (x) (refer x referential-p)) objects))))
    (debug-log :actualization :actualization ";;Generator: List reference to ~S as ~A" objects foo)))

(defun pick-by-character (phrase-texts)
  (cond
   ((consp phrase-texts)
    (pick-one-short phrase-texts))            ; no character.
   ((stringp phrase-texts)
    phrase-texts)
   (t
    (let ((x-axis (or (if *personality*
                          (cdr (assoc *personality* *personality-alist*)))
                      0))
          (y-axis (max 0 (+ 5 (floor (/ *frustration-level* 5))))))
      (if (> y-axis 10)
          (setq y-axis 10))
      (or (cond
           ((eql (array-rank phrase-texts) 1)
            (let*-non-null ((phrase-set (aref phrase-texts x-axis)))
              (pick-one-short phrase-set)))
           (t
            (let*-non-null ((phrase-set (aref phrase-texts x-axis y-axis)))
              (pick-one-short phrase-set))))
          "")))))                        ; so we return a string
    
(defun add-gen (act priority &rest args)
  ;; if act is a say, and we didn't understand part of the input, then qualify it.
  (let ((control (car args)))
    (when (and (eq act :say) (did-huh-p))
      (let ((last-char-posn (- (length control) 1)))
        (if (member (char control last-char-posn) '(#\. #\! #\?))
            (setf control (subseq control 0 last-char-posn)))
        (setf control
          (format nil "~A; ~A" control (pick-by-character *weak-huh-texts*)))))
    (apply #'add-gen-simple act priority control (cdr args))))

(defun gen-huh ()
  (unless (did-huh-p)
    (case (kb-request-kqml (create-request :user-model-kb '( :last-mode)))
      (:spoken
       (gen-sayone :huh *spoken-huh-texts*))
      (t
       (gen-sayone :huh *written-huh-texts*)))
    (setf (did-huh-p) t)))

(defun gen-wazzawump ()
  (gen-sayone :huh *wazzawump-texts*))

(let (deferred-complaints)
  (defun gen-module-complaint-defer (module input)
    ;; gf: I think we need a list here (for gen-module-complaint-1)
    ;;(update-alist module (if (cdr (assoc module deferred-complaints))
    ;;                         (concatenate 'string (cdr (assoc module deferred-complaints)) input)
    ;;                       input)
    ;;              deferred-complaints)
    (let ((prior-complaints (cdr (assoc module deferred-complaints)))
	  (new-complaints (if (listp input) input (list input))))
      (update-alist module (append prior-complaints new-complaints)
		    deferred-complaints)))
  
  (defun gen-module-complaint (module input)
    (cond
     ((null deferred-complaints)
      (gen-module-complaint-1 module input))
     (t
      (gen-module-complaint-defer module input)
      (dolist (mi deferred-complaints)
        (gen-module-complaint-1 (car mi) (cdr mi)))))))

(defun gen-module-complaint-1 (module input)
  (let ((user-text (mapcar #'(lambda (x)
                               (case x
                                 (hack::punc-period
                                  ".")
                                 (hack::punc-comma
                                  ",")
                                 (hack::punc-question-mark
                                  "?")
                                 (t
                                  (string-downcase x))))
                           input)))
    (case module
      (:ps
       (gen-sayone :huh *ps-complaint-texts* user-text))
      (:prince
       (gen-sayone :huh *prince-complaint-texts* user-text))
      (t
       (gen-sayone :huh *internal-complaint-texts* (string-downcase (string module)) user-text)))))

(defun gen-sayone (priority texts &rest args)
  (let ((text (pick-by-character texts)))
    (unless (zerop (length text))       ; picked a non-utterance
      (apply #'gen-sayformat t priority text args))))

(defun gen-sayone-refuser (priority texts)
  (let ((text (pick-by-character texts))
        (*inhibit-refuser* t))
    (unless (zerop (length text))       ; picked a non-utterance
      (gen-sayformat t priority text (hack::user-name)))))

(defun gen-prepend-one (texts &rest args)
  (set-deferred-speech
    (format nil "~A ~?" (or *pending-speech* "") (pick-by-character texts) args)))
             
(defun gen-sayformat (simple priority control &rest args)
  (let* ((user-ref (gen-refuser)))
    (setq control
      (concatenate 'string
        (get-deferred-speech)
        (if (deferred-speech-p) " ")
        control))
    (clear-deferred-speech)
    (let* ((say-string (apply #'format nil control args))
           (last-char  (1- (length say-string)))
           (punctuation (elt say-string last-char)))
      (unless (equal user-ref "")
        (if (member punctuation '(#\? #\. #\!))
            (setq say-string
              (format nil "~A, ~A~A" 
                      (subseq say-string 0 last-char)
                      user-ref
                      punctuation))
          (setq say-string
            (format nil "~A, ~A." say-string user-ref))))
      (funcall (if simple
                   #'add-gen-simple
                 #'add-gen)
               :say
               priority
               say-string))))

(defun gen-handle-annoyance (&optional reason)
  (when *emotion-p*
    (setq *frustration-level* (kb-request-kqml (create-request :self-model-kb
                                                               `( :incf-frustration-level ,reason))))
    (unless (did-comment-p)
      (setf (did-comment-p) t)
      ;; really we should have queries for these too. Module might be on another machine.
      (gen-prepend-one *emotion-phrases*)
      (gen-evaluative-qualification))))

(defun gen-handle-appeasement (&optional reason)
  (when *emotion-p*
    (setq *frustration-level* (kb-request-kqml (create-request :self-model-kb
                                                               `( :decf-frustration-level ,reason))))

    (unless (did-comment-p)
      (setf (did-comment-p) t)
      (gen-prepend-one *emotion-phrases*))))

(defun gen-refuser ()
  (if *inhibit-refuser* ""
    (let ((fl (or (kb-request-kqml (create-request :self-model-kb '( :frustration-level))) 0)))
      (cond
       ((and (eq *personality* :abusive)
             (> fl 24))
        (generate-total-abuse :abusive))
       ((or (and (eq *personality* :respectful)
                 (< fl -4))
            (and (eq *personality* :casual)
                 (< fl -24)))
        (generate-total-abuse :respectful))
       (t
        (or (pick-by-character *user-comment*)
            ;; use their name sometimes
            (let ((foo (random 10)))
              (if (> foo 8)
                  (hack::user-name)
                (if (= foo 8)
                    (if (eql (hack::user-sex) :male)
                        "sir"
                      "ma'am"))))))))))
  
(defun gen-mentioned-highlights ()
  (let ((old-highlights (mapcar #'(lambda (x) (fix-pkg (object-name x)))
                                (kb-request-kqml
                                 (create-ask-about :display-kb
                                                   '( :current-highlights :mentioned)
                                                   :actualization)))))
    ;; unhighlight previously mentioned objects
    (dolist (ob old-highlights)
      (unless (member ob (get-highlights))
        (add-gen :unhighlight nil :mentioned ob)))
    ;; highlight any mentioned objects
    (dolist (ob (get-highlights))
      (unless (member ob old-highlights)
        (add-gen :highlight nil :mentioned ob)
        (unless (member ob (kb-request-kqml (create-request :self-model-kb
                                                            '( :mentioned-objects)))) ; if we've never mentioned it before
          (kb-request-kqml (create-request :self-model-kb `( :update-mentioned-objects ,ob))))))))


;; handles appropriate level of yes/no.

(defun gen-evaluative (type)
  (case type
    ( :good
      (gen-sayone :expressive *good-texts*)
      (set-just-did-evaluative :positive))
    ( :bad
      (gen-sayone :expressive *bad-texts*)
      (set-just-did-evaluative :negative))))

(defun gen-waffly-ack ()
  (unless (did-ack-p)
    (setf (did-huh-p) t)                ; makes it waffle, replaces later nolo, etc.
    (let ((text (pick-by-character *weak-ack-texts*)))
      (unless (zerop (length text))     ; picked a non-utterance
        (gen-sayformat nil :ack text)))))


(defun gen-ack (strong-p)
  (unless (did-ack-p)
    (gen-sayone :ack (if strong-p
                         *strong-ack-texts*
                       *weak-ack-texts*))
    (setf (did-ack-p) t)
    (set-just-did-evaluative :confirm)))

(defun gen-ack-qa ()
  (gen-sayone :ack *qa-ack-texts*)
  (setf (did-ack-p) t)
  (set-just-did-evaluative :confirm))

(defun gen-ack-request (strong-p)
  (unless (did-ack-p)
    (if (did-nack-p)
        (set-deferred-speech "Well,")
      (gen-sayone :ack (if strong-p
                           *request-responses*
                         *weak-ack-texts*)))
    (setf (did-ack-p) t)
    (set-just-did-evaluative :confirm)))

(defun gen-request-ack ()
  (unless (did-request-p)
    (gen-sayone :request-ack *request-ack-texts*)
    (setf (did-request-p) t)))

(defun gen-delay (type)
  (case type
    ( :but
      ;; add a beat to the stream
      (add-gen-simple :delay :delay 1)) ; pause a second
    ( :dramatic
      (add-gen-simple :delay :delay 2))))

(defun gen-nack (strong-p)
  (unless (did-nack-p)
    (if (did-ack-p)
        (set-deferred-speech "But,")
      (gen-sayone :nack (if strong-p
                            *strong-nack-texts*
                          *weak-nack-texts*)))
    (setf (did-nack-p) t)
    (set-just-did-evaluative :reject)))

(defun gen-nack-qa ()
  (gen-sayone :nack *qa-nack-texts*)
  (setf (did-nack-p) t)
  (set-just-did-evaluative :reject))

(defun gen-greeting (type)
  (let ((*inhibit-refuser* t))
    (if (and (null type)
             (> (kb-request-kqml (create-request :self-model-kb '( :incf-greeting-level))) 1))
        (gen-handle-annoyance "redundant greetings")
      (gen-handle-appeasement "greeting")) ; I like to be greeted.
    (if (eq type :status)
        (gen-sayone :greeting *status-texts*) ; probably want to make this depend on current emotional state.
      (gen-sayone-refuser :greeting *greeting-texts*))))

(defun gen-close ()
  (gen-handle-appeasement "finish")     ; another day over!
  (gen-evaluative :good)
  (if hack::*score-p*
      (gen-sayformat t 0 "You'll be hearing from Phenny about your score shortly.")
    (gen-sayformat t 0 "See you around."))
  (add-gen :exit nil))

(Defun gen-fake-huh ()
  (setf (did-huh-p) t)                  ; pretend, so we give qualification
  (gen-handle-annoyance "huh")
  (debug-log :actualization :actualization ";;actualization: Ignoring error, will be generating a path"))

(defvar *remaining-input* nil "Temporary")
(defvar *just-picked-colors* nil "Back end won't know about colors we're about to display.")

(defun process-generator-request (input)
  (do-log-timestamp :perf "Actualization starts")
  (debug-log :actualization :actualization "Command: ~W" input)
  (progfoo 
      (catch 'generator-toplevel
        (reset-temp-kb)
        (let ((content (content input))   ; de-kqml
              (*pending-speech* nil)
              (*confirm-state* nil)
              ;; for picking appropriate phrases.
              (*frustration-level* (or (kb-request-kqml (create-request :self-model-kb
                                                                        '( :frustration-level))) 0)) 
              (*just-picked-colors* nil)
              (*remaining-input* nil)
              (*current-plan* nil))     ; so we can track what's part of a given plan, for supression purposes.
          (kb-request-kqml (create-request :self-model-kb
                                           '( :new-generation)))
          (cond
           ((compound-communications-act-p content)
            (setq *remaining-input* (acts content))
            (while *remaining-input*    ; so we can tell we might be generating more output later.
              (cond
               ((compound-communications-act-p (car *remaining-input*))
                (shift-generation)      ; so we can tell what's part of THIS act, vs. others.
                (setq *current-plan* (plan (car *remaining-input*)))
                (setq *remaining-input* (append (acts (car *remaining-input*)) (cdr *remaining-input*))))
               (t
                (gen-handle-input (pop *remaining-input*))))))
           (t
            (gen-handle-input content)))

          ;; crosses may have changed
          (unless (did-handle-cross-p)
            (handle-cross (check-for-crossed-routes)))
          
          (gen-mentioned-highlights)
          ;; sort generation, strip out sorting information.
          (handle-output)))
    (unless (receiver foo)              ; may have gotten via throw
      (setf (receiver foo) (fix-pkg :display-manager)))
    (do-log-timestamp :perf "Actualization done")))

;; dealing with generation order, etc.

(defun add-gen-simple (act priority &rest args)
  (cond
   ((null priority)
    (setq priority (gen-priority act)))
   ((keywordp priority)
    (setq priority (gen-priority priority))))

  (let ((current-generation (get-current-generation)))
    (cond
     ((member priority '( :congested-x :cross-x)) ; appending.
      (if (second current-generation)
          (setf (fourth (last current-generation))
            (concatenate 'string (fourth (last current-generation)) " " (second args)))
        (setf (fourth current-generation)
          (concatenate 'string (fourth current-generation) " " (second args)))))
     (t
      (add-to-current-generation act priority args)))))

(defun handle-output ()
  (cond
   ((first-output-p)
    (log-warning :actualization ";;Generator: Null generation?"))
   (t
    (shift-generation)
    (create-request :display-manager (get-prior-generation-filtered)))))



