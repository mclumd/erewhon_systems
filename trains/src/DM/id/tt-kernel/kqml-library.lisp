;; Time-stamp: <Mon Jan 13 18:45:31 EST 1997 ferguson>

(when (not (find-package :kqml))
  (load "kqml-library-def"))
(in-package :kqml)

;; stuff leftover from TDS that was useful for abstractions.
;; being ported as a KQML interface...
;; Brad Miller miller@cs.rochester.edu

;(defvar *thread* 0 "Threadnumber for tracking transactions.")
;
                                        ;(defvar *current-cookies* nil "List of cookies the current module is allowed.")

(defvar *local-modules* nil "List of local registered modules (in this image")

(defvar *interest-alist* nil "Alist of modules that have internal modules interested in their broadcasts.")

(defvar *kqml-sender* nil "Sender of the \"input\" kqml request")

(defvar *kqml-recipient* nil "Useful often as the name of the module currently running")

(defvar *kqml-reply-with* nil "If reply-with is supplied")

(defvar *kqml-re* nil "If re is supplied")

(defvar *register-initializations* nil)

(defvar *other-startup-initializations* nil)

(defvar *print-for-kqml* nil "Some print-functions will print diffo if t, e.g. path-quantum")

;(defclass message-wrapper ()
;  ((thread :initform *thread* :initarg :thread :type fixnum :reader thread)
;   (cookies :initform *current-cookies* :initarg :cookies :type list :reader cookies)))

;(defclass-x default-message (message-wrapper)
;  ((message :initarg :message :type t :initform nil :reader message)))

;(defclass-x generic-message (message-wrapper)
;  ((message-name :initarg :message-name :type t :initform nil :reader gm-message-name)
;   (message-args :initarg :message-args :type t :initform nil :reader gm-message-args)))

