(in-package lymphocyte-internal)
;; Time-stamp: <Tue Jan 14 13:13:54 EST 1997 ferguson>

;; exported interface
(deftype t-positive (&optional (high most-positive-fixnum)) `(integer 1 ,high))

;; to add rules
(defun define-rulebase (rulebasename &rest parents)
  (declare (type symbol rulebasename))
  (cond-binding-predicate-to foo
   ((assoc rulebasename *lymphocyte-rulebases*)
    ;; clear it.
    (let ((rulebase (cdr foo)))
      (setf (rulebase-rules-0 rulebase) nil)
      (setf (rulebase-rules-meta rulebase) nil)))
   (t
    (update-alist rulebasename (make-rulebase :name rulebasename :parents parents) *lymphocyte-rulebases*))))

;(defun load-rulebase (filename)
;  (declare (type string filename)
;           )
;  
;  )
;
;(defun compile-rulebase (filename)
;  (declare (type string filename))
;  )

(defun add-rule (rule)
  (flet ((add-to-rules (level-accessor)
           (let ((hit (position (lrule-name rule) (slot-value *current-rulebase* level-accessor) :test #'equalp :key #'lrule-name)))
             (if hit
                 (setf (nth hit (slot-value *current-rulebase* level-accessor)) rule)
               (setf (slot-value *current-rulebase* level-accessor)
                 (nconc (slot-value *current-rulebase* level-accessor)
                        (list rule)))))))
    (case (lrule-level rule)
      (0
       (add-to-rules 'rules-0))
      (t
       (add-to-rules 'rules-meta)))))

(defun in-rulebase (rulebasename &rest parents)
  (declare (type symbol rulebasename))
  (cond
   ((assoc rulebasename *lymphocyte-rulebases*)
    (setq *current-rulebase* (cdr (assoc rulebasename *lymphocyte-rulebases*))))
   (t
    (apply #'define-rulebase rulebasename parents)
    (setq *current-rulebase* (cdr (assoc rulebasename *lymphocyte-rulebases*))))))

(defmacro with-rulebase ((rulebasename) &body body)
  `(let ((*current-rulebase* (cdr (assoc ,rulebasename *lymphocyte-rulebases*))))
     ,@body))

;; builtin functions, good in actions or queries.

(defconstant +var-introducing-macros+ '(foreach forall forsome bind))

(defmacro ForEach ((iteration-var rule-var) &rest body)
  `(nreverse
    (progfoo nil
      (dolist (,iteration-var ,rule-var)
        (push (progn ,@body) foo)))))

(defmacro ForAll ((iteration-var rule-var) &rest body)
  `(every #'(lambda (,iteration-var)
              ,@body)
          ,rule-var))

