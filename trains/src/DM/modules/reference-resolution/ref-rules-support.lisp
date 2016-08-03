;; Time-stamp: <Mon Jan 13 17:20:50 EST 1997 ferguson>

(when (not (find-package :reference-resolution))
  (load "reference-resolution-def"))
(in-package :reference-resolution)

(defun combine-evidence (a b)
  (cond
   ((and a (not b))
    a)
   ((and b (not a))
    b)
   ((and a b)
    (nconc (force-list a) (force-list b)))))
   
(defun update-engine-refs (new-engine engine-np input)
  (setf (objects input) (substitute new-engine engine-np (objects input)))
  (if (eq (focus input) engine-np)
      (setf (focus input) new-engine))
  (mapc #'(lambda (path) 
            (when (eq (engine path) engine-np)
              (setf (engine path) new-engine)))
        (paths input))
  (mapc #'(lambda (action-entry)
            (update-prop action-entry new-engine engine-np))
        (defs input))

  (if (semantics input)
      (update-prop (semantics input) new-engine engine-np)))

(defun ref-find-engine (engine-np at-restriction input)
  (let (location-engines)
    (cond 
     ((consp at-restriction)
      ;; somehow something like "send the cincinnati engine at philly" was said. Choose the more likely candidate.
      (some #'(lambda (x) (ref-find-engine engine-np x input)) at-restriction))
     ((and (null (setq location-engines (engines-at-location at-restriction))) at-restriction)
      ;; check if they mean an engine that USED to be in the location. 
      ;; For now, only use the original location, since other interpretations are clumsy.
      (setq location-engines (engines-originally-at-location at-restriction))
      (when location-engines
        (if (consp location-engines)
            (if (endp (cdr location-engines))
                (setq location-engines (car location-engines))
              (return-from ref-find-engine (ref-ambiguous location-engines :engine))))
        ;; gotcha. Probably we should enter into a clarification subdialogue to be sure, but heck.
        (update-engine-refs location-engines engine-np input)
        location-engines))
     ((null location-engines)
;      (unless (sa-yn-question-p input)
;        (ref-huh (list :at at-restriction) :engine))
      nil)
     ((endp (cdr location-engines))
      ;; substitute the engine for the object.
      (update-engine-refs (car location-engines) engine-np input)
      (car location-engines))
     ((sa-yn-question-p input)
      (progfoo (make-collection :terms location-engines)
        (setf (collection-disjunct-p foo) nil)
        (update-engine-refs foo engine-np input))
      location-engines)
     (t
      (ref-ambiguous location-engines :engine)))))

(defun object-type-for-obtype (obtype)
  (case obtype
    (( :city :destination :goal)
     'city)
    (( :route)
     'route)
    (( :track)
     'track)
    (( :engine :plane :train)
     'engine)
    (t
     (log-warning :reference ";;reference: don't handle reference to ~S yet" obtype)
     (throw :no-such-object nil))))

(defun hack-pronouns (arglist)
  (mlet (new changed-p) (hack-pronouns-i arglist)
    (if changed-p new arglist)))

(defun hack-pronouns-i (arglist)
  (cond
   ((null arglist)
    (values nil nil))
   (t
    (mlet (newcdr changed-p) (hack-pronouns-i (cdr arglist))
      (cond ((and (consp (car arglist))
                  (eql (caar arglist) :*pro*))
             (values
              (cons (make-vari :name (gensym "pronoun") 
                               :vclass (let ((class-spec (cadar arglist)))
                                         (if (consp class-spec)
                                             (ecase (car class-spec)
                                               ( :and
                                                 (make-collection :terms (cdr class-spec)))
                                               ( :or
                                                 (progfoo (make-collection :terms (cdr class-spec))
                                                   (setf (collection-disjunct-p foo) t))))
                                           class-spec)))
                    newcdr)
              t))
            (t
             (values (cons (car arglist) newcdr) changed-p)))))))
    
(defun create-predicate (pred args &optional parser-token)
  (make-predicate-prop :predicate pred :terms (hack-pronouns args) :parser-token parser-token))

