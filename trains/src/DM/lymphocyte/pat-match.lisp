(in-package :pat-match)
;; Time-stamp: <96/03/21 19:25:36 miller>
;; port (only) for tds by Brad Miller, miller@cs.rochester.edu

;;;; Code from Paradigms of AI Programming
;;;; Copyright (c) 1991 Peter Norvig

;;;; File pat-match.lisp: Pattern matcher from section 6.2

;;; Two bug fixes By Richard Fateman, rjf@cs.berkeley.edu  October 92.

;; Some speed and functional improvements
;; June 96 miller@cs.rochester.edu for lymphocyte
;;  make pattern vars a structure, will be used in character macro
;; change rules from ? syntax to use $.
;; need to be able to tell if at start or end of original input. (toplevel-pat-match)

;; also define structures in patterns used to access slots of structured objects.
(defstruct psval
  (value nil :type t))

(defstruct psacc
  (slotname nil :type symbol)
  (next nil :type (or null psacc psval)))

(defun structured-object-p (foo)
  (typep foo 'standard-object)) ; only handle clos structures for now.

(defstruct pvariable 
  (name nil :type symbol)
  (type t)
  (flags 0 :type fixnum)
  (next nil :type (or null psacc psval)) ; for terms of the form ?foo^mumble=nil 
  )

(defflags pvariable
  collection
  dont-care)

(defmethod print-object ((o psacc) stream)
  (format stream "^~A" (psacc-slotname o))
  (when (psacc-next o)
    (write (psacc-next o) :stream stream)))

(defun print-pattern (pattern stream)
  (pprint-logical-block (stream pattern :prefix "[" :suffix "]")
    (pprint-exit-if-list-exhausted)
    (let (saw-value)
      (loop 
        (progfoo (pprint-pop)
          (write foo :stream stream)
          (write-char #\space stream)
          (pprint-exit-if-list-exhausted)
          (cond
           ((psacc-p foo)
            ;; force a line break
            (setq saw-value t)
            (pprint-newline :mandatory stream))
           (saw-value
            (pprint-newline :linear stream))
           (t
            (pprint-newline :fill stream))))))))

(defmethod print-object ((o psval) stream)
  (cond
   ((consp (psval-value o))
    (write-char #\= stream)
    (print-pattern (psval-value o) stream))
   (t
    (format stream "=~W" (psval-value o)))))

(defmethod print-object ((o pvariable) stream)
  (format stream "?~A~@[@~A~]~@[~W~]" 
          (pvariable-name o)
          (if (not (eq (pvariable-type o) t))
              (pvariable-type o))
          (pvariable-next o)))

(deftype t-non-null () '(not null))

(defun typecheck (t1 t2)
  "Return non-nil if t1 is a proper subtype of t2"
  (declare (optimize (speed 3)))
  (cond
   ((eq t2 't))
   ((and (eq t2 't-non-null)
         (not (eq t1 't)))
    (not (member t1 '(null nil))))
   (t
    (subtypep t1 t2))))

(defun object-of-type (ob type)
  (declare (optimize (speed 3)))
  (cond
   ((eq type 't))
   ((eq type 't-non-null)
    (not (null ob)))
   (t
    (typep ob type))))
  
(defun typecheck-var (var object)
  "Return non-nil if var can bind with the object's type."
  (cond
   ((pvariable-collection-p var)
    ;; elements must be of the type
    (let ((type (pvariable-type var)))
      (every #'(lambda (x)
                 (object-of-type x type))
             object)))
   (t
    (object-of-type object (pvariable-type var)))))

(defun slotcheck-var (var object bindings)
  "Check that the psacc can be matched with object. For now, don't handle subvars."
  (declare (optimize (speed 3) (debug 0)))
  (let*-non-null ((psacc (pvariable-next var)))
    (if (consp object)
        ;; check we match each one
        (and (every #'(lambda (thingo) (setq bindings (structure-match-1 psacc thingo bindings))) object)
             bindings)
      (structure-match-1 psacc object bindings))))

(defconstant fail nil "Indicates pat-match failure")

(defconstant no-bindings '((t . t))
  "Indicates pat-match success, with no variables.")

(defun pat-match (pattern input bindings)
  "Match pattern against input in the context of the bindings"
  (cond ((eq bindings fail) fail)
        ((pvariable-p pattern)
         (match-variable pattern input bindings))
        ((eql pattern input) bindings)
        ((segment-pattern-p pattern)                
         (segment-matcher pattern input bindings))  
        ((single-pattern-p pattern)                 ; ***
         (single-matcher pattern input bindings)) ; ***
        ((structure-pattern-p pattern)         ; bwm, added structure accessors.
         (structure-matcher pattern input bindings))
        ;; handle this, since we get it from meta-rules.
        ((psval-p pattern)
         (pat-match (psval-value pattern) input bindings))
        ((and (consp pattern) (psval-p (car pattern)))
         (pat-match (cons (psval-value (car pattern)) (cdr pattern)) input bindings))
        ((and (consp pattern) (consp input)) 
         (pat-match (rest pattern) (rest input)
                    (pat-match (first pattern) (first input) 
                               bindings)))
        (t fail)))

(defvar *original-input* nil "Bound to original input, so we can check for start or end condition")

(defun pat-match-toplevel (pattern input &optional (bindings no-bindings))
  (declare (optimize (speed 3)))
  (let ((*original-input* input))
    (pat-match pattern input bindings)))

;(defun pvariable-p (x)
;  "Is x a variable (a symbol beginning with `?')?"
;  (and (symbolp x) (equal (char (symbol-name x) 0) #\?)))

(defun get-binding (var bindings)
  "Find a (variable . value) pair in a binding list."
  (declare (optimize (speed 3)))
  (assoc (pvariable-name var) bindings :test #'equalp :key #'(lambda (x) (if (pvariable-p x) (pvariable-name x)))))

(defun binding-var (binding)
  "Get the variable part of a single binding."
  (declare (optimize (speed 3)))
  (car binding))

(defun binding-val (binding)
  "Get the value part of a single binding."
  (declare (optimize (speed 3)))
  (cdr binding))

(defun make-binding (var val) 
  (declare (optimize (speed 3)))
  (cons var val))

(defun lookup (var bindings)
  "Get the value part (for var) from a binding list."
  (declare (optimize (speed 3)))
  (let ((binding (get-binding var bindings)))
    (values (binding-val binding)
            (binding-var binding))))     ; so we know if it was found -- miller

(defun extend-bindings (var val bindings)
  "Add a (var . value) pair to a binding list."
  (declare (optimize (speed 3)))
  (cons (make-binding var val)
        ;; Once we add a "real" binding,
        ;; we can get rid of the dummy no-bindings
        (if (and (eq bindings no-bindings))
            nil
            bindings)))

(defun match-variable (var input bindings)
  "Does VAR match input?  Uses (or updates) and returns bindings."
  (let ((binding (get-binding var bindings)))
    (cond ((not binding) 
           (if (and (typecheck-var var input)
                    (if (and input (pvariable-next var)) ; allow vars to bind to nil if typechecks ok.
                        (setq bindings (slotcheck-var var input bindings))
                      t))
               (extend-bindings var input bindings)
             fail))
          ((equal input (binding-val binding)) 
           (if (and input (pvariable-next var))
               (slotcheck-var var input bindings)
             bindings))
          (t fail))))

(eval-when (load eval)                  ; added eval-when -- miller
  (setf (get '$is  'single-match) 'match-is)
  (setf (get '$or  'single-match) 'match-or)
  (setf (get '$and 'single-match) 'match-and)
  (setf (get '$not 'single-match) 'match-not)
  
  (setf (get '$*  'segment-match) 'segment-match)
  (setf (get '$** 'segment-match) 'segment-submatch) ; new -- miller
  (setf (get '$+  'segment-match) 'segment-match+)
  (setf (get '$?  'segment-match) 'segment-match?)
  (setf (get '$if 'segment-match) 'match-if))

(defun segment-pattern-p (pattern)
  "Is this a segment-matching pattern like (($* var) . pat)?"
  (declare (optimize (speed 3)))
  (and (consp pattern) (consp (first pattern)) 
       (symbolp (first (first pattern)))
       (segment-match-fn (first (first pattern)))))

(defun single-pattern-p (pattern)
  "Is this a single-matching pattern?
  E.g. ($is x predicate) ($and . patterns) ($or . patterns)."
  (declare (optimize (speed 3)))
  (and (consp pattern)
       (single-match-fn (first pattern))))

(defun segment-matcher (pattern input bindings)
  "Call the right function for this kind of segment pattern."
  (declare (optimize (speed 3)))
  (funcall (segment-match-fn (first (first pattern)))
           pattern input bindings 0))   ; avoid optional start, -- miller (efficiency)

(defun single-matcher (pattern input bindings)
  "Call the right function for this kind of single pattern."
  (declare (optimize (speed 3)))
  (funcall (single-match-fn (first pattern))
           (rest pattern) input bindings))

(defun segment-match-fn (x)
  "Get the segment-match function for x, 
  if it is a symbol that has one."
  (declare (optimize (speed 3)))
  (when (symbolp x) (get x 'segment-match)))

(defun single-match-fn (x)
  "Get the single-match function for x, 
  if it is a symbol that has one."
  (declare (optimize (speed 3)))
  (when (symbolp x) (get x 'single-match)))

(defun match-is (var-and-pred input bindings)
  "Succeed and bind var if the input satisfies pred,
  where var-and-pred is the list (var pred)."
  (let* ((var (first var-and-pred))
         (pred (second var-and-pred))
         (new-bindings (pat-match var input bindings)))
    (if (or (eq new-bindings fail)
            (not (if (consp pred)
                     (eval-with-bindings `(funcall ',pred ',input) bindings)
                   (funcall pred input))))
        fail
        new-bindings)))

(defun match-and (patterns input bindings)
  "Succeed if all the patterns match the input."
  (cond ((eq bindings fail) fail)
        ((null patterns) bindings)
        (t (match-and (rest patterns) input
                      (pat-match (first patterns) input
                                 bindings)))))

(defun match-or (patterns input bindings)
  "Succeed if any one of the patterns match the input."
  (if (null patterns)
      fail
      (let ((new-bindings (pat-match (first patterns) 
                                     input bindings)))
        (if (eq new-bindings fail)
            (match-or (rest patterns) input bindings)
            new-bindings))))

(defun match-not (patterns input bindings)
  "Succeed if none of the patterns match the input.
  This will never bind any variables."
  (if (match-or patterns input bindings)
      fail
    bindings))

(defun segment-match (pattern input bindings start)
  "Match the segment pattern (($* var) . pat) against input."
  (destructuring-bind ((cmd var &rest extension) . pat)
      pattern
    (declare (ignore cmd))
    ;; extension to the original code (miller): if there is an extension, then THAT is matched
    ;; to the pattern, and the var is bound to a list of the copies of the matched extension. 
    ;; Don't cares and constants are ignored in the extension for the purposes of binding var.
    ;; ie.. ($* ?x ?a :a ?b :b) into (3 :a 4 :b 7 :a 16 :b) -> (?x (3 4) (7 16))
    (cond
     ((and (null pat)
           (null extension))
      (match-variable var input bindings))
     ((null pat)
      ;; the extension has to account for the rest of the input. (1 or more times)
      (cond
       ((and (zerop start)
             (null input))
        (match-variable var nil bindings))
       ((null input)
        fail)
       (t
        (extended-segment-match var extension input bindings start))))
     ((null extension)
      ;; original code
      (let ((pos (first-match-pos (first pat) input start)))
        (if (null pos)
            fail
          (let ((b2 (pat-match
                     pat (subseq input pos)
                     (match-variable var (subseq input 0 pos)
                                     bindings))))
            ;; If this match failed, try another longer one
            (if (eq b2 fail)
                (segment-match pattern input bindings (+ pos 1))
              b2)))))
     (t ;; pat & extension
      (let ((pos (first-match-pos (first pat) input start)))
        (cond 
         ((null pos)
          fail)
          ;; flip this test for efficiency, extended-segment-match can be very expensive.
         ((extended-match-p pat)        ; make it cheap
          (let ((b1 (if (zerop pos)
                        bindings
                      (extended-segment-match var extension (subseq input 0 pos) bindings 0))))
            (if (eq b1 fail)
                (segment-match pattern input bindings (+ pos 1))
              (let ((b2 (pat-match pat (subseq input pos) b1)))
                (if (eq b2 fail)
                    (segment-match pattern input bindings (+ pos 1))
                  b2)))))
         (t
          (let ((b2 (pat-match pat (subseq input pos) bindings)))
            (if (eq b2 fail)
                (segment-match pattern input bindings (+ pos 1))
              (let ((b1 (if (zerop pos)
                            b2
                          (extended-segment-match var extension (subseq input 0 pos) b2 0))))
                (if (eq b1 fail)
                    (segment-match pattern input bindings (+ pos 1))
                  b1)))))))))))

(defun segment-submatch (pattern input bindings start)
  "Match the entire subsegment, applying each of the subpatterns to the entire subsegment, then returning
vars bound to all the matching subsubsegments. I.e. ($** ^via=?foo@t-non-null ^from=?bar@t-non-null)
applied to a list of paths would always match, and bind ?foo to a list of all the vias in those paths, 
and bar to all the froms. Nonmatching subpatterns are ignored, and do *not* cause the rule to fail."
  (declare (ignore start))
  (let ((subpattern (cdar pattern))
        (subbinding-collection nil)
        (result-bindings bindings))
    (dolist (pat subpattern)
      (let ((subpattern-vars (subbinding-vars pat nil)))
        (dolist (seg input)
          (dolist (binding (pat-match pat seg bindings))
            (when (member (binding-var binding) subpattern-vars)
              (update-alist (binding-var binding) (cons (binding-val binding)
                                                        (lookup (binding-var binding) subbinding-collection))
                            subbinding-collection)))))
      ;; process the collected subbindings, and update our result.
      (setq result-bindings (nconc subbinding-collection result-bindings))
      (setq subbinding-collection nil))
    (pat-match (cdr pattern) nil result-bindings))) ; we ate the input.

(defun extended-match-p (pattern)
  "Return non-nil if pat involves an extended (i.e. hard) match"
  (cond
   ((or (null pattern)
        (symbolp pattern))
    nil)
   ((pvariable-p pattern)
    (if (pvariable-next pattern)
        (extended-match-p (pvariable-next pattern))))
   ((segment-pattern-p pattern)                
    (third (car pattern)))              ; extension
   ((single-pattern-p pattern)
    nil)
   ((psacc-p pattern)       
    (extended-match-p (psacc-next pattern)))
   ((psval-p pattern)
    (extended-match-p (psval-value pattern)))
   ((consp pattern)
    (or (extended-match-p (car pattern))
        (extended-match-p (cdr pattern))))
   (t
    nil)))

(defun extended-segment-match (var extension input bindings start)
  (let ((result (extended-segment-match-i extension input bindings start 0)))
    (if result
        (match-variable var result bindings)
      fail)))
  
(defun extended-segment-match-1 (extension input bindings)
  "Match extension to the input exactly once."
  (declare (optimize (speed 3)))
  (pat-match extension input bindings)) ;; hmm. looks the same no? :-

(defun next-match-pos (extension input start next)
  "Guess at the next position that extension could possibly match input (or where it would
finish matching from the beginning). If the extension is non-constant, then just return 1+ start."
  (let ((fmp (first-match-pos (first extension) input (1+ start))))
    (if fmp
        (max fmp next)
      (if (and (< start (length input))
               (<= next (length input)))
          (length input)))))

(defun extended-segment-match-i (extension input bindings start next)
  "completely account for the input with at least one application of the extension pattern."
  (let* ((pos (next-match-pos extension input start next))
         (b1 (if (null pos)
                 fail
               (extended-segment-match-1 extension (subseq input 0 pos) bindings))))
    (cond
     ((and (eq b1 fail)
           (null pos))
      fail)
     ((eq b1 fail)
      (extended-segment-match-i extension input bindings (1+ start) (1+ pos)))
     ((>= pos (length input))
      (subbinding-bindings extension b1 t))
     (t                                 ; more to do
      (let ((cur-bindings (subbinding-bindings extension b1 t))
            (b2 (extended-segment-match-i extension (subseq input pos) bindings 0 0)))
        (if (eq b2 fail)
            (extended-segment-match-i extension input bindings (1+ start) (1+ pos))
          ;; done.
          (nconc cur-bindings b2)))))))

(defun first-match-pos (pat1 input start)
  "Find the first position that pat1 could possibly match input,
  starting at position start.  If pat1 is non-constant, then just
  return start."
  (cond 
   ((not (consp input))                 ;*** fix, bwm 6/12/95 (didn't test)
    nil)
   ((psval-p pat1)
    (first-match-pos (psval-value pat1) input start))
   ((psacc-p pat1)                  ; new bwm 6/15/95
    (let ((non-null-p (psacc-needs-non-null-p pat1)))
      (position-if #'(lambda (x) (possible-matching-psacc-p pat1 x non-null-p)) input :start start)))
   ((and (pvariable-p pat1)             ; new bwm 6/28/95
         (psacc-p (pvariable-next pat1)))
    (let* ((nxt (pvariable-next pat1))
           (non-null-p (psacc-needs-non-null-p nxt)))
      (position-if #'(lambda (x) (possible-matching-psacc-p nxt x non-null-p)) input :start start)))
   ((and (atom pat1)
         (not (pvariable-p pat1))
         (not (single-match-fn pat1)))  ; separate check, now that no longer var bwm 6/15/95
    (position pat1 input :start start :test #'equal))
   ((<= start (length input)) start)    ;*** fix, rjf 10/1/92 (was <)
   (t nil)))

(defun segment-match+ (pattern input bindings ignore)
  "Match one or more elements of input."
  (declare (ignore ignore))
  (segment-match pattern input bindings 1))

(defun subbinding-vars (extension visible-only)
  (let (visited)
    (dolist (x (flatten (force-list extension)))
      (when (and (pvariable-p x)
                 (not (member x visited))
                 (not (and visible-only
                           (pvariable-dont-care-p x))))
        (push x visited))
      (block check-next
        (let (next)
          (cond
           ((and (pvariable-p x)
                 (pvariable-next x))
            (setq next (pvariable-next x)))
           ((psacc-p x)
            (setq next x))
           (t
            (return-from check-next nil)))
          ;; see if there's a value that's a var.
          (while (and next (psacc-p next))
            (setq next (psacc-next next)))
          (when (and (psval-p next)
                     (pvariable-p (psval-value next))
                     (not (member (psval-value next) visited))
                     (not (and visible-only
                               (pvariable-dont-care-p (psval-value next)))))
            (push (psval-value next) visited)))))
    visited))

(defun subbinding-bindings (extension subbind visible-only)
  (declare (optimize (speed 3)))
  (mapcan #'(lambda (x) (mlet (bind bound-p)
                            (lookup x subbind)
                          (when bound-p
                            (list bind))))
          (subbinding-vars extension visible-only)))
    
(defun match-var-to-subbindings (var extension subbind)
  (declare (optimize (speed 3)))
  (match-variable 
   var
   (subbinding-bindings extension subbind t)
   subbind))

(defun segment-match? (pattern input bindings ignore)
  "Match zero or one element of input."
  (declare (ignore ignore))
  (destructuring-bind ((cmd var &rest extension) . pat)
      pattern
    (declare (ignore cmd))
    (if (null extension)
        ;; original code
        (or (pat-match (cons var pat) input bindings)
            (pat-match pat input bindings))
      (let ((subbind (pat-match (append extension pat) input bindings)))
        (if (eq subbind fail)
            (pat-match pat input bindings)
          (match-var-to-subbindings var extension subbind))))))

(defun match-if (pattern input bindings ignore)
  "Test an arbitrary expression involving variables.
  The pattern looks like (($if code) . rest)."
  (declare (ignore ignore))
  ;; *** fix, rjf 10/1/92 (used to eval binding values)
  (let*-non-null ((if-result (eval-with-bindings (second (first pattern)) bindings)))
    (pat-match 
     (rest pattern)
     input
     (if (and (third (first pattern)) ;; == form (bwm)?
              (psval-p (third (first pattern)))
              (psval-p (psval-value (third (first pattern))))
              (pvariable-p (psval-value (psval-value (third (first pattern))))))
         ;; extend bindings
         (extend-bindings (psval-value (psval-value (third (first pattern)))) if-result bindings)
       bindings))))

(defun pat-match-abbrev (symbol expansion)
  "Define symbol as a macro standing for a pat-match pattern."
  (setf (get symbol 'expand-pat-match-abbrev) expansion))

(defun expand-pat-match-abbrev (pat)
  "Expand out all pattern matching abbreviations in pat."
  (cond ((and (symbolp pat) (get pat 'expand-pat-match-abbrev)))
        ((atom pat) pat)
        (t (cons (expand-pat-match-abbrev (first pat))
                 (expand-pat-match-abbrev (rest pat))))))

;;; new stuff to handle some kinds of structured input, miller 6/13/95

(eval-when (load eval)
  (setf (get '$boe 'single-match) 'match-beginning-of-expression)
  (setf (get '$eoe 'single-match) 'match-end-of-expression)
  (setf (get '$boi 'single-match) 'match-beginning-of-input)
  (setf (get '$eoi 'single-match) 'match-end-of-input))

(defun match-beginning-of-input (pattern input bindings)
  "Succeed iff we haven't matched anything yet."
  (and (eq input *original-input*)
       (pat-match pattern input bindings)))

(defun match-end-of-input (pattern input bindings)
  "Succeed if we are at the end of the input."
  (and (null input)
       (pat-match pattern input bindings)))

;; expressions here just mean structures within a collection, so we can force matching on the next expression.

(defun match-beginning-of-expression (pattern input bindings)
  "skip forward to the next boe if we haven't matched into one."
  (cond
   ((compound-communications-act-p input)
    (pat-match pattern (acts input) bindings))
   ((consp input)
    (while-not (or (structured-object-p (car input))
                   (null input))
      (pop input))
    (pat-match pattern input bindings))
   (t
    ;; no boe, so fail.
    nil)))

(defun match-end-of-expression (pattern input bindings)
  "skip forward to the next eoe"
  (cond
   ((compound-communications-act-p input)
    (pat-match pattern nil bindings))
   ((consp input)
    (while-not (or (structured-object-p (pop input))
                   (null input)))
    (pat-match pattern input bindings))
   (t
    ;; no eoe, so fail.
    nil)))

(defun structure-pattern-p (pattern)
  (declare (optimize (speed 3)))
  (if (consp pattern)
      (psacc-p (car pattern))
    (psacc-p pattern)))
    
(defun structure-matcher (pattern input bindings)
  "Match a structure pattern to the input"
  (cond
   ((consp pattern)
    (let ((sm1 (structure-match-1 (car pattern) (car input) bindings)))
      (if (eq sm1 fail)
          fail
        (pat-match (cdr pattern) input sm1)))) ; don't consume the input.
   (t
    (structure-match-1 pattern input bindings))))
        
(defun structure-match-1 (psacc object bindings)
  (let ((slotname (psacc-slotname psacc))
        (next (psacc-next psacc)))
    (cond
     ((eq slotname 'type)               ; handle special, means the type of the object
      (if (and next
               (psval-p next)
               (typecheck (type-of object) (psval-value next)))
          bindings
        fail))
     ((not (structured-object-p object)) ; better be a structured object then
      fail)
     ((and (slot-exists-p object slotname)
           (slot-boundp object slotname))
      (cond
       ((and next
             (psacc-p next)
             (slot-value object slotname))
        (structure-match-1 next (slot-value object slotname) bindings))
       ((and next
             (psval-p next)
             ;; allow nil
             (case (psacc-needs-non-null-p psacc)
               (:nil
                (null (slot-value object slotname)))
               ((nil)
                t)
               (t
                (slot-value object slotname))))
        (pat-match (psval-value next) (slot-value object slotname) bindings))
       (t
        fail)))
     (t
      fail))))

(defun psacc-needs-non-null-p (psacc)
  (declare (optimize (speed 3)))
  (let*-non-null ((next (psacc-next psacc)))
    (cond
     ((and (psval-p next)
           (null (psval-value next)))
      :nil)                             ;looking for an empty slot
     ((and (or (psacc-p next)
               (and (psval-p next)
                    (if (pvariable-p (psval-value next))
                        (typecheck (pvariable-type (psval-value next)) 't-non-null)
                      (object-of-type (psval-value next) 't-non-null)))))))))

(defun possible-matching-psacc-p (psacc input non-null-p) 
  "Quick and dirty, could we even possibly match this input?"
  (declare (optimize (speed 3)))
  (let ((slotname (psacc-slotname psacc)))
    (or (eq slotname 'type)
        (and (slot-exists-p input slotname)
             (slot-boundp input slotname)
             (or (not non-null-p)
                 (if (eq non-null-p nil)
                     (null (slot-value input slotname))
                   (slot-value input slotname)))))))

(defgeneric substitute-name-for-vars (form blessed-vars))

(defmethod substitute-name-for-vars (form blessed-vars)
  (declare (ignore blessed-vars))
  (values form nil))

(defmethod substitute-name-for-vars ((form cons) blessed-vars)
  (mlet (first-form first-form-new)
      (substitute-name-for-vars (car form) blessed-vars)
    (mlet (second-form second-form-new)
        (substitute-name-for-vars (cdr form) blessed-vars)
      (if (or second-form-new first-form-new)
          (values (cons first-form second-form) t)
        (values form nil)))))           ; so we don't cons excessively

(defmethod substitute-name-for-vars ((form pvariable) blessed-vars)
  (let ((name (pvariable-name form)))
    (unless (or (boundp name) (member (pvariable-name form) blessed-vars :test #'equal :key #'pvariable-name))
      (debug-log kqml:*kqml-recipient* t ";;pat match: missing binding for ~S, possible spelling error" name)
      (throw :missing-binding nil))
    (values name t)))

(defgeneric find-macro-vars (form))

(defmethod find-macro-vars (form)
  (declare (ignore form))
  nil)

(defmethod find-macro-vars ((form cons))
  (cond
   ((member (car form) lymi::+var-introducing-macros+)
    (cons (caadr form)
          (find-macro-vars (cddr form))))
   ((consp (car form))
    (let ((first-part (find-macro-vars (car form))))
      (if first-part
          (nconc first-part (find-macro-vars (cdr form)))
        (find-macro-vars (cdr form)))))
   (t
    (find-macro-vars (cdr form)))))
      

(defun eval-with-bindings (form bindings)
  "Eval a form with the bindings in effect for any encountered pattern variables"
  ;; some forms build new variables, we ignore them for the time being.
  (let ((blessed-vars (find-macro-vars form)))
    (catch :missing-binding
      (cond
       ((symbolp (caar bindings))
        ;; no bindings
        (eval (substitute-name-for-vars form blessed-vars)))
       (t
        (progv (mapcar #'(lambda (x) (pvariable-name (car x)))
                       bindings)
            (mapcar #'cdr bindings)
          (eval (substitute-name-for-vars form blessed-vars))))))))

