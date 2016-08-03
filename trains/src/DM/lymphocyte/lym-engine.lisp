(in-package lymphocyte-internal)
;; Time-stamp: <96/11/06 17:58:57 miller>

;; These are the "UI" for the engine

;; the general interface
(defun run-lymphocyte (rulebasename input-expression initial-budget &optional dont-execute-p)
  "Standard interface; run lymphocyte, generate continuable error when out of funds"
  (declare (type symbol rulebasename)
           (type number initial-budget) ; "dollars"
           (ignore initial-budget))     ; for now
  (complete-lymphocyte rulebasename input-expression dont-execute-p))

(defvar *prior-results* nil "alist Cache of prior results from matcher")

(defun complete-lymphocyte (rulebasename input-expression &optional dont-execute-p)
  "Run lymphocyte to completion regardless of cost."
  (declare (type symbol rulebasename))
  (with-rulebase (rulebasename)
    (assert (rulebase-rules-0 *current-rulebase*) (rulebasename) "Null rulebase, ~A" rulebasename))
  (let ((level 0)
        level-rules
        *prior-results*)
    (while (setq level-rules (handle-level rulebasename level input-expression #'patternmatch-all))
      ;; we had some rules at this level, so keep going.
      (update-alist level level-rules *prior-results*) ; save result for level
      (incf level))
    ;; ok, no more applicable rules. Run best production.
    (let*-non-null ((rule-evaluations (reduce #'append (mapcar #'cdr *prior-results*)))
                    (utility-results (sort (remove-if-not #'(lambda (re)
                                                              (lrule-produces (lrule-eval-rule re)))
                                                          rule-evaluations)
                                           #'compare-utility)))
      (unless dont-execute-p
        (transcribe-and-log kqml:*kqml-recipient* "Lym: Chose strategy: ~W"
                            (if (car utility-results)
                                (lrule-name (lrule-eval-rule (car utility-results))))))
      (debug-log kqml:*kqml-recipient* t "Lym: Top 3 rules: 1:~W 2:~W 3:~W"
        (if (car utility-results)
            (lrule-name (lrule-eval-rule (car utility-results))))
        (if (cadr utility-results)
            (lrule-name (lrule-eval-rule (cadr utility-results))))
        (if (caddr utility-results)
            (lrule-name (lrule-eval-rule (caddr utility-results)))))
      (debug-log kqml:*kqml-recipient* t  "Lym: Top 3 productions (~S):~% 1:~W~% 2:~W~% 3:~W~%"
                 rulebasename
                 (car utility-results)
                 (cadr utility-results)
                 (caddr utility-results))
      
      (if dont-execute-p
          (values (lrule-produces (lrule-eval-rule (car utility-results))) 
                  (lrule-eval-postmatch-cache (car utility-results)))
        (eval-with-bindings (lrule-produces (lrule-eval-rule (car utility-results))) 
                            (lrule-eval-postmatch-cache (car utility-results)))))))

(defun tight-lymphocyte (rulebasename input-expression initial-budget &optional dont-execute-p)
  "Run lymphocyte strictly on the budget, don't ask for more money"
  (declare (type symbol rulebasename)
           (type number initial-budget)) ; "dollars"
  
  (run-lymphocyte rulebasename input-expression initial-budget dont-execute-p)) ; for now

;;; internal functions. Soon these should be made "lazy" and take advantage of "side effect free" nature.

(defun cache-cost (rule1-eval)
  (or (lrule-eval-cost-cache rule1-eval)
      (setf (lrule-eval-cost-cache rule1-eval)
        (eval-with-bindings (lrule-cost (lrule-eval-rule rule1-eval)) (lrule-eval-prematch-cache rule1-eval)))))

(defun compare-cost (rule1-eval rule2-eval)
  "Do any needed partial evaluations of the rules, and then return return t if rule1 <= rule2"
  (< (cache-cost rule1-eval) (cache-cost rule2-eval)))

(defun cache-utility (rule1-eval)
  (or (lrule-eval-utility-cache rule1-eval)
      (setf (lrule-eval-utility-cache rule1-eval)
        (if (lrule-eval-successful-p rule1-eval)
            (eval-with-bindings (lrule-utility (lrule-eval-rule rule1-eval)) (lrule-eval-postmatch-cache rule1-eval))
          0))))

(defun compare-utility (rule1-eval rule2-eval)
  "Do any needed partial evaluations of the rules, and then return return t if rule1 >= rule2"
  (>= (cache-utility rule1-eval) (cache-utility rule2-eval)))

(defun handle-prematch-bindings (rule)
  (or (mapcar #'(lambda (pair)
                  (assert (pvariable-p (car pair)) nil
                    "A pattern variable must be the target of a preeval: ~S" (car pair))
                  (pat-match::make-binding (car pair) (eval (cadr pair))))
              (lrule-prematch rule))
      pat-match:no-bindings))

(defun er-2 (rule input prematch-bindings class trace-rule &optional (local-pattern (lrule-pattern rule)))
  (let* ((trace (or trace-rule *trace-lym*))
         (match-bindings (if (eq class :meta-rule)
                             (pat-match-toplevel local-pattern input prematch-bindings)
                           (patternmatch-one local-pattern input prematch-bindings)))
         (postmatch-bindings match-bindings))
    
      (when (eq match-bindings pat-match:fail)
        (if trace-rule
            (do-log kqml:*kqml-recipient* "~&~A ~A failed, prematch: ~W,~%~8Tinput: ~W~8Tpattern: ~W" 
                    class
                    (string (lrule-name rule))
                    prematch-bindings
                    input
                    local-pattern))
        (return-from er-2 nil))
      
      (if trace
          (do-log kqml:*kqml-recipient* "~&~A ~A matched, bindings: ~W~%" 
                  class
                  (string (lrule-name rule))
                  match-bindings))
      
      (mapc #'(lambda (pair)
                (assert (pvariable-p (car pair)) nil
                  "A pattern variable must be the target of a posteval: ~S" (car pair))
                (setq postmatch-bindings (pat-match::extend-bindings (car pair) 
                                                                     (eval-with-bindings (cadr pair) postmatch-bindings)
                                                                     postmatch-bindings)))
            (lrule-postmatch rule))
      
      (if (and trace (lrule-postmatch rule))
          (do-log kqml:*kqml-recipient* "Posteval bindings: ~W" postmatch-bindings))
      
      (progfoo (make-lrule-eval :rule rule
                                :prematch-cache prematch-bindings
                                :match-cache match-bindings
                                :postmatch-cache postmatch-bindings
                                :utility-cache nil)
        (setf (lrule-eval-successful-p foo) (not (eq match-bindings pat-match:fail))))))

(defun eval-rule (rule input)
  "Handle evaluation of a single rule from patternmatch-all (not the general interface!"
  ;; since we won't have evaluating the cost, have to do any prematch work ourself.
  (let* ((prematch-bindings (handle-prematch-bindings rule))
         (trace-rule (or (member (string (lrule-name rule)) *trace-rules*  :test #'equalp :key #'string)
                         (member (string (lrule-type rule)) *trace-rules*  :test #'equalp :key #'string))))
    (er-2 rule input prematch-bindings :rule trace-rule)))

(defun eval-meta-rule (rule level)
  "Handle evaluation of a single meta-rule from patternmatch-all-meta (not the general interface!"
  ;; unlike normal rules, we select those level 0 rules that already matched as interesting to match with the
  ;; meta-rule's pattern. Then we invoke the matcher.
  (declare (ignore level))
  (let* ((prematch-bindings (handle-prematch-bindings rule))
         (prior-results (reduce #'append (mapcar #'cdr *prior-results*)))
         (local-pattern)
         (trace-rule (or (member (string (lrule-name rule)) *trace-rules*  :test #'equalp :key #'string)
                         (member (string (lrule-type rule)) *trace-rules*  :test #'equalp :key #'string)))
         (trace (or trace-rule *trace-lym*))
         input)
    (do* ((pattern (copy-list (lrule-pattern rule)) (cdr pattern))
          (pattern-element (car pattern) (car pattern))
          (pattern-specifier (cadr pattern) (cadr pattern)))
        ((null pattern))
      (cond
       ((and (symbolp pattern-element)
             (not (keywordp pattern-element)))
        ;; names a level-0 rule
        (let ((rule-eval (find-if #'(lambda (x)
                                      (and (or (equal pattern-element (lrule-type (lrule-eval-rule x)))
                                               (equal pattern-element (lrule-name (lrule-eval-rule x))))
                                           (plusp (cache-utility x)))) ; matched
                                  prior-results)))
          ;; pick out what's needed.
          (cond
           ((null rule-eval)            ; not a match
            (if trace
                (do-log kqml:*kqml-recipient* "~&~A ~A failed, prematch: ~W,~%~8Tmissing input: ~W" 
                        :meta-rule
                        (string (lrule-name rule))
                        prematch-bindings
                        pattern-element))
            (return-from eval-meta-rule nil))
           ((psacc-p pattern-specifier) ; map to right part of the structure
            (let ((rule  (lrule-eval-rule rule-eval)))
              (push (case (psacc-slotname pattern-specifier)
                      (name
                       (lrule-name rule))
                      (type
                       (lrule-type rule))
                      ((utility benefit)
                       (cache-utility rule-eval))
                      (cost
                       (cache-cost rule-eval))
                      (explanation
                       (lrule-explanation rule))
                      ((prematch local)
                       (lrule-eval-prematch-cache rule-eval))
                      ((postmatch localeval)
                       (lrule-eval-postmatch-cache rule-eval))
                      (produces
                       (lrule-produces rule))
                      (pattern
                       (lrule-pattern rule))
                      (t
                       ;; exported variable name?
                       (progfoo (find (string (psacc-slotname pattern-specifier)) (lrule-arguments rule)
                                      :key #'(lambda (x) (string (pvariable-name x))) :test #'equalp)
                         (cond
                          (foo
                           ;; yes, use it's binding.
                           (let ((binding (binding-val
                                           (get-binding foo (lrule-eval-postmatch-cache rule-eval)))))
                             (setq foo binding)))
                          (t
                           (debug-log kqml:*kqml-recipient* t "~&~A ~A failed, unknown psacc, typo?: ~W" 
                                   :meta-rule
                                   (string (lrule-name rule))
                                   pattern-specifier)
                           ;; unknown, fail
                           (return-from eval-meta-rule nil))))))
                    input)
              (setf (cadr pattern) (psacc-next pattern-specifier)))) ; so we process it next.
           (t
            (push rule-eval input)))))
       (t
        (push pattern-element local-pattern))))
    (er-2 rule (nreverse input) prematch-bindings :meta-rule trace-rule (nreverse local-pattern))))

(defun patternmatch-all (rules input)
  "Match *all* rules (at a level) to input, return sorted by utility"
  ;; only handles a specific level, that is, the rules are explicitly an argument.
  
  (stable-sort (mapcan #'(lambda (r) (force-list (eval-rule r input)))
                       rules)
               #'compare-utility))

(defun patternmatch-all-meta (rules level)
  (stable-sort (mapcan #'(lambda (r) (force-list (eval-meta-rule r level)))
                       rules)
               #'compare-utility))

(defun dont-care-pattern-p (pattern)
  (and (consp pattern)
       (eq (car pattern) '$*)
       (pvariable-p (cadr pattern))
       (or (pvariable-dont-care-p (cadr pattern))
           (null (pvariable-type (cadr pattern)))))) ; untyped.

(defun patternmatch-one (pattern input &optional (bindings pat-match:no-bindings))
  "Return non-nil if the rule patternmatches the input"
  (let* ((pattern-start (car pattern))
         (pattern-end (car (last pattern))))
    (setq input (force-list input))
    ;; check to see if the pattern looks for $boi or $eoi
    (cond
     ((and (or (eq pattern-start '$boi)
               (dont-care-pattern-p pattern-start))
           (or (eq pattern-end '$eoi)
               (dont-care-pattern-p pattern-end)))
      (pat-match-toplevel pattern input bindings))
     ((or (eq pattern-start '$boi)
         (dont-care-pattern-p pattern-start))
      (pat-match-toplevel `(,@pattern
                              ($* ,(make-pvariable :name (gensym) :flags pat-match::+pvariable-dont-care+)))
                          input bindings))
     ((or (eq pattern-end '$eoi)
          (dont-care-pattern-p pattern-end))
      (pat-match-toplevel `(($* ,(make-pvariable :name (gensym) :flags pat-match::+pvariable-dont-care+))
                            ,@pattern) input bindings))
     (t
      (pat-match-toplevel `(($* ,(make-pvariable :name (gensym) :flags pat-match::+pvariable-dont-care+))
                            ,@pattern 
                            ($* ,(make-pvariable :name (gensym) :flags pat-match::+pvariable-dont-care+)))
                          input bindings)))))

(defun handle-level (rulebasename level input match-fn)
  (declare (type symbol rulebasename)
           (type function match-fn))
  
  (if (eql level 0)
      (handle-level-0 rulebasename input match-fn)
    (handle-meta-level rulebasename level match-fn)))

(defun get-level-0-rules (rulebasename)
  (with-rulebase (rulebasename)
    (append (rulebase-rules-0 *current-rulebase*)
            (mapcan #'get-level-0-rules (rulebase-parents *current-rulebase*)))))

(defun handle-level-0 (rulebasename input match-fn)
  (let ((rules (get-level-0-rules rulebasename)))
    (funcall match-fn rules input)))

(defvar *lv* 1)
(defun get-meta-rules (rulebasename &optional (level *lv*))
  (let ((*lv* level))
    (remove-if-not #'(lambda (x)
                       (eql (lrule-level x) level))
                   (with-rulebase (rulebasename)
                     (append (rulebase-rules-meta *current-rulebase*)
                             (mapcan #'get-meta-rules (rulebase-parents *current-rulebase*)))))))


(defun handle-meta-level (rulebasename level match-fn)
  (let ((rules (get-meta-rules rulebasename level)))
    ;; meta-rules are handles a little funny, 
    ;; we need to set up our input as the relevant portions of the matched level-9 rules.
    (cond
     ((eq match-fn #'patternmatch-all)
      (funcall #'patternmatch-all-meta rules level)))))
