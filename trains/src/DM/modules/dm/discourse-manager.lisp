;; Time-stamp: <Mon Jan 20 14:20:00 EST 1997 ferguson>

(when (not (find-package :discourse-manager))
  (load "discourse-manager-def"))
(in-package discourse-manager)

(eval-when (load eval)
  (add-initialization "Register :discourse-manager"
                      '(register :discourse-manager #'discourse-manager::process-discourse-manager-request)
                      () 'kqml::*register-initializations*)
  (add-initialization "Register dm instest in parser"
                      '(register-interest :discourse-manager :parser nil nil)
                      () 'kqml::*other-startup-initializations*))


(defparameter *confirm-expressives* '( :thanks :be-welcome) "Expressives that probably indicate a confirmation.")

(defparameter *timeout-dm-marker* '( :sa-yn-question :existance nil :self))

(defvar *discourse-context* nil "Ugly, but at least not global. Makes it easy to break out rules.")

(defvar *last-plan* nil)
(defvar *last-ps-state* nil)

(let ((did-push-this-pass))
  (defun clear-frame-pusher ()
    (setq did-push-this-pass nil))
  (defun clean-stack ()
    (while (equal (car *discourse-context*) *timeout-dm-marker*)
      (pop *discourse-context*)))
  (defun pop-to-last-frame ()
    (unless did-push-this-pass          ; don't pop off what we've just added
      (debug-log :discourse-manager :reference "Popping to last frame marker")
      (while-not (or (eq (pop *discourse-context*) :frame-marker)
                     (null *discourse-context*)))
      (clean-stack)))
  (defun push-on-context (x)
    (setq did-push-this-pass t)
    (if (null *discourse-context*)
        (push :frame-marker *discourse-context*))
    (push x *discourse-context*))
  
  (defun standard-push (sa)
    (push-on-context (list (make-keyword (type-of sa)) (semantics sa) sa (initiator sa)))))


(defun dm-compound-context (sa initiator)
  ;; capture stuff in compound cas
  (when (or (ps-state sa) (plan sa))
    (let* ((ps-state (ps-state sa))
           (this-plan (plan sa))) ;use last plan
      
      (cond
       ((and this-plan *last-plan* (not (eql *last-plan* this-plan)))
        (debug-log :discourse-manager :discourse-manager "Dropping frame; this-plan: ~S last-plan: ~S" this-plan *last-plan*)
        (push-on-context '(:FRAME-MARKER)) ; intoduction of a new plan, not the first one.
        (push-on-context `(:PLAN-FRAME-MARKER ,ps-state ,this-plan))
        (setq *last-plan* this-plan))    ; update
       
       ((not (eql *last-ps-state* ps-state))
        (push-on-context `(:plan-frame-marker ,ps-state ,(or this-plan *last-plan*))))))) ; just update ps-state
  
  (mapc #'(lambda (x) (dm-context x initiator)) (acts sa)))

(defun dm-context (sa initiator)
  (cond
   ((compound-communications-act-p sa)
    (dm-compound-context sa initiator))
   ((and (or (sa-close-p sa)
             (sa-restart-p sa))
         (eq (mode sa) :mouse))
    (setq *discourse-context* nil)
    (mlet (ps-state plan) (kb-request-kqml (create-request :self-model-kb `( :root-plan)))
      (push-on-context `( :plan-frame-marker ,ps-state ,plan))))
                
   ((and (sa-greet-p sa)
         (eq initiator :user))          ; system might generate due to timeout.
    (unless (eq (car *discourse-context*) :frame-marker)
      (push-on-context :frame-marker)))

   ((and (eq initiator :system)
         (sa-restart-p sa))
    nil)                                ; nothing to do anymore (used to reset stuff)
   
   ((and (eq initiator :system)
         (sa-expressive-p sa)
         (equal (semantics sa) :welcome)) ; system indicating a matter is closed.
    (pop-to-last-frame))
                
   ((or (and (sa-confirm-p sa)
             (consp (semantics sa))
             (or (eq initiator :user)
                 (not (eq :new-focus (car (semantics sa)))))) ; if we are confiming to set a new focus, that's not really a confirm.
        (and (sa-expressive-p sa)
             (member (semantics sa) *confirm-expressives*)))
    (if (equal (car *discourse-context*) *timeout-dm-marker*)
        ;; increase the timeout.
        (kb-request-kqml (create-request :display-kb
                                         `( :set-timeout-value
                                            ,(* 4 (kb-request-kqml 
                                                   (create-request :display-kb
                                                                   '( :timeout-value)))))))
      ;; reset the timeout
      (kb-request-kqml (create-request :display-kb '( :set-timeout-value 30))))
    )
               
   ((sa-reject-p sa)
    ;; don't pop context, change to reject
    (unless (and (consp (car *discourse-context*)) (eq (caar *discourse-context*) 'sa-reject))
      (standard-push sa)))
   
   (t
    (standard-push sa))))

(defun update-context (initiator input)
  (let ((*discourse-context* (kb-request-kqml (create-request :context-manager '( :discourse-context))))
        (*last-plan* (kb-request-kqml (create-evaluate :context-manager '( :current-plan))))
        (*last-ps-state* (kb-request-kqml (create-evaluate :context-manager '( :current-ps-state))))
        (input (content input)))         ; strip kqml
    (clear-frame-pusher)
    (if (compound-communications-act-p input)
        (dm-compound-context input initiator)
      (dm-context input initiator))
    (debug-log :discourse-manager :reference "Setting discourse context to: ~S" *discourse-context*)
    (kb-request-kqml (create-request :context-manager
                                     `( :set-discourse-context ,*discourse-context*)))))

(defun process-parser-output (input)
  (unless (and (consp input)
               (eq (car (content input)) :timeout))
    (stamp-view-log-indicator (hack::count-interactions) "interaction count")) ; scoring, logging
  (setf (content input) (apply #'make-instance (car (content input)) (cdr (content input))))
  
  (when (compound-communications-act-p (content input))
    (setf (acts (content input))
      (mapcar #'(lambda (x) (apply #'make-instance (car x) (cdr x))) (acts (content input))))
    
    ;; stupid parser doesn't alwasy set input for compund act.
    (unless (input (content input))
      (setf (input (content input))
        (mapcan #'(lambda (x) (if (input x)
                                  (copy-list (input x))))
                (acts (content input))))))
  
  (stamp-view-log-indicator (re input) (input (content input)))
  
  (setf (sender input) 'hack::discourse-manager)
  (setf (receiver input) 'hack::reference)

  (do-log-timestamp :perf "Calling reference")  
  (process-reference-resolution-response
   (progfoo (hack::handle-kqml input) ; send to reference
     (debug-log :discourse-manager :prince ";;reference output:: ~S~%" foo)
     (do-log-timestamp :perf "Ref done"))))
  
(defun process-verbal-reasoner-response (input)
  ;; generate a response, depending on what back-end returned.
  (update-context :system input)
  (cond 
   ((not (and input (content input)))
    (setq input (create-tell :actualization (make-sa-expressive :semantics :ah)))) ; so we say something
   (t
    (setf (sender input) 'hack::discourse-manager)
    (setf (receiver input) 'hack::actualization)))
  input)                                ; pass on to generator

(defun process-reference-resolution-response (input)
  ;; tell context manager about it.
  (kb-request-kqml (create-request :context-manager `( :new-sa ,(content input))))
  ;; build a context
  (update-context :user input)
  (setf (perf input) :request)
  (setf (sender input) 'hack::discourse-manager)
  (setf (receiver input) 'hack::prince)
  input)                                ; just return, will send to verbal-reasoner

(defun process-discourse-manager-request (input)
  "handle raw input, calls our stack pal."
  (declare (special hack::*maximal-timeout-value*))
  (debug-log :discourse-manager :discourse-manager "Command: ~W" input)
  (do-log-timestamp :perf "Start DM handling")
  (let ((source (if (eq (sender input) 'hack::parser)
                    :user
                  :system)))
    (cond
     ((and (consp (content input))
           (eq (car (content input)) :timeout))
      (process-timeout))
     (t
      (ecase source
        (:system
         (hack::handle-kqml (process-verbal-reasoner-response input)))
        (:user
         (hack::handle-kqml (process-parser-output input))))))))

(defun process-timeout ()
  (let ((kqml:*kqml-re* 99997)          ; to have something
        (gl (kb-request-kqml (create-request :self-model-kb '(:greeting-level)))))
    ;; got tired of waiting for the user.
    (cond
     ((and (null (kb-request-kqml (create-request :context-manager 
                                                  '(:discourse-context)))) ; no context
           (or (null gl) (zerop gl)))
      ;; send a greeting
      (kb-request-kqml (create-request :context-manager 
                                       '(:push-discourse-context (:sa-greet))))
      (create-request :actualization 
                      (make-sa-greet :initiator :self :mode :timeout)))
     (t
      (if (not (equal (car (kb-request-kqml (create-request :context-manager
                                                            '(:discourse-context)))) 
                      *timeout-dm-marker*))
          (kb-request-kqml (create-request :context-manager
                                           `(:push-discourse-context ,(copy-list *timeout-dm-marker*)))))
      ;; increase the timeout
      (kb-request-kqml (create-request :display-kb 
                                       `(:set-timeout-value
                                         ,(min hack::*maximal-timeout-value*
                                               (floor (* 1.25 (kb-request-kqml
                                                               (create-request :display-kb
                                                                               '(:timeout-value)))))))))
      (create-request :actualization 
                      (make-sa-yn-question :semantics :existance :initiator :self :mode :timeout))))))


(defun test-parser-output (sa)
  (let ((input (create-request :reference sa :discourse-manager)))
    (setf (content input) (apply #'make-instance (car (content input)) (cdr (content input))))
  
    (when (compound-communications-act-p (content input))
      (setf (acts (content input))
        (mapcar #'(lambda (x) (apply #'make-instance (car x) (cdr x))) (acts (content input))))
    
      ;; stupid parser doesn't alwasy set input for compund act.
      (unless (input (content input))
        (setf (input (content input))
          (mapcan #'(lambda (x) (if (input x)
                                    (copy-list (input x))))
                  (acts (content input))))))
  
    (hack::handle-kqml input)))           ; send to reference
