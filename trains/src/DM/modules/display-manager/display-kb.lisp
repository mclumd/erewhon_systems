;; Time-stamp: <Mon Jan 20 14:18:47 EST 1997 ferguson>

(when (not (find-package :display-kb))
  (load "display-kb-def"))
(in-package :display-kb)

(eval-when (load eval)
  (add-initialization "Register :display-kb"
                      '(register :display-kb #'process-display-kb-request)
                      () 'kqml::*register-initializations*))

(defun reset-dkb ()
  (simple-clear)
  (simple-replace :timeout-value (if user::*debug* 60 30)))

(defun print-tracks (tracks)
  (mapcar #'(lambda (track)
               (intern (string (if (track-p track)
                                   (basic-name track)
                                 track))
                       user::*hack-package*))
           tracks))

(defun dkb-object-name (thingo)
  (let ((ob (object-name thingo)))
    (if (equalp (string ob) "NEW_YORK")
        'world-kb::new_york_city
      ob)))

(defun find-engines-1 (at type)
  (let (result)
    (dolist (eng (simple-find type))
      (if (equalp (object-name at) (object-name (mobile-at eng)))
          (push eng result)))
    result))

(defun find-engines (at)
  ;; return a list of the engines drawn at the location.
  (nconc (find-engines-1 at :engines)
         (find-engines-1 at :ghost-engines)))

