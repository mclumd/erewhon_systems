;; Time-stamp: <Wed Jan 15 11:09:51 EST 1997 ferguson>

(when (not (find-package :world-kb))
  (load "world-kb-def"))
(in-package world-kb)

(defconstant +world-kb+ (find-package 'world-kb))

(defvar *connection-hash* (make-hash-table))
(defvar *name-hash* (make-hash-table :test #'equal))

(defvar *all-cities* nil)
(defvar *all-tracks* nil)
(defvar *all-engines* nil)

(defvar *obfuscations* 0 "How often we supplied a suboptimal route")
(defparameter *max-search-depth* 3 "We will look no further than this (+1) to find a route.")
(defparameter *number-of-engines* 3 "How many engines.")
(defparameter *congested-cities-max* 3 "maximum number of cities (random) to be congested.")

(defparameter *congested-tracks-max* 0 "maximum number of tracks (random) to be congested.")

(defparameter *congested-track-delay* 10 "Additional cost to have a train use a congested track.")
(defparameter *crossed-track-delay* 5 "Additional cost to have two trains pass each-other on a track (per train)")

(defparameter *congested-city-delay* 5 "Additional cost to have a train use a congested city.")
(defparameter *crossed-city-delay* 3 "Additional cost to have two trains pass each-other through a city (per train)")
(defparameter *city-congestion-delay-alist*
    '((:heavy-traffic . 5)
      (:terminal-repair . 5)
      (:bad-weather . 5)
      (:ice-storm . 5)

      (:snow . 3)
      (:heavy-snow . 6)
      (:lake-effect-snow . 4)
      (:rain . 2)
      (:heavy-rain . 4)
      (:freezing-rain . 6)
      (:storms . 2)
      (:heavy-storms . 4)
      (:fog . 1)

      (:floods . 6)
      (:insurrection . 10)
      (:secession . 8)
      (:plague . 15)
      (:zealots . 12)
      (:ufo . 9)
      (:delegation . 18)
      (:convention . 6)
      (:constitution . 21)
      (:junket . 2)
      (:devastation . 48)
      (:nuclear-accident . 36)))
       
(defparameter *track-congestion-delay-alist*
    '((:heavy-traffic . 5)
      (:track-repair . 5)
      (:bad-weather . 5)
      (:ice-storm . 5)

      (:snow . 3)
      (:heavy-snow . 6)
      (:lake-effect-snow . 4)
      (:rain . 2)
      (:heavy-rain . 4)
      (:freezing-rain . 6)
      (:storms . 2)
      (:heavy-storms . 4)
      (:fog . 1)

      (:floods . 6)
      (:devastation . 48)
      (:nuclear-accident . 36)))

(defparameter *emotions-off-limit* 4 "first n items to use when emotions off")   ; 

(defparameter *scenario-name* "northeast" "file to load for scenario information")
(defparameter *start-locations* nil "pick random if nil, else preset start locations")
(defparameter *congested-cities* nil "pick random if nil, else preset congested cities")
(defparameter *congested-tracks* nil "pick random if nil, else preset congested tracks")

(defparameter *engine-synonyms* '(engine train) "What we can call the engine")
(defparameter *engine-display-type* :engine "What display calls the engine")

;; set up world objects here
(defun create-point (x y)
  (make-point :x x :y y))

(defun setup-city (name x y)
  (let ((new-city (make-city :name name :position (create-point x y))))
    (setf (basic-for-reference-p new-city) nil)
    (setf (gethash name *name-hash*) new-city)
    (push new-city *all-cities*)
    ;;    (simple-add :all-cities new-city)
    new-city))

(defun setup-city-alias (name alias)
  (let ((actual (gethash name *name-hash*)))
    (setf (gethash (intern (string alias) +world-kb+) *name-hash*) actual)
    actual))

(defun setup-track (from to &optional (distance 1) (cost 1))
  ;; hack for new york name
  (flet ((fixup-ny (thingo)
           (if (equalp (string thingo) "NEW_YORK")
               "NEW_YORK_CITY"
             thingo)))
    (let* ((sorted-names (sort (list from to) #'string-lessp))
           (name (format nil "~A-~A" (fixup-ny (car sorted-names)) (fixup-ny (cadr sorted-names))))
           (new-track (make-track :name name :loc-1 from :loc-2 to :distance distance :cost cost)))
      (setf (basic-for-reference-p new-track) nil)
      (pushnew new-track (mo-connections (gethash from *name-hash*)))
      (pushnew new-track (mo-connections (gethash to *name-hash*)))
      (push new-track *all-tracks*)
      ;;(simple-add :all-tracks new-track)
      (setf (gethash (intern (string name) +world-kb+) *name-hash*) new-track)
      ;; build hash table of tracks based on connection.
      (let ((from-entry (gethash from *connection-hash*))
            (to-entry (gethash to *connection-hash*)))
        (setf (gethash from *connection-hash*) (update-alist to new-track from-entry))
        (setf (gethash to *connection-hash*) (update-alist from new-track to-entry)))
      new-track)))

(defun setup-dtrack (from to &optional (distance 1) (cost 1))
  "Like setup-track, but only works in one direction."
  )

(defun setup-engine (name at)
  (let ((new-engine (make-engine :name name :at at)))
    (setf (basic-for-reference-p new-engine) nil)
    (setf (gethash (intern (string name) +world-kb+) *name-hash*) new-engine)
    (push new-engine *all-engines*)
    ;;(simple-add :engine new-engine)
    new-engine))

(defun load-scenario (&optional (sn *scenario-name*))
  ;; create the objects we need for the world. Intern them into the alist (see world-kb).
  (simple-clear)
  (setq *all-cities* nil
        *all-tracks* nil
        *all-engines* nil)
  (clrhash *connection-hash*)
  (clrhash *name-hash*)
  (or
   (load (format nil "scenarios/~A.lisp" sn)
	 :if-does-not-exist nil :verbose nil)
   (load (format nil "~A/etc/scenarios/~A.lisp" user::*trains-base* sn)
	 :if-does-not-exist nil :verbose nil)
   (format *error-output* "DM: couldn't load scenario: ~A~%" sn)))

(eval-when (load eval)
  (add-initialization "Register :world-kb"
                      '(register :world-kb #'process-world-kb-request)
                      () 'kqml::*register-initializations*))

(defun init-world-kb ()
  (declare (special actualization::*emotion-p*))
  (setq *obfuscations* 0)

  (let (trains
        train-locations
        congested-cities
        congested-tracks)

    (load-scenario)
    (let ((start-locs (copy-list *start-locations*)))
      (flet ((pick-loc ()
               (if *start-locations*
                   (gethash (intern (pop start-locs) +world-kb+) *name-hash*)
                 (pick-one *all-cities*))))
        (while (< (list-length train-locations) *number-of-engines*)
          (let* ((engine-name (intern (format nil "ENGINE_~D" (1+ (list-length train-locations))) +world-kb+)))
            (progfoo (pick-loc)
              (unless (member foo train-locations)
                (push foo train-locations)
                (push (setup-engine engine-name foo) trains)))))))

    (flet ((ccity (city &optional reason)
             (declare (type city city))
             (unless (or (member city congested-cities)
                         (member city train-locations))
               (setf (city-congested-p city) t)
               (setf (congestion-reason city) (or reason
                                                  (car (pick-one 
                                                        (if generator::*emotion-p*
                                                            *city-congestion-delay-alist*
                                                          ;; only the first 4
                                                          (butlast *city-congestion-delay-alist*
                                                                   (- (length *city-congestion-delay-alist*) *emotions-off-limit*)))))))
               (push city congested-cities))))
      (if *congested-cities*
          (mapcar #'(lambda (ccpair)
                      (let ((city (if (consp ccpair) (car ccpair) ccpair))
                            (reason (if (consp ccpair) (make-keyword (cdr ccpair)))))
                        (ccity (gethash (intern city +world-kb+) *name-hash*) reason)))
                  *congested-cities*)
        (while (< (list-length congested-cities) *congested-cities-max*)
          (progfoo (pick-one *all-cities*)
            (if (> (list-length (mo-connections foo)) 1) ;don't use terminal cities
                (ccity foo))))))

    (flet ((ctrack (track &optional reason)
             (declare (type track track))
             (unless (member track congested-tracks)
               (setf (track-congested-p track) t)
               (setf (congestion-reason track) (or reason
                                                   (car (pick-one 
                                                         (if generator::*emotion-p*
                                                             *track-congestion-delay-alist*
                                                           ;; only the first 4
                                                           (butlast *track-congestion-delay-alist*
                                                                    (- (length *track-congestion-delay-alist*) *emotions-off-limit*))
                                                           )))))
               (push track congested-tracks))))
      (if *congested-tracks*
          (mapcar #'(lambda (ctpair)
                      (let ((track (if (consp ctpair) (car ctpair) ctpair))
                            (reason (if (consp ctpair) (make-keyword (cdr ctpair)))))
                        (ctrack (gethash (intern track +world-kb+) *name-hash*) reason)))
                  *congested-tracks*)
        (dotimes (n *congested-tracks-max*)
          (declare (ignorable n))
          (progfoo (pick-one *all-tracks* #||(simple-find :all-tracks)||#)
            (ctrack foo)))))

    (list (nreverse trains) congested-cities congested-tracks))) ; reverse trains so it's in the same order as a lookup would generate.