(defclass-x kqml-performative ()
  ((perf :initarg :perf :type symbol :initform 'request :accessor perf)
   (content :initarg :content :initform nil :type t :accessor content)
   (force :initarg :force :type symbol :initform nil :accessor force)
   (in-reply-to :initarg :in-reply-to :type t :initform nil :accessor in-reply-to)
   (language :initarg :language :type symbol :initform nil :accessor language)
   (ontology :initarg :ontology :type symbol :initform nil :accessor ontology)
   (receiver :initarg :receiver :type symbol :initform nil :accessor receiver)
   (sender :initarg :sender :type symbol :initform nil :accessor sender)
   ;; some performatives are special, and define extra slots
   
   ;; perf is insert, delete, delete-one, delete-all, evaluate, ask-if, ask-about, ask-one, ask-all, stream-about, stream-all
   ;;         standby, ready, generator, subscribe, monitor, pipe, broker-one, broker-all, recommend-one, recommend-all,
   (reply-with :initarg :reply-with :type t :initform nil :accessor reply-with) 
   
   ;; other user stuff
   (re :initarg :re :type t :initform 0 :accessor re)
   (other :initarg :other :type t :initform nil :accessor other)
   ))

(defclass-x kqml-forward (kqml-performative)
  ((perf :initform 'forward :reader perf)
   (to :initarg :to :type symbol :initform nil :accessor to) ; forward
   (from :initarg :from :type symbol :initform nil :accessor from))) ; forward

(defclass-x kqml-problem (kqml-performative)
  ((perf :initarg :perf :initform 'error :accessor perf)
   (comment :initarg :comment :type string :initform "" :accessor comment) ; error, sorry
   (code :initarg :code :type fixnum :initform 0 :accessor code))) ; error

(defclass-x kqml-transport (kqml-performative)
  ((perf :initarg :perf :initform 'register :accessor perf)
   (name :initarg :name :type symbol :initform nil :accessor name))) ; register, unregister, transport-address

(defclass-x kqml-w-aspect (kqml-performative)
  ;; delete-one, delete-all, ask-one, ask-all, stream-all, generator
  ((aspect :initarg :aspect :type t :initform nil :accessor aspect)))

(defclass-x kqml-delete-one (kqml-w-aspect)
  ((perf :initarg :perf :initform 'delete-one :reader perf)
   (order :initarg :order :type (member first last undefined) :initform 'undefined :accessor order))) ; delete-one

(defmethod make-load-form ((self kqml-performative) &optional environment)
  (make-load-form-saving-slots self :environment environment))   ; no eq-ness need be preserved.

(macrolet ((test-param (param)
             `(if (,param kqml)
                  (push `(,,(make-keyword param) ,(,param kqml)) reply))))
  (defun gather-non-null-parameters (kqml)
    (let ((reply))
      (test-param content)
      (test-param force)
      (test-param in-reply-to)
      (test-param language)
      (test-param ontology)
      (test-param receiver)
      (test-param sender)
      (test-param reply-with)
      (test-param re)
      (when (kqml-forward-p kqml)
        (test-param to)
        (test-param from))
      (when (kqml-problem-p kqml)
        (test-param comment)
        (test-param code))
      (when (kqml-transport-p kqml)
        (test-param name))
      (when (kqml-w-aspect-p kqml)
        (test-param aspect))
      (when (kqml-delete-one-p kqml)
        (test-param order))
      (when (other kqml)
        (setq reply (nconc reply (other kqml))))
      reply)))

(defmethod print-object ((self kqml-performative) stream)
  (cond
   (*print-readably*
    (with-standard-io-syntax
      (format stream "#.~S" (make-load-form self))))
   ;; standard interchange format
   (t
    (format stream "(~A ~<~@{~{~W ~W~}~^ ~:_~}~:>)" (perf self) (gather-non-null-parameters self)))))

;(defun copy-generic-message (gm)
;  (make-generic-message :message-name (gm-message-name gm)
;                        :message-args (copy-list (gm-message-args gm))
;                        :thread (thread gm)
;                        :cookies (copy-list (cookies gm))))
;
;(defmethod make-load-form ((self generic-message) &optional environment)
;  (declare (ignore environment))
;  `(make-generic-message :message-name ',(gm-message-name self)
;                         :message-args ',(gm-message-args self)
;                         :thread ',(thread self)
;                         :cookies ',(cookies self)))
;
;(defmethod print-object ((self generic-message) stream)
;  (cond
;   (*print-readably*
;    (with-standard-io-syntax
;      (format stream "#.~S" (make-load-form self))))
;   (t
;    (print-unreadable-object (self stream :type nil) ;; specialized so the presentation is somewhat readable.
                                        ;      (format stream "GM: ~S~{ ~S~}" (gm-message-name self) (gm-message-args self))))))

(defun vette-kqml-args (args)
  "Vette the arguments to create-kqml; they should be a list of alternating keywords and values.
Since the user can create new keywords, we can't check that."
  (labels ((vka-i (args)
             (or (null args)
                 (and (keywordp (car args))
                      (vka-i (cddr args))))))
    (and (evenp (length args))
         (vka-i args))))

(defun vette-performative-name (perf)
  "Vette it's a performative; for now that means a symbol."
  (symbolp perf))

(let (cache)
  (defun legal-slots-for-class (class &aux hit)
    (or (cdr (assoc class cache))
        (progn 
          (setq cache
            (update-alist
                class
              (setq hit (remove-if #'(lambda (x) (member x '( :perf :other))) ; get rid of internal slots
                                   (cl-lib:generate-legal-slot-initargs (find-class class))))
              cache))
          hit))))

(defun create-kqml (performative-name &rest args)
  ;; vette the args
  (unless (and (vette-performative-name performative-name)
               (vette-kqml-args args))
    (hack::handle-kqml (create-error (extract-keyword :sender args nil)
                                     999
                                     "bad kqml"
                                     (extract-keyword :receiver args user::*dump-name*)))
    (return-from create-kqml nil))

  (let* ((class (case performative-name
                  (delete-one
                   'kqml-delete-one)
                  ((delete-all ask-one ask-all stream-all generator)
                   'kqml-w-aspect)
                  ((register unregister transport-address)
                   'kqml-transport)
                  ((error sorry)
                   'kqml-problem)
                  (forward
                   'kqml-forward)
                  (t
                   'kqml-performative)))
         (legal-slots (legal-slots-for-class class))
         other
         proc-args)

    ;; check args for user slots, and stick them onto other.
    (let ((args args))
      (while args
        (if (member (car args) legal-slots)
            (setq proc-args (nconc (list (first args) (second args)) proc-args))
          (push (list (first args) (second args)) other))
        (setq args (cddr args))))
    
    (progfoo (apply #'make-instance
                    class
                    (append
                     (unless (member performative-name '(delete-one forward))
                       `(:perf ,performative-name))
                     (when other
                       `(:other ,other))
                     proc-args))
      (unless (sender foo)
        (hack::handle-kqml (create-error (extract-keyword :sender args nil)
                                         999
                                         "Bad Sender"
                                         (extract-keyword :receiver args user::*dump-name*)))
        (return-from create-kqml nil))
      ;; fix re
      (when (and (or (null (re foo))
                     (zerop (re foo))))
        (when (debug-p :kqml)
          (sa-defs:tt-assert (or *kqml-re*
                                 (not (or (member (sender foo) *local-modules*)
                                          (member (sender foo) '(hack::parser hack::ps))))
                                 (member (receiver foo) '(hack::dm hack::im)))
                             () "Bad RE"))
        (setf (re foo) *kqml-re*))
      
      ;; fix reply with
      (if (and (reply-with foo)
               (not (consp (reply-with foo)))
               (boundp '*kqml-reply-with*)
               *kqml-reply-with*)
          (setf (reply-with foo) (cons (reply-with foo)
                                       (if (consp *kqml-reply-with*)
                                           *kqml-reply-with*
                                         (list *kqml-reply-with*))))))))

(defun fix-pkg (sym)
  (if (and (symbolp sym) (eq (symbol-package sym) user::*hack-package*) )
      sym
    (intern (string sym) user::*hack-package*)))

(defun create-request (kb content &optional (me *kqml-recipient*) (reply-with (gentemp "RQ" user::*hack-package*)))
  (create-kqml 'request
               :content content
               :sender (fix-pkg me)
               :receiver (fix-pkg kb)
               :reply-with reply-with))

(defun create-reply (content)
  (sa-defs:tt-assert (and (boundp '*kqml-recipient*)
                          *kqml-sender*) () "No context for reply: ~S recip: ~S sender: ~S" content *kqml-recipient* *kqml-sender*)
  (create-kqml 'reply
               :content content
               :sender *kqml-recipient* ; set up by handle-kqml when caller was called.
               :receiver *kqml-sender*
               :in-reply-to *kqml-reply-with*))

(defun create-tell (kb content &optional (me *kqml-recipient*))
  (create-kqml 'tell
               :content content
               :sender (fix-pkg me)
               :receiver (fix-pkg kb)))

(defun create-broadcast (kb content &optional (me *kqml-recipient*))
  (create-kqml 'broadcast
               :content content
               :sender (fix-pkg me)
               :receiver (fix-pkg kb)))

(defun create-ask-if (kb content &optional (me *kqml-recipient*) (reply-with (gentemp "AI" user::*hack-package*)))
  (create-kqml 'ask-if
               :content content
               :sender (fix-pkg me)
               :receiver (fix-pkg kb)
               :reply-with reply-with))

(defun create-ask-all (kb content aspect &optional (me *kqml-recipient*) (reply-with (gentemp "AA" user::*hack-package*)))
  (create-kqml 'ask-all
               :content content
               :sender (fix-pkg me)
               :receiver (fix-pkg kb)
               :aspect aspect
               :reply-with reply-with))

(defun create-ask-one (kb content aspect &optional (me *kqml-recipient*) (reply-with (gentemp "AO" user::*hack-package*)))
  (create-kqml 'ask-one
               :content content
               :sender (fix-pkg me)
               :receiver (fix-pkg kb)
               :aspect aspect
               :reply-with reply-with))

(defun create-ask-about (kb content &optional (me *kqml-recipient*) (reply-with (gentemp "AA" user::*hack-package*)))
  (create-kqml 'ask-about
               :content content
               :sender (fix-pkg me)
               :receiver (fix-pkg kb)
               :reply-with reply-with))

(defun create-evaluate (kb content &optional (me *kqml-recipient*) (reply-with (gentemp "EV" user::*hack-package*)))
  (create-kqml 'evaluate
               :content content
               :sender (fix-pkg me)
               :receiver (fix-pkg kb)
               :reply-with reply-with))

(defun create-error (kb code comment &optional (me *kqml-recipient*))
  (create-kqml 'error :sender me :receiver kb :code code :comment comment))

(defun register (me func)
  (setq me (fix-pkg me))
  (update-alist me func *local-modules*) ; so we know who's in this image
  (open-log-stream-for-module me)       ; so we will get any log-alls.
  (hack::handle-kqml                    ; transmit it now.
   (create-kqml 'register
                :sender me
                :receiver 'hack::im
                :name (fix-pkg me)))
  (hack::handle-kqml
   (create-kqml 'tell :sender me :receiver 'hack::im :content '( hack::ready))))

(defun register-interest (me module expression &optional (reply-with (gentemp "RI" user::*hack-package*)))
  ;; so we know if interest is internal.
  (declare (ignorable expression))
  (setq module (fix-pkg module))
  (setq me (fix-pkg me))
  (let ((newvalue (adjoin me (cdr (assoc module *interest-alist*)))))
    (update-alist module newvalue *interest-alist*) 
    (hack::register-interest-w-pm module reply-with)))

(defun kb-request-kqml (kqml)
  (let ((result (do-hack-service (receiver kqml) kqml)))
    (cond
     ((kqml-problem-p result)
      (log-warning (list (sender kqml) (receiver kqml)) ";;;***~%;;;*** PROBLEM: ~S~%;;;***" result)
      result)                           ; caller might handle (well, maybe). Otherwise, crash. What the heck.
     ((and result (kqml-performative-p result))
      (content result))
     (t
      result))))

(defun internal-module-p (kqml-message)
  (let ((sender (if (symbolp kqml-message)
                    kqml-message        ; handle a simple case
                  (sender kqml-message))))
    (or (assoc sender *local-modules*)
        (eq sender user::*dump-name*))))

#+simple-kr
(let ((first-time t))
  (defun do-hack-service (kb message)
    (declare (special display-kb problem-kb self-model-kb user-model-kb context-manager))
    (when first-time
      ;; yah, we'll get complaints. Too bad.
      (setq display-kb nil
            #|| plan-kb nil             ; now external
            problem-kb nil ||#
            self-model-kb nil
            user-model-kb nil
            context-manager nil
            first-time nil))
    (let ((*package* user::*hack-package*))
      (logging:debug-log (list kb (sender message)) :kb-messages "To ~S: ~S~%" kb message))
    (let* ((simple-kr::*simple-kr-alist* (intern (string kb) :kqml))
           (result (hack::handle-kqml message)))
      (if (and (reply-with message)
               (not (internal-module-p kb))                     ; internal modules are "synchronous" (at least now)
               (or (null result)
                   (not (equal (in-reply-to result) (reply-with message)))))
          (setq result (hack::wait-for-reply (let ((rw (reply-with message)))
                                               (if (consp rw)
                                                   (car rw)
                                                 rw)))))
      (let ((*package* user::*hack-package*))
        (if result
            (logging:debug-log (list kb (receiver result)) :kb-messages "From ~S: ~S~%" kb result)))
      result)))

(defun copy-kqml (kqml-message)
  (progfoo (make-instance (type-of kqml-message)
             :perf (perf kqml-message)
             :content (if (consp (content kqml-message))
                          (copy-list (content kqml-message))
                        (content kqml-message))
             :force (force kqml-message)
             :in-reply-to (in-reply-to kqml-message)
             :language (language kqml-message)
             :ontology (ontology kqml-message)
             :receiver (receiver kqml-message)
             :sender (sender kqml-message)
             :reply-with (reply-with kqml-message)
             :re (re kqml-message)
             :other (copy-list (other kqml-message)))
    (cond
     ((kqml-forward-p kqml-message)
      (setf (to foo) (to kqml-message))
      (setf (from foo) (from kqml-message)))
     ((kqml-problem-p kqml-message)
      (setf (comment foo) (comment kqml-message))
      (setf (code foo) (code kqml-message)))
     ((kqml-transport-p kqml-message)
      (setf (name foo) (name kqml-message)))
     ((kqml-delete-one-p kqml-message)
      (setf (aspect foo) (aspect kqml-message))
      (setf (order foo) (order kqml-message)))
     ((kqml-w-aspect-p kqml-message)
      (setf (aspect foo) (aspect kqml-message))))))
            
    
