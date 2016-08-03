;; Time-stamp: <Mon Jan 13 16:51:16 EST 1997 ferguson>

(when (not (find-package :demo-kb-lib))
  (load "kb-lib-def"))
(in-package demo-kb-lib)

(defgeneric object-name (foo)
  (declare (optimize (speed 3) (safety 0) (debug 0))))

(let ((world-kb (find-package 'world-kb)))
  (defmethod object-name ((foo symbol))
    (if (eq (symbol-package foo) world-kb)
        foo
      (intern (string foo) world-kb))) ; consistant package.

  (defmethod object-name ((foo string))
    (intern foo world-kb))

  (defmethod object-name ((foo cons))
    (log-warning *kqml-recipient* "Warning: Object name got a bogus object: ~S" foo)
    (when (debug-p :hard)
      (unless (tt-assert (not (consp foo)) (foo) "Bogus object: ~S" foo)
        (return-from object-name (object-name foo)))) ; continued from the assert
    :BOGUS)
  
  (defmethod object-name ((foo collection))
    (log-warning *kqml-recipient* "Warning: Object name got a bogus object: ~S" foo)
    (when (debug-p :hard)
      (unless (tt-assert (not (consp foo)) (foo) "Bogus object: ~S" foo)
        (return-from object-name (object-name foo)))) ; continued from the assert
    :BOGUS)

  (defmethod object-name ((foo proposition))
    (name foo))

  (defmethod object-name ((foo basic-kb-object))
    (basic-name foo)))

(defun contained-in (item container)
  (member item (basic-contents container)))

(defun other-connection (connected-object connection)
  (let ((loc1 (co-loc-1 connected-object))
        (loc2 (co-loc-2 connected-object)))
    (cond
     ((connected-object-p connection)
      ;; return slot not shared
      (cond 
       ((or (eq loc1 (co-loc-1 connection))
            (eq loc1 (co-loc-2 connection)))
        loc2)
       ((or (eq loc2 (co-loc-1 connection))
            (eq loc2 (co-loc-2 connection)))
        loc1)
       (t
        (log-warning *kqml-recipient* ";;other-connection: bad other-connection request; no shared connection. ~S ~S" connected-object connection))))
     (t
      (other-connection-city connected-object connection loc1 loc2)))))

(defun other-connection-city (connected-object city &optional (loc1 (co-loc-1 connected-object))
                                                              (loc2 (co-loc-2 connected-object)))
  (cond
   ((eq (object-name city) loc1)
    loc2)
   ((not (eq (object-name city) loc2))
    (log-warning *kqml-recipient* ";;other-connection-city: bad other-connection request; connection not found: ~S ~S" connected-object city)
    loc1)
   (t
    loc1)))

(defun city-in-connections-p (connected-object city &optional (loc1 (co-loc-1 connected-object))
                                                              (loc2 (co-loc-2 connected-object)))
  (or (eq (object-name city) loc1)
      (eq (object-name city) loc2)))

(defun common-connection (connected-object1 connected-object2)
  (let ((loc1 (co-loc-1 connected-object1))
        (loc2 (co-loc-2 connected-object1)))

    (cond
     ((eq loc1 (co-loc-1 connected-object2))
      loc1)
     ((eq loc1 (co-loc-2 connected-object2))
      loc1)
     ((eq loc2 (co-loc-1 connected-object2))
      loc2)
     ((eq loc2 (co-loc-2 connected-object2))
      loc2)
     (t
      nil))))                           ; no common connection

(defun city-congested-p (city)
  (basic-congested-p city))

(defsetf city-congested-p (city) (new-value)
  `(setf (basic-congested-p ,city) ,new-value))

(defsetf track-congested-p (track) (new-value)
  `(setf (basic-congested-p ,track) ,new-value))

(defun track-congested-p (track)
  (basic-congested-p track))

(defun pick-one (l)
  (let ((n (random (list-length l))))
    (nth n l)))

(defun pick-one-short (l)
  "Like pick one, but have a preference for shorter members."
  (declare (optimize (debug 3)))
  ;; give more buckets to short members of l.
  (let* ((entries (list-length l))
         (total-size (reduce #'+ (mapcar #'length l)))
         (average-size (/ total-size entries))
         (v (make-array (list entries) :element-type t :initial-element nil :adjustable t
                        :fill-pointer 0))
         (posn 0))
    ;; every entry gets at least one bucket. Give extra buckets to shorter entries.
    (dolist (e l)
      (vector-push-extend posn v)
      (cond
       ((< (length e) (/ average-size 2))
        (vector-push-extend posn v)
        (vector-push-extend posn v))
       ((< (length e) average-size)
        (vector-push-extend posn v)))
      (incf posn))
    (let ((choice (random (fill-pointer v))))
      (nth (aref v choice) l))))

(defun find-matches (l)
  (cond-binding-predicate-to temp
    ((null l)
     nil)
    ((member (car l) (cdr l))
     (nconc (list (car l))
            (find-matches (cons (car l) (cdr temp)))
            (find-matches (cdr l))))
    (t
     (find-matches (cdr l)))))

(defun force-list-c (foo)
  (if (collection-p foo)
      (terms foo)
    (force-list foo)))

(defun compare-cities (x y)
  (equal (string (object-name x)) (string (object-name y))))

;; for one-ary predicates:
(defun satisfy-predicate-p (predicate-prop route)
  ;; does the route satisfy the predicate? (later, generalize this to handle non-route thingos, n-ary predicates, etc.).
  (case (name (predicate predicate-prop))
    ( :direct
     ;; a route is direct if it is a single step.
     (or (not (consp route))            ; just a track
         (endp (cdr route))))
    ( ( :then :ultimate)
      t)                                 ; for now
    (t
     (log-warning *kqml-recipient* ";;Satisfy-predicate-p, no rule for ~S on ~S" predicate-prop route)
     t)                                 ; blecho.
    )) 

(defun ref-object-of-type (object type)
  (or (typep object type)
      (if (predicate-prop-p object)
          (eq (name (predicate object)) (make-keyword type)))
      (if (quantifier-prop-p object)
          (eq (vclass (variable object)) (make-keyword type)))))

(defun ref-object-of-types (object types)
  "Here type is a english type, e.g. goal"
  (or (and (predicate-prop-p object)
           (member (name (predicate object)) types :key #'make-keyword))
      (and (quantifier-prop-p object)
           (member (vclass (variable object)) types :key #'make-keyword))))

(defun check-prop-p (prop-name prop)
  (and (predicate-prop-p prop)
       (let ((prop-names (flatten (force-list (name (predicate prop))))))
         (when (if (symbolp prop-name)
                   (member prop-name prop-names)
                 (null (set-difference prop-names prop-name)))
           prop-names))))

(defun build-collection-if-needed (terms &optional disjunct)
  (if (endp (cdr terms))
      (car terms)
    (progfoo (make-collection :terms terms)
      (setf (collection-disjunct-p foo) disjunct))))

(defun set-quantifier-p (q)
  (if (and (quantifier-prop-p q)
           (check-prop-p :eq-to (car (propositions q)))
           (endp (cdr (propositions q))))
      (case (name (quantifier q))
        (( :every :forall)
         (build-collection-if-needed (terms (car (propositions q)))))
        (( :the :exists)
         (build-collection-if-needed (terms (car (propositions q))) t)))))

(defun and-op-p (prop)
  (and (operator-prop-p prop)
       (or (eq (operator prop) (find-operator :and))
           (eq (operator prop) :and))))

(defun rcheck-prop-p (prop-name prop)
  (cond
   ((and-op-p prop)
    (some #'(lambda (x) (rcheck-prop-p prop-name x)) (propositions prop)))
   ((check-prop-p prop-name prop)
    (or (if (endp (cdr (terms prop)))
            (car (terms prop))
          (terms prop))
        prop))))

(defun perf-prop-p (prop sem)
  (cond
   ((and-op-p sem)
    (some #'(lambda (x) (perf-prop-p prop x)) (propositions sem)))
   ((and (prop-prop-p sem)                ; has proposition args
         (consp (propositions sem))
         (check-prop-p prop (car (propositions sem)))))))

(defun rperf-prop-p (prop sem)
  (cond
   ((and-op-p sem)
    (some #'(lambda (x) (rperf-prop-p prop x)) (propositions sem)))
   ((and (prop-prop-p sem)               ; has proposition args
         (consp (propositions sem))
         (some #'(lambda (x) (rcheck-prop-p prop x)) (propositions sem))))))

(defun perf-be-p (subject object sem)
  (let ((prop-names (perf-prop-p :be sem)))
    (when prop-names
      (let ((sub (rcheck-prop-p :lsubj (cadr (propositions sem))))
            (ob (or (rcheck-prop-p :lobj (cadr (propositions sem)))
                    (rcheck-prop-p :lcomp (cadr (propositions sem))))))
        (when (and (if subject
                       (eqmemb subject sub)
                     t)
                   (if object 
                       (eqmemb object ob)
                     t))
          (values t sub ob prop-names))))))

(defun mentioned-predicate (predicate predicate-prop)
  (and (predicate-prop-p predicate-prop)
       (find predicate (basic-predicates predicate-prop))))

;; mostly for stuff james sends
(defun get-sslot (slotname slotlist)
  (cond
   ((or (null slotlist)
        (not (consp slotlist)))
    nil)
   ((and (consp (car slotlist))
         (eq :and (caar slotlist)))
    (or (get-sslot slotname (cdar slotlist))
        (get-sslot slotname (cdr slotlist))))
   ((and (consp (car slotlist))
         (eq slotname (caar slotlist)))
    (cadar slotlist))
   (t
    (get-sslot slotname (cdr slotlist)))))

(defun get-sslotn (slotname slotlist)
  (cond
   ((or (null slotlist)
        (not (consp slotlist)))
    nil)
   ((and (consp (car slotlist))
         (eq :and (caar slotlist)))
    (or (get-sslotn slotname (cdar slotlist))
        (get-sslotn slotname (cdr slotlist))))
   ((and (consp (car slotlist))
         (eq slotname (caar slotlist)))
    (cdar slotlist))                    ; the difference
   (t
    (get-sslotn slotname (cdr slotlist)))))

;; old interface
(defun do-ps-find (content aspect &optional (me *kqml-recipient*))
  (let ((ps-result  (kb-request-kqml
                     (create-ask-all :ps content (copy-list aspect) me))))
    (if (sa-defs:tt-assert (or (null ps-result) (not (kqml-problem-p ps-result))) (ps-result) "bad result")
        (return-from do-ps-find nil)
      (extract-keyword :result ps-result))))

;; new interface
(defun ps-ask-all (content aspect &optional (me *kqml-recipient*))
  (do-ps-find content aspect me))

(defun ps-ask-if (content &optional (me *kqml-recipient*))
  (let ((qr (kb-request-kqml (create-ask-if :ps content me))))
    (unless (sa-defs:tt-assert (or (null qr) (not (kqml-problem-p qr))) () "bad result")
      (extract-keyword :result qr))))

(defun ps-ask-one (content aspect &optional (me *kqml-recipient*))
  (let ((qr (kb-request-kqml (create-ask-one :ps content (copy-list aspect) me))))
    (unless (sa-defs:tt-assert (or (null qr) (not (kqml-problem-p qr))) () "bad result")
      (extract-keyword :result qr))))

(defun identify (ob)
  (kb-request-kqml (create-request :world-kb `( :identify ,ob))))

(defun proc-ss-pred-for-ps (ss-pred)
  (cond
   ((and (consp ss-pred)
         (eq (car ss-pred) :or))
    ;; pick one
    (proc-ss-pred-for-ps (pick-one (cdr ss-pred))))
   ((consp ss-pred)
    (mapcar #'proc-ss-pred-for-ps ss-pred))
   (t
    (case ss-pred
      (( :less :min)
        '<)
      (( :more :greater :max)
        '>)
      ( :equal
        '=)
      ( :time-duration
        'hack::duration)
      ( :distance
        'hack::distance)
      (t
       (log-warning :prince "Unhandled ss-pred: ~S" ss-pred)
       '<)))))
