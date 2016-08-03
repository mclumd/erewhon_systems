;; Time-stamp: <Mon Jan 13 17:22:39 EST 1997 ferguson>

(when (not (find-package :verbal-reasoner))
  (load "verbal-reasoner-def"))
(in-package verbal-reasoner)

(defparameter *existance-non-responsive-rejects* '( :oops :nevermind :forget-it)
  "These rejects are never in response to an existance frame, e.g. are you there, but should have their undo interpretation")

(defvar *current-focus* nil "the environmental focus (train for now)")
(defvar *discourse-context* nil "The envionmental discourse context")
(defvar *focus-changed* nil "Environmental: Set non-nil if invoking focus rules changes the focus")
(defvar *engine-synonyms* nil "Environmental: set to list of engine synonyms")
(defvar *all-engines* nil "Environmental: set to list of all known engines")
(defvar *current-plan* nil "Environmental: set to (discourse presumed) current plan")
(defvar *current-input* nil "Environmental: used to deal with errors (add to response)")
(defparameter *parser-problem-threshold* 89 "If reliability of sa is over this number, complain about module, not user.")

(defun get-slot (slotname slotlist)
  (let*-non-null ((foo (position slotname (flatten slotlist))))
    (nth (1+ foo) slotlist)))

;; how's this for encapsulation. Not reentrant, but not a global. Which is better?
;; well, this is certainly easier to move to a thread based kb, so I argue this is, since we can then
;; make the code reentrant with respect to these flags and other items easily.

(build-simple-pred reject-handled)
(build-simple-pred prior-reject)
(build-simple-pred handling-reject)
(build-simple-pred handling-question)
(build-simple-pred focus-changed)
(build-simple-pred did-close)

(build-stack-pred remaining-acts)
(build-stack-pred did-undo)

(defun clear-kb ()
  (clear-reject-handled)
  (clear-prior-reject)
  (clear-handling-reject)
  (clear-handling-question)
  (clear-did-undo)
  (clear-focus-changed)
  (clear-did-close)
  
  (clear-remaining-acts))
  
;; for output preparation

(build-stack-pred response-route)
(build-stack-pred recognized-objects pushnew)

(build-value-pred ps-state)
(build-value-pred plan)
(build-value-pred action)
(build-value-pred request-error)

(build-commitment-pair proposed-state new-state pushnew)
(build-commitment-pair proposed-sas output-sas)

(defun clear-output-queue ()
  (clear-response-route)
  (clear-recognized-objects)
  (clear-ps-state)
  (clear-plan)
  (clear-action)
  (clear-request-error)
  (clear-proposed-state)
  (clear-new-state)
  (clear-proposed-sas)
  (clear-output-sas))

(let ((sub-sas))
  (defun open-sub-sa ()
    (if sub-sas
        (close-sub-sa)))
  (defun push-sub-sa (sa)
    (push sa sub-sas))
  (defun close-sub-sa ()
    (if sub-sas
        (push-output-sas (make-compound-communications-act :acts sub-sas)))))
       
(defun clear-ps (&optional (requestor kqml:*kqml-recipient*)) ; who am I?
  (let* ((kqml:*kqml-recipient* (fix-pkg requestor))
         (kqml:*kqml-sender* 'hack::ps) ; set up for result
         (engines (kb-request-kqml (create-request :world-kb '( :find-engines))))
         (tracks (kb-request-kqml (create-request :world-kb '( :all-tracks))))
         (cities (kb-request-kqml (create-request :world-kb '( :all-cities))))
         (reply-with (gentemp "CPS" user::*hack-package*))
         result)

    (clear-root-plan)
    (kb-request-kqml (create-request :context-manager '( :clear)))
    (kb-request-kqml (create-request :user-model-kb '( :clear)))
    (kb-request-kqml (create-request :self-model-kb '( :clear)))
    
    (setq result
      (kb-request-kqml
       (create-request
        :ps 
        (list :new-problem              ; use new-scenario and more complete map stuff shortly.
              :content
              (copy-tree                ; prevent print-circle problems
               `(:and 
                 ,@(append
                    (mapcan #'(lambda (city)
                                (if (city-congested-p city)
                                    `((:and (:type ,(fix-pkg (basic-name city)) :city)
                                            (:DELAY ,(congestion-reason city)
                                                    ,(fix-pkg (basic-name city))
                                                    ,(cdr (assoc (congestion-reason city)
                                                                 world-kb::*city-congestion-delay-alist*)))))
                                  `((:type ,(fix-pkg (basic-name city)) :city))))
                            cities)

                    (mapcar #'(lambda (engine)
                                `(:and (:type ,(fix-pkg (basic-name engine)) :engine)
                                       (:at-loc ,(fix-pkg (basic-name engine))
                                                ,(fix-pkg (basic-name (kb-request-kqml 
                                                                       (create-request :world-kb `( :engine-location ,engine))))))))
                            engines)
                     
                    (mapcan #'(lambda (track)
                                (let ((name (fix-pkg (basic-name track))))
                                  (if (track-congested-p track)
                                      `((:and (:type ,name :track)
                                              (:connection ,name 
                                                           ,(fix-pkg (co-loc-1 track))
                                                           ,(fix-pkg (co-loc-2 track))
                                                           :train ; class
                                                           ,(co-distance track)
                                                           ,(co-cost track))
                                              (:DELAY ,(congestion-reason track) 
                                                      ,name
                                                      ,(cdr (assoc (congestion-reason track)
                                                                   world-kb::*track-congestion-delay-alist*)))))
                                    `((:and (:type ,name :track)
                                            (:connection ,name 
                                                         ,(fix-pkg (co-loc-1 track))
                                                         ,(fix-pkg (co-loc-2 track))
                                                         :train ; class
                                                         ,(co-distance track)
                                                         ,(co-cost track))))))) ; time
                            tracks)))))
        (fix-pkg requestor)
        reply-with)))
    (if (and result (extract-keyword :plan-id result))
        (kb-request-kqml
         (create-request :self-model-kb `( :set-root-plan (,(extract-keyword :ps-state result)
                                                           ,(extract-keyword :plan-id result))) requestor)))))


(let (root-plan)                        ; cache
  (defun clear-root-plan ()
    
    (setq root-plan nil))
  (defun root-plan ()
    "The grandfather plan node in the PS. Used when we don't know where to attach."
    (or root-plan
        (setq root-plan (second (kb-request-kqml 
                                 (create-request :self-model-kb '( :root-plan ))))))))


(defmacro do-pairs ((key value pairlist) &body body)
  "Map over pairlist, of the form (:a a-value :b b-value);
key bound to each of the keys, e.g. :a then :b, value to the value after that key
until the end of the list."
  (let ((remaining (gensym)))
    `(let ((,remaining ,pairlist) 
           ,key
           ,value)
       (while ,remaining
         (setq ,key (car ,remaining))
         (setq ,value (cadr ,remaining))
         (setq ,remaining (cddr ,remaining))
       
         ,@body))))

