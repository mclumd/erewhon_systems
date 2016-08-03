;; Time-stamp: <Tue Jan 14 11:00:26 EST 1997 ferguson>

(when (not (find-package :hack))
  (load "hack-def"))
(in-package hack)

;; command line arguments expected (all optional): -- -speaker t -map <mapname> -speech host -emotion t -personality pname
;; -start (start city list) -enum 3 -goal (goal city list) -ccnum 2 -ccities (congested city list) -ctnum 0 
;; -ctracks (congested track list) -ctrackdelay 10 -ccitydelay 5 -xtrackdelay 5 -xcitydelay 3 -sdepth 3 -supress-intro nil
;; -amp 6 -log "/tmp/logfile" -transcript "/tmp/transcript" -sex [m | f] -debug [t | nil] -known-goals [t | nil] -speechin michost
;; -speechdev [-line | -mic]

;; definitions:
;; <mapname> = "wny" | "northeast" (looks for a file in directory /u/trains/95/modules/world/<mapname>.lisp to initialize the databases)
;; 
;; speaker user speaker instead of line out for truetalk. runs on machine AUDIO
;; speech do speech recognition using sphynx (runs on argument machine)
;; emotion have generator use emotions for responses.
;; personality have system use a personality (pick a supported name, currently none)
;;
;; enum (number of engines)
;; ccnum (max number of congested cities)
;; ctnum (max number of congested tracks)
;; the delays in hours for using a congested city/track or a crossed route (>1 train using track or city at same time, 
;; PER TRAIN, i.e. the minimum is 2x this number).
;; sdepth - depth of search - 1. (route length the system can find for itself).
;; supress-intro - goal information not given verbally.
;; sex (sex of  speaker for recognizer)

(defparameter *special-name-list*
    #||'(("James Allen" "Dad" "Daddy" "Pop" "Pater" "Father")
      ("james" "Dad" "Daddy" "Pop" "Pater" "Father")
      ("George Ferguson" "Uncle George" "Uncle" "Uncle Fergy" "The Fergunator")
      ("ferguson" "Uncle George" "Uncle" "Uncle Fergy" "The Fergunator")
      ("Brad Miller" "Mom" "Mommy" "Mater" "Mother")
      ("miller" "Mom" "Mommy" "Mater" "Mother"))
    ||#
    nil)                                ; for the road

