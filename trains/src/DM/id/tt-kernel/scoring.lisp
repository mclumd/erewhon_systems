;;; Time-stamp: <Mon Jan 13 17:31:05 EST 1997 ferguson>

(when (not (find-package :hack))
  (load "hack-def"))
(in-package hack)

(defparameter *magic-score-constant* 100)
(defparameter *bad-route-penalty* 40 "number of hops (& hours) penalty when engine isn't in a destination.")
(defparameter *interactions-per-minute* 6 "number of expected interactions per minute.")
(defparameter *goal-cities* nil "Nil to choose randomly")
(defparameter *score-p* t "Final Scoring enabled")
(defvar *hack-goal* nil)
(defvar *do-demo* nil)

(defparameter *known-goals* :rootabega "T: phenny and narco know. NIL: neither know. Anything else and phenny knows but narco doesn't (allows scoring)")
(defparameter *minimum-interactions* 3 "Allow the user to state the goals, quit, and confirm the quit")

(defparameter *depth-check-init* 24 "Amount of hours to attempt to solve problem initially. Then kick by below number if none found.")
(defparameter *depth-check-kick* 6 "Amount to increase score-time by when checking routes. Depends on minimal time in route to follow a link, but overestimating doesn't kill us.")

(eval-when (load eval)
  (add-initialization "Register :score"
                      '(register :score #'handle-scoring-request) ; shouldn't get any direct requests (yet)
                      () 'kqml::*register-initializations*))


(defun compare-by-name (x y)
  (equalp (string (object-name x)) (string (object-name y))))

(let* ((start-time 0)
       (system-interactions 0)
       (trains nil)
       (goals 2) ; number of trains, really
       (congested-cities nil)
       (congested-tracks nil)
       (goal-cities *goal-cities*)    ; local copy of global value.
       (max-routing-distance 4) ; distance we will self-route
       (best-case-time 100000)         ; best train time to solve problem
       (best-case-hops 0)
       (best-case-distance 0)
       (best-case-cost 0)
       (best-case-routes nil)
       )
  
  (defun count-interactions ()
    (prog1 (incf system-interactions)
      (if (zerop start-time)
          (setq start-time (get-universal-time))))) ; record first interaction time as start-time.
  
  (defun system-interactions ()
    system-interactions)
  
  (defun reset-interactions ()
    (setq system-interactions 0))
  
  (defun ignore-interaction ()
    (decf system-interactions)
    (if (< system-interactions 0)
        (reset-interactions)))
  
  (defun find-solution ()
    (let ((ps-solution (kb-request-kqml 
                        (create-request :ps
                                        `(:find-solution :content
                                                         (:and
                                                          ,@(mapcar #'(lambda (c) 
                                                                        `(:go ,(fix-pkg (gentemp "G" user::*hack-package*))
                                                                              (:to ,(fix-pkg (object-name c)))))
                                                                    goal-cities)))))))
      ;; something like (((:agent <foo> :actions (...))
      ;;                  (:agent <bar> ...))
      ;; where a route is ((:GO GO821 (:FROM MILWAUKEE) (:TO CHICAGO) (:TRACK CHICAGO-MILWAUKEE))
      ;;                   (:GO GO822 (:FROM CHICAGO) (:TO INDIANAPOLIS) (:TRACK CHICAGO-INDIANAPOLIS)))
      (setq best-case-time (extract-keyword :cost ps-solution)) ; for now, because my idea of time is train-time, not 
      (setq best-case-hops (extract-keyword :hops ps-solution)) ; maximum plan-time (which it really should be, but
      (setq best-case-cost (extract-keyword :cost ps-solution)) ; scoring doesn't care)
      (setq best-case-distance (extract-keyword :distance ps-solution))
      ;;  (list start-city destination-city best-so-far best-route-so-far best-hops-so-far)
      (setq best-case-routes
        (mapcar #'(lambda (r)
                    (let ((actions (extract-keyword :actions r)))
                      (list (get-sslot :from (car actions))
                            (get-sslot :to (car (last actions)))
                            nil         ; no longer needed
                            (mapcar #'(lambda (act)
                                        (get-sslot :track act))
                                    actions))))
                (extract-keyword :routes ps-solution)))))

  #||
    ;; check each combination, account for congestion (but not crossing, sigh)
    (let (allcost
          (user::*debug* nil))          ; avoid too many messages
      (handle-speech "Hold on... I'm looking for optimal solutions for scoring.")
      (dolist (start-city (mapcar #'mobile-at trains))
        (let (paircost
              (*game-in-progress* nil)) ; don't slow down speech for status reports.
          (dolist (destination-city goal-cities)
            (let ((best-so-far 10000)
                  (best-so-far-d 0)
                  (best-hops-so-far 0)
                  (n *depth-check-init*)                ; start at 10 hours
                  (best-route-so-far nil)
                  (score-rq-kqml (create-request :world-kb `(:score-route nil) :score)) ; reuse these for speed.
                  (frv-rq-kqml (create-request :world-kb
                                               `(:find-routes-via-with-limit
                                                 ,(make-path-quantum :from start-city :to destination-city)
                                                 0)
                                               :score)))
              (while (< n best-so-far)
                (setf (third (content frv-rq-kqml)) n) ; reuse for speed.
                (if (= n (+ *depth-check-init* *depth-check-kick*))
                    (handle-speech "Examining ~A to ~A. " (say-name start-city) (say-name destination-city)))
                (if (>= n (+ *depth-check-init* *depth-check-kick*))
                    (handle-speech "Checking ~D hours..." n))
                (mapc #'(lambda (route)
                          (setf (second (content score-rq-kqml)) route) ; reuse for speed.
                          (destructuring-bind (time hops distance)
                              (kb-request-kqml score-rq-kqml)
                            (when (< time best-so-far)
                              (setq best-so-far-d distance)
                              (setq best-so-far time)
                              (setq best-hops-so-far hops)
                              (setq best-route-so-far (force-list route)))))
                      (kb-request-kqml frv-rq-kqml))
                (incf n *depth-check-kick*))
              (handle-speech "Solution found!")
              (push (list start-city destination-city best-so-far best-route-so-far best-hops-so-far best-so-far-d) paircost)))
          ;; that's it for this start city.
          (push paircost allcost)))
      ;; add up the possible combinations, and find the best
      (setq best-case-time 10000)
      (dolist (route-entry (delete-if #'(lambda (entry)
                                          ;; remove the ones that don't cover the destination set.
                                          (nset-difference (copy-list goal-cities) (mapcar #'second entry)))
                                      (apply #'cross-product allcost)))
        (destructuring-bind (score hops distance) 
            (kb-request-kqml (create-request :world-kb `( :score-route ,@(mapcar #'fourth route-entry)) :score))
          (declare (ignore distance))
          (cond 
           ((< score best-case-time)
            (setq best-case-time score)
            (setq best-case-hops hops)
            (setq best-case-routes (list route-entry)))
           ((= score best-case-time)
            (if (< hops best-case-hops)
                (setq best-case-hops hops))
            (push route-entry best-case-routes))))))
    (tt-assert (and (plusp best-case-time)
                    (plusp best-case-hops)) () "didn't find a route")
    ||#
  
  (defun handle-scoring-request (reply)
    (let ((sender (sender reply)))
      (if (and (eql sender 'speech-out)
               (eql (car (content reply)) 'done))
          ()                            ; ignore it, we aren't waiting for the dones.
        (handle-kqml (create-error sender 999 "Bad request/reply for SCORE" :score)))))
        
  (defun generate-new-problem (&aux (kqml::*kqml-re* 99999)) ; so we can track it
    ;; pick some random goals
    (transcribe-and-log :SCORE "Scenario: ~A, Engines: ~D" world-kb::*scenario-name* world-kb::*number-of-engines*)
    (destructuring-bind (tr cc ct) 
        (kb-request-kqml (create-request :world-kb '( :clear) :score))
      (setq max-routing-distance (1+ world-kb::*max-search-depth*))
      (when ct
        (format *error-output* "~&~{~A ~}are congested tracks.***~%" (mapcar #'say-name ct))
        (transcribe-and-log :SCORE "***Scenario Choice Made: ~{~A ~}are congested tracks.***~%" (mapcar #'say-name ct)))
      
      (when cc
        (format *error-output* "~&~{~A ~}are congested cities.~%" (mapcar #'say-name cc))
        (transcribe-and-log :SCORE "***Scenario Choice Made: ~{~A ~}are congested cities.***~%" (mapcar #'say-name cc)))

      (setq trains tr
            congested-cities cc
            congested-tracks ct
            goals world-kb::*number-of-engines*)) ; might have been reset by application args
    
    (kb-request-kqml (create-request :display-kb '( :clear) :score))
    (kb-request-kqml (create-request :self-model-kb '( :clear) :score))
    (kb-request-kqml (create-request :user-model-kb '( :clear) :score))
    (kb-request-kqml (create-request :context-manager '( :clear) :score))

    (verbal-reasoner::clear-ps :score) ; clear problem solver, and initialize it (now remote)
    
    (when *known-goals*
      (cond
       ((null *goal-cities*)
        (setq goal-cities nil)
        (let* ((all-cities (kb-request-kqml (create-request :world-kb '( :all-cities) :score)))
               (start-cities (mapcar #'mobile-at trains))
               (prohibited-cities
                (union (union start-cities congested-cities)
                       ;; all cities next to a start city.
                       (mapcan #'(lambda (sc)
                                   (mapcar #'(lambda (x)
                                               (kb-request-kqml 
                                                (create-request :world-kb 
                                                                `( :identify ,(other-connection x sc)) :score)))
                                           (mo-connections sc)))
                               start-cities))))
          ;;(do-log :SCORE ";;scoring: ~S are prohibited." prohibited-cities)
          (while (< (list-length goal-cities) goals)
            (let ((possible-goal (pick-one all-cities)))
              (unless (or (member possible-goal goal-cities)
                          (member possible-goal prohibited-cities))
                (push possible-goal goal-cities))))))
       (t
        (setq goal-cities *goal-cities*)))
      ;; inform the display
      (send-goal goal-cities)
      ;; should the system know what the goals are
      (when (eq *known-goals* t)
        ;; yes
        (mapc #'(lambda (goal)
                  (kb-request-kqml (create-request :ps `( :new-subplan :content ( :go ,(gentemp user::*hack-package*) (:to ,goal))) :score))
                  (place-goal goal))
              goal-cities)
        (refresh-display :score)) ; display the goals
      ))
    
  (defun state-problem (&aux (kqml::*kqml-re* 99998))
    (let ((start-cities (mapcar #'(lambda (e) (say-name (mobile-at e))) trains))
          (destination-cities (mapcar #'say-name goal-cities))
          (kqml:*kqml-recipient* 'score))

      (transcribe-and-log :SCORE "***Scenario Choice Made: ~{~A ~}are the start cities.***~%" start-cities)
      (transcribe-and-log :SCORE "***Scenario Choice Made: ~{~A ~}are the destination cities.***~%" destination-cities)

      (setq goals (list-length trains))
      (setq start-time 0)
      
      (dolist (engine trains) ;; fix engine locations
        (place-engine (display-kb::dkb-object-name engine) (mobile-at engine)))

      (let* ((engine-name (string-downcase (string (car (kb-request-kqml
                                                         (create-request :world-kb '( :engine-synonyms) :score))))))
             (pronouncement (concatenate 'string
                              (format nil "The ~As are \\!/ currently at " engine-name)
                              (apply #'format nil generator::*format-control-for-list-reference* start-cities)
                               " \\!sf15 .")))
        (transcribe-and-log :score pronouncement)
        (unless (not *known-goals*)
          (send-to-log (format nil "ini ~A" pronouncement))
          (handle-speech pronouncement)))
      
      (cond
       (*known-goals*
        (let ((pronouncement (concatenate 'string
                               "\\!{F.5 \\!*H*1.1 Your goal is to get them to "
                               (apply #'format nil generator::*format-control-for-list-reference* destination-cities)
                               " \\!sf70 .")))
          (transcribe-and-log :score pronouncement)
          (send-to-log (format nil "ini ~A" pronouncement))
          (handle-speech pronouncement))))))

  (defun do-score (&aux (kqml::*kqml-re* 99993))
    (switch-to-female-voice)

    (let* ((total-cities (list-length (kb-request-kqml (create-request :world-kb '( :all-cities) :score))))
           (numgoals (list-length goal-cities))
           (potential-assistance) ;adjusted for how much we hurt.
           (complexity)
           (actual-hops 0)
           (total-time-seconds (- (get-universal-time) start-time))
           (actual-time (ceiling (/ total-time-seconds 60)))
           (solution-time 0)
           (score 0)
           (missing-cities 0)
           (greetings (kb-request-kqml (create-request :self-model-kb '( :greeting-level) :score)))
           (gcities (mapcar #'object-name goal-cities)) ; make a local copy
           (frustration-level (or (kb-request-kqml (create-request :self-model-kb '( :frustration-level) :score)) 0))
           (bonus (* 3 frustration-level))
           (ipm (/ *interactions-per-minute*
                   (if cl-user::*debug* 1.25 1) ; debugging slows system for log generation,
                                        ; and presumably reporting bugs.
                   ))
           (expected-time 0)
           (expected-interactions 0))
      
              ;; don't count politeness against user
        (when (and greetings (plusp greetings))
          (decf system-interactions)
          (decf actual-time))            ; and give her an extra minute for being nice.

        (let (all-routes)
          (dolist (eng (kb-request-kqml (create-request :world-kb '( :find-engines) :score)))
            (let ((goal (caar (do-ps-find `(:at-loc ,eng hack::?loc) '(hack::?loc) :score)))
                  (route (caar (do-ps-find `( :engine-route ,eng hack::?route) '(hack::?route) :score))))
              (cond
               ((member goal gcities :test #'compare-by-name)
                (setf gcities (delete goal gcities :test #'compare-by-name)) ; can only use a goal once.
                (push (mapcar #'(lambda (track)
                                  (if (consp track)
                                      (setq track (get-sslot :track track))) ; for now
                                  (kb-request-kqml (create-request :world-kb `( :identify ,track))))
                              route)
                      all-routes))
               (t
                (incf missing-cities)
                (incf solution-time *bad-route-penalty*)
                (incf actual-hops *bad-route-penalty*)))))
          ;; reverse all-routes so it's in same order as engines
          (destructuring-bind (s h d) (kb-request-kqml (create-request :world-kb `( :score-route ,@(nreverse all-routes)) :score))
            (declare (ignore d))
            (incf solution-time (round-to s .01))
            (incf actual-hops (round-to h .01))))

      (cond
       ((and *score-p*
             *known-goals*)

        (handle-speech " \\!si70 OK.")

        (find-solution)
        (setq potential-assistance (max (/ best-case-hops max-routing-distance)
                                        numgoals))
        (setq complexity  (ceiling (+ (/ (expt (1- (list-length trains))
                                               (max 1 (ceiling (+ (/ (list-length congested-cities) 2) (list-length congested-tracks)))))
                                         (/ total-cities 22) ; scale to wny map. (more cities is easier).
                                         8) ; normalize, since hops should be the main factor in problem size.
                                      potential-assistance)))

        
        (flet ((display-system-route ()
                 (handle-speech "Here is the route \\!* I used:")
                 (dolist (r best-case-routes)
                   (display-route (car r) ; start
                                  (fourth r) ; tracks
                                  (kb-request-kqml (create-evaluate :display-kb '(:new-color :score) :score)))))) ; color
      
          (cond
           ((plusp missing-cities)
            (apply #'handle-speech (concatenate 'string
                                     (format nil "\\!sf8 You missed getting \\!c to \\!- ~D cities" missing-cities)
                                     (format nil generator::*format-control-for-list-reference* (mapcar #'say-name gcities))
                                     "."))
            (transcribe-and-log :SCORE "***Missing cities: ~S" missing-cities)
            (display-system-route))

           ((> solution-time best-case-time)
            (handle-speech "You made it to every city, using \\!1.1 ~D more hours \\!- than the best case, ~D." 
                             (round (- solution-time best-case-time))
                             (round best-case-time))
            (transcribe-and-log :SCORE "***Suboptimal by ~D cities (best: ~D)." (- solution-time best-case-time) best-case-time)
            (display-system-route))
           
           ((< solution-time best-case-time)
            (handle-speech "Wow! You made it to every city, doing better than \\!*.8 I \\!- would've done!")
            (transcribe-and-log :SCORE "***Supraoptimal solution! Best: ~D Actual: ~D" best-case-time solution-time)
            (incf complexity)
            (display-system-route))

           (t
            (handle-speech "\\!c You made it \\!c to every city, using an optimal path.")
            (transcribe-and-log :SCORE "***Optimal solution."))))

        (setq expected-interactions (ceiling (* (max (+ *minimum-interactions* numgoals)
                                                     (* (+ (/ (- (/ best-case-time best-case-hops) ; we'll poke around more, 
                                                                 1) ; normalize
                                                              2) ; scale
                                                           1) ; back to reality
                                                        potential-assistance))
                                                (cond
                                                 ((> *used-speech* system-interactions) ; text is harder.
                                                  1)
                                                 ((plusp *used-speech*)
                                                  (max 1.4 (* 1.4 (/ (- system-interactions *used-speech*) system-interactions))))
                                                 (t
                                                  1.4))))) ; harder with text, contrary to expectations.
        (setq expected-time (ceiling (* (/ expected-interactions ipm)
                                        (cond 
                                         ((> *used-speech* system-interactions)
                                          1) ; text takes a little longer (later we can figure out how much)
                                         ((plusp *used-speech*)
                                          (max 1.4 (* 1.4 (/ (- system-interactions *used-speech*) system-interactions))))
                                         (t
                                          1.4)))))
        (handle-speech "You took ~D minutes, and made ~D \\!r.9 interactions \\!r1 with the system."
                       actual-time system-interactions)
          
        (handle-speech "I expected you to take ~D minutes, and make ~D \\!r.9 interactions \\!r1 with the system, for \\!*1.1 this \\!- level of problem."
                       expected-time expected-interactions)
 
        (transcribe-and-log :SCORE "***User Time: ~D seconds ~D interactions.~%" total-time-seconds system-interactions)



        ;; we might have adjusted complexity.
        (setq score (max (- (floor (* (/ expected-interactions system-interactions)
                                      (/ expected-time
                                         (if (zerop actual-time)
                                             1
                                           actual-time))
                                      (/ (- numgoals missing-cities) numgoals) ; scale
                                      (/ best-case-time solution-time)
                                      complexity ; a hack, but harder problems should score higher.
                                      *magic-score-constant*))
                            bonus)      ; bonus if we liked you, hurts if we didn't.
                         0              ; don't go negative
                         (* (- numgoals missing-cities) 10))) ;; minimum 10 points per city reached.
        (transcribe-and-log :SCORE "***Score: ~D, complexity: ~D, distance: ~D/~D hops: ~D/~D speech: ~S Frustration: ~D  PA factor: ~D***" 
                            score complexity solution-time best-case-time actual-hops best-case-hops *use-speech* frustration-level potential-assistance)
        (send-to-log (format nil "SCR ~D VTIME ~D/~D HOPS ~D/~D TIME ~D INTERACTIONS ~D DEGREEofDIFFICULTY ~D Best-Distance: ~D Best-Cost: ~D" 
                             score solution-time best-case-time actual-hops best-case-hops total-time-seconds system-interactions complexity best-case-distance best-case-cost))

        (handle-speech "I rated this problem as \\!*1.2 ~[easy~;not hard~;fair~;difficult~;very hard~:;impossible~], ~
which gives you a score of ~D, with an average score of ~D~A" 
                       (floor (/ complexity 2))
                       score
                       *magic-score-constant*
                       (cond
                          ((plusp bonus)
                          (format nil ", and includes a penalty of \\!- ~D." bonus))
                          ((zerop bonus)
                           "")
                          (t
                          (format nil ", and includes a \\!* bonus of \\!- ~D." (- bonus)))))
         (handle-speech "~A score \\!bH !"
                         (cond
                          ((> score 1100)
                          "A \\!{R175 \\!bH \\!*1.2 stupendous")
                          ((> score 1000)
                          "\\!{R175 \\!{T205 A \\!r.8 \\!- super \\!r.7 \\!*1.1 colossal \\!r1")
                          ((> score 900)
                          "\\!{R175 \\!{T205 A \\!r.9 \\!* colossal \\!r1")
                          ((> score 800)
                          "\\!{R175 \\!{T200 A \\!r.9 \\!*1.2 fantastic \\!r1 ")
                          ((> score 700)
                          "An \\!*1 amazing")
                          ((> score 600)
                          "\\!{R175 \\!{T205 A \\!c really hip")
                          ((> score 500)
                           "An impressive")
                          ((> score 400)
                          "\\!{R175 \\!{T205 A terrific")
                          ((> score 350)
                          "\\!{R175 \\!{T205 A \\!* marvelous")
                          ((> score 300)
                          "A \\!r1.3 \\!* marvy \\!r1 \\( *[3]\\) ")
                          ((> score 250)
                          "\\!{R175 \\!{T205 An excellent")
                          ((> score 200)
                          "\\!{R175 \\!{T205 A very \\!c good")
                          ((> score 150)
                          "\\!{R175 \\!{T205 A \\!r.9 pretty good \\!r1")
                          ((> score 110)
                          "\\!{R175 \\!{T205 A \\!r.9 fair to middling \\!r1")
                          ((> score 90)
                          "\\!{R175 \\!{T205 An \\!* unremarkable")
                          ((> score 70)
                           "A poor")
                          ((> score 50)
                           "A lousy")
                          ((> score 30)
                          "A \\!r.8 \\!* miserable \\!r1")
                          ((> score 10)
                          "A \\!r1.2 dreadful \\!r1")
                          ((plusp score)
                           "A hopeless")
                          (t
                          "A \\!r1.2 \\!* nausea inducing \\!r1")))
          
          (when (> system-interactions 2) ; make sure there's enough to average over.
            (let ((average-frustration (/ frustration-level system-interactions)))
              (cond
               ((>= average-frustration 1)
               (handle-speech "Brad considered \\!* you to$2 be \\!fH \\!* amazingly \\!- difficult \\!c to$2 work with."))
               ((> average-frustration .5)
               (handle-speech "Brad considered \\!* you \\!c to be quite annoying \\!c to$2 work with."))
               ((<= average-frustration -1)
               (handle-speech "Brad and \\!* I really enjoyed working with you,\\!c  and we look forward \\!c to$2 dealing with you again!"))
               ((< average-frustration -.5)
               (handle-speech "Brad and I \\!r1.1 enjoyed \\!r1 working with you!")))))

        
        (sleep 10)
        (handle-kqml (create-broadcast :im `(tell :content (end-conversation :score ,score 
                                                         :complexity ,complexity 
                                                         :time ,total-time-seconds 
                                                         :interactions ,system-interactions
                                                         :vtime ,solution-time
                                                         :best-time ,best-case-time
                                                         :hops ,actual-hops
                                                         :best-hops ,best-case-hops
                                                         :best-distance ,best-case-distance
                                                         :best-cost ,best-case-cost))
                                  :score)))
       (t
        (handle-kqml (create-broadcast :im `(tell :content (end-conversation :time ,total-time-seconds 
                                                         :interactions ,system-interactions
                                                         :vtime ,solution-time
                                                         :hops ,actual-hops))
                                  :score)))))
    (setq *game-in-progress* nil)))


