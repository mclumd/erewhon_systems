;; Time-stamp: <Mon Jan 13 17:20:36 EST 1997 ferguson>

(when (not (find-package :reference-resolution))
  (load "reference-resolution-def"))
(in-package :reference-resolution)

(defvar *quantum*)
(defvar *not* nil)
(defvar *postprocess* nil)
(defvar *substitute-slot* nil "slot name to do a substitute into, from not avon, bath utterances.")
(defvar *substitute-value* nil "slot value to substitute into a slot, from bath instead of avon utterances.")
(defparameter *list-path-slots* '(via not-via not-to not-from beyond not-beyond between not-between) "slots of path-quantum that can be lists.")

(defun convert-parser-path-to-quanta (var parser-path-list engine-focus &optional *quantum*)
  "Return a list of path quanta, given the parser's path output."
  ;; so we only have to figure this out once 
  (let ((first (car parser-path-list))
        (*postprocess* nil)  ;; handle :and in slots
        (*substitute-slot* nil)
        (*substitute-value* nil)
        result)

    (setq result 
      (cond
       ((null parser-path-list)
        nil)
       ((eq first :lex-and)             ; split! Better be at outermost level, no?
        (throw :split-sas (cdr parser-path-list)))
       ((member first '( :and :seq))
        ;; new quantum
        (let-maybe (or (not (boundp '*quantum*))
                    (null *quantum*))
          ((*quantum* (make-path-quantum :engine engine-focus)))
          (mapc #'(lambda (x) (progfoo (handle-path-entry var x engine-focus)
                                (if (consp foo)
                                    ;; new entry
                                    (setq result (nconc result (cdr foo))))))
                (cdr parser-path-list))
          (cons *quantum* result)))
       ((null first)                    ; bogosity from the parser
        (convert-parser-path-to-quanta var (cdr parser-path-list) engine-focus))
       (t
        (let ((foo (handle-path-entry var parser-path-list engine-focus)))
          (if (and foo (not (consp foo)))
              (list foo)
            foo)))))

    (dolist (post *postprocess*)
      (destructuring-bind (slotname quantum values &optional real-slotname) post
        (cond
         ((eq slotname :predicate)
          ;; fill in terms for the predicate, based on type
          (case (name (predicate values))
            (( :direct :then)
             (setf (terms values)
               (if real-slotname
                   (list real-slotname (get-qslot real-slotname quantum))
                 (list (progfoo (copy-path-quantum quantum)
                         (setf (predicates foo) (delete values (predicates foo)))))))))) ; remove ourself from the copy
         (t
          (dolist (value values)
            (setq result
              (nconc result 
                     (list (progfoo (copy-path-quantum quantum)
                             (setf (from foo) nil) ; override prior from, so we get the most recent value.
                             (setf (slot-value foo slotname) value))))))))))
    (debug-log :reference :reference "pp pre-filter: ~S" result)
    (progfoo (delete-if-not #'pq-non-null-p result)                   ;; delete any empty path quantaa
      (debug-log :reference :reference "pp post-filter: ~S" result))))

(defun get-qslot (slotname quantum)
  (slot-value quantum (intern (string slotname) (find-package 'demo-kb-lib))))

(defmacro handle-single-slot (slotname inverse-slotname)
  `(cond
    (*not*
     (setf (,inverse-slotname *quantum*) (nconc (,inverse-slotname *quantum*)
                                                (handle-path-value var (caddr parser-path-entry) ',inverse-slotname))))
    ((and (,slotname *quantum*)
          (not disjunction))
     (return-from handle-path-entry
       (cons *quantum* (let ((*quantum* (make-path-quantum :engine engine-focus)))
                         (force-list (convert-parser-path-to-quanta var parser-path-entry engine-focus))))))
    ((and (,slotname *quantum*)
          disjunction)
     (if (collection-p (,slotname *quantum*))
         (push (handle-path-value var (caddr parser-path-entry) ',slotname) (terms (,slotname *quantum*)))
       (setf (,slotname *quantum*)
         (progfoo (make-collection :terms (list (,slotname *quantum*) 
                                                (handle-path-value var (caddr parser-path-entry) ',slotname)))
           (setf (sa-defs:collection-disjunct-p foo) t)))))
    (t
     (setf (,slotname *quantum*) (handle-path-value var (caddr parser-path-entry) ',slotname)))))

(defun flatten-collection (c)
  (cond
   ((null c)
    nil)
   ((collection-p c)
    (mapcar #'flatten-collection (terms c)))
   ((and (consp c) (consp (car c)))
    (append (flatten-collection (car c))
            (flatten-collection (cdr c))))
   ((consp c)
    (cons (car c) (flatten-collection (cdr c))))
   (t
    c)))

(defmacro handle-multi-slot (slotname inverse-slotname)
  `(cond
    (*not*
     (if disjunction
         (if (collection-p (,inverse-slotname *quantum*))
             (setf (terms (,inverse-slotname *quantum*))
               (flatten-collection (nconc (force-list (handle-path-value var (cddr parser-path-entry) ',inverse-slotname))
                                          (flatten-collection (,inverse-slotname *quantum*)))))
           (setf (,inverse-slotname *quantum*)
             (progfoo (make-collection :terms (flatten-collection (nconc (force-list (handle-path-value var (cddr parser-path-entry) ',inverse-slotname))
                                                                         (,inverse-slotname *quantum*))))
               (setf (sa-defs:collection-disjunct-p foo) t))))
       (setf (,inverse-slotname *quantum*)
         (flatten-collection (nconc (,inverse-slotname *quantum*)
                                    (force-list (handle-path-value var (cddr parser-path-entry) ',inverse-slotname)))))))
    (t
     (if disjunction
         (if (collection-p (,slotname *quantum*))
             (setf (terms (,slotname *quantum*))
               (flatten-collection (nconc (force-list (handle-path-value var (cddr parser-path-entry) ',slotname))
                                          (flatten-collection (,slotname *quantum*)))))
           (setf (,slotname *quantum*)
             (progfoo (make-collection :terms (flatten-collection (nconc (force-list (handle-path-value var (cddr parser-path-entry) ',slotname))
                                                                         (,slotname *quantum*))))
               (setf (sa-defs:collection-disjunct-p foo) t))))
       (setf (,slotname *quantum*)
         (flatten-collection (nconc (,slotname *quantum*)
                                   (force-list (handle-path-value var (cddr parser-path-entry) ',slotname)))))))))

(defun handle-path-entry (var parser-path-entry &optional engine-focus disjunction)
  (let-maybe (or (not (boundp '*quantum*))
              (null *quantum*))
    ((*quantum* (make-path-quantum :engine engine-focus))) ; standalone quantum?
    (let ((local-quantum *quantum*))
      (if (not (consp parser-path-entry))
          (handle-naked-path-entry var parser-path-entry engine-focus)
        (case (car parser-path-entry)
          ( :eq
            (cond
             ((eql (second parser-path-entry) var)
              (add-ref-1 var (third parser-path-entry)) ; make the reference direct
              (return-from handle-path-entry (third parser-path-entry)))
             (t
              (log-warning :reference "Unhandled :EQ in path"))))
          ( :-
            (log-warning :reference "parser screw-up; Path has: ~S; ignoring" parser-path-entry)
            (handle-path-entry var (cadr parser-path-entry) engine-focus))
          (( :and :seq :list )
           (return-from handle-path-entry
             (convert-parser-path-to-quanta var parser-path-entry engine-focus local-quantum)))
          (( :directly :direct ) ;; modifiers
           (progfoo (make-predicate-prop :predicate (make-predicate :direct 2)) ; can't fill in the values yet.
             (push foo (predicates *quantum*))
             (push (list :predicate *quantum* foo) *postprocess*)
             (if (cadr parser-path-entry)
                 (handle-path-entry var (cadr parser-path-entry) engine-focus disjunction))))
          ( :or
            (return-from handle-path-entry
              (car (mapcar #'(lambda (x) (handle-path-entry var x engine-focus t))
                           (cdr parser-path-entry)))))
          ( :to
            (handle-single-slot to not-to))
          (:from
           (handle-single-slot from not-from))
          (:via
           (handle-multi-slot via not-via))
          (:beyond
           (handle-multi-slot beyond not-beyond))
          (:between
           (handle-multi-slot between not-between))
          (:not
           (let ((*not* (not *not*)))
             (handle-path-entry var (cdr parser-path-entry) engine-focus)))
          (:loc
           ;; ignore, at least for now.
           (return-from handle-path-entry nil))
          (otherwise
           (cond
            ((consp (car parser-path-entry))
             ;; special
             (let* ((slot-name (find-if #'(lambda (x) (member x '( :from :to :via))) (flatten (car parser-path-entry))))
                    (remainder (remove slot-name (flatten (car parser-path-entry)))))
               (cond
                ((and (eqmemb :then remainder)
                      (null (cdr remainder))
                      (member slot-name '( :from :via :to :beyond)))
                 ;; ignore it. THe default should work.
                 (handle-path-entry var (cons slot-name (cdr parser-path-entry)) engine-focus))
                ((and (eqmemb :not remainder)
                      (null (cdr remainder))
                      (member slot-name '( :via :to :from)))
                 ;; handle it via normal mechanisms
                 (let ((*not* (not *not*)))
                   (handle-path-entry var (cons slot-name (cdr parser-path-entry)) engine-focus)))
                (t
                 (let-maybe (and (eqmemb :then remainder)
                             (not (null (get-qslot slot-name local-quantum)))) 
                   ((*quantum* (progfoo (make-path-quantum :engine engine-focus)
                                 (setq local-quantum (list *quantum* foo))))) ; so caller sees it.
                   ;; remainder are predicates (I hope)
                   (if (endp (cdr remainder))
                       (progfoo (make-predicate-prop :predicate (make-predicate (car remainder) 2)) ; can't fill in the values yet.
                         (push foo (predicates *quantum*))
                         (push (list :predicate *quantum* foo slot-name) *postprocess*))
                     (mapcar #'(lambda (x)
                                 (progfoo (make-predicate-prop :predicate (make-predicate x 2))
                                   (push (list :predicate *quantum* foo slot-name) *postprocess*)
                                   (push foo (predicates *quantum*))))
                             remainder))
                   (handle-path-entry var (cons slot-name (cdr parser-path-entry)) engine-focus))))))
            (t
             (log-warning :reference "Reference: Bad parser path entry: ~S" parser-path-entry)
             (return-from handle-path-entry nil))))))
      local-quantum)))

(defun path-slot-name (pq)
  (cond
   ((via pq)
    :via)
   ((to pq)
    :to)
   ((from pq)
    :from)
   ((not-via pq)
    :not-via)
   ((beyond pq)
    :beyond)
   ((not-beyond pq)
    :not-beyond)
   ((between pq)
    :between)
   ((not-between pq)
    :not-between)))

(defun pq-non-null-p (pq)
  (cond
   ((vari-p pq)
    nil)
   (t
    (or (path-slot-name pq)
        (cond
         ((engine pq)
          :engine)
         ((predicates pq)
          :predicates))))))

(defun handle-naked-path-entry (var parser-path-entry &optional engine-focus)
  ;; mention of a naked city. If there's a negation, use it to substitute for a prior slot.
  (cond
   ((not (city-p parser-path-entry))
    (log-warning :reference "unidentified path entry: ~S~%" parser-path-entry)
    nil)                                ; don't handle
   (*not*
    (let ((old-paths (kb-request-kqml (create-request :user-model-kb '( :last-mentioned-paths)))))
      (setq *substitute-slot*
        (some #'(lambda (pq)
                  (cond
                   ((eq parser-path-entry (from pq))
                    :from)
                   ((eq parser-path-entry (to pq))
                    :to)
                   ((eqmemb parser-path-entry (via pq))
                    :via)
                   ((eqmemb parser-path-entry (not-via pq))
                    :not-via)))
              old-paths))
      (if *substitute-slot*
          (let ((result1 (handle-path-entry var (cons *substitute-slot* (force-list parser-path-entry)) engine-focus)))
            (if *substitute-value*
                (let ((*not* nil))
                  (return-from handle-naked-path-entry 
                    (let ((result2 (handle-path-entry var
                                                      (cons *substitute-slot* (force-list *substitute-value*))
                                                      engine-focus)))
                      (if (eq result1 result2)
                          result1
                        (list result1 result2)))))
              (return-from handle-naked-path-entry result1))))))
   (t
    (setq *substitute-value* parser-path-entry)
    (if *substitute-slot*
        (return-from handle-naked-path-entry 
          (handle-path-entry var (cons *substitute-slot* (force-list *substitute-value*)) engine-focus))))))

(defun handle-path-value (var parser-path-value slotname)
  (cond
   ((and (consp parser-path-value)
         (collection-p (car parser-path-value))
         (endp (cdr parser-path-value)))
    (handle-path-value var (car parser-path-value) slotname))
   ((consp parser-path-value)
    ;; foo. Return the first, and postprocess the others.
    (setq parser-path-value (remove-if #'(lambda (x) (or (member x '(:list :seq))
                                                         (eq x var)))
                                       parser-path-value))
    (cond
     ((member slotname *list-path-slots*) ; these can be lists.
      ;; handles cons
      (delete nil (mapcar #'(lambda (x) (handle-path-value var x slotname)) parser-path-value)))
     (t
      (push (list slotname *quantum* (cdr parser-path-value)) *postprocess*)
      (handle-path-value var (car parser-path-value) slotname))))
   ((collection-p parser-path-value)
    ;; foo. Return the first, and postprocess the others.
    (setf (terms parser-path-value) (remove-if #'(lambda (x) (or (member x '(:list :seq))
                                                                 (eq x var)))
                                               (terms parser-path-value)))
    (cond
     ((member slotname *list-path-slots*) ; these can be lists.
      ;; handles cons
      (delete nil (mapcar #'(lambda (x) (handle-path-value var x slotname)) (terms parser-path-value))))
     (t
      (push (list slotname *quantum* (cdr (terms parser-path-value))) *postprocess*)
      (handle-path-value var (car (terms parser-path-value)) slotname))))
   ((eq parser-path-value var)
    (log-warning :reference ";;path-parser Path var not removed; Should have been handled.")
    nil)
   ;; temporary; nuke bad values.
   ((not (city-p parser-path-value))
    (log-warning :reference ";;Path-parser Bad pathvalue: Slot ~S, Value ~S, ignored." slotname parser-path-value)
    nil)
   (t
    parser-path-value)))


(defun disjunctive-city-p (city)
  (and (city-p city)
       (eq t (basic-name city))
       (predicate-prop-p (car (basic-predicates city)))
       (eq :member (name (predicate (car (basic-predicates city)))))
       (collection-p (car (terms (car (basic-predicates city)))))
       (collection-disjunct-p (car (terms (car (basic-predicates city)))))))

(defun flip-city (cities &optional list-p)
  ;;If a city is actually a disjunction object, turn it into a list of the cities,
  ;; while conjuctions of cities turn into a disjunct.
  
  ;; if list-p is non-nil, then we can return a list or collection instead of a single city.
  (cond
   ((null cities)
    nil)
   ((collection-p cities)
    (flip-city (terms cities)))
   ((not (consp cities))
    ;; just check if it's a disjunct
    (if (disjunctive-city-p cities)
        (terms (car (terms (car (basic-predicates cities))))) ; list of cities in disjunct
      cities))                          ; just return it, no flip needed.
   ;; it's a cons.
   ((endp (cdr cities))
    (flip-city (car cities)))           ; treat like a single city
   ;; implicit conjunction. Turn into a disjunct
   (list-p
    (make-collection :flags sa-defs::+collection-disjunct+
                     :terms cities))
   (t
    (make-city :predicates (list (make-predicate-prop :predicate (find-predicate :member)
                                                      :terms (make-collection :flags sa-defs::+collection-disjunct+
                                                                              :terms cities)))))))

(defun invert-path (pq)
  (with-slots (from not-from to not-to via not-via beyond not-beyond between not-between) pq
    ;; if any of the slots contain a conjunction (or disjunction), flip.
    (rotatef from not-from)
    (setf from (flip-city from))
    (setf not-from (flip-city not-from))
    
    (rotatef to not-to)
    (setf to (flip-city to))
    (setf not-to (flip-city not-to))
    
    (rotatef via not-via)
    (setf via (flip-city via t))
    (setf not-via (flip-city not-via t))
    
    (rotatef beyond not-beyond)
    (setf beyond (flip-city beyond))
    (setf not-beyond (flip-city not-beyond))
    
    (rotatef between not-between)
    (setf between (flip-city between))
    (setf not-between (flip-city not-between))))

(defun combine-quanta (q1 q2)
  "Normally used when one quanta is used as the setting, or combining evidence from an instead."
  ;; q1 and q2 should be combined and q1 corrupted into the combined quanta.
  (when (null q2)
    (return-from combine-quanta q1))
  
  (with-slots (from not-from to not-to via not-via engine beyond not-beyond between not-between predicates) q2
    (cond
     ((or (and engine (engine q1) (not (eq (engine q1) engine)))
          (and (from q1) from (not (eq (from q1) from)))
          (and (to q1) to (not (eq (to q1) to))))
      ;; not compatible
      nil)
     (t
      (setf (engine q1) (or (engine q1) engine))
      (setf (from q1) (or (from q1) from))
      (setf (not-from q1) (union (not-from q1) not-from))
      (setf (to q1) (or (to q1) to))
      (setf (not-to q1) (union (not-to q1) not-to))
      (setf (via q1) (union (via q1) via))
      (setf (not-via q1) (union (not-via q1) not-via))
      (setf (beyond q1) (union (beyond q1) beyond))
      (setf (not-beyond q1) (union (not-beyond q1) not-beyond))
      (setf (between q1) (union (between q1) between))
      (setf (not-between q1) (union (not-between q1) not-between))
      (setf (predicates q1) (union (predicates q1) predicates))
      q1))))
