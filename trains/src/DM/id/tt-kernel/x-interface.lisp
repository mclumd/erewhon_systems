;; Time-stamp: <Mon Jan 13 17:31:41 EST 1997 ferguson>

(when (not (find-package :hack))
  (load "hack-def"))
(in-package hack)

(Defparameter *maximal-timeout-value* 60 "number of seconds we will wait to time out, maximum")

(defvar *use-speech* nil  "non-nil to allow speech input")
(defvar *no-delay* nil "non-nil to inhibit delay")

(defvar *speech-rate* 1.0)

(defparameter *display-start-time* 15 "Seconds to pause to allow the display to appear.")
(defparameter *display-delay-time* 0 "Seconds to pause after sending a display command.")

(defun send-goal (goal-cities)
  (handle-kqml (create-request 'display `( dialog :goals ,(generator::say-list goal-cities)) user::*dump-name*)))
      
(defun send-parsetree (parsetree)
  (handle-kqml (create-request 'display `( dialog :parser ,parsetree) user::*dump-name*)))

(defun hack-speech-string-for-display (string &optional (startposn 0))
  "Cut out the orders for the speech synth. (look for \! and delete until you get a space)"
  (let ((backslash-posn (position #\\ string :start startposn)))
    (if backslash-posn                ; found one
        (if (eql (char string (1+ backslash-posn)) #\!)
            ;; a hit. Find the next space.
            (let ((space-posn (position #\space string :start backslash-posn)))
              (if (null space-posn)     ; to end
                  (subseq string 0 backslash-posn) ; return string up to the backslash.
                (concatenate 'string
                  (subseq string 0 backslash-posn)
                  (hack-speech-string-for-display (subseq string (1+ space-posn))))))
          ;; found a backslash, but not a truetalk parameter. Keep looking
          (hack-speech-string-for-display string (1+ backslash-posn)))
      string)))                         ; return the input string

;; may want to handle ready message from speech-out to know we are done.
(let ((voice :male)
      (last-voice :none))
  (labels ((gen-speech-kqml (format-str args)
             (let* ((reply-tag (gentemp "SR" user::*hack-package*))
                    (kqml (create-request :speech-out 
                                          `(say ,(apply #'format nil
                                                        (concatenate 'string
                                                          (cond
                                                           ((eq voice last-voice)
                                                            "")
                                                           ((eq voice :female)
                                                            (format nil "\\!uSf\\!R~F " *speech-rate*))
                                                           (t
                                                            (format nil "\\!uSm\\!R~F " *speech-rate*)))
                                                          format-str)
                                                        args))
                                          (or kqml::*kqml-recipient* user::*dump-name*)
                                          reply-tag)))
               (values kqml reply-tag)))
             
           (handle-speech-internal (format-str speech-only args)
             (mlet (kqml reply-tag)
                 (gen-speech-kqml format-str args)
               (handle-speech-kqml kqml speech-only reply-tag))))
    
    (defun handle-speech-kqml (kqml &optional speech-only (reply-tag (reply-with kqml)) &aux spoke-p)
      (if (consp reply-tag)
          (setq reply-tag (car reply-tag))) ; happens if called w/o reply tag from dumb module (display-parser).
      ;;  (REQUEST :RE 6 :REPLY-WITH (RQ620 RQ618) :SENDER DISPLAY-MANAGER :RECEIVER DISPLAY :CONTENT (SAY "I don't understand your destination for The engine at Toronto; if I caught your drift"))
      (unless speech-only
        (let* ((speech-content (content kqml))
               (speech-string (second speech-content))
               (display-kqml (copy-kqml kqml)))
          (setf (content display-kqml)
            `(say ,(hack-speech-string-for-display speech-string)))
          (send-kqml-to-display display-kqml)))
      (when (module-running-p :speech-out)
        (setq last-voice voice)
        (setq spoke-p t)
        (setf (receiver kqml) (fix-pkg :speech-out))
        (handle-kqml kqml))
      (transcribe-and-log *kqml-recipient* "System said: ~S~%~%" (content kqml))
      (when (and spoke-p *game-in-progress*) ; don't wait in attract mode.
        (wait-for-reply reply-tag)))
        
    (defun handle-speech (format-str &rest args)
      (handle-speech-internal format-str nil args))
            
    (defun handle-speech-only (format-str &rest args)
      (if (module-running-p :speech-out)
          (handle-speech-internal format-str t args))))
  
  (defun reset-speech ()
    (setq last-voice :none)
    (setq voice :female))
          
  (defun switch-to-female-voice ()
    (setq voice :female))
            
  (defun current-voice ()
    voice)
        
  (defun switch-to-male-voice ()
    (setq voice :male)))

(let (did-sync)
  (defun im-sync ()
    (unless did-sync
      (wait-for-module-ready :display)
      (wait-for-module-ready :parser)
      (wait-for-module-ready :ps)
      ;; (check-module-running :geo)
      (if *use-truetalk*
          (wait-for-module-ready :speech-out))
      (if *use-speech*
          (wait-for-module-ready :speech-in "I'm still waiting for that glacial CMU Sphynx module."))
      (setq did-sync t))))
  
(defun say-name (thingo)
  (substitute #\space #\_ (string-downcase (object-name thingo))))

(let ((first-time t))
  (defun fake-first-time ()
    (setq first-time t))
  
  (defun reset-kbs ()
    (declare (special *no-delay*))
    ;;(setq *random-state* (make-random-state t))
    ;; make sure we have synch with fe
    (when first-time
      (setq first-time nil)
      (im-sync)
      (reset-initializations 'kqml::*register-initializations*)
      (initializations 'kqml::*register-initializations*) ; makes the modules register themselves.
      (reset-speech))
    (reset-initializations 'kqml::*other-startup-initializations*)
    (initializations 'kqml::*other-startup-initializations*)
    ;;(kb-request-kqml (create-request :log '( :open) cl-user::*dump-name*)) ; session log module
    (if *initial-seed*
        (transcribe-and-log :DM "Random Seed: ~S" (make-random-state *initial-seed*))
      (transcribe-and-log :DM "Random Seed: ~S" (make-random-state)))
    (reset-interactions)
    (switch-to-female-voice)
    (let ((*no-delay* t))
      (handle-speech (if user::*debug* 
                         *initial-welcome-message-debug*
                       *initial-welcome-message*))
      (send-kqml-to-display (create-request :display '(restart) user::*dump-name*))

      (check-for-demo)
      (generate-new-problem)
      (state-problem)
      (switch-to-male-voice)
      (handle-speech-only (if user::*debug*
                              *real-welcome-message-debug*
                            *real-welcome-message*)))))


(defun place-engine (engine-name location)
  "Used by scoring and demo"
  (send-kqml-to-display (create-request :display (car (kb-request-kqml (create-evaluate :display-kb `(:place-engine ,engine-name yellow red ,location) :score))) :score))
  (refresh-display :score)
  (sleep *display-delay-time*))         ; extra time to handle the create

(defun place-goal (location)
  "Used by scoring and demo"
  (mapc #'(lambda (x)
            (send-kqml-to-display (create-request :display x :score)))
        (kb-request-kqml (create-request :display-kb `(:highlight :goal ,location) :score))))

(defun pause (type)
  (case type
    ( :short
      (sleep 1))
    ( :long
      (sleep 2))
    ( :very-long
      (sleep 3))))

(defun run-demo (&aux (kqml:*kqml-re* 99990) (*game-in-progress* t))
  (handle-speech "Since I see that you have not run ~A before, I'm going to do a short demo for you." *full-system-name*)
  (pause :long)
  (kb-request-kqml (create-request :display-kb '( :clear) :score))
  (place-engine 'ENGINE1 'Buffalo)
  (place-engine 'ENGINE2 'Baltimore)
  (pause :short)
  (handle-speech "I've placed two engines on the display, at Buffalo and Baltimore.")
  (handle-speech "This is how engines look when they are in their starting, or initial, locations.")
  (pause :short)
  (place-goal 'Richmond)
  (pause :short)
  (handle-speech "This is how a goal is indicated when the system knows about it (or thinks it does).")
  (handle-speech "Typically, Brad will not know what the goals are, but I will tell them to you.")
  (handle-speech "If Brad knows the goals, he will highlight them when he says that he is ready.")
  (pause :long)
  (display-route 'Buffalo '(Buffalo-Pittsburgh Charleston-Pittsburgh Charleston-Richmond) 'orange)
  (handle-speech "Here is an example of a route from Buffalo, where there is an engine, to Richmond, a goal.")
  (pause :long)
  (mapc #'(lambda (x) (send-kqml-to-display (create-request :display x :score)))
        (display-kb::generate-highlight-list 'Pittsburgh :bad-weather t))
  (handle-speech "Pittsburgh shows an example of a problem, e.g. congestion or bad weather.")
  (handle-speech "Brad will normally give you the specifics of the congestion, as well as the delay through the city.")
  ;; add another city, route, and show a cross.
  
  (pause :very-long)
  (handle-speech "OK, that's the end of the demo. I hope you found it helpful. Now on with the game!")
  (pause :long)
  (send-kqml-to-display (create-request :display '(RESTART) :score)))

(Defun refresh-display (module)
  (handle-kqml (create-request :display '(REFRESH) module)))

(defun display-route (start tracks color)
  (send-kqml-to-display
   (create-request :display
                   `(create :type hack::route
                            :thickness 2
                            :name ,(gentemp "RT" user::*hack-package*)
                            :start ,(fix-pkg (display-kb::dkb-object-name start))
                            :tracks ,(display-kb::print-tracks tracks)
                            :color ,(fix-pkg color))
                   :score))
  (refresh-display :score))