(let ((transcript-dir "./" #|| (concatenate 'string user::*trains-base* "/logs/") ||#) ; change to current directory
      user-file-name
      whoaminame
      preset-names-p
      name
      sex)

  ;; probably should be part of user-kb.
  
  (defun preset-names (&aux line)
    (unless preset-names-p
      (setq user-file-name
        (with-open-file (stream (concatenate 'string transcript-dir "user") 
                                           :direction :input
                                           :if-does-not-exist nil)
                            (when (streamp stream)
                              (while (setq line (read-line stream nil nil))
                                (if (equalp "Username:" (subseq line 0 9))
                                    (subseq line 10 (position #\space line :start 10)))))))
      (setq whoaminame
        (let ((stream (excl:run-shell-command "whoami" :output :stream :wait nil)))
          (read-line stream)))))
  
  (defun set-name (n)
    (setq preset-names-p t)
    (setq user-file-name n)
    (setq whoaminame (let ((stream (excl:run-shell-command "whoami" :output :stream :wait nil)))
                       (read-line stream))))

  (defun reset-user ()
    (setq name nil
          user-file-name nil
          preset-names-p nil
          whoaminame nil
          sex nil)
    (preset-names))
  
  (defun set-sex (s)
    (if (or (equalp s "male")
            (eql #\m (char (string s) 0)))
        (setq sex :male)
      (setq sex :female)))
  
  (defun user-sex (&aux line)
    (setq sex
      (or sex
          (with-open-file (stream (concatenate 'string transcript-dir "user") 
                           :direction :input
                           :if-does-not-exist nil)
            (when (streamp stream)
              (while (setq line (read-line stream nil nil))
                (if (equalp "Sex:" (subseq line 0 4))
                    (if (eql (char line 10) #\m)
                        :male
                      :female)))))
          :male)))                      ; sexist default
  
  (defun real-user-name ()
    (or user-file-name
        whoaminame))
      
  (defun user-name ()
    (cond
     ((consp name)
      (pick-one name))
     (name)
     ((and user-file-name
           ;; ok to setq name here, because failure is nil.
           (pick-one (setq name (cdr (assoc user-file-name *special-name-list* :test #'equalp))))) )
     (user-file-name
      (setq name user-file-name))
     ((and whoaminame
           (pick-one (setq name (cdr (assoc whoaminame *special-name-list* :test #'equalp))))))
     (whoaminame
      (setq name
        (format nil "~:[Ms.~;Mr.~] ~:(~A~)" 
                (eq (user-sex) :male)
                whoaminame)))
     (t
      (setq name ""))))

  (defmethod other-config-message (line var value)
    (case var
      ( :speech-in
        (setq *use-speech* value))
        
      ( :speech-out
        (setq *use-truetalk* value))
        
      ( :speech-rate
        (setq *speech-rate* value))
          
      ( :personality
        (setq generator::*personality* (make-keyword value)))

      ( ( :emotions :emotion)
        (setq generator::*emotion-p* value))

      ( :hack-goal
        (setq *hack-goal* value))

      ( :sdepth
        (setq world-kb::*max-search-depth* value))
      
      ( :score
        (setq *score-p* value))
      
      ( :intro
        (setq *do-demo* value))

      ( :known-goals
        (setq *known-goals* value))

      ( :start
        (setq world-kb::*start-locations*
          (mapcar #'(lambda (x) (intern x (find-package 'world-kb)))
                  value))
        (setq world-kb::*number-of-engines* (list-length value)))

      ( :enum
        (setq world-kb::*start-locations* nil)
        (setq *goal-cities* nil)
        (setq world-kb::*number-of-engines* value))

      ( :goal
        (setq *goal-cities*
          (mapcar #'(lambda (x) (intern x (find-package 'world-kb))) 
                  value)))

      ( :ccities
        (setq world-kb::*congested-cities* 
;;          (mapcar #'(lambda (x) (if (consp x) (setf (car x) (intern (car x) (find-package 'world-kb)))
;;                                  (intern x (find-package 'world-kb))))
;;                  value)))
          (mapcar #'(lambda (x) (if (consp x)
				    (cons (setf (car x) (intern (car x) (find-package 'world-kb))) (cadr x))
                                  (intern x (find-package 'world-kb))))
                  value)))

      ( :ccnum
        (setq world-kb::*congested-cities* nil)
        (setq world-kb::*congested-cities-max* value))

      ( :ccitydelay
        (setq world-kb::*congested-city-delay* value))

      ( :xcitydelay
        (setq world-kb::*crossed-city-delay* value))
      
      ( :ctracks
        (setq world-kb::*congested-tracks*
          (mapcar #'(lambda (x) (if (consp x) (setf (car x) (intern (car x) (find-package 'world-kb)))
                                  (intern x (find-package 'world-kb))))
                  value)))

      ( :ctnum
        (setq world-kb::*congested-tracks* nil)
        (setq world-kb::*congested-tracks-max* value))

      ( :ctrackdelay
        (setq world-kb::*congested-track-delay* value))

      ( :xtrackdelay
        (setq world-kb::*crossed-track-delay* value))
        
      ( :seed
        (setq *initial-seed* value))
      ( :debug
        (setq user::*debug* value))
      )))

;; preload a scenario, etc.
(eval-when (load eval)
  (let ((simple-kr::*simple-kr-alist* 'kqml::world-kb)) ; 
    (world-kb::load-scenario world-kb:*scenario-name*))
  )

(defun check-for-demo ()
  "See if the user has run a demo before, and otherwise, check to see if they want one (or just run one?)."
  (ignore-errors
   (with-open-file (kb-stream (format nil "~A/etc/user-data" user::*trains-base*) 
                    :direction :io
                    :if-does-not-exist :create
                    :if-exists :overwrite)
     (let ((demo-alist (read kb-stream nil nil))
           (user-name (real-user-name))
           (user-preferences (read kb-stream nil nil)))
       (if (and user-preferences
                (assoc user-name user-preferences :test #'equal))
           ;; stuff to remember between runs.
           (destructuring-bind (personality) (cdr (assoc user-name user-preferences :test #'equal))
             (format *error-output* "Setting personality to ~S based on recorded preference." personality)
             (setq generator::*personality* personality))
         (format *error-output* "Using default personality of ~S" generator::*personality*)))))

  (unless (null *do-demo*)
    (run-demo)))





