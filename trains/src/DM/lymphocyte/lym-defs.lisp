(in-package lymphocyte-internal)
;; Time-stamp: <95/07/19 17:17:21 miller>

(defvar *lymphocyte-readtable* nil "Readtable for rules")

(defparameter *li-package* (find-package 'lymphocyte-internal))

(defvar *lymphocyte-rulebases* nil "Rulebases we know about")

(defvar *current-rulebase* nil "Entry for the current rulebase")

(defvar *trace-lym* nil)
(defvar *trace-rules* nil)

(defun trace-lym (&optional toggle)
  (cond
   ((and toggle *trace-lym*)
    (setq *trace-lym* nil))
   (t
    (setq *trace-lym* *trace-output*)
    t)))

(defmacro trace-lym-rule (&rest names)
  `(setq *trace-rules* (union *trace-rules* '(,@names))))

(defmacro untrace-lym-rule (&rest names)
  `(if ',names
       (setq *trace-rules* (nset-difference *trace-rules* '(,@names)))
     (setq *trace-rules* nil)))

(defstruct rulebase
  (name nil :type (or null symbol))
  (parents nil :type list)
  (rules-0 nil :type list)
  (rules-meta nil :type list))               ; for now

(defun lpattern-p (x)
  (consp x))                            ; presumably something more robust here would be nice

(deftype lpattern () '(and cons (satisfies lpattern-p)))

(defclass-x lrule ()
  ((level :initform 0 :type fixnum :initarg :level :accessor lrule-level)
   (name :initform t :type symbol :initarg :name :accessor lrule-name)
   (arguments :initform nil :type list :initarg :arguments :accessor lrule-arguments)
   (type :initform t :type symbol :initarg :type :accessor lrule-type)
   (pattern :initform nil :initarg :pattern :accessor lrule-pattern)
   (cost :initform '$match :type t :initarg :cost :accessor lrule-cost)
   (utility :initform 1 :type t :initarg :utility :accessor lrule-utility)
   (explanation :initform nil :type t :initarg :explanation :accessor lrule-explanation)
   (prematch :initform nil :type list :initarg :prematch :accessor lrule-prematch)
   (postmatch :initform nil :type list :initarg :postmatch :accessor lrule-postmatch)
   (produces :initform nil :type t :initarg :produces :accessor lrule-produces)))

(defstruct lrule-eval
  (rule nil :type (or null lrule))
  (prematch-cache nil :type alist)
  (cost-cache nil :type (or null number))
  (match-cache nil :type alist)
  (postmatch-cache nil :type alist)
  (utility-cache nil :type (or null number))
  (flags 0 :type fixnum))

(defflags lrule-eval
  successful)

(defmethod print-object ((o lrule) stream)
  ;; can just about print it readably in any case since we've got read stuff for the rules.
  (flet ((space ()
           (write-char #\space stream)))
    (pprint-logical-block (stream nil :prefix "[" :suffix "]")
      (if (not (minusp (lrule-level o)))
          (princ (lrule-level o) stream)
        (princ "*" stream))
      (space)
      (pprint-indent :current 0 stream) ; make this the indent level for further arguments
      (if (lrule-arguments o)
          (pprint-logical-block (stream (cons (lrule-name o) (lrule-arguments o)) :prefix "(" :suffix ")")
            (loop
              (pprint-exit-if-list-exhausted)
              (space)
              (pprint-newline :linear stream)
              (write (pprint-pop) :stream stream)))
        (princ (lrule-name o) stream))
      
      (if (equal (lrule-type o) (lrule-name o))
          (format stream "~_ * ~_")
        (format stream "~_ ~W ~_" (lrule-type o)))
      
      (pat-match::print-pattern (lrule-pattern o) stream)
      (space)
      (pprint-indent :block (+ 1 (length (format nil "~D" (lrule-level o)))) stream)
      (pprint-newline :linear stream)
      (format stream "cost= ~W ~_utility= ~W" (lrule-cost o) (lrule-utility o))
      (format stream "~@[ ~_explanation= ~W~]" (lrule-explanation o))
      (format stream "~@[ ~_prematch= ~W~]" (lrule-prematch o))
      (format stream "~@[ ~_postmatch= ~W~]" (lrule-postmatch o))
      (format stream "~@[ ~_produces= ~W~]" (lrule-produces o)))))

      


