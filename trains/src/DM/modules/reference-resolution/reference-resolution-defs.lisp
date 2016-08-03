;; Time-stamp: <Mon Jan 13 17:21:11 EST 1997 ferguson>

(when (not (find-package :reference-resolution))
  (load "reference-resolution-def"))
(in-package :reference-resolution)

(defvar *current-focus* nil "The current dynamic focus")

(defvar *output-sas* nil "Collect output speech acts")

(defvar *obalist* nil "Alist of variables from the parser and the object")

(defun find-ref (var)
  (cdr (assoc var *obalist*)))

(defun find-ref-if-needed (thingo)
  (cond
   ((null thingo)
    nil)
   ((consp thingo)
    (cons (find-ref-if-needed (car thingo))
          (find-ref-if-needed (cdr thingo))))
   ((find-ref thingo))
   (t
    thingo)))

(defun add-ref-1 (var value)
  (update-alist var value *obalist*))

(defun add-ref (object value)
  (prog1 (add-ref-1 (get-sslot :var object) value)
    (hack-predicates value)))

(defun hack-predicates (x)
  (if (consp x)
      (mapc #'hack-predicates x)
    (if (basic-kb-object-p x)
        (mapc #'hack-predicates-1 (basic-predicates x)))))

(defun hack-predicates-1 (pp)
  (setf (terms pp) (find-ref-if-needed (terms pp))))

(defun find-type-predicate (predicate-props)
  (find-if #'pred-type-p (force-list predicate-props) :key #'predicate))

(defun engine-ref-p (x)
  (or (ref-object-of-type x 'engine)
      (ref-object-of-types x '(train))))

(defun ref-record-paths (paths)
  ;; record them in case of subsequent minor correction
  (kb-request-kqml (create-request :user-model-kb `( :set-last-mentioned-paths ,paths))))

(defgeneric update-prop (prop new-engine engine-np))

(defmethod update-prop ((o t) new-engine engine-np)
  (declare (ignore new-engine engine-np))
  nil)

(defmethod update-prop ((prop prop-prop) new-engine engine-np)
  (mapc #'(lambda (x) (update-prop x new-engine engine-np)) (propositions prop)))

(defmethod update-prop ((prop predicate-prop) new-engine engine-np)
  (setf (terms prop)
    (mapcar #'(lambda (x)
                (if (eq x engine-np)
                    new-engine
                  x))
            (terms prop))))

(defun ref-get-focus ()
  (kb-request-kqml (create-request :user-model-kb '( :engine-focus))))
