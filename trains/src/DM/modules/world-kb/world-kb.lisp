;; Time-stamp: <Mon Jan 13 17:15:44 EST 1997 ferguson>

(when (not (find-package :world-kb))
  (load "world-kb-def"))
(IN-PACKAGE world-kb)

(defun city-name (city-object)
  (cond
   ((symbolp city-object)
    (intern city-object +world-kb+))
   ((city-p city-object)
    (basic-name city-object))
   ((consp city-object)
    (mapcar #'city-name city-object))))

(defun engine-name (engine-object)
  (cond
   ((symbolp engine-object)
    (intern engine-object +world-kb+))
   ((engine-p engine-object)
    (basic-name engine-object))))

(defun process-world-kb-request (input)
  (let ((command (first (content input)))
        (arg1 (second (content input)))
        (arg2 (third (content input))))
    (create-reply (ecase command
                    (:clear
                     (debug-log :world-kb :hard "Clearing WORLD-KB")
                     (init-world-kb))
                    (:engine-synonyms
                     (mapcar #'make-keyword *engine-synonyms*))
                    (:find-objects-of-type
                     (let ((type arg1))
                       (case type
                         (:engine
                          *all-engines*)
                          ;;(simple-find :engine)
                         (:city
                          *all-cities*)
                          ;;(simple-find :all-cities)
                         (:track
                          *all-tracks*))))
                          ;;(simple-find :all-tracks)
                    ( :all-cities
                     *all-cities*)
                    ( :all-tracks
                     *all-tracks*)
                    ( :find-engine
                     ;; passes a location name, return the name of the engine there.
                     (find-if #'(lambda (engine)
                                  (let ((request-city (city-name arg1)))
                                    (equalp (object-name (mobile-at engine)) (object-name request-city))))
                              *all-engines*))
                    (:identify
                     (progfoo
                         (gethash (intern (string arg1) +world-kb+) *name-hash*)
                       (if (and (consp foo) (null (cdr foo)))
                           (setq foo (car foo)))))
                    ( :engine-location
                     (mobile-at (gethash (engine-name arg1) *name-hash*)))
                    ( :find-engines
                     *all-engines*)
                    ( :find-location
                     (find-location arg1))
                    (:find-track
                     ;; passes two location names, returns track name if a track directly connects them.
                     (find-track (city-name arg1) (city-name arg2)))
                    (:find-route-via
                     ;; passes three or four location names, returns a list of track names that connect the first two (if short),
                     ;; that goes through the third.
                     (find-route-via (from arg1) (to arg1) (via arg1) (mapcar #'basic-name (not-via arg1))))
                    (:find-routes-via
                     (find-routes-via (from arg1) (to arg1) (via arg1) (mapcar #'basic-name (not-via arg1))))
                    (:find-routes-via-with-limit
                     (let ((*max-search-depth* arg2))
                       (find-routes-via (from arg1) (to arg1) (via arg1) (mapcar #'basic-name (not-via arg1)))))
                    (:score-route
                     (multiple-value-list (apply #'score-route (cdr (content input)))))
                    ))))

(defun find-city-if-necessary (city)
  (cond
   ((symbolp city)
    (gethash city *name-hash*))                ; efficiency
   ((and (city-p city)
         (not (basic-for-reference-p city)))
    city)
   ((city-p city)
    (gethash (name city) *name-hash*))
   (t
    (gethash city *name-hash*))))

(defun find-track (loc1 loc2)
  (declare (optimize (speed 0) (safety 3) (debug 3)))
  (let ((c1 (object-name loc1))
        (c2 (object-name loc2)))
    (let ((hash-entry (gethash c1 *connection-hash*)))
      (cdr (assoc c2 hash-entry)))))
;  (let*-non-null ((city1 (find-city-if-necessary loc1))
;                  (city2 (find-city-if-necessary loc2)))
;    ;;later, we can extend to handle contents in addition to city names
;    (when (and (city-p city1)
;               (city-p city2))
;      (find-if #'(lambda (connection)
;                   (eq (basic-name city2) (other-connection-city connection (basic-name city1))))
;               (mo-connections city1))))

(defun intermediate-cities (city1 not-via)
  (let ((c1name (basic-name city1))
        result)
    (mapc #'(lambda (track)
              (let ((oc (other-connection-city track c1name)))
                (unless (member oc not-via)
                  (push oc result))))
          (mo-connections city1))
    result))

(defun find-route (loc1 loc2 &optional (depth 0) not-via)
  (cond-binding-predicate-to foo
    ((or (> depth *max-search-depth*)
      (eq loc1 loc2))
     nil)                               ; don't look further
    ((find-track loc1 loc2)
     (list foo))                        ; direct connection
    (t
     (let*-non-null ((city1 (find-city-if-necessary loc1))
                     (possible-intermediates (intermediate-cities city1 not-via)))
       (let ((results nil))             ; list of results.
         (dolist (int possible-intermediates)
           (let*-non-null ((new-route (find-route int loc2 (1+ depth) (cons (object-name loc1) not-via))))
             (push (append new-route (list (find-track loc1 int))) results)))
         (when results
           (let* ((result (pick-one results)) ; pick one, (confuse the user if possible).
                  (score (basic-score-route result)))
             ;; if we picked suboptimally, increment obfuscations, for scoring purposes.
             (block worst
               (dolist (r results)
                 (when (< (basic-score-route r) score)
                   (debug-log :world-kb :hard ";; world-kb: Picked suboptimal route")
                   (incf *obfuscations*)
                   (return-from worst nil))))
             result)))))))

(defun find-routes (loc1 loc2 &optional (depth 0) not-via)
 (declare (optimize (speed 0) (safety 3) (debug 3)))
  (cond-binding-predicate-to foo
    ((or (> depth *max-search-depth*)
      (eq loc1 loc2))
     nil)                               ; don't look further
    ((find-track loc1 loc2)
     (list foo))                        ; direct connection
    (t
     (let*-non-null ((city1 (find-city-if-necessary loc1))
                     (possible-intermediates  (intermediate-cities city1 not-via)))
       (let ((results nil))             ; list of results.
         (dolist (int possible-intermediates)
           (let*-non-null ((new-routes (find-routes int loc2 (1+ depth) (cons (object-name loc1) not-via))))
             (let ((delta (list (find-track loc1 int))))
               (setq results (nconc results (mapcar #'(lambda (subroute)
                                                        (append delta
                                                                (if (consp subroute)
                                                                    subroute
                                                                  (list subroute))))
                                                    new-routes))))))
         results)))))

(defun find-route-via (loc1 loc2 via not-via &optional (depth 0))
  (cond
   ((null via)
    (find-route loc1 loc2 depth not-via))
   (t
    (setq via (force-list via))
    (if (member loc1 via)
        (find-route-via loc1 loc2 (remove loc1 via) not-via depth)) ;; because it's amazing what a user will say.
    (if (member loc2 via)
        (find-route-via loc1 loc2 (remove loc2 via) not-via depth))
    (let ((first-part (find-route loc1 (car via) depth not-via))
          (second-part (find-route-via (car via) loc2 (cdr via) (cons (object-name loc1) not-via) depth)))
      (append (force-list first-part)
              (force-list second-part))))))


(defun find-routes-via (loc1 loc2 via not-via &optional (depth 0))
  (declare (optimize (safety 3) (speed 0) (debug 3)))
  (handler-bind ((storage-condition #'(lambda (c) (declare (ignore c)) (return-from find-routes-via nil)))) ;; too complex a path.
    (cond
     ((null via)
      (find-routes loc1 loc2 depth not-via))
     (t
      (setq via (force-list via))
      (if (member loc1 via)
          (find-routes-via loc1 loc2 (remove loc1 via) not-via depth))
      (if (member loc2 via)
          (find-routes-via loc1 loc2 (remove loc2 via) not-via depth))
      (let ((first-part (find-routes loc1 (car via) depth not-via))
            (second-part (find-routes-via (car via) loc2 (cdr via) (cons (object-name loc1) not-via) depth))
            result)
        ;; for each first part option, combine with second-part option.
        (dolist (f first-part)
          (setq f (force-list f))
          (mapc #'(lambda (s)
                    (setq s (force-list s))
                    (unless (eq (car (last f)) (first s))
                      (push (append (force-list f) (force-list s)) result)))
                second-part))
        result)))))

(defun find-location (object)
  (if (engine-p object)
      (mobile-at (gethash (engine-name object) *name-hash*))
    (find-city-if-necessary object)))

(defun next-posn (track posn)
  (if track 
      (other-connection-city track (object-name posn))
    posn))

(defun score-route (&rest routes)
  (declare (optimize (debug 3)))
  ;; add penalties for cities and tracks in route. This doesn't count overlaps (yet).
  (if (null (cdr routes))
      (basic-score-route (car routes))
    (let ((distance 0)
          (time 0)
          (actual-hops 0))
      (dolist (r routes)
        (mlet (ti h d) (basic-score-route r)
          (incf distance d)
          (incf time ti)
          (incf actual-hops h)))
      (let ((positions (mapcar #'mobile-at *all-engines*))
            (tracks routes))
        ;; check that order is ok.

        (while (some #'identity tracks)
          (let* ((current-set (mapcar #'car tracks))
                 (filtered-set (remove nil current-set))) ; remove shorter routes.

            ;; if any member of tracks appears more than once, it's a conflict. (handle n engines).
            (incf time (* *crossed-track-delay* (list-length (find-matches filtered-set))))
            ;; Also, if after taking a track, the destination (other city from position) matches for any pair, that's a congestion too,
            ;;  UNLESS it's the destination of the engine (no further movement).
            (setq positions (mapcar #'next-posn current-set positions))
            (incf time (* *crossed-city-delay* (list-length (find-matches positions))))
            (setq tracks (mapcar #'cdr tracks)))))
      (values time actual-hops distance))))

(defun basic-score-route (route)
  (setq route (force-list route))
  (let ((actual-hops 0)
        (distance 0)
        (time 0))
    (mapl #'(lambda (route)
              (when (car route)
                (incf distance (co-distance (car route)))
                (incf time (co-cost (car route)))
                (incf actual-hops)
                (if (track-congested-p (car route))
                    (incf time (cdr (assoc (congestion-reason (car route)) *track-congestion-delay-alist*))))
                (unless (endp (cdr route))
                  ;; check the common city
                  (let*-non-null ((cc (common-connection (car route) (cadr route)))
                                  (loc (find-location cc)))
                    (if (city-congested-p loc)
                        (incf time (cdr (assoc (congestion-reason loc) *city-congestion-delay-alist*))))))))
          route)
    (values time actual-hops distance)))



