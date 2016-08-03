;; Time-stamp: <Fri Jan 17 14:46:25 EST 1997 ferguson>

(when (not (find-package :hack))
  (load "tt-kernel/hack-def"))
(in-package :hack)

(defvar *running-toy-trains* nil)       ; so we know when we've initialized.

(Defvar *waiting-for-reply* nil "right now, only one use: speech")

(defvar *im-queue* nil "queue of unprocessed im messages (here for debug purposes)")

(defvar *monitored-modules* nil "Modules we are monitoring for status changes")

(defvar *do-transcript* nil)

(defvar *game-in-progress* nil "non-nil when playing a game")

(defvar *command-line* "")

(defun command-line-arg (argname default &optional no-read)
  (cond-binding-predicate-to foo
    ((member argname *command-line* :test #'equalp :key #'(lambda (x) (if (symbolp x) (string x) x)))
     (if no-read
         (values (second foo) t)
       (let ((read-value (if (stringp (second foo))
                             (read-from-string (second foo) nil :eof)
                           (second foo))))
         (if (eq read-value :eof)
             (values default nil)
           (values read-value t)))))
    (t
     (values default nil))))

(defun command-line-inits (override-inits)
  ;; some extra initializations when we do this (for debugging)
  ;;(mpwatchfor-debug)
;  (trace (mp::start-scheduler :break-before t))
  (setq *command-line* (if override-inits 
                           override-inits
                         (system:command-line-arguments :application t)))
  ;;(format *error-output* "Initializing parameters from ~A~%" (if override-inits "tt arguments" "command line"))
  (setq *trains-socket* (command-line-arg "-socket" (sys:getenv "TRAINS_SOCKET") t))
  (setq cl-user::*debug* (command-line-arg "-debug" cl-user::*debug*))
  (setq cl-user::*debug-interactive* (command-line-arg "-debug-interactive" cl-user::*debug-interactive*))
  (setq *score-p* (command-line-arg "-score-p" *score-p*))
  (setq *initial-seed* (command-line-arg "-seed" *initial-seed*))
  (setq *use-truetalk* (command-line-arg "-speech-out" *use-truetalk*))
  )

(defgeneric other-config-message (line var value))

(defvar *prevent-recursion* nil)
(defun start-conversation (&optional do-transcript args)
  (unless *prevent-recursion*           ; strange problem with restarting, temporary hack
    (let ((*prevent-recursion* t))
      (reset-user)
      (let ((name (extract-keyword :name args))
            (sex (extract-keyword :sex args))
            (intro (extract-keyword :intro args))
	    (goals (extract-keyword :goals args))
            (score (extract-keyword :scoring args)))
        (if (and sex
                 (not (equalp sex "")))
            (set-sex sex))
        (if (and name
                 (not (equalp name "")))
            (set-name name))
        (setq *score-p* score)
        (setq *do-demo* intro)
	(setq *known-goals* goals))
      (open-logs do-transcript)         ; debugging log
      (reset-kbs)
      (send-to-log (format nil "ini VERSION ~A" *version-string*))
      (setq *game-in-progress* t)
      (throw :toplevel-input nil))))

(let ((transcript-dir "."))
  (defun transcript-dir ()
    transcript-dir)
  (defun set-transcript-dir (x)
    (setq transcript-dir x)))
  
(let ((logroot (string user::*dump-name*))
      (doing-transcript))

  
  (defun open-logs (&optional (do-transcript doing-transcript))
    (open-log-stream (format nil "~A.log" logroot))
    (do-log :DM "Opening log stream: ~A.log" logroot)
    (when do-transcript
      (setq doing-transcript t)         ; in case we close/open with chdir command
      (open-transcript-stream (format nil "~A.transcript" logroot)))
    (do-log-all "~%~%*~%*~%*** NEW USER: ***~%*~%*~%~%" ))
  
  (defun parse-config-message (line)
    (let ((var (car line))
          (value (cadr line)))
      (declare (special world-kb::*scenario-name*))
      (debug-log :DM :hard "Got config message: ~S" line)
      (case var
        ( trains-dir
          (close-logs)
          (set-transcript-dir value))

        ( debug
          (setq cl-user::*debug* value))

        ( scenario
          (setq world-kb::*scenario-name* (string-downcase (string value))))
        (t
         (other-config-message line var value)
         (if (cddr line)
             (parse-config-message (cddr line)))))))
  (defun parse-supervisor-message (command line)
    ;; popped off :supervisor already
    (case command
      (chdir
       (close-logs)
       ;;       (kb-request-kqml (create-request :log '( :close)))
       (excl:chdir (car line))
       (set-transcript-dir (car line))
       (open-logs)
       ;; (kb-request-kqml (create-request :log '( :open)))
       nil)
      (:bug
       (do-log-all "Bug Logged: ~S" line)
       nil)
      (t
       ;; ignore for now
       (log-warning :DM "unrecognized supervisor message: ~S ~S" command line)
       nil))))

(defvar *im-stream* nil "Handle for debugging only")

(defvar *use-truetalk* t "non-nil to allow speech output (if modules supports)")

(defvar *used-speech* 0 "incremented for each interaction the user trys speech (when speech-in supported).")

(defvar *module-status-alist* nil "Alist of external modules (we are monitoring), and their status.")

(defgeneric handle-input (command &rest args))

(eval-when (compile load eval)
  (export '(other-config-message parse-config-message *im-stream* *use-truetalk* 
            *used-speech* handle-input setup-im-interface kill-im
            check-module-running wait-for-module-ready send-to-im send-to-log send-to-display send-to-dm
            handle-im-input im-rendezvous handle-kqml send-kqml-to-im send-kqml-to-display)))

(defun module-status (module)
  (cdr (assoc (fix-pkg module) *module-status-alist*)))

(defun module-running-p (module)
  (setq module (fix-pkg module))
  (let ((status (module-status module)))
    (cond
     ((null status)
      (check-module-running module)
      (module-running-p module))
     ((member status '(ready :ready))))))

(let (last-status)
  (defun check-module-running (module &optional no-init)
    (setq module (fix-pkg module))
    (debug-log :DM :hard ";;CMR: Checking module: ~S" module)
    (unless no-init
      (check-status-w-pm module))
    ;; register interest will do this for us.
    (if (module-running-p module)
        (return-from check-module-running :ready))

    (unless (member module *monitored-modules*) ; don't need to request status
      (send-kqml-to-im (create-kqml 'evaluate :sender user::*dump-name* :receiver 'im :content `(status ,module)) :check-module-running))

    (debug-log :DM :hard ";;CMR: waiting for IM status or ready message on ~S" module)
    (loop
      (unless (stream:stream-listen *im-stream*)
        (mp:wait-for-input-available (list *im-stream*) :timeout 20)
        (unless (stream:stream-listen *im-stream*) 
          (return-from check-module-running :timeout)))
      (setq last-status nil)
      (handle-im-input t nil)
      (when (eq last-status module)
        (return-from check-module-running t))))
      
  (defun handle-status-message (kqml)
    (let ((content (content kqml)))
      (cond
       ((or (not (eq (sender kqml) 'im))
            (not (eq (first content) 'status)))
        (log-warning :DM ";;HSM: Got something unexpected: ~S" kqml))
       (t
        (update-alist (second content) (third content) *module-status-alist*)
        (setq last-status (second content))
        ;; (tell :content (status ps exited 120208) :receiver DM :sender PM)
        (when (member (third content) '( exited eof))
          ;; complain.
          (log-warning :DM "HSM: Crash reported on ~S" (second content))
          (handle-speech (format nil (pick-one generator:*module-bug-texts*) (string-downcase (string (second content)))))
          ;; log file?
          (mail-log-file (second content) :crash)))))))

(defun wait-for-module-ready (module &optional whine-message)
  (setq module (fix-pkg module))        ; fix this in callers!!
  (let ((second-time nil))
    (loop
      (while (eq (check-module-running module second-time) :timeout)
        (setq second-time t)
        (unless (or (not whine-message)
                    (not *use-truetalk*))
          ;; whine. Truetalk and display must be up for there to be a whine message.
          (handle-speech-only whine-message)))
      (setq second-time t)
      (debug-log :DM :hard ";;WFMR: Module status: ~S" (module-status module))
      (case (module-status module)
        (ready
         (debug-log :DM :hard ";;WFMR: IM eventually returned ready on module: ~S" module)
         (return-from wait-for-module-ready :ready))
        (exited
         (debug-log :DM :hard ";;WFMR: IM returned exited on module: ~S" module)
         (return-from wait-for-module-ready :exited))
        (t
         (debug-log :DM :hard ";;WFMR: still waiting for IM status or ready message on ~S" module))))))

(defun kill-im ()
  (close *im-stream*)
  (setq *im-stream* nil))
    
(let ((registered nil)
      (listened nil))
      
  (defun reset-registered ()
    (setq registered nil
          listened nil))
      
  (defun check-status-w-pm (module &optional reply-with)
    (setq module (fix-pkg module)) 
    (unless (member module registered)
      (push module registered)
      (update-alist module 'dead *module-status-alist*)
      (push module *monitored-modules*) ; so we remember it's being monitored - no status messages needed.
      (send-kqml-to-im (create-kqml 'monitor
                                    :sender user::*dump-name* 
                                    :receiver 'im
                                    :content `(status ,module)
                                    :reply-with reply-with)
                       :check-status-w-pm)))
      
  (defun register-interest-w-pm (module &optional reply-with)
    (setq module (fix-pkg module))      ; fix this in callers!!
    (check-status-w-pm module reply-with)
    (unless (member module listened)
      (push module listened)
      (send-kqml-to-im (create-kqml 'request :sender user::*dump-name* :receiver 'im  :content `(listen ,module) :reply-with reply-with) :register-interest-w-pm))))

(defun setup-im-interface (do-transcript listen-ports)
  (if *im-stream*                       ; debugging? (so stream might be hanging around?)
      (close *im-stream*))

  (setq *module-status-alist* nil       ; clear from prior run.
        *do-transcript* do-transcript
        *interest-alist* nil
        *im-queue* nil
        *waiting-for-reply* nil)

  (reset-registered)
  (setq *im-stream* (server-stream))
  ;; tell system what I'm interested in
  (send-kqml-to-im (create-kqml 'register :sender user::*dump-name* :name user::*dump-name* :receiver 'im) :initial-register) ; name for ourself.
  (dolist (x listen-ports)
    (check-status-w-pm x)
    (wait-for-module-ready x))

  ;; tell him I'm ready
  (send-kqml-to-im (create-kqml 'tell :sender user::*dump-name* :receiver 'im :content '(READY)) :ready)

  ;;gf:done in toplevel (im-rendezvous)
)
  
(defun send-kqml-to-im (kqml &optional why)
  (let ((*package* user::*hack-package*)
        (*print-pretty* nil)            ; turn this off to please george
        (*print-circle* nil)
        (*print-for-kqml* t))           ; some print functions obey this
    (debug-log :DM :kqml "Sending to IM (~A): ~S~%" why kqml)
    (write kqml :stream *im-stream* :length nil :level nil :readably nil :pretty nil :circle nil)
    (fresh-line *im-stream*)
    (force-output *im-stream*)
    (finish-output *im-stream*)))
    
(defun send-to-im (address str)
  (let ((kqml (create-kqml 'request
                           :sender (or kqml::*kqml-recipient*
                                       user::*dump-name*)
                           :receiver (fix-pkg address)
                           :content str)))
    (send-kqml-to-im kqml :send-to-im)))
      
(defun send-to-log (str)
  (stamp-view-log-indicator (system-interactions) str t)
  (handle-kqml (create-kqml 'request
                            :sender (or *kqml-recipient*
                                        user::*dump-name*)
                            :receiver 'transcript
                            :content `(log ,(format nil "SYS ~A" str)))))

(defun send-kqml-to-display (kqml)
  (setf (receiver kqml) 'display)       ; in case it came from handle-speech
  (transcribe-and-log *kqml-recipient* ";;Display Output: ~S~%" kqml)
  (send-kqml-to-im kqml :send-kqml-to-display)
  (if (plusp *display-delay-time*)
      (sleep *display-delay-time*)))
        
(defun send-to-display (str)
  (transcribe-and-log *kqml-recipient* ";;Display Output: ~A~%" str)
  (send-to-im "DISPLAY" str)
  (if (plusp *display-delay-time*)
      (sleep *display-delay-time*)))    ; give it time to digest

;; for "remote" modules
(defun send-to-dm (str)
  (send-to-im "DM" str))

(defun get-text-from-im (&optional no-dispatch)
  (let* ((*package* user::*hack-package*)
         (input (progfoo (read *im-stream* nil :eof)
                  (if (eq foo :eof)
		      (throw :die-die-die :im-died)))))
    (debug-log :DM :kqml "From IM: ~S~%" input)
    ;; ignore utter garbage
    ;;;put test here for bogosity from im.
    (let*-non-null ((kqml-input (apply #'create-kqml input))
                    (performative (perf kqml-input))
                    (source (sender kqml-input)))
      (let* ((content (content kqml-input))
             (receiver (receiver kqml-input))
             (command (and (consp content) (car content)))
             (args (and (consp content) (cdr content))))
        
        ;; handle special backchannel commands
        (cond
         ((eq performative 'error)
          ;; if we're waiting for it, let the caller deal with it.
          (when (and *waiting-for-reply*
                     (eq *waiting-for-reply* (in-reply-to kqml-input)))
            (debug-log :DM :kqml "kqml input (from im): ~S~%" kqml-input)
            (return-from get-text-from-im (handle-kqml kqml-input)))
          (log-warning :DM ";;; Got error message (ignored): code: ~D ~A~%" (code kqml-input) (kqml:comment kqml-input)))
         
         ((eq command 'ping)
          nil)                          ; ignore
         
         ((eq command 'break)
          (cerror "KQML break requested" "Continue")
          nil)
         
         ((eq command 'exit)
          (throw :die-die-die :exit-command))

         ((eq command 'status)
          (handle-status-message kqml-input)
          :status)
         
         ((eq command 'config)
          (progfoo (parse-config-message 
                    args)))

         ((eq command 'start-conversation)
          (when (eq receiver 'dm)       ; ignore messages to submodules
            (start-conversation *do-transcript* args)))
         
         ((eq command 'end-conversation)
          (when (eq receiver 'dm)       ; ignore messages to submodules
            (setq *game-in-progress* nil)
            (throw :end-conversation :message)))

         ((member source '(supervisor splash))
          (parse-supervisor-message command args))
         
         (no-dispatch
          (log-warning :DM ";;get-text-from-im Got something unexpected: (~S ~{~S~})" command args)
          nil)
           
         ((and *waiting-for-reply*
               (not (eqmemb *waiting-for-reply* (in-reply-to kqml-input))))
          ;; queue, not part of the transaction.
          (debug-log :DM :hard ";;QUEUEING (waiting on ~S): ~S" *waiting-for-reply* kqml-input)
          (setq *im-queue* (nconc *im-queue* (list kqml-input)))
          nil)
         
         (t
          (debug-log :DM :hard "kqml input (from im): ~S~%" kqml-input)
          (handle-kqml kqml-input)))))))
        
(defun im-rendezvous ()
  ;;get configuration messages
  (while-not *game-in-progress*
    (handle-im-input t nil)))                                   ; keep reading config messages.

(defun check-queue ()
  (when *im-queue*
    ;; scan queue for usable message, otherwise get something new.
    (progfoo (find-if #'(lambda (q-entry)
                          (or (not *waiting-for-reply*)
                              (eqmemb *waiting-for-reply* (in-reply-to q-entry))))
                      *im-queue*)
      (when foo
        (debug-log :DM :hard ";;DEQUEUEING: ~S" foo)
        (setq *im-queue* (delete foo *im-queue*))
        (throw :queue-result (handle-kqml foo))))))
    
(defun handle-im-input (no-dispatch timeout-destination)
  (catch :queue-result
    ;; is there something in the queue?
    (check-queue)

    ;; no queue hit, so read from im.
    (let ((max-timeout (or (and (assoc 'display-kb *local-modules*)
                                (kb-request-kqml 
                                 (create-kqml 'request :sender user::*dump-name* :receiver 'display-kb :content '(timeout-value))))
                           3000)))      ; effectively forever
      (loop
        (check-queue)
        (debug-log :dm :hard "waiting for input")
        (progfoo (if (plusp max-timeout)
		     (mp:wait-for-input-available *im-stream* :timeout (* 2 max-timeout))
		   (mp:wait-for-input-available *im-stream*))
          (debug-log :dm :hard "got input or timeout")
          (cond
           ((null foo)                ; timeout 
            (return-from handle-im-input (create-kqml 'reply
                                                      :sender user::*dump-name* 
                                                      :receiver timeout-destination
                                                      :content '(:timeout))))

           ((eql foo -2)                ; error (only with hack-wait-for-input-available)
            (log-warning :dm "something went wrong with select. Blah."))
           (t
            (progfoo (get-text-from-im no-dispatch)
              (if foo (return-from handle-im-input foo))))))))))

(defvar *ping-perf* (create-request :nobody '(ping) :nobody nil))

(defun handle-kqml (kqml-message &aux (*package* user::*hack-package*))
  "may be internally generated, decide if we redispatch, or pass to im"
  (debug-log (sender kqml-message) :kqml ";;~S output:: ~S~%" (sender kqml-message) kqml-message)
  (progfoo (let ((recipient (receiver kqml-message))
                 (sender (sender kqml-message))
                 (performative (perf kqml-message)))
             (cond-binding-predicate-to foo
               ((eq performative 'kqml:register)
                ;; replace sender and send on to im.
                (setf (sender kqml-message) user::*dump-name*) ; me
                (send-kqml-to-im kqml-message :register))
               ((and (in-reply-to kqml-message)
                 (if (consp (in-reply-to kqml-message))
                     (eq (car (in-reply-to kqml-message)) *waiting-for-reply*)
                   (eq (in-reply-to kqml-message) *waiting-for-reply*)))
                (throw *waiting-for-reply* kqml-message)) ; give it to he who waits.
               ((assoc recipient *local-modules*)
                ;; dispatch to the right module
                (direct-dispatch recipient (cdr foo) kqml-message))
               ((and (or (null recipient) ;broadcast
                         (eq recipient user::*dump-name*))
                 (assoc sender *interest-alist*)) ; local interest
                (let ((bc-results (mapcar #'(lambda (module)
                                              (direct-dispatch module (cdr (assoc module *local-modules*)) (copy-kqml kqml-message))) ; copy in case they corrupt it.
                                          (cdr foo))))
                  ;; from an internal module?
                  (when (internal-module-p kqml-message)
                    (send-kqml-to-im kqml-message :broadcast))
                  ;; only one response?
                  (cond
                   ((null (cdr bc-results))
                    (car bc-results))
                   (t
                    ;; have to redispatch based on these guys... may want to change this to queue later.
                    (debug-log sender :kqml ";;Redispatch on multiple results from broadcast: ~S" bc-results)
                    (mapcar #'handle-kqml bc-results)))))
               ((internal-module-p kqml-message)
                (send-kqml-to-im kqml-message :from-local-to-non-local)) ;send it on
               (t
                (unless (and (eq (sender kqml-message) :speech-out)
                             (equalp (content kqml-message) '(done)))
                  (log-warning :DM "(handle-kqml) Ignoring message: ~S" kqml-message)) ; ignore ignored dones
                nil)))
    #||
    (unless (kqml-performative-p foo)
      (log-warning :DM ";;handle-kqml returning non-kqml: ~S" foo))
    ||#
    ))
    
;; basic input loop

(defun do-toplevel (modname needed-modules &optional do-transcript override-inits &aux (*running-toy-trains* t))
  ;; write our version number
  ;;(format *standard-output* "~&~A: @(#)ttcl ~A~%" (car (sys:command-line-arguments)) *version-string*)
  (setq *game-in-progess* nil)          ; 
  (cond
   ;; check for lep
   ((and (find-package 'lep)
         (funcall (intern "LEP-IS-RUNNING" (find-package 'lep))))
    (fake-first-time) ;; because we need to force a reset.
    (setq user::*debug-interactive* t))        ; force t if running from emacs.
   (t
    (setq *initial-seed* nil)))          ; don't do this if running from emacs
  (hack::command-line-inits override-inits) ; read the command line
  
  ;; gf: Initialize random state the portable way (ignores seed, sorry)
  (setq *random-state* (make-random-state t))

  ;; why the fuck mess with use-truetalk here???
  ;;(setq hack::*use-truetalk* do-transcript)       ; don't try to use truetalk, unless DM
    
  (unwind-protect
      (catch :die-die-die
        ;; module resets
	(catch :toplevel-input      ; to catch start-conversation the first time
	  (setup-im-interface do-transcript needed-modules))
        (loop
	 (catch :end-conversation      ; gf: don't reset connection (crapola!)
	   (catch :toplevel-input
	     (im-rendezvous))
            (let (kb-output)
              (excl:gc :tenure)
              (loop                     ; outer loop to catch continue signal
                (catch :toplevel-input  ; catch start-conversation subsequent times (im-interface set up)
                  (restart-case
                      (loop
                        (setq kb-output (handle-im-input nil 'discourse-manager))
                        (while (kqml-performative-p kb-output) ; loop while we have kqml to process
                          (setq kb-output (handle-kqml kb-output))))
              
                    (continue ()
                        :report
                          (lambda (s)
                            (format s "Restart ~A at toplevel input loop." modname))
                      (setq kb-output nil)))))))))
    (progn
      (close-logs)
      (when *im-stream*
	(kill-im))
      ;; gf: Get outta here! No, don't! Let autozoom try to do the zoom...
      ;;(excl:exit 0 :quiet t)
      (tpl:do-command "zoom" :count t :all t)
      )))

(defun wait-for-reply (reply-tag &aux kb-output)
  "Wait until a performative matching reply-tag is received, then return it."
  (if (sa-defs:tt-assert reply-tag nil "bad wfr")
      (return-from wait-for-reply (values nil :bad-wfr)))
  ;; are we already waiting for a reply?
  (if (and (boundp '*waiting-for-reply*)
           *waiting-for-reply*)
      (debug-log :dm :hard "recursive wfr"))
  (let ((*waiting-for-reply* reply-tag)) ; really only works on one level right now
    (debug-log :DM :hard ";; set up WFR on ~S" reply-tag)
    (prog1 (catch reply-tag
             (loop                      ; outer loop to catch continue signal
               (restart-case
                   (loop
                     (setq kb-output (handle-im-input nil 'discourse-manager))
                     (while (kqml-performative-p kb-output) ; loop while we have kqml to process
                       (cond
                        ((eq (in-reply-to kb-output) reply-tag)
                         ;; should have been thrown?
                         (debug-log :DM :hard "returning from WFR, non-throw: ~S" reply-tag)
                         ;; note this kqml is not completely "handled" yet... the caller wanted it back
                         (return-from wait-for-reply kb-output)) 
                        (t
                         (debug-log :DM :hard ";;going around WFR loop: ~S" reply-tag)))
                       (setq kb-output (handle-kqml kb-output))))
      
                 (continue ()
                     :report
                       (lambda (s)
                         (format s "Restart ~A at wait-for-reply input loop." user::*dump-name*))
                   (setq kb-output nil)))))
      (debug-log :DM :hard "Returning from WFR: ~S" reply-tag))))

(defun direct-dispatch (recipient function kqml-message)
  (let ((*kqml-sender* (sender kqml-message)) ; so we can autohandle some headers
        (*kqml-recipient* (or recipient (receiver kqml-message)))
        (*kqml-re* (re kqml-message))
        (*kqml-reply-with* (reply-with kqml-message)))
    (declare (ignorable *kqml-sender* *kqml-recipient* *kqml-re* *kqml-reply-with*))
    (if (assert *kqml-sender* nil "Bad sender")
        (return-from direct-dispatch nil))
    (funcall function kqml-message)))

(defun mail-log-file (module-name &optional severity)
  (declare (ignore to-who))
  (let ((logfile1 (format nil "~(~A~).log" module-name))
        (logfile2 (format nil "~@(~A~).log" module-name))
        logfile)
    (cond 
     ((probe-file logfile1)
      (setq logfile logfile1))
     ((probe-file logfile2)
      (setq logfile logfile2)))
    (when logfile
      (with-open-file (kb-stream (format nil "~A/etc/module-data" user::*trains-base*) 
                       :direction :input
                       :if-does-not-exist :error)
        (let* ((module-alist (read kb-stream nil nil))
               (who (cdr (assoc (make-keyword module-name) module-alist))))

          (log-warning :DM "HSM: Sending ~A report to ~S" severity who)
          (format *error-output* "Module ~A ~Aed (telling ~S)" module-name severity who)
          (excl:shell (format nil "setenv TRAINS_BASE ~A; echo \"Automatic ~A Report from DM on module ~A, Logfile is in ~A, My version is ~A\" > /tmp/crashlog; cat ~A >> /tmp/crashlog; ~A/bin/crashmail ~{~A ~}; rm /tmp/crashlog" user::*trains-base* severity module-name (transcript-dir) *version-string* logfile user::*trains-base* who)))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Formerly in hack-streams.lisp
;;;
;;;                     SERVER-STREAM
;;; Server-stream returns a stream that is connected to the trains-socket by
;;; a call to open-socket-stream

(defvar *trains-socket* nil
  "Set by -socket on command-line-inits (default envvar TRAINS_SOCKET)")

(defun SERVER-STREAM ()
  "Returns a stream connected to the IM (using stdio in this version)"
  ;; This would be nice, but what has happened to these streams already...
  ;;(make-two-way-stream *standard-input* *standard-output*)
  ;; Instead, use the file descriptors
  (make-instance 'stream:bidirectional-terminal-stream :fn-in 0 :fn-out 1))

#|| ;; This is the real code, that establishes a socket connection
(defun SERVER-STREAM ()
  (let (hostname port
        (temp *trains-socket*)
        (i 0)
        stream
        lastport)
    (cond
     (temp
      (setq hostname (subseq temp 0  (setq i (position #\: temp))))
      (setq lastport (+ 100 (setq port (read-from-string (subseq temp (1+ i)))))))
     (t
      (or (setq hostname (socket::gethostname))
          (error "no hostname for stream; set TRAINS_SOCKET"))
      (setq port 6200)
      (setq lastport 6300)))
    (while (and (not (setq stream (socket::open-socket-stream hostname port)))
                (or (format *error-output* ";; failed to connect to port ~A:~D~%" hostname port)
                    t)
                (< (incf port) lastport)))
    (unless stream
      (format *error-output* ";; No port available, bailing out.")
      (throw :die-die-die :no-im-stream))
    (format *error-output* ";; Connected to port ~A:~D~%" hostname port)
    stream))
||#
