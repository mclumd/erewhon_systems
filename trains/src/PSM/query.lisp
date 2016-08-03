;  THE QUERY FACILITY
;; This file contains the general functions to support  queries to the PSM.
;;  The specific procedural definitions of the PS-level predicates is elsewhere

;;  A data structure that maintains all the KNOWN PS-level relation names

(in-package "PSM")

(let ((PS-predicate-names)
      (SS-predicate-names))
  
  (defun known-PS-level-predicate-names nil
    PS-predicate-names)
  
  (defun add-PS-level-predicate (name)
    (setq PS-predicate-names 
      (cons name PS-predicate-names)))
  
  (defun set-PS-level-predicate-names (value)
    (setq PS-predicate-names value))
  
  (defun known-SS-level-predicate-names nil
    SS-predicate-names)
  
  (defun add-SS-level-predicate (name)
    (setq SS-predicate-names 
      (cons name SS-predicate-names)))
  
  (defun set-SS-level-predicate-names (value)
    (setq SS-predicate-names value))
  ) ;; end scope of PS-PREDICATE-NAMES and SS-PREDICATE-NAMES


(defun HANDLE-PSM-QUERY (op content vars-of-interest)
  "The handles queries from the KQML interface. PLAN-ID and PS-STATE 
   default to current focussed items if not specified"
  (let* ((prop (if (consp (car content)) (car content) content)) ;; allow (PRED arg1 arg2) or ((PRED arg1 arg2) :PLAN-ID hdg) forms
	 (plan-id (find-arg (cdr content) :plan-id))
	 (ps-state-id (find-arg (cdr content) :ps-state))
	 (ps-state (if ps-state-id 
		       (get-pss-by-name ps-state-id)
		     (current-pss))))
    (if (task-tree-p ps-state)
      (let* ((ST (task-tree-symbol-table ps-state))
             (plan (if plan-id (get-node-by-name plan-id ST)
		       (get-node-by-name (task-tree-focus ps-state) ST))))
        (if (task-node-p plan)
          (process-query op prop vars-of-interest plan ps-state)
          (list 'ANSWER :RESULT :FAILURE :REASON '(:TYPE :BAD-PLAN-ID))))
      (list 'ANSWER :RESULT :FAILURE :REASON '(:TYPE :BAD-PS-STATE-ID))))
  )