(defun generate-unique-orientation (engines)
  (cond
   ((null engines)
    'hack::east)
   (t
    (car (set-difference '(hack::east hack::northeast hack::southeast hack::north 
                           hack::south hack::northwest hack::southwest hack::west) 
                         (mapcar #'(lambda (x) (fix-pkg (mobile-orientation x))) engines))))))

;; define server commands to handle:
(defun process-display-kb-request (input)
  ;; flesh this out for various request types. 
  (let* ((performative (perf input))
         (command (make-keyword (car (content input))))
         (args (cdr (content input)))
         (arg1 (car args))
         (arg2 (cadr args))
         (response))
    (declare (ignore performative))     ; don't use it (yet)
    (create-reply (case command
                    (:restart
                     (flet ((make-engine (eng)
                              (setf (color eng) 'yellow)
                              (push `(hack::create :type ,(fix-pkg world-kb::*engine-display-type*)
                                              :name ,(fix-pkg (basic-name eng))
                                              :color hack::yellow
                                              :fillcolor hack::red
                                              :at ,(fix-pkg (dkb-object-name (mobile-at eng)))
                                              :orientation hack::EAST)
                                    response)))
                       (let ((new-scenario arg1)
                             ;; almost a clear, but we save the engine positions.
                             (engines (simple-find :engines)))
                         (reset-dkb)
                         (cond
                          (new-scenario
                           (simple-addl :engines (setq engines (mapcar #'make-engine (kb-request-kqml (create-request :world-kb
                                                                                                                      '( :engines))))))
                           (dolist (eng engines)
                             (simple-add (fix-pkg (basic-name eng)) eng))
                           (push '(hack::say "OK, here is a new problem for you.") response)
                           (push '(hack::restart) response))
                          (t
                           (mapc #'make-engine engines)
                           (push '(hack::say "OK, I'm starting over.") response)
                           (push '(hack::restart) response)
                           (simple-addl :engines engines)
                           (dolist (eng engines)
                             (simple-add (fix-pkg (basic-name eng)) eng))))
                         response)))
                    ((:clear-world :clear)
                     (reset-dkb)
                     '((restart)
                       (say "OK, I'm starting over."))) ; passed on to display
                  
                    (:identify
                     ;; given an object name, return the object.
                     (or (simple-find arg1)
                         (kb-request-kqml (create-request :world-kb `( :identify ,arg1))))) ; ask the world for it.
      
                    (:world-objects
                     (simple-find :all-objects))
                  
                    (( hack::timeout-value :timeout-value)
                     (or (simple-find :timeout-value)
                         30))
                  
                    (:set-timeout-value
                     (simple-replace :timeout-value arg1)
                     t)
                 
                    (:current-highlights
                     (let ((highlight-type arg1))
                       (if highlight-type
                           (simple-find (highlight-entry highlight-type))
                         (mapcan #'(lambda (hl)
                                     (simple-find (highlight-entry hl)))
                                 +highlight-types+))))
                  
                    (:new-color
                     (let ((colored-objects (objects-with-feature '( :color))))
                       (pick-one (or (set-difference (if arg1 
                                                         *score-colors*
                                                       *color-list*)
                                                     (append arg2 (mapcar #'color colored-objects)))
                                     (if arg1 
                                         *score-colors*
                                       *color-list*)))))
       
                    (:objects-with-feature ; type feature value
                     (objects-with-feature args))
                    (:route-with-feature
                     (route-with-feature args))
       
                    (:define-route 
                        (destructuring-bind (engine-name route-color paths start end plan) args
                          (let* ((routes (simple-find :routes))
                                 (current-route (find engine-name routes 
                                                      :key #'engine
                                                      :test #'(lambda (x y) (equalp (string x) (string y)))))
                                 (new-route (if paths ;;  when paths is null, we're undefining the route
                                                (make-route :engine engine-name
                                                            :name (gensym)
                                                            :color route-color
                                                            :path (make-path-quantum :from (dkb-object-name start)
                                                                                     :to (dkb-object-name end))
                                                            :segment-list paths
                                                            :plan plan)))
                                 (ghostname (intern (format nil "~A-GHOST" engine-name))))
                            (cond
                             (current-route
                              (simple-replace :color (delete nil (nsubstitute new-route current-route (simple-find :color))))
                              (simple-replace :routes (delete nil (nsubstitute new-route current-route routes)))
                              (push `(hack::destroy ,(fix-pkg ghostname)) response)
                              (simple-replace :ghost-engines
                                              (remove-if #'(lambda (x) (equalp (basic-name x) ghostname))
                                                         (simple-find :ghost-engines)))
                              (simple-replace (fix-pkg ghostname) nil)
                              (push `(hack::destroy ,(fix-pkg (basic-name current-route))) response))
                             (new-route
                              (simple-add :color new-route)
                              (simple-add :routes new-route)))
                            (when new-route
                              (let ((tracks (mapcar #'(lambda (x) (if (symbolp x)
                                                                      x ; just the track name
                                                                    (dkb-object-name (get-sslot :track x))))
                                                    paths)))
                                (push `(hack::create :type hack::route
                                                     :thickness 2
                                                     :name ,(fix-pkg (basic-name new-route))
                                                     :start ,(fix-pkg (from (path new-route)))
                                                     :tracks ,(print-tracks tracks)
                                                     :color ,(fix-pkg route-color))
                                      response)
                                (unless (sa-defs:tt-assert end () "Can't display ghost at city nil")
                                  (let* ((other-engines (find-engines end))
                                         (orientation (generate-unique-orientation other-engines)))
                                    (push `(hack::create :type ,(fix-pkg world-kb::*engine-display-type*)
                                                         :name ,(fix-pkg ghostname)
                                                         :color ,(fix-pkg route-color)
                                                         :at ,(fix-pkg (dkb-object-name end))
                                                         :orientation ,orientation
                                                         :outlined t)
                                          response)
                                    (let ((eng  (make-engine :at end
                                                             :name ghostname
                                                             :color route-color 
                                                             :orientation orientation)))
                                      (simple-add :color eng)
                                      (simple-add :ghost-engines eng)
                                      (simple-add ghostname eng))))))))
                        (nreverse response))
                    (:color-engine
                     (destructuring-bind (engine-name color at) args
                       (assert at () "Can't color engine at nil")
                       (let* ((find-result (simple-find (fix-pkg engine-name)))
                              (old-engine (if (consp find-result) (car find-result) find-result)))
                         (push `(hack::create :type ,(fix-pkg world-kb::*engine-display-type*)
                                              :name ,(fix-pkg engine-name)
                                              :color ,(fix-pkg color)
                                              :at ,(fix-pkg (dkb-object-name at))
                                              :orientation ,(mobile-orientation old-engine))
                             response)
                         (push `(hack::destroy ,(fix-pkg engine-name)) response)
                         (let ((eng  (make-engine :name engine-name :color color :at at :orientation (mobile-orientation old-engine))))
                           (simple-add :color eng)
                           (simple-replace (fix-pkg engine-name) eng))))
                     response)
                    (:place-engine
                     (destructuring-bind (engine-name color fillcolor at) args
                       (unless (sa-defs:tt-assert at () "Can't place engine at nil")
                         (let* ((other-engines (find-engines at))
                                (orientation (generate-unique-orientation other-engines)))
                           (push `(hack::create :type ,(fix-pkg world-kb::*engine-display-type*)
                                                :name ,(fix-pkg engine-name)
                                                :color ,(fix-pkg color)
                                                :fillcolor ,(fix-pkg fillcolor)
                                                :fill 100
                                                :at ,(fix-pkg (dkb-object-name at))
                                                :orientation ,orientation) 
                                 response)
                           (let ((eng (make-engine :name engine-name :color color :at at :orientation orientation)))
                             (unless (equal (string color) "BLACK")
                               (simple-add :color eng))
                             (simple-add :engines eng)
                             (simple-add (fix-pkg engine-name) eng)))))
                     response)
                    (:highlight
                     (destructuring-bind (highlight-type object &optional plan) args
                       (let ((entry (highlight-entry highlight-type)))
                         (setq object (dkb-object-name object))
                         (unless (member object (simple-find entry))
                           (simple-add entry object)
                           (when plan
                             (simple-add plan (cons entry object))
                             (simple-add :plan-highlights plan))
                           (generate-highlight-list (fix-pkg object) highlight-type :for-highlight)))))

                    (:unhighlight
                     (do-unhighlight args))
                    
                    (:unhighlight-plan-objects ;; arg1 is plan
                     (let* ((plan arg1)
                            (plan-highlights (simple-find plan)))
                       (mapc #'(lambda (eobpair)
                                 (do-unhighlight  eobpair)) ; don't tell it the plan, I'll clean up.
                             plan-highlights)
                       (simple-subtract :plan-highlights plan)
                       (simple-replace plan nil)))
                    
                    (:focus
                     #||(let ((object (dkb-object-name arg1)))
                          (unless (equal object (car (simple-find :focus)))
                            (simple-replace :focus (list object))
                            `((hack::focus ,(fix-pkg object)))))||# ; display doesn't currently handle it.
                     )
                    ((:zoom-level :ZOOM-IN :ZOOM-OUT :draw-arrow :erase-arrow :show :unshow)
        
                     )
                    ((:current-arrows :object-features)
                     )
                    (:all-visible-objects)
      
                    (:info-menu-items)
                    (t
                     (error "no such case: ~S" command))))))

(defun highlight-entry (highlight-level)
  (sa-defs:tt-assert (member highlight-level +highlight-types+) (highlight-level)
    "~S is not a recognized highlight level. Legal levels are: ~S"
    highlight-level +highlight-types+)
  (make-keyword (format nil "HIGHLIGHT-~A" highlight-level)))

(defun do-unhighlight (args)
  (destructuring-bind (highlight-type object &optional plan) args
    (let ((entry (highlight-entry highlight-type)))
      (setq object (dkb-object-name object))
      (when plan
        (let*-non-null ((pe (simple-find plan)))
          (simple-replace plan (delete-if #'(lambda (eobpair)
                                              (and (eq (car eobpair) entry)
                                                   (eql object (cdr eobpair))))
                                          pe))))
      (when (member object (simple-find entry))
        (simple-subtract entry object)
        (generate-highlight-list (fix-pkg object) highlight-type nil)))))

(defun objects-with-feature (args)
  (let ((hits (simple-find (car args))))
    (if (cdr args)
        (destructuring-bind (feature featurevalue) (cdr args) ; car is the type.
          (find-if #'(lambda (ob)
                       (equal featurevalue
                              (slot-value ob (intern feature (find-package 'demo-kb-lib)))))
                   hits))
      hits)))

(defun route-with-feature (args)
  (destructuring-bind (feature featurevalue) args
    (find-if #'(lambda (route)
                 (let ((slotval (slot-value route (intern feature (find-package 'demo-kb-lib)))))
                   (or (equal featurevalue slotval)
                       ;; could be package
                       (if (and (symbolp featurevalue) (symbolp slotval)
                                (not (eq (symbol-package featurevalue) (symbol-package slotval))))
                           (equalp (string featurevalue) (string slotval))))))
             (simple-find :routes))))
                  
(defun generate-highlight-list (object highlight-type for-highlight-p)
  (let ((highlight-features (type-for-highlight highlight-type)))
    (cond
     (for-highlight-p
      (if (consp (car highlight-features)) ; has a flash too
          (mapcar #'(lambda (x)
                      `(hack::highlight ,object ,@x))
                  highlight-features)
        `((hack::highlight ,object ,@highlight-features))))
     (t
      (if (consp (car highlight-features)) ; ignore the flash (second object)
          `((hack::unhighlight ,object ,@(car highlight-features)))
        `((hack::unhighlight ,object ,@highlight-features)))))))