(defmacro ForSome ((iteration-var rule-var) &rest body)
  `(some #'(lambda (,iteration-var)
             ,@body)
         ,rule-var))

;(defmacro Bind (var binding)
;  )
;
;(defmacro With-Arguments ((patternvar-or-rule-var &rest arguments) &body body)
;  )

;; define a readtable for evaluating rules.

(defvar *in-rule* nil "non-nil if we are parsing inside of a rule")
(defvar *level* 0 "So we can tell if we are in a meta level (pattern rules slightly different)")

(defun lrule-reader (stream char)
  "Read a rule or pattern"
  (if *in-rule*
      (lpattern-reader stream char)
    (flet ((check-for-termination (missing)
             (if (eql (peek-char t stream t nil t) #\])
                 (parser-error stream 
                               "Rule terminated before all required parameters entered:~_ Missing ~(~A~)"
                               missing))))
      (let ((*in-rule* '(nil))             ; alist for variables
            (rule (make-lrule)) ;; so we can tell when a pattern starts.
            *level*)
        ;; read the level
        (check-for-termination :level)
        (progfoo (read stream t nil t)
          (check-type foo fixnum)
          (setq *level* (setf (lrule-level rule) foo)))
        ;; read the name, or (name arguments...)
        (check-for-termination :name)
        (progfoo (read stream t nil t)
          ;; if it's a list, the cdr are the arguments.
          (cond
           ((consp foo)
            (setf (lrule-name rule) (car foo))
            (setf (lrule-arguments rule) (cdr foo)))
           (t
            (setf (lrule-name rule) foo))))
        (check-type (lrule-name rule) symbol)
        (check-type (lrule-arguments rule) list)
        ;; read the ruletype
        (check-for-termination :type)
        (setf (lrule-type rule) (read stream t nil t))
        (if (eql (lrule-type rule) '*)
            (setf (lrule-type rule) (lrule-name rule))
          (check-type (lrule-type rule) symbol))
      
        ;; read the pattern (recursive)
        (check-for-termination :pattern)
        (setf (lrule-pattern rule) (read stream t nil t))
        (check-type (lrule-pattern rule) lpattern)
      
        ;; all other fields are optional. Scan for them.
        (while-not (eql (peek-char t stream t nil t) #\])
          (let ((fieldname (let ((old-char (get-macro-character #\= *lymphocyte-readtable*))) ; turn off special processing of #\=
                             (set-macro-character #\= (get-macro-character #\= (copy-readtable nil)) t *lymphocyte-readtable*)
                             (prog1 (read stream t nil t)
                               (set-macro-character #\= old-char nil *lymphocyte-readtable*)))))
            ;; check that it's a valid field, then process it.
            (case fieldname
              (cost=
               (setf (lrule-cost rule) (read stream t nil t)))
              ((utility= benefit=)
               (setf (lrule-utility rule) (read stream t nil t)))
              (explanation=
               (setf (lrule-explanation rule) (read stream t nil t)))
              ((prematch= local=)
               (setf (lrule-prematch rule) (read stream t nil t)))
              ((postmatch= localeval=)
               (setf (lrule-postmatch rule) (read stream t nil t)))
              (produces=
               (setf (lrule-produces rule) (read stream t nil t)))
              (t
               (parser-error stream "Bad optional field in rule: ~S" fieldname)))))
        (read-char stream t nil t)
        rule))))                            ; get the #\]

(defun lpattern-reader (stream char)
  "Read a pattern"
  (declare (ignore char))
  (let ((pattern (read-delimited-list #\] stream t))
        (meta-rule-p (not (eql *level* 0))))
    (declare (ignore meta-rule-p))
    pattern))

;        result)
    ;; munge together as needed accessors/values.
;    (mapl #'(lambda (pentry)
;              (cond
;               ((and (psacc-p (first pentry))
;                     (or (psacc-p (second pentry))
;                         (psval-p (second pentry))))
;                ;; link them
;                (setf (psacc-next (first pentry)) (second pentry))
;                (unless (and (psacc-p (car result))
;                             (eq (first pentry) (psacc-next (car result))))
;                  (push (first pentry) result)))
;               ((psval-p (first pentry))
;                ;; don't push it, but check for sanity.
;                (unless (and (psacc-p (car result))
;                             (eq (first pentry) (psacc-next (car result))))
;                  (parser-error stream "Cannot have a value accessor unless preceeded by a slot accessor")))
;               (t
;                (push (first pentry) result))))
;          pattern)
;    (nreverse result)))                 ; because of all the pushing.

(defvar *in-var* nil)

;; type handling interface
(defun lvar-reader (stream char)
  "Read a (possibly typed) pattern variable"
  (if *in-var*
      (return-from lvar-reader char))
  
  (let* ((type t)
         (*in-var* t)
         name
         next
         result
         (special (if (member (peek-char nil stream t nil t) '(#\+ #\? #\*))    ;; check to see if it's special
                      ;; yep. eat it and deal with it later.
                      (read-char stream))))

    (setq name (read stream t nil t))
    ;; is there a type?
    (when (eql (peek-char nil stream t nil t) #\@)
      ;; yes, read it.
      (setq type (read stream t nil t))
      (if (eq type :self)               ; empty type
          (setq type name)))
    
    (when (eql (peek-char nil stream t nil t) #\^)
      (let ((*in-var* nil))             ; so we can read an embedded var
        (setq next (read stream t nil t)))) ; slot accessor
    
    (setq result
      (cond
       ((assoc name *in-rule*)
        (progfoo (cdr (assoc name *in-rule*))
          (assert (null type) nil "Don't currently handle structure ref off multiple variable occurances")
          ;; if there's a type, check it
          (if (not (eq type t))
              (cond
               ((eq (pvariable-type foo) t)
                (setf (pvariable-type foo) type))
               ((not (typecheck (pvariable-type foo) type))
                (parser-error stream "Invalid retype of variable ~S" foo))
               (t
                (setf (pvariable-type foo) type))))))
       (t
        (let ((flags 0))
          (when (char= (char (string name) 0) #\_)
            (setq name (gentemp "_"))   ; make it unique
            (setq flags pat-match::+pvariable-dont-care+))
          (make-pvariable :name name :type type :flags flags :next next)))))
    
    (cond 
     (special
      (if (member special '(#\* #\+))
          (setf (pvariable-collection-p result) t))
      (list (intern (format nil "$~C" special) *li-package*) ; unabbrev
            result))
     (t result))))

(defun ltype-reader (stream char)
  ;; check for null type
  (if *in-var*
      (if (member (peek-char nil stream t nil t) '(#\space #\tab #\) #\] #\return #\newline))
          :self
        (read stream t nil t))          ; passed back to lvar reader
    char))                              ; not in lvar-reader

(defun lannotation-reader (stream char)
  "Read an annotation"
  (declare (ignore char))
  (let ((annotation (read-delimited-list #\} stream t)))
    annotation))                        ; presumably I'll do something else here first.

(defun lslot-accessor-reader (stream char)
  "Begin reading a slot accessor"
  (declare (ignore char))
  (if (member (peek-char nil stream t nil t) '(#\space #\tab #\) #\] #\return #\newline #\^))
      (parser-error stream "Invalid slot accessor")
    (progfoo (make-psacc :slotname (read stream t nil t))
      (if (member (peek-char nil stream t nil t) '(#\^ #\=))
          (setf (psacc-next foo) (read stream t nil t))))))

(defun lvalue-accessor-reader (stream char) ; value accessor
  (declare (ignore char))
  (if (member (peek-char t stream t nil t) '( #\) #\]))
      (parser-error stream "Invalid value accessor")
    (make-psval :value (read stream t nil t))))

(defun setup-lymphocyte-readtable ()
  (setq *lymphocyte-readtable* (copy-readtable nil *lymphocyte-readtable*))
  (set-syntax-from-char #\] #\) *lymphocyte-readtable*)
  (set-syntax-from-char #\} #\) *lymphocyte-readtable*)
  (set-macro-character #\[ #'lrule-reader nil *lymphocyte-readtable*)
  (set-macro-character #\? #'lvar-reader nil *lymphocyte-readtable*)
  (set-macro-character #\{ #'lannotation-reader nil *lymphocyte-readtable*)
  (set-macro-character #\^ #'lslot-accessor-reader nil *lymphocyte-readtable*)
  (set-macro-character #\= #'lvalue-accessor-reader nil *lymphocyte-readtable*)
  (set-macro-character #\@ #'ltype-reader nil *lymphocyte-readtable*))

(eval-when (load eval)
  ;;(format t ";;;~%;;;Initializing lymphocyte readtable~%;;;~%")
  (setup-lymphocyte-readtable)
  (add-syntax :lymphocyte '*lymphocyte-readtable*))