(defun process-query (op prop vars-of-interest plan ps-state)
  (cond ((not (consp prop))
	 (make-error-msg (Format nil "Illegal format in PROP ~S" prop)))
	((not (or (eq op 'ask-if)
		  (consp vars-of-interest) (eq vars-of-interest 'all)))
	 (make-error-msg (Format nil "Illegal format in ASPECT ~S" var-of-interest)))
	((some #'null (cdr prop))
	 (make-error-msg (Format nil "NIL argument not allowed in queries: ~S" prop)))
	(t
	 (let ((predname (car prop)))
	   (cond 
	    ((member predname '(:AT-TIME :AT-PS-STATE :AND :OR :NOT :MEMBER :AT-LOC :ORIGINAL-LOCATION))
	     (handle-built-in-preds predname op prop vars-of-interest plan ps-state))
	    ((member predname (known-PS-level-predicate-names))
	     (handle-PS-level-query
	      op prop vars-of-interest plan ps-state
	      (read-from-string (format nil "HANDLE-QUERY-~A" (symbol-name predname)))))
	    ((member predname (known-SS-level-predicate-names))
	     (handle-SS-level-query
	      op prop vars-of-interest plan ps-state
	      (read-from-string (format nil "HANDLE-QUERY-~A" (symbol-name predname)))
	      ))
	    (t (handle-domain-query op prop vars-of-interest plan ps-state))))
	)))
    
(defun handle-built-in-preds (predname op prop vars-of-interest plan ps-state)
  (let ((answer 
         (case predname
           (:AT-TIME)
           (:AT-PS-STATE)
           (:AND (handle-query-and prop plan ps-state))
           (:OR)
           (:NOT)
           (:MEMBER)
	   (:AT-LOC (handle-at-loc prop))
	   (:ORIGINAL-LOCATION (handle-original-location prop))
           )))
    (if answer (prepare-answer-for-query op prop vars-of-interest answer))))


;;  UTILITY FUNCTIONS FOR MAPPING A FULL RESULT TO THE ANSWER THAT WAS REQUESTED

(defun prepare-answer-from-tuples (op prop vars-of-interest tuples)
  (prepare-answer-for-query op prop vars-of-interest 
                             (get-answers-for-rel prop tuples)))

(defun prepare-answer-for-query (op prop vars-of-interest answers)
  "This gets the full answer back for the query and then modifies the output to 
   fit the requested act. OP is the speech act type, PROP the query prop, VARS-OF-INTEREST
   are the variables for which an answer is requested, and ANSWERS is the list of all
   tuples that satisfy the PROP"
    (if answers
	(case op
	  (ask-if
	   (if (cadr answers)
	       '(ANSWER :RESULT T)
	     '(ANSWER :RESULT NIL))
	     )
	  ((ask-one ask-all)
	   (let ((var-list (extract-vars-of-interest vars-of-interest answers))
		 (vars vars-of-interest))
	     (when (eq vars-of-interest 'ALL)
	       (setq vars (car var-list))
	       (setq var-list (cadr var-list)))
	     (if (eq op 'ASK-ONE)
		 `(ANSWER :RESULT ,(car var-list) :VARS ,vars)
	       `(ANSWER :RESULT ,var-list :VARS ,vars))))
          (otherwise
           (PSM-warn "Illegal performative: ~S" op)))
        ))

(defun extract-vars-of-interest (vars-of-interest var-list)
  "This takes a list a variables and a set of variable bindings,
    and returns the values for the variables of interest"
  (if vars-of-interest
    (if (EQ vars-of-interest 'ALL)
      var-list
      (let ((vals (mapcar #'(lambda (x)
                              (get-value-list-for-var x var-list))
                          vars-of-interest)))
        (reorder-lists vals)))))

(defun get-value-list-for-var (var var-list)
  "The returns the list of values for a specific var from a complex var list.
   e.g., (get-value-list-for-var 'x '((x y) (x1 y1) (x2 y2) (x3 y3)))
   returns (x1 x2 x3)"
  (let ((n (position-if #'(lambda (x) (eq x var)) (car var-list))))
    (if n
	(mapcar #'(lambda (y)
		(nth n y))
	    (second var-list))
        ;; no values for this variable, return a list of nils
        (gen-list-of-nils (length (second var-list))))
    ))

(defun gen-list-of-nils (n)
  (if (> n 0)
    (cons nil (gen-list-of-nils (- n 1)))))

(defun reorder-lists (vals)
  "This takes a list of individual values for variables, and creates a list 
    of lists, each containing one value of each variable. e.g., ((x1 x2 x3) (y1 y2 y3))
    returns ((x1 y1) (x2 y2) (x3 y3))"
  (if (and vals (car vals))
      (cons (mapcar #'car vals)
	    (reorder-lists (mapcar #'cdr vals)))))
	    
(defun get-answers-for-rel (prop tuples)
  "This takes a PROP and list of possible values for each ARG position,
     and returns a binding list of any variables. Currently, we do not 
     allow embedded variables or a value of NIL as an argument (as NIL is used as a wildcard in matching"
  (let* ((max (length (cdr prop)))
	 (temp (filter-tuples (cdr prop) tuples 0 max)))
    (gen-var-list-from-tuples (cdr prop) temp 0 max)))

(defun filter-tuples (args tuples index max)
  "Returns the tuples that match the query args."
  (if (< index max)
    (let ((arg (nth index args)))
        (filter-tuples args
                       (if (isvariable arg)
                         tuples 
                         (remove-if-not 
                          #'(lambda (x) (match-prop (nth index x) arg T))
                          tuples))
                       (+ index 1) 
                       max))
    tuples))

(defun gen-var-list-from-tuples  (args tuples index max)
  "converts a list of successful tuples into a var-list representation of the solution"
   (if (< index max)
    (let ((arg (nth index args)))
      (if (isvariable arg)
        (gen-var-list-from-tuples args tuples (+ index 1) max)
        ;;  arg is a constant. remove it from all lists
        (gen-var-list-from-tuples (remove-nth index args)
                                  (mapcar #'(lambda (x) (remove-nth index x))
                                          tuples)
                                  index
                                  (- max 1))))
   (list (remove-if-not #'isvariable args)
         tuples)))

(defun remove-nth (n list)
  "probably wan to generalize this!"
  (case n
    (0 (cdr list))
    (1 (cons (car list) (cddr list)))
    (2 (cons (car list)
             (cons (cadr list)
                   (cdddr list))))))

;;  HANDLE-AT-LOC
;;  This is a hack that should be replaced when the temporal database is implemented
;;  It checks the location of engines according to the current plan
;;  It defaults to a standard DB query if no answer is found

(defun handle-at-loc (prop)
  (let ((planned-locs (get-engine-locs-from-plan (task-tree-leafs (current-pss))))
	(db-locs (find-domain-tuples prop nil nil)))
    (get-answers-for-rel prop (append planned-locs (remove-superceded-tuples planned-locs db-locs)))))

(defun get-engine-locs-from-plan (nodes)
  (when nodes
    (let* ((node (car nodes))
	   (content (task-node-content node))
	   (soln (task-solution content)))
      (if (solution-set-p soln)
	  (let ((agent (solution-set-agents soln))
		(destination (car (last (get-cities-in-route soln)))))
	    (cons (list agent destination)
		  (get-engine-locs-from-plan (cdr nodes))))
	(get-engine-locs-from-plan (cdr nodes))))))
    

(defun remove-superceded-tuples (new-locs old-locs)
  "removes any old locations that are superceded by new location information"
  (if new-locs
    (let ((obj (caar new-locs)))
      (remove-superceded-tuples (cdr new-locs)
				(remove-if #'(lambda (x) (eq (car x) obj)) old-locs)))
    old-locs))


;;  ORIGINAL LOCATION

(defun handle-original-location (prop)
  (let ((db-locs (find-domain-tuples (cons :at-loc (cdr prop)) nil nil)))
    (get-answers-for-rel prop db-locs)))

;;  BUILT-IN PREDICATES
;;   The most complex is AND

(defun handle-query-AND (prop plan ps-state)		 
  "AND is handle by doing successive individual queries and joins on the results"
  (query-and-join (cddr prop) plan ps-state (query-one (second prop) plan ps-state)))

(defun query-one (prop plan ps-state)
  "An embedded query - we are interested in all variables returned.
   We may want to optimize this later"
  (let ((ans (cdr (process-query 'ASK-ALL prop 'ALL plan ps-state))))
    (list (find-arg ans :vars) (find-arg ans :result))))

(defun query-and-join (remaining-props plan ps-state answer-so-far)
  (if (or (null remaining-props) (null answer-so-far))
    answer-so-far
    (let ((new-answer (query-one (car remaining-props) plan ps-state)))
      (when new-answer
        (query-and-join (cdr remaining-props)
                        plan ps-state
                        (join-var-lists new-answer answer-so-far))))))

(defun join-var-lists (vl1 vl2)
  "Joins two var lists together to create a combined var list"
  (cond
   ((or (null vl1) (null vl2))
    nil)
   ((eq vl1 T) vl2)
   ((eq vl2 T) vl1)
   ((and (consp vl1) (consp vl2))
    (let* ((v-names-1 (car vl1))
           (v-names-2 (car vl2))
           (combined-v-names (union v-names-1 v-names-2))
           (v-tuples-1 (expand-v-list vl1 combined-v-names))
           (v-tuples-2 (expand-v-list vl2 combined-v-names)))
      (list combined-v-names (intersect-tuples v-tuples-1 v-tuples-2))))
   (t (PSM-warn "Bad arg to join-var-lists:~S" (list vl1 vl2)))))

(defun expand-v-list (binding-list var-names)
  (if (equal var-names (car binding-list))
    (second binding-list)
    ;; expand binding-list with new variables
    ;;   this is a rather expensive way to do this, but works for now
    ;;  EXTRACT-VARS-OF-INTEREST will insert NIL as values for vars not in binding list
    (extract-vars-of-interest var-names binding-list)))

(defun intersect-tuples (tuples1 tuples2)
  "Takes two var lists involving identical variables in the same order
    and returns their join, where a NIL values is a wildcard"
  (if (null tuples1) 
    nil
    (let ((tuple1 (car tuples1)))
      (append
       (remove-if #'null
                  (mapcar #'(lambda (tuple)
                              (match-tuple tuple1 tuple nil))
                          tuples2))
       (intersect-tuples (cdr tuples1) tuples2)))))

(defun match-tuple (tuple1 tuple2 ans)
  (cond
   ((null tuple1) 
    (if (null tuple2) (reverse ans)))
   ;; check wildcards
   ((or (null (car tuple1)) (eq (car tuple1) (car tuple2)))
    (match-tuple (cdr tuple1) (cdr tuple2) (cons (car tuple2) ans)))
   ((null (car tuple2))
    (match-tuple (cdr tuple1) (cdr tuple2) (cons (car tuple1) ans)))
   ))

;;=================================================================================
;;  MANAGEMENT OF KNOWN SYMBOLS FOR DEFINITE REFERENCE
;;  this maintains the symbol tables for various objects that can be talked about
;;  (except for plans, which are handled in the Task-Tree code.

(defstruct st-entry 
  type value)

(let ((object-symbol-table nil))
  
  (defun clear-symbol-tables nil
    (setq object-symbol-table nil) 
    )
 
  (defun object-symbol-table nil
    object-symbol-table)
  
  (defun declare-an-object (name type value)
    (setq object-symbol-table
      (cons (cons name (make-st-entry :type type :value value))
	    object-symbol-table))
    name)
  
  (defun lookup-object (name)
    (let ((object (assoc name object-symbol-table)))
      (if object (st-entry-value (cdr object)))))
  
  (defun find-st-objects-by-type (type)
    (mapcar #'car
	    (remove-if-not #'(lambda (x) (eq (st-entry-type (cdr x)) type))
			   object-symbol-table)))
  
  (defun  find-st-values-by-type (type)
    (mapcar #'(lambda (e)
		(st-entry-value (cdr e)))
	    (remove-if-not #'(lambda (x) (eq (st-entry-type (cdr x)) type))
			   object-symbol-table)))
  

  )

          

;; CHECK-IF-TRUE
;; return t if query is successful

(defun check-if-true (prop)
  (let ((ans (process-query 'ask-if prop nil nil nil)))
    (and (consp ans) (find-arg (cdr ans) :RESULT))))
    

;; AGENT-ALREADY-IN-USE

(defun agent-in-use (agent)
  (quick-query 'ask-if `(:AGENT ,agent ?plan) '?plan))
    
