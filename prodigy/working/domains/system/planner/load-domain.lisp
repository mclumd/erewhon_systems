;;; $Revision: 1.12 $
;;; $Date: 1995/11/25 20:19:31 $
;;; $Author: jblythe $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: load-domain.lisp,v $
;;; Revision 1.12  1995/11/25  20:19:31  jblythe
;;; Fixed var-to-type so it would not suggest a type for specifications of
;;; the form (or t1 t2) or (~ t).
;;;
;;; Revision 1.11  1995/11/12  22:08:21  jblythe
;;; Main change is to fix some parts of apply and instantiate-op that assumed all
;;; infinite type objects were numbers. Now other sorts of objects can be used.
;;; Also removed some dead code for a general clean-up.
;;;
;;; Revision 1.10  1995/10/12  14:23:01  jblythe
;;; Added protection nodes as a node type and search strategy, turned on with
;;; the variable *use-protection* (off by default). Also added the "event"
;;; macro which accepts similar syntax to operators. The new file "protect.lisp"
;;; has the protection code.
;;;
;;; Revision 1.9  1995/10/03  14:23:58  jblythe
;;; 2 small fixes: 1 in load-domain to fix the print-out when a variable
;;; is not printed correctly, 1 in result.lisp to fix the output in
;;; multiple-solutions where a first solution is found but not a second, for
;;; example because of a time limit (this from dborrajo).
;;;
;;; Revision 1.8  1995/06/07  04:25:30  jblythe
;;; The relevance table was changed to make use of type information and more
;;; extensive error messages were provided for the domain checker. In the
;;; relevance table, permanent objects are assigned the top-type for simplicity.
;;;
;;; Revision 1.7  1995/04/20  20:10:58  khaigh
;;; Added code to allow objects to stay the same between runs.
;;; Based on Alicia's run-same-objects2
;;;
;;; Revision 1.6  1995/04/05  16:39:24  jblythe
;;; Included some layers of changes to dealing with forall and exists
;;; goals that had been languishing in a separate file. Also added code to
;;; allow arbitrary slots of operators, that are added to the property
;;; list, and fixed a problem with optionally compiling the matching
;;; functions.
;;;
;;; Revision 1.5  1995/03/14  17:17:51  khaigh
;;; Integrated SABA into main version of prodigy.
;;; Call (set-running-mode 'saba) and
;;;      (set-running-mode 'savta)
;;;
;;; Also integrated apply-op control rules:
;;; ;;    (control-rule RULE
;;; ;;         (if...)
;;; ;;         (then select/reject applied-op <a>))
;;; ;; OR:
;;; ;;    (control-rule RULE
;;; ;;         (if (and (candidate-applicable-op (NAME <v1> <v2>...) )
;;; ;;                  (candidate-applicable-op (NAME <v1-prime> <v2-prime>...) )
;;; ;;                  (somehow-better <v1> <v1-prime>)))
;;; ;;         (then select/reject applied-op (NAME <v1> <v2> ...)))
;;; (candidate-applicable-op is in meta-predicates.lisp)
;;;
;;; Revision 1.4  1995/03/13  00:39:25  jblythe
;;; General clean-ups, including a definition of gen-from-pred that can have
;;; more than one variable in the literal.
;;;
;;; Revision 1.3  1994/05/30  20:56:00  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:10  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


;; This is the load domain code.  It is all of the data structures
;; need to  load a domain.  Domain loading is done in two parts.
;; First components like operators, inference rules, and control rules
;; are parsed for syntactic correctness and then they are added to the
;; problem space, where they are checked for "semantic" correctness.
;; It is possible for a rule of any sort to exists independently of a
;; particular space.  If a space is changed (for instance by adding a
;; new operator to it) the function LOAD-DOMAIN must be called on
;; that problem space to rebuild the tables of static information.


;; The code in this file is in the PRODIGY4 package, the domains are
;; in the USER package.  For this reason when making reference to
;; symbols in the domains specification (for example the del in the
;; effects list of an operator) you must specify the user package
;; explicitly as in user::del.  There are some examples of this in
;; this file.

;; This could be better, but let's wait for the new lisp system.
#-CLISP
(unless (find-package "PRODIGY4")
	(make-package "PRODIGY4" :nicknames '("P4") :use '("LISP")))

(in-package  "PRODIGY4")

(defvar *current-problem-space*)

(defvar *subgoal-on-conditional-effects* t
  "If nil, the system will no longer subgoal on conditional effects.")

(defvar *always-remove-p* nil
  "If t, when you load in a new domain as the current problem space,
the system will always remove the old one without asking you. Useful
for running bunches of tests.")

(defvar *behaviour-on-arity-change* :warn
  "If has value :error, prodigy will cause an error if the arity of a predicate
changes in the domain being loaded. If it has the value :warn prodigy
will print a warning. Otherwise it won't do anything.")

;; none of the following variables may have global values.  They will
;; always have dynamic scope, but lexical extent. (I think)

(defvar *arity-hash*)
(defvar *defined-vars*)
(defvar *all-preds*)
(defvar *non-static-preds*)
(defvar *effect-preds*)

(setf (documentation '*current-problem-space* 'variable)
      "Variable that holds the current problem-space for PRODIGY 4.0.")

(export '(operator 
	  foperator 
	  inference-rule
	  event
	  control-rule
	  fcontrol-rule
	  primary-effects
	  axioms
	  pprint-rule 
	  add-operator
	  create-problem-space
	  delete-problem-space
	  *current-problem-space*
	  *always-remove-p*
	  load-domain
	  problem-space-property))

(defstruct (rule  (:print-function rule-print))
	   (name nil)
	   (params nil)
	   (precond-exp nil)
	   (precond-vars nil)
	   (vars nil)
	   (binding-lambda nil)
	   (effects nil)
	   (add-list nil)  ;; list of EFFECT-COND structures
	   (del-list nil)  ;; list of EFFECT-COND structures
	   (effect-var-map)
	   (select-bindings-crs nil)
	   (reject-bindings-crs nil)
	   (simple-tests nil)
	   (unary-tests nil)
	   (join-tests nil) 
	   (neg-simple-tests nil)
	   (neg-unary-tests nil)
	   (neg-join-tests nil)
	   (generator nil)
	   (plist nil))


;; EFFECT-COND holds a uninstantited cons'ed literal and its
;; associated conditional effect if it has one.  If it doesn't then
;; the CONDITIONAL  slot is nil.

(defstruct effect-cond
           effect
	   (conditional nil))


(defun rule-print (rule stream level)
  (declare (stream stream)
	   (type rule rule)
	   (ignore level))
  (princ "#<" stream)
  (cond ((typep rule 'operator)
	 (princ "OP: " stream))
	((typep rule 'inference)
	 (princ "INFER: " stream)))
  (princ (rule-name rule) stream)
  (princ ">" stream))

(defstruct (control-rule (:print-function control-rule-print))
           (name nil)
           (type nil)
	   (if nil)
	   (then nil)
	   (plist nil))

(defun control-rule-print (cr stream z)
  (declare (type control-rule cr)
	   (stream stream)
	   (ignore z))

  (let ((*standard-output* stream))
    (princ "#<")
    (princ "CR: ")
    (princ (symbol-name (control-rule-name cr)))
    (princ ">")))

(defmacro rule-effects-preds (rule)
  `(getf (rule-plist ,rule) :effects-preds))

(defmacro rule-select-crules (rule)
  "This is the list of select binding control rules that are relevant
to the operator or inference rule."
  `(getf (rule-plist ,rule) :select-binding-rules))

(defstruct (operator (:include rule) (:print-function rule-print)))

(defstruct (inference (:include rule) (:print-function rule-print)))

(defun rule-name-to-rule (rule-name p-space)
  (or (find rule-name (problem-space-operators p-space) 
	    :key #'rule-name)
      (find rule-name (problem-space-lazy-inference-rules p-space) 
	    :key #'rule-name)
      (find rule-name (problem-space-eager-inference-rules p-space) 
	    :key #'rule-name)))

;; One important, but slightly complicated thing to understand about
;; the problem space is the role of the type hierarchy.  There are
;; three components to the type hierarchy, sub-types, parent-types and
;; object-types.  It is a strict hierarchy so each type will have only
;; one parent type except :top-type which has none.  The object type
;; is the type of an object.  Objects exist only with respect to a
;; particular state (or problem).  At this writing objects can not be
;; created or destroyed during problem solving.  {An object has one and
;; only one type.}: soon to be changed.

;; The current implementation stores the types on the property lists
;; of the type or object symbols.  The indicator used is stored on the
;; plist of a particluar problem-space and is formed by concatenating
;; the name of the problem-space with other stuff.  In this way one
;; symbol may appear in two different problem spaces, but not collide
;; with it because type types for a particular problem are guarented
;; to be distinct.

;; INFINITE TYPES are types whose objects are not stored as a
;; prodigy-object structure, but as some other lisp object.  When a
;; type is declared infinite in a problem-space a lisp predicate must
;; be provided that is non-nil of every lisp objects of that
;; particular infinite type.  Since in a problem the state is
;; represented by a list of lists, symbols and numbers we need a way
;; to determine which ones represent a prodigy-object (by nameing it)
;; or an infinite type.  To determine if a thing should be represented
;; as a prodigy-object we search (using EQUAL to allow for objects
;; which have names that are complex objects) the prodigy-object-name's
;; of the objects in :top-type.  If it is found then that object is
;; used, if it is not found then we check (for completness) to see if
;; it is an infinite type, if it is fine we just use the lisp
;; representation.  If it is not then we issue an error.

(defstruct (problem-space (:print-function problem-space-print))
           name
           (operators nil)
	   (eager-inference-rules nil)
	   (lazy-inference-rules nil)
	   ;; control rules
	   (select-nodes nil)
	   (select-goals nil)
	   (select-operators nil)
	   (select-bindings nil)
	   (reject-nodes nil)
	   (reject-goals nil)
	   (reject-operators nil)
	   (reject-bindings nil)
	   (prefer-nodes nil)
	   (prefer-goals nil)
	   (prefer-operators nil)
	   (prefer-bindings nil)
	   (apply-or-subgoal nil)
	   (refine-or-expand nil)
	   (relevance-table '#(nil nil))
	   (flags nil)
	   (infinite-type-preds nil) ; list of predicates T of infin. types.
	   (arity-hash (make-hash-table :test #'eq))
	   (all-preds nil)
	   (static-preds nil)
	   (assertion-hash (make-hash-table :test #'eq))
	   (expandable-nodes (vector nil nil))
	   (expanded-goals nil)
	   (plist nil))


(defun problem-space-print (p-space stream level)
  (declare (stream stream)
	   (type problem-space p-space)
	   (ignore level))
  (princ "#<p-space:  " stream)
  (princ (problem-space-name p-space) stream)
  (princ ">" stream))

;;; Saves a few characters here and there.
(defmacro problem-space-property (property)
  `(getf (problem-space-plist *current-problem-space*) ,property))

;; The next two macros get gensym'ed symbols from the problems space
;; that let us get types and objects off of the names (symbols) that
;; correspond to the types and symbols.

(defmacro problem-space-type (p-space)
  "Returns idicator name for types in problems-space P-SPACE"
  `(getf (problem-space-plist ,p-space) :p-space-types))

(defmacro problem-space-object (p-space)
     `(getf (problem-space-plist ,p-space) :p-space-object))

;; This code manages objects in a problem space.
(defun reset-problem-space (p-space)
  (declare (type problem-space p-space))
  "Removes all the objects that weren't declared with \"pinstance\" from the
problem space.  This is the function to use BEFORE loading a new problem for
the existing problem space."
  (clear-assertion-hash p-space)
  (map nil #'(lambda (x)
	       (unless (permanent-object-p x)
		 (remove-object x p-space)))
       (type-instances (type-name-to-type :TOP-TYPE p-space)))
  (reset-prodigy-types (type-name-to-type :top-type p-space) p-space))

(defun reset-prodigy-types (type p-space)
  (declare (type type type))
  (map nil #'(lambda (x) (reset-prodigy-types x p-space)) (type-sub type))
  (setf (type-real-instances type)
	(type-permanent-instances type))
  (setf (type-instances type)
	(append (type-permanent-instances type)
		(apply #'append
		       (mapcar #'type-instances
			       (type-sub type))))))

(defun remove-object (object p-space)
  (let ((object-name (prodigy-object-name object)))
    (if (symbolp object-name)
	(remprop object-name (problem-space-object p-space)))))

(defun CREATE-PROBLEM-SPACE (name &key (current t))
  (declare (special *current-problem-space* *always-remove-p*))
  "CREATE-PROBLEM-SPACE by default creates a new problem space and
makes in the current problem space.  If :current is nil then it simply
returns a fresh problem space."

  (if (and  current
	    (boundp '*current-problem-space*)
	    (or *always-remove-p*
		(y-or-n-p "~&Remove existing problem space: ~S?(y/n)~%"
		      *current-problem-space*)))
      (remove-problem-space *current-problem-space*))
  
  (let ((key-package (find-package "KEYWORD"))
	(upcase-name (string-upcase (gentemp (string name))))
	(p-space (make-problem-space :name name)))
    
    (if current (setf *current-problem-space* p-space))

     (setf (problem-space-object p-space)
	   (intern (concatenate 'string upcase-name "-OBJECT")
		   key-package))
  
     (setf (problem-space-type p-space)
	     (intern (concatenate 'string upcase-name "-TYPES")
		     key-package))

     (setf (get :top-type (problem-space-type p-space))
	   (make-type :name :top-type))

     ;; Set up some of the default switches in the problem space to
     ;; reasonable starting values.
     (setf (getf (problem-space-plist p-space) :search-default)
	   :depth-first)
     
     ;; Turn abstraction off by default at the mo, until it works
     ;; better (soon, hopefully).
     (setf (getf (problem-space-plist p-space) :abstraction-level) 0)
     (setf (getf (problem-space-plist p-space) :schema-abstractions) t)

     ;; Turn some heuristics on by default.
     (setf (getf (problem-space-plist p-space) :min-conspiracy-number) t)
     (setf (getf (problem-space-plist p-space) :excise-loops) t)
     (setf (getf (problem-space-plist p-space) :use-abs-level) t)

     ;; Initialise before loading control rules
     (setf (getf (problem-space-plist p-space) :control-rule-abstraction-levels)
	   nil)

     ;; AAAARGH!
;;;     (setf (getf (problem-space-plist p-space) :lexical-goal-ordering)
;;;	   #'literal-lessp)
     ))
     
  

;; Predicates are stored in the assertion (I used assertion and
;; literal interchangeble.  They both refer to structures of type
;; literal) hash table in two different ways depending on the kind of
;; the predicate.  The hash table stored in the problem space maps all
;; the predicates to all the instances of each predicates literals.
;; So if you want all the literals for ON you say (gethash 'on
;; hash-table).  If the predicate is non-static (ie can be add'ed or
;; del'ed by an operator or inference rule then the above GETHASH will
;; return a hash table with an EQUAL test.  This takes a key like
;; (BLOCKA BLOCKB) and returns the instance of the literal if one
;; exists.  If the predicate is static then what is returned is a LIST
;; of all the literals.

;; The reason for doing it this way is that when we are generating
;; bindings for an operator we may want to know all the objects which
;; appear as the first object of and particular class of static
;; literals.  This means that when we examine a potential object we
;; need to know if it appears in at least one literal of a particular
;; class.  This is difficult to do if the predicates are stored in a
;; hash table because we can map over the hash table, but these means
;; we must examine every literal, and cannot simply stop when we know
;; the object is in at least one.  With a list (or any sequence) we
;; can use the common lisp SOME predicate, which stops at the right
;; time. 

(defun add-non-static-pred-new (predicate problem-space)
  (declare (symbol predicate)
	   (type problem-space problem-space))
  "Creates an entry for a non-static predicate in the assertion
hash-table if it does not already exists.  Entries for non-static
predicates are always hash-tables with an equal test."
  (let ((hash (problem-space-assertion-hash problem-space)))
    (if (not (hash-entry-p predicate hash))
	(setf (gethash predicate hash) (make-hash-table :test #'equal)))))

(defun add-static-pred-new (predicate problem-space)
  (declare (symbol predicate)
	   (type problem-space problem-space))
  "Creates an entry for a static predicate in the assertion hash-table
if it does not already exist.  Entries for static predicates are
always lists of literals."
  (let ((hash (problem-space-assertion-hash problem-space)))  
   (if (not (hash-entry-p predicate hash))
       (setf (gethash predicate hash)
	     (make-hash-table :test #'equal)))))

(defun hash-entry-p (key hash-table)
  (multiple-value-bind (a b)
		       (gethash key hash-table)
		       (declare (ignore a))
		       b))

(defun static-pred-p (pred)
  (declare (special *current-problem-space*))
  (if (member pred (problem-space-static-preds *current-problem-space*))
      t
      nil))

(defun clear-assertion-hash (p-space)
  (declare (type problem-space p-space))
  (setf (problem-space-assertion-hash p-space)
	(clrhash (problem-space-assertion-hash p-space))))

;;; *******************************************************
;;alicia: create my own macro so it will not
;;        clear-assertion-hash.
;;needed for load-problem-same-objects

(defmacro state-keep-lits (consed-literals)
  `(prog nil
;    (clear-assertion-hash *current-problem-space*)
    ,(cond ((eq (car consed-literals) 'user::and)
	    `(mapcar #'instantiate-consed-exp ',(cdr consed-literals)))
	   ((consp (car consed-literals))
	    `(mapcar #'instantiate-consed-exp ',consed-literals))
	   ((symbolp (car consed-literals))
	    `(instantiate-consed-exp ',consed-literals))
	   (t
	    (error "~&Bad state in ~S.~%" consed-literals)))))




;; The following code for load-domain requires the follow to be done 
;; (in the order listed) before it is called:

;;  All functions must be loaded.

;;  The type hierarchy must be loaded.

;;  All operators, inference, and control rules must be loaded.

;; The LOAD-DOMAIN and associated commands load a domain into the
;; system and create a problem space named NAME.

(defun load-domain (&key (problem-space *current-problem-space*)
			 (compile t))
  (declare (special *current-problem-space*)
	   (type problem-space *current-problem-space*))

  ;;; Mei, July 3.
  ;;; changed the sequence of several functions in load-domain.
  ;;; First,find all the non-static preds.
  ;;; Second,  build the static-preds list. static preds are members
  ;;; of all-preds that are not non-static-preds.
  ;;; third, build the relevance table for the problem-space.

  (let ((then (get-internal-run-time))
	(*compile-tests* compile))
    (declare (special *compile-tests*))
    
    (setf *non-static-preds* nil)
    (find-non-static-pred problem-space)
    (build-static-predicate-list problem-space)
    (build-relevance-table-for-p-space problem-space)

    ;; Each rule has a dependency graph that needs to be passed on to
    ;; the functions that build the test for the matching network.
    (build-select-binding-all-tests problem-space)
    (build-reject-binding-all-tests problem-space)

    (add-select-bindings-crs problem-space)
    (add-reject-bindings-crs problem-space)
    (create-tests-for-operators problem-space)
    (create-generator-for-operators problem-space)
    ;; Set up the relevance table and tests for events.
    (when (problem-space-property :events)
      (let ((table (vector nil nil)))
	(setf (problem-space-property 'event-relevance-table) table)
	(dolist (event (problem-space-property :events))
	  (add-to-event-relevance-table event table)))
      (dolist (event (problem-space-property :events))
	(create-tests-for-operator event)
	(create-generator-for-operator event)))
    
    ;; Check out the primary effects and domain axioms, if set, and
    ;; build the initial abstraction hierarchy.
    (check-primary-effects-and-axioms problem-space)
    
    (setf (getf (problem-space-plist problem-space)
		:use-primary-effects)
	  (if (getf (problem-space-plist problem-space)
		    :primary-effects)
	      t))
    (setf (getf (problem-space-plist problem-space)
		:problem-independent-hierarchy)
	  (create-hierarchy problem-space))
    (setf (getf (problem-space-plist problem-space)
		:domain-loaded)
	  (/ (float (- (get-internal-run-time) then))
	     internal-time-units-per-second))))

(defun maybe-compile (lambda-exp)
  (if *compile-tests*
      (compile nil lambda-exp)
    (eval `(function ,lambda-exp))))


(defun find-non-static-pred (p-space)
  (declare (special *non-static-preds*))
  "determined all the non static predicates of the domain."

  ;;; all the preds in the effect list of operators are non-static. 
  (dolist (op (problem-space-operators p-space))
    (add-effect-pred-as-non-static op))
  
  ;;; all the preds in the effect list of lazy inference rules are
  ;;; non-static. 
  (dolist (rule (problem-space-lazy-inference-rules p-space))
    (add-effect-pred-as-non-static rule))
  
  ;;; eager inference rules whose preconds has non-static preds are
  ;;; non-static inference rules, therefore the preds in their effect
  ;;; list are non-static.  The left-over eager-inference rules are
  ;;; static rules.
  (let ((flag t))
    (do ((rules (problem-space-eager-inference-rules p-space)))
	((or (null flag) (null rules)))
      (setf flag nil)
      (dolist (rule rules)
	(when (non-static-rule-p rule)
	  (setf (getf (rule-plist rule) :static) :no)
	  (when (add-effect-pred-as-non-static rule)
	    (setf flag t)))
	(setf rules (delete rule rules)))))

  ;;; if the eager inference is not non-static, record in its property
  ;;; list that it's static.
  (dolist (rule (problem-space-eager-inference-rules p-space))
    (if (null (getf (rule-plist rule) :static))
	(setf (getf (rule-plist rule) :static) :yes))))



;;; if at least one of the preds in the preconds of the rule is
;;; non-static, then this rule is non-static.
(defun non-static-rule-p (rule)
  (declare (special *non-static-preds*))
  (let ((preds (all-precond-preds rule)))
    (intersection preds *non-static-preds*)))


;;; returns T is rule is static.
(defun static-inference-rule-p (rule)
  (eq (getf (rule-plist rule) :static) :yes))


;;; add the predicates in the effect list of rule to
;;; *non-static-pred*, returns T is *non-static-preds* is changed, nil
;;; if it's not changed.
(defun add-effect-pred-as-non-static (rule)
  (declare (special *non-static-preds*))
  (let ((changed nil))
    (dolist (pred (all-effects-preds rule))
      (unless (member pred *non-static-preds*)
	(push pred *non-static-preds*)
	(setf changed t)))
    changed))
      

(defun conditional-effect-p (expr)
  (eq (car expr) 'user::if))

(defun universal-effect-p (expr)
  (eq (car expr) 'user::forall))

;;; returns all the predicates in the preconds list.
(defun all-precond-preds (rule)
  (let* ((preconds (rule-precond-exp rule))
	 (preds (third preconds))
	 (precond-preds (all-preds-exp preds))
	 (effects (third (rule-effects rule)))
	 (effect-precond-pred
	  (mapcan #'(lambda (x)
		      (all-preds-exp (if (conditional-effect-p x)
					 (second x))))
		  effects)))
    (delete-duplicates (append precond-preds effect-precond-pred))))


;;; Jim 9/93: added test for universal effects ("forall" effects). 
;;; Without this, we could think that effects were static when they
;;; were not, destroying completeness.
(defun all-effects-preds (rule)
  (let* ((effects (third (rule-effects rule)))
	 (preds (mapcan
		 #'(lambda (x)
		     (cond ((conditional-effect-p x)
			    (mapcan #'get-preds-effect (third x)))
			   ((universal-effect-p x)
			    (mapcan #'get-preds-effect (fourth x)))
			   (t (get-preds-effect x))))
		 effects)))
    (delete-duplicates preds)))

(defun get-preds-effect (effect)
  (all-preds-exp (second effect)))

;;; find all predicates from an expression list.
#|
(defun all-preds-exp (preds)
  (cond ((null preds) nil)
	((or (eq 'user::and (car preds))
	     (eq 'user::or (car preds)))
	 (mapcan #'all-preds-exp (cdr preds)))
;;	((eq 'user::if (car preds))
;;	 (mapcan #'all-preds-exp (third preds)))
	((eq 'user::~ (car preds))
	 (all-preds-exp (cdr preds)))
	((or (eq 'user::forall (car preds))
	     (eq 'user::exists (car preds)))
	 (all-preds-exp (third preds)))
	(t (list (car preds)))))
|#

(defun all-preds-exp (preds)
  (cond ((null preds) nil)
	((or (eq 'user::and (car preds))
	     (eq 'user::or (car preds)))
	 (mapcan #'all-preds-exp (cdr preds)))
;;	((eq 'user::if (car preds))
;;	 (mapcan #'all-preds-exp (third preds)))
	((eq 'user::~ (car preds))
	 (all-preds-exp (second preds)))
	((or (eq 'user::forall (car preds))
	     (eq 'user::exists (car preds)))
	 (all-preds-exp (third preds)))
	(t (list (car preds)))))


;;====================================================================
;; These functions build the lambda expressions that will eventually
;; be used by the matcher.  The tests are written in the spirit of
;; RETE net tests, although Prodigy 4 does not necessarily use a RETE net.

(defun create-tests-for-operators (p-space)
  (dolist (op (problem-space-operators p-space))
    (create-tests-for-operator op))
  (dolist (op (problem-space-lazy-inference-rules p-space))
    (create-tests-for-operator op))
  (dolist (op (problem-space-eager-inference-rules p-space))
    (create-tests-for-operator op)))


(defun create-tests-for-operator (op)
    (setf (rule-simple-tests op)
	  (get-all-simple-tests op))
    (setf (rule-unary-tests op)
	  (get-all-unary-tests op))
    (setf (rule-join-tests op)
	  (get-all-join-tests op))
    (setf (rule-neg-simple-tests op)
	  (get-all-neg-simple-tests op))
    (setf (rule-neg-unary-tests op)
	  (get-all-neg-unary-tests op))
    (setf (rule-neg-join-tests op)
	  (get-all-neg-join-tests op)))
  
(defun create-generator-for-operators (p-space)
  (dolist (op (problem-space-operators p-space))
    (create-generator-for-operator op))
  (dolist (op (problem-space-lazy-inference-rules p-space))
    (create-generator-for-operator op))
  (dolist (op (problem-space-eager-inference-rules p-space))
    (create-generator-for-operator op)))

(defun create-generator-for-operator (op)    
    (setf (rule-generator op)
	  (build-generator-for-rule op))
    (setf (getf (rule-plist op) :quantifier-generators) nil)
    (add-quantifier-generators (third (rule-precond-exp op)) t op)
    (dolist (effect (third (rule-effects op)))
      (if (eq (car effect) 'user::if)
	  (add-quantifier-generators (second effect) t op))))

(defun add-quantifier-generators (expr parity op)
  (case (car expr)
    ((user::and user::or)
     (dolist (subexp (cdr expr))
       (add-quantifier-generators subexp parity op)))
    (user::~ (add-quantifier-generators (second expr) (not parity) op))
    ((user::exists user::forall)
     (if (eq (car expr) (if parity 'user::forall 'user::exists))
	 (push (cons (second expr)
		     (build-generator-for-quantifier (second expr) op))
	       (getf (rule-plist op) :quantifier-generators)))
     (add-quantifier-generators (third expr) parity op))))

(defun build-generator-for-quantifier (varlist op)
  (let ((body (mapcar #'(lambda (var-spec)
			  (build-generator-for-var var-spec op))
		      varlist)))
    (if body
	(maybe-compile
	 `(lambda (partial-binding-list) (list ,.body))))))
		      

;;====================================================================
;;
#|
(defun build-select-binding-all-tests (p-space)
  (declare (type problem-space p-space))
  (dolist (cr (problem-space-select-bindings p-space))
    (let ((relevant-ops (ops-relevent-to-cr cr)))
      (if (null relevant-ops)
	  (error
	   "Can't find relevant operators for the control-rule ~S~% - ~
you should use current-ops or current-operator."
	   (control-rule-name cr))
	  (setf (getf (control-rule-plist cr) :all-tests)
		(extract-all-tests cr
				   (rule-name-to-rule
				    (first relevant-ops)
				    p-space)))))))
|#

;; (getf (control-rule-plist cr) :all-tests) is a list of
;;  (op-name all-tests-for-this-op). 
(defun build-select-binding-all-tests (p-space)
  (declare (type problem-space p-space))
  (dolist (cr (problem-space-select-bindings p-space))
    (let ((relevant-ops-names (ops-relevent-to-cr cr)))
      (if (null relevant-ops-names)
	  (error
	   "Can't find relevant operators for the control-rule ~S~% - ~
you should use current-ops or current-operator."
	   (control-rule-name cr))
	  (setf (getf (control-rule-plist cr) :all-tests)
		(extract-all-tests-for-all-ops cr relevant-ops-names p-space))))))

(defun extract-all-tests-for-all-ops (cr relevant-ops-names p-space)
  (let ((result nil))
    (dolist (op-name relevant-ops-names)
      (setf result
	    (push (list op-name
			(extract-all-tests cr (rule-name-to-rule op-name p-space)))
		  result)))
    result))


;;; all-tests is (list  *bucket-simple* *bucket-unary*  *bucket-join*
;;; vars))). 
(defun get-last-test (all-tests)
  (let ((pos1 (position-if-not #'null (second all-tests) :from-end t))
	(pos2 (position-if-not #'null (third all-tests) :from-end t)))
;    (format t "~% pos1: ~S pos2: ~s" pos1 pos2)
    (if pos1
	(if pos2
	    (if (> (1- pos1) pos2)
		(elt (second all-tests) pos1)
		(elt (third all-tests) pos2))
	    (elt (second all-tests) pos1))
	(if pos2
	    (elt (third all-tests) pos2)
	    (first all-tests)))))

#|	 
(defun get-last-test (all-tests)
  (let ((pos1 (position-if-not #'null (second all-tests)))
	(pos2 (position-if-not #'null (third all-tests))))
    (if pos1
	(if pos2
	    (if (>= (1+ pos1) pos2)
		(elt (second all-tests) pos1)
		(elt (third all-tests) pos2))
	    (elt (second all-tests) pos1))
	(if pos2
	    (elt (third all-tests) pos2)
	    (first all-tests)))))
|#	 

#|
;;; the way it's done now depend on the fact that all the ops in
;;; current-ops list have same length of vars.
(defun build-reject-binding-all-tests (p-space)
  (declare (type problem-space p-space))
  (dolist (cr (problem-space-reject-bindings p-space))
    (let ((relevant-ops (ops-relevent-to-cr cr)))
      (if (null relevant-ops)
	  (error
	   "Can't find relevant operators for the control-rule ~S~% - ~
you should use current-ops or current-operator."
	   (control-rule-name cr))
	  (let ((all-tests 
		 (extract-all-tests
		  cr (rule-name-to-rule (first relevant-ops) p-space))))
	    (setf (getf (control-rule-plist cr) :all-tests) all-tests)
	    (setf (getf (control-rule-plist cr) :last-test)
		  (get-last-test all-tests)))))))
|#

;;; 5/5/92
;;; the way it's done now depend on the fact that all the ops in
;;; current-ops list have same length of vars.
;;; 10/9/92, Mei
;;; (getf (control-rule-plist cr) :all-tests) is a list of the form
;;; (op-name all-tests-for-this-op)
;;; (getf (control-rule-plist cr) :last-test) is a list of the form
;;; (op-name last-test-for-this-op)
(defun build-reject-binding-all-tests (p-space)
  (declare (type problem-space p-space))
  (dolist (cr (problem-space-reject-bindings p-space))
    (let ((relevant-ops-names (ops-relevent-to-cr cr)))
      (if (null relevant-ops-names)
	  (error
	   "Can't find relevant operators for the control-rule ~S~% - ~
you should use current-ops or current-operator."
	   (control-rule-name cr))
	  (let* ((all-tests 
		 (extract-all-tests-for-all-ops
		  cr relevant-ops-names p-space))
		 (last-test
		  (get-last-test-for-all-ops all-tests p-space)))
	    (setf (getf (control-rule-plist cr) :all-tests) all-tests)
	    (setf (getf (control-rule-plist cr) :last-test) last-test))))))

(defun get-last-test-for-all-ops (all-tests p-space)
  (let ((res nil))
    (dolist (op-and-tests all-tests)
      (setf res
	    (push (list (first op-and-tests)
			(get-last-test (second op-and-tests)))
		  res)))
    res))


;;====================================================================
;; Each operator needs a list of the binding select control rules which
;; apply to it.  This is done by looking around in the select control
;; rule and pulling out the line that says current-ops and looking at
;; the argument.  ADD-SELECT-BINDINGS-FOR-OPERATORS looks into each CR
;; and figures out which operators to add the CR to.

(defun add-select-bindings-crs (p-space)
  (declare (type problem-space p-space))

  (dolist (cr (problem-space-select-bindings p-space))
    (let ((rule-names (ops-relevent-to-cr cr)))
      (dolist (rule-name rule-names)
	(let ((rule (or (find rule-name (problem-space-operators p-space)
			      :key #'rule-name)
			(find rule-name (problem-space-lazy-inference-rules p-space)
			      :key #'rule-name)
			(find rule-name (problem-space-eager-inference-rules p-space)
			      :key #'rule-name))))
	  (declare (type rule rule))
	  (pushnew cr (rule-select-bindings-crs rule)))))))
			 

(defun add-reject-bindings-crs (p-space)
  (declare (type problem-space p-space))

  (dolist (cr (problem-space-reject-bindings p-space))
    (let ((rule-names (ops-relevent-to-cr cr)))
      (dolist (rule-name rule-names)
	(let ((rule (or (find rule-name (problem-space-operators p-space)
			      :key #'rule-name)
			(find rule-name (problem-space-lazy-inference-rules p-space)
			      :key #'rule-name)
			(find rule-name (problem-space-eager-inference-rules p-space)
			      :key #'rule-name))))
	  (declare (type rule rule))
	  (pushnew cr (rule-reject-bindings-crs rule)))))))
			 



;;====================================================================
;; INTERNAL-CONSISTANCY-CHECKS looks at the domain and tries to find
;; things that might be wrong with the domain.

;; The internal-consistancy-checks checks things like 
(defun internal-consistancy-checks (p-space)
  (warn-for-unused-predicates p-space))


(defun warn-for-unused-predicates (p-space)
  (declare (ignore p-space))
  ())


;; Syntax checks on problem space.

;; Here we will check to be sure that all the operators and inference
;; rules are self consistent, and that all the functions used in the
;; variable bindings are in the user package.  This is a problem
;; because if a function is not in the user package it means that the
;; user either has used or redefined a function not in the user
;; package. 
;; The error message could be informative by giving you the names of
;; the operators and the inference rules that violate the rules, but I
;; will leave that for future generations.

(defun check-infer-op-interference (p-space)
  (declare (ignore p-space))
  "Currently does nothing"
  ())

;; This is commented out because I am now going to do these things at
;; load time and not at (load-domain) time.

;; user macros

(defmacro OPERATOR (&body body)
  (declare (special *current-problem-space*))
  "Does an expansion time syntax check and then reads the operator
into a data-structure."
  (check-syntax body *current-problem-space*)
  `(push (create-operator ',body)
    (problem-space-operators *current-problem-space*)))

(defun foperator (&rest op)
  (declare (special *current-problem-space*))
  "Checks the operator syntax and then reads the operator into a data
structure."
  (check-syntax op *current-problem-space*)
  (let ((real-op (create-operator op)))
    (setf (problem-space-operators *current-problem-space*)
	  (delete (operator-name real-op)
		  (problem-space-operators *current-problem-space*)
		  :key #'operator-name))
    (push real-op  (problem-space-operators *current-problem-space*))
    real-op))


(defun foperator-new (&rest op)
  (declare (special *current-problem-space*))
  (let ((real-op (apply #'foperator op)))
    (add-to-relevance-table (find (operator-name real-op)
				  (problem-space-operators *current-problem-space*)
				  :key #'operator-name)
			    *current-problem-space*)
  (build-static-predicate-list *current-problem-space*)
  (create-tests-for-operator real-op)
  (create-generator-for-operator real-op)))


(defmacro INFERENCE-RULE (&body body)
  (declare (special *current-problem-space*))
  "Does an expansion time syntax check and then reads the inference-rule
into a data-structure."
  (check-syntax body *current-problem-space*)
  `(let ((a ',(create-operator body)))
    (setf (getf (operator-plist a) :inference-rule) t)
    (if (eq (getf (operator-plist a) :mode) :eager)
	(push a (problem-space-eager-inference-rules *current-problem-space*))
	(push a (problem-space-lazy-inference-rules *current-problem-space*)))))

;;; I don't know if this is the greatest way to represent inference rules,
;;; so this macro is used throughout the code, and should be changed
;;; if the representation is changed. Jim.
(defmacro inference-rule-p (op)
  `(getf (operator-plist ,op) :inference-rule))

(defmacro inference-rule-a-or-b-node-p (node)
  `(inference-rule-p (instantiated-op-op
		      (a-or-b-node-instantiated-op ,node))))

;;; A prodigy "event" is basically an operator.
(defmacro event (&body b)
  `(progn
    (check-syntax ',b *current-problem-space*)
    (let ((op (create-operator ',b)))
      (setf (getf (rule-plist op) :event) t)
      (push op
	    (getf (problem-space-plist *current-problem-space*) :events)))))

(defun event-p (rule) (getf (rule-plist rule) :event))

(defun rule-duration (rule) (getf (rule-plist rule) 'user::duration))

(defun add-operator (op &optional (p-space *current-problem-space*))
  (declare (type operator op)
	   (type problem-space p-space)  
	   (special *current-problem-space*))
  (push op (problem-space-operators p-space)))


(defmacro PRIMARY-EFFECTS (&body effects)
  `(setf (problem-space-property :primary-effects) ',effects))

(defmacro AXIOMS (&body axioms)
  `(setf (problem-space-property  :axioms) ',axioms))

;; =================================================================
;; RELEVANCE TABLE CODE.  This code allows you to reset and add to a
;; a relevance table.  It probably should have a remove as well.  A
;; relevance table is a vector of two elements.  The first is a p-list
;; of add predicates mapped to rules and the second is a p-list of del
;; predicates mapped to their rules.  So to get the relevant operators
;; for the predicate ON give P-SPACE use: 
;;     (get (elt (problem-space-relevance-table P-SPACE) 0) 'user::on)

;;; NOTE - FORMAT CHANGED IN MAY 95

;;; New format uses the type specification of the predicate as well as
;;; its name to increase relevance. Each element of the two-element
;;; vector is now a hash-table, indexed by the predicate name, leading
;;; to an assoc list of type specifications, each being a list of
;;; types, derived from the operator spec. The body of the list is a
;;; list of operators as before.

;; User may be interested in the following functions:

;; To add a rule to the relevance table:

;; (ADD-TO-RELEVANCE-TABLE rule problem-space) will add a rule to the
;; relevance table



(defun build-relevance-table-for-p-space (p-space)
  (reset-relevance-table p-space)
  (add-rules-to-relevance-table
   (problem-space-operators p-space) p-space)
  (add-rules-to-relevance-table
   (problem-space-lazy-inference-rules p-space) p-space)
  (add-rules-to-relevance-table
   (remove-if #'static-inference-rule-p
	      (problem-space-eager-inference-rules p-space)) p-space))


;; The relevance-table is stored as a plist in this implementation.
;; All of the functions that use this implementation follow.  They
;; would all need to be re-written if the table were to be stored as,
;; say, a hash table.

(defun reset-relevance-table (p-space)
  (declare (type problem-space p-space))
  (setf (problem-space-relevance-table p-space)
	(vector (make-hash-table) (make-hash-table))))


(defun add-rules-to-relevance-table (rules p-space)
  (declare (type problem-space p-space))
  (dolist (rule rules)
	  (add-to-relevance-table rule p-space)))

;;; Note can't deal with nested foralls and ifs.
(defun add-to-relevance-table (rule p-space)
  (dolist (effect (third (rule-effects rule)))
    (cond				; is it a del or add?
      ((member (car effect) '(user::del user::add))
       (add-rule-for-pred (cadr effect) rule p-space (car effect)))
      ;; no, then a conditional or universal effect.
      ((eq (car effect) 'user::if)
       (dolist (subeffect (third effect))
	 (add-rule-for-pred (cadr subeffect) rule p-space (car subeffect))))
      ((eq (car effect) 'user::forall)
       (dolist (subeffect (fourth effect))
	 (add-rule-for-pred (cadr subeffect) rule p-space (car subeffect)
			    (second effect))))
      (t 
       (error "~S is not a legal effect (should be add or del)."
	      effect)))))

;;; turns a variable in the rule to a type in the type-spec, or t if
;;; the type should match anything.
(defun var-to-type (var rule p-space forall-bindings)
  (cond ((strong-is-var-p var)
	 (let ((spec
		(second (or (assoc var (second (rule-precond-exp rule)))
			    (assoc var (second (rule-effects rule)))
			    (assoc var forall-bindings)))))
	   (if (or (symbolp spec)
		   (and (listp spec)
			(eq (car spec) 'user::and)
			(symbolp (second spec))))
	       (type-name-to-type (if (listp spec) (second spec) spec)
				  p-space)
	     ;; just return global match for more complicated types
	     t)))
	;; permanent objects are not dealt with properly
	(t t)))


;;; checks if the object can match the type.
(defun relevance-match-type (type object)
  (cond ((eq type t) t)
	((functionp type)
	 (funcall type object))
	((prodigy-object-p object)
	 (or (eq (prodigy-object-type object) type)
	     (child-type-p (prodigy-object-type object) type)))))

;;; Adds rule to relevance table. Keeps the order in the table the
;;; same as the order in the file (it gets operators in reverse order).
(defun add-rule-for-pred (pred rule p-space parity &optional forall-bindings)
  " This adds the rule to the relevance table for PRED.  The table is
made up of two smaller tables, 0 for adding predicates and 1 for
removing them.  Use the keyword :add for adding predicates and :neg
for deleting."
  (let* ((type-spec
	  (mapcar #'(lambda (arg) (var-to-type arg rule p-space forall-bindings))
		  (cdr pred)))
	 (hash-table
	  (case parity
	    ((:add user::add) (elt (problem-space-relevance-table p-space) 0))
	    ((:del user::del) (elt (problem-space-relevance-table p-space) 1))
	    (otherwise (error "~S is not an acceptable parity.  Only :add
and :del.~%" parity))))
	 (hash-entry (gethash (car pred) hash-table)))
    (if hash-entry
	(let ((type-entry (assoc type-spec hash-entry :test #'tree-equal)))
	  (if type-entry
	      (pushnew rule (cdr type-entry))
	    (setf (gethash (car pred) hash-table)
		  (cons (list type-spec rule) hash-entry))))
      (setf (gethash (car pred) hash-table)
	    (list (list type-spec rule))))))

;;; The equivalent code for events doesn't yet use predicate
;;; signatures - this should be streamlined with the code above.
(defun add-to-event-relevance-table (rule table)
  (dolist (effect (third (rule-effects rule)))
    (cond 
      ((member (car effect) '(user::del user::add))
       (add-event-for-pred (caadr effect) rule table (car effect)))
      ;; no, then a conditional or universal effect.
      ((eq (car effect) 'user::if)
       (dolist (effect (third effect))
	 (add-event-for-pred (caadr effect) rule table (car effect))))
      ((eq (car effect) 'user::forall)
       (dolist (effect (fourth effect))
	 (add-event-for-pred (caadr effect) rule table (car effect)))))))

(defun add-event-for-pred (pred rule table parity)
  (case parity
	((:add user::add)
	 (pushnew rule (getf (elt table 0) pred)))
	((:del user::del)
	 (pushnew rule (getf (elt table 1) pred)))))

;;; This function gets the relevent operators from the table. 
(defun relevant-operators (lit p-space parity)
  (declare (symbol effect)
	   (type problem-space p-space))
  (let* ((hash-entry
	  (gethash (literal-name lit)
		   (case parity
		     ((:add user::add)
		      (elt (problem-space-relevance-table p-space) 0))
		     ((:del user::del)
		      (elt (problem-space-relevance-table p-space) 1))
		     (otherwise (error "relevant-operators: ~S must be either :add, :del,~
user::add or user::del.~%" parity)))))
	 (argvec (literal-arguments lit))
	 ;; find all entries that match the type
	 (all-matches
	   (mapcar
	    #'(lambda (type-entry)
		(if (and (= (length (car type-entry))
			    (length argvec))
			 (dotimes (i (length argvec) t)
			   (unless (relevance-match-type
				    (elt (car type-entry) i) (elt argvec i))
			     (return nil))))
		    (cdr type-entry)))
	    hash-entry)))
    (copy-list (remove-duplicates (apply #'append all-matches)))))
	    

#|(defun relevance-list (p-space)
  "Returns a list of the form ((effect . op1 op2 op3 op4) ... )"
  (declare (type problem-space p-space))
  (do* ((relevance-list (problem-space-relevance-table p-space)
		       (cddr relevance-list))
	(result (list (cons (first relevance-list)
			    (second relevance-list)))
		(nconc result (list (cons (first relevance-list)
			    (second relevance-list))))))
       ((endp relevance-list) result)))|#

(defun remove-operator-for-relevance (pred rule p-space parity)
  (declare (type rule rule))

  "This removes an operator from a particular relevance condition.
For example if you run (remove-operator-for-relevance 'ON 'STACK :add)
then STACK will not be considered when the goal is ON"

  (if (not (typep rule 'rule))
      (error "~S is not type rule.~%" rule))

  (let ((index (case parity
		 ((:add user::add) 0)
		 ((:del user::del) 1))))
    (setf (getf (elt (problem-space-relevance-table p-space) index) pred)
	  (delete rule 
		  (getf (elt (problem-space-relevance-table p-space) index)
			pred)))))



;; =======================================================
;; BUILD-STATIC-PREDICATE-LIST 

;;; this is changed because I use a different algorithm for building
;;; non-static-preds.
;;; sometimes nil becomes a pred in problem-space-all-preds, which
;;; shouldn't be there.  It's not causing us any trouble, so I delay
;;; finding out where the bug is;  but I can't have nil as static
;;; pred, since it will screw up function has-entry-p.  [Mei]

(defun build-static-predicate-list (p-space)
  (declare (special *non-static-preds*))
  (setf (problem-space-static-preds p-space)
	(remove-if #'(lambda (x) (or (member x *non-static-preds*)
				     (null x)))
		   (problem-space-all-preds p-space))))



;; this is a pretty print function for rules.			    

(defun pprint-rule (rule)
  (fresh-line)
  (princ "TYPE: ")
  (cond ((typep rule 'operator)
	 (princ "Operator"))
	((typep rule 'inference)
	 (princ "Inference-Rule")))
  (terpri)
  (princ "NAME:  ")
  (princ (rule-name rule))
  (terpri)
  (princ "PARAMS:  ")
  (princ (rule-params rule))
  (terpri)
  (princ "PRECOND:  ")
  (princ (rule-precond-exp rule))
  (terpri)
  (princ "EFFECTS:  ")
  (princ (rule-effects rule))
  (terpri)
  (princ "PLIST:  ")
  (princ (rule-plist rule))
  (values))
  
;; This section generates a data structure for each operator.

(defun create-operator (op)
  (let* ((name (first op))
	 (params (assoc 'user::params (cdr op)))
	 (preconds (assoc 'user::preconds (cdr op)))
	 (effects (assoc 'user::effects (cdr op)))
	 (all-vars  (nconc
		     (mapcar #'car (second preconds))
		     (mapcar #'car (second effects))
		     (mapcan #'(lambda (eff)
				 (if (eq (car eff) 'user::forall)
				     (mapcar #'car (second eff))))
			     (third effects))))
	 ;; only there for inference rules.
	 (mode (or (second (assoc 'user::mode (cdr op))) :lazy)))
    (if (not (subsetp (cdr params) all-vars))
	(error "~%params list has variables that are not in the~
 operator: ~S" name))
    (make-operator
     :name name
     :params params
     :precond-exp preconds
     :precond-vars (mapcar #'car (second preconds))
     ;; I assume this order in apply.lisp - don't change!
     :vars all-vars
     :binding-lambda nil      ; (make-binding-generator (car preconds))
     :add-list (make-effect-list (third effects) :add nil)
     :del-list (make-effect-list (third effects) :del nil)
     :effects effects
     :effect-var-map (match-effects-with-vars effects)
     :plist `(:mode ,(intern (symbol-name mode) :keyword)
		    ,@(mapcan #'(lambda (slot)
				  (unless (member (car slot)
						  '(user::params user::preconds
						    user::effects user::mode))
				    (copy-list slot)))
			      (cdr op))))))

(defun make-effect-list (effects type cond)
  (let ((whatever-list nil)
	(conditional-list nil))
    
    (dolist (effect effects)
      (cond ((and (eq type :add)
		  (eq (car effect) 'user::add))
	     (push (make-effect-cond
		    :effect (second effect)
		    :conditional cond)
		   whatever-list))
	    ((and (eq type :del)
		  (eq (car effect) 'user::del))
	     (push (make-effect-cond
		    :effect (second effect)
		    :conditional cond)
		   whatever-list))
	    ((eq (car effect) 'user::if)
	     (if cond
		 (error "You can't have nested conditional effects.~%")
		 (let ((newbit (make-effect-list (third effect) type effect)))
		   (if newbit (push newbit conditional-list)))))
	    ((eq (car effect) 'user::forall)
	     (if cond
		 (error "You can't nest conditional and universal effects.~%")
		 (let ((newbit (make-effect-list (fourth effect) type effect)))
		   (if newbit (push newbit conditional-list)))))))
    (cond (cond whatever-list)
	  ((null whatever-list) conditional-list)
	  (t
	   (cons whatever-list conditional-list)))))

;;; MATCH-EFFECTS-WITH-VARS 
(defun match-effects-with-vars (effects)
  (let ((cond-var-assoc-list nil)
	(vars-in-effects
	 (nconc (mapcar #'car (second effects))
		(mapcan #'(lambda (effect)
			    (if (eq (car effect) 'user::forall)
				(mapcar #'car (second effect))))
			(third effects)))))

    (dolist (effect (third effects) cond-var-assoc-list)
      (if (member (car effect) '(user::if user::forall))
	  (setf cond-var-assoc-list
		(acons effect
		       (intersection vars-in-effects
				     (all-vars effect))
		       cond-var-assoc-list))))))
      
    
;; The following code does a simple syntax check on the operators.  It
;; moves recursively through the entire structure checking arity and
;; keywords.  Checking for semantics (such as adds that are the same
;; in both an inference rule and an operator) will be done in other
;; code.
(defmacro rule-name* (rule) `(first ,rule))

(defmacro rule-params* (rule) `(assoc 'user::params (cdr ,rule)))

(defmacro rule-preconds* (rule) `(assoc 'user::preconds (cdr ,rule)))

(defmacro rule-effects* (rule) `(assoc 'user::effects (cdr ,rule)))

(defmacro rule-mode* (rule) `(assoc 'user::mode (cdr ,rule)))

(defun is-variable-p (sym)
   (and (symbolp sym)
	(char= #\< (char (symbol-name sym) 0))))

(defun check-syntax (*checked-op* p-space)
  (declare (type problem-space p-space)
	   (special *checked-op*))

  (let ((*arity-hash* (problem-space-arity-hash p-space))
	(*defined-vars* (check-variable-generators
			 (second (rule-preconds* *checked-op*))))
	(*all-preds* nil)         ; all the predicates in conditional of rule.
	(*non-static-preds* nil)
	(*effect-preds* nil)		; collects preds in effects
	(name (rule-name* *checked-op*)))
    (declare (special *arity-hash* *all-preds* *non-static-preds*
		      *effect-preds* *defined-vars*))
    (check-name name)
    (check-preconds (rule-preconds* *checked-op*) name)
    (check-effects (rule-effects* *checked-op*) name)
    (check-params (rule-params* *checked-op*) name)
    (check-mode (rule-mode* *checked-op*) name)

    ;; I don't know why I simply didn't use set difference here.
    (setf (problem-space-all-preds p-space)
	  (union
	   (union (problem-space-all-preds p-space)
		   *all-preds*)
	   *effect-preds*))))

(defun check-name (name)
  (cond ((not (symbolp name))
	 (error "Rule name ~S is not a symbol." name))
	((null name)
	 (error "Rule name may not be null."))))

(defun check-params (params name)
  (cond ((null params)
	 (error "No params found in operator ~S." name))
	((null (second params))  ;NO vars
	 nil)
	((notevery #'strong-is-var-p (cdr params))
	 (error "~S is not a variable"
		(find-if #'(lambda (x) (not (strong-is-var-p x)))
			 (cdr params))))))
	

(defun check-preconds (*checked-part* name)
  (declare (special *checked-part*))
  (cond ((< (length *checked-part*) 3)
	 (error "Preconds ~S too short in op ~S." *checked-part* name))
	((> (length *checked-part*) 3)
	 (error "Preconds ~S too long in op ~S." *checked-part* name)))
  ;; *defined-vars* will be used to check if all the variables in the
  ;; preconds have been bound by a generator.  This variable will be
  ;; shadowed when we process forall and exists constructs.
  (check-expression (third *checked-part*) t))

(defun check-mode (mode name)
  (unless (or (null mode)
	      (and (symbolp (second mode))
		   (member (intern (symbol-name (second mode)) 'keyword)
			   '(:eager :lazy))))
    (error "~S is not a proper mode for rule ~S." (second mode) name)))
   

;; Here is where we check the variable generators.  Each variable
;; generator consistes of a list of 2 elements.  The first element is
;; a variable name like <object>.  The second is either a valid type
;; symbol (the type hierarchy must be loaded before the rest of the
;; domain may be loaded) or a valid generator expression.  Such an
;; expression must follow these rules:

;; It must be a combinations of conjunctions, disjunctions, and
;; negations.

;; A conjunction must have one and only one type, along with lisp
;; functions, disjunctions, and negations.  The following is an error:



;; (<obj> (and BOX COLOR)

;; This is meaningless since we are working with a strict type
;; hierarchy.  Either BOX subsumes COLOR (or vise-versa) or we are
;; talking about the empty set.

;; A disjunction may have any combination of types, 
;; negations, and conjunctions and disjunctions.  A disjuncive
;; generator may not have any lisp functions, this is meaning less
;; because the disjunct does not describe a range of values for the
;; function to range over.  Values could be used from outside the
;; disjunct, but I think this can always be re-written in a better
;; form. 

(defun check-variable-generators (var-gen-list &optional other-vars)
  "Checks all the generators to be sure they are syntactically correct
and that variables are not used before they are defined."
  (let ((defined-vars other-vars))
    (dolist (var-gen-pair var-gen-list defined-vars)
      (setf defined-vars
	    (nconc defined-vars
		   (check-var-gen-pair var-gen-pair defined-vars))))))

(defun check-effect-variable-generators (var-gen-list &optional other-vars)
  "Checks all the generators to be sure they are syntactically correct
and that variables are not used before they are defined."
  (let ((defined-vars other-vars))
    (dolist (var-gen-pair var-gen-list defined-vars)
      (setf defined-vars
	    (nconc defined-vars
		   (check-effect-var-gen-pair var-gen-pair defined-vars))))))

;; a var gen pair is a list of the form (<a> object) or
;; (<a> (and object (diff <a> <b>))) where <b> must already have been defined.

(defun check-var-gen-pair (pair defined-vars)
  (declare (special *checked-op*))
  (cond ((/= (length pair) 2)
	 (error "Error in length of ~S in rule ~S." pair (car *checked-op*)))
	((not (strong-is-var-p (car pair)))
	 (error "~S not a variable in ~S in rule ~S."
		(car pair) pair (car *checked-op*))))
  
   (check-generator (cadr pair) (cons (car pair) defined-vars))
   (list (car pair)))

(defun check-effect-var-gen-pair (pair defined-vars)
  (declare (special *checked-op*))
  (cond ((/= (length pair) 2)
	 (error "Error in length of ~S in rule ~S."
		pair (car *checked-op*)))
	((not (strong-is-var-p (car pair)))
	 (error "~S not a variable in ~S in rule ~S."
		(car pair) pair (car *checked-op*))))
  
   (check-effect-generator (cadr pair) (cons (car pair) defined-vars))
   (list (car pair)))

(defun check-generator (generator defined-vars)
  (declare (special *current-problem-space* *checked-op*))
  (cond ((symbolp generator) ;; should realy check to see if sym
	 (unless (is-type-p generator *current-problem-space*)
	   (error "~S is not a valid type in rule ~S.~%"
		  generator (car *checked-op*))))
	((member (car generator) '(user::and user::or user::not))
	 (check-complex-generator generator defined-vars))
	((member (car generator) '(lisp:funcall lisp:apply))
	 (check-generator-vars (cddr generator) defined-vars))
	;; This change added by Jim to fix an incompatibility between
	;; cmu lisp and the new definition of common lisp. Also note
	;; the swapped order of this clause and the previous one.
	((or (symbolp (car generator))
	     (and (listp (car generator))
		  (eq (caar generator) 'lambda))
	     (functionp (car generator)))
	 (check-generator-vars (cdr generator) defined-vars))
	(t
	 (error "~S is neither a valid type nor one of AND, OR, or ~
NOT in rule ~S.~%"
		(car generator) (car *checked-op*)))))

(defun check-effect-generator (generator defined-vars)
  (declare (special *current-problem-space* *checked-op*))
  (cond ((symbolp generator) ;; should realy check to see if sym
	 (unless (is-type-p generator *current-problem-space*)
	   (error "~S is not a valid type in the effects of rule ~S.~%"
		  generator (car *checked-op*)))
	 (if (is-infinite-type-p generator *current-problem-space*)
	     (error
	      "~S is an infinite type, there should be a generator ~
 for this variable in rule ~S. " 
		    generator (car *checked-op*))))
	((member (car generator) '(user::and user::or user::not))
	 (check-complex-generator generator defined-vars))
	((member (car generator) '(lisp:funcall lisp:apply))
	 (check-generator-vars (cddr generator) defined-vars))
	;; This change added by Jim to fix an incompatibility between
	;; cmu lisp and the new definition of common lisp. Also note
	;; the swapped order of this clause and the previous one.
	((or (symbolp (car generator))
	     (and (listp (car generator))
		  (eq (caar generator) 'lambda))
	     (functionp (car generator)))
	 (check-generator-vars (cdr generator) defined-vars))
	(t
	 (error "~S is neither a valid type nor one of AND,~
 OR, or NOT in rule ~S.~%"
		(car generator) (car *checked-op*)))))

(defun check-complex-generator (generator defined-vars)
  (case (car generator)
        (user::and (check-and-generator generator defined-vars))
	(user::or  (check-or-generator generator defined-vars))
	(user::not (check-not-generator generator defined-vars))))

(defun check-and-generator (and-gen defined-vars)
  (declare (special *current-problem-space* *checked-op*))
  (cond ((> (count #'is-type-p (cdr and-gen)) 1)
	 (error "Conjunction ~S has more then one type spec in rule ~S.~%"
		and-gen (car *checked-op*))))
  (let ((gens (if (is-infinite-type-p (cadr and-gen) *current-problem-space*)
		   (cddr and-gen)
		   (cdr and-gen))))
    (dolist (gen gens)
      (check-generator gen defined-vars))))

(defun check-or-generator (or-gen defined-vars)
  (declare (special *checked-op*))
  (dolist (gen (cdr or-gen))
    ;;aperez:
    ;;if gen is a function (which is what you intend to check here)
    ;;(fboundp gen) produces an error because gen is a list. Should
    ;;test car of that list
    (cond (;(and (fboundp  gen)
	   ;     (not (special-form-p gen)))
	   (and (listp gen) (fboundp (car gen))
		(not (special-form-p (car gen))))
	   (error "Function generators not allowed in disjunctive ~
bindings.~%Generator: ~S~%in expression ~S of rule ~S~%"
		  gen or-gen (car *checked-op*)))
	  (t (check-generator gen defined-vars)))))

(defun check-not-generator (not-gen defined-vars)
  (check-generator (second not-gen) defined-vars))
		   
(defun check-generator-vars (args defined-vars)
  (declare (special *checked-op*))
  (dolist (arg args)
    (when (and (strong-is-var-p arg)
	       (not (member arg defined-vars)))
      (error "~S not defined before used in rule ~S.~%"
	     arg (car *checked-op*)))))

;;; This has changed slightly, and now allows ~ to surround any
;;; expression. It would be weird to allow it for exists but not and.
(defun check-expression (exp parity)
  (declare (special *checked-op*))
  (case (car exp)
    ((user::and user::or)
     (dolist (subexp (cdr exp))
       (check-expression subexp parity)))
    ((user::exists user::forall)
     (check-quantified-exp exp parity))
    (user::~
     (if (/= (length exp) 2)
	 (error "Negated expression ~S is the wrong length ~
in rule ~S."
		exp (car *checked-op*)))
     (check-expression (second exp) (not parity)))
    (t (check-predicate-expression exp))))

(defun check-quantified-exp (exp parity)
  (declare (special *defined-vars* *checked-op* *checked-part*))
  (cond ((< (length exp) 3)
	 (error "Quantified expression ~S too short in rule ~S.~%"
		exp (car *checked-op*)))
	((> (length exp) 3)
	 (error "Quantified expression ~S too long in rule ~S.~%"
		exp (car *checked-op*))))
  (let ((*defined-vars* (check-variable-generators (second exp) *defined-vars*)))
    (declare (special *defined-vars*))
    ;; Stick the generator expression from a "true exists" on the list
    ;; for the precond expression.
    (if (eq (car exp) (if parity 'user::exists 'user::forall))
	(setf (second *checked-part*)
	      (append (second exp) (second *checked-part*))))
    (check-expression (third exp) parity)))

;; Check-predicate-expression assumes that there is no complex
;; structure to uninstantiated literals, they are a predicate followed
;; by symbols and prodigy variables.

(defun check-predicate-expression (exp)
  (declare (special *arity-hash* *defined-vars* *all-preds*
		    *checked-op* *current-problem-space*))
  "Returns if every element of the exp is a symbol or prodigy
variable.  Otherwise generates and error."
  (cond ((notevery #'(lambda (x)
		       (or (infinite-type-object-p x *current-problem-space*)
			   (symbolp x) (strong-is-var-p x)))
		   (cdr exp))
	 (error "Not all arguments are symbols or vars in ~S in rule ~S.~%"
		exp (car *checked-op*)))
	((not (subsetp (all-vars (cdr exp)) *defined-vars* :test #'var-eq))
	 (let ((diff (set-difference (cdr exp) *defined-vars* :test #'var-eq)))
	   (error "The variable~P~{ ~S~} ~[are~;is~:;are~] ~
not generated for expression ~S in rule ~S.~%"
		  (length diff) diff (length diff) exp (car *checked-op*))))
	(t
	 (let ((arity (gethash (car exp) *arity-hash*)))
	   (if arity
	       (if (/= (length exp) arity)
		   (cond ((eq *behaviour-on-arity-change* :error)
			  (error "Inconsistent arity for expression ~S in rule ~S.~%~
Should have arity of ~D.~%"
				 exp (car *checked-op*) arity))
			 ((eq *behaviour-on-arity-change* :warn)
			  (format t "Warning: different arity for ~
 predicate ~S in rule ~S: was ~D~%"
				  exp (car *checked-op*) arity))))
	       (setf (gethash (car exp) *arity-hash*) (length exp))))
	 (if (car exp) (pushnew (car exp) *all-preds*)))))


#|
;;; Jim 1/8/90: added appropriate tests for quantifiers in nots.
(defun check-neg-exp (exp)
  (declare (special *defined-vars*))
  (cond ((not (= (length exp) 2))
	 (error "Negated expression ~S is the wrong length." exp))
	((eq (car (second exp)) 'user::exists)
	 (check-exists-exp (second exp)))
	((eq (car (second exp)) 'user::forall)
	 (check-forall-exp (second exp)))
	((not (subsetp (all-vars exp) *defined-vars*))
	 (let ((diff (set-difference (all-vars exp) *defined-vars*)))
	   (error "The variable~P~{ ~S~} ~[are~;is~:;are~] not generated for expression ~S.~%"
		  (length diff)
		  diff
		  (length diff)
		  exp)))))
|#

  

;; code to check the effects list.

(defun check-effects (*checked-part* name)
  (declare (special *defined-vars* *checked-part*))
  (unless *checked-part*
    (error "No effects in operator ~S~%" name))
  (cond  ((< (length *checked-part*) 3)
	  (error "Effects list ~S is too short in ~S.~%" *checked-part* name))
	 ((> (length *checked-part*) 3)
	  (error "Effects list ~S is too long in ~S.~%" *checked-part* name)))
  (let ((*defined-vars*
	 (append *defined-vars*
		 (check-effect-variable-generators (second *checked-part*)
					    *defined-vars*))))
    (declare (special *defined-vars*))
    (dolist (action (third *checked-part*))
      (check-action action))))

(defun check-action (action)
  (declare (special *checked-op*))
  (case (car action)
	((user::add user::del)
	 (check-add-or-del action))
	(user::if (check-if action))
	(user::forall (check-forall-effect action))
	(t (error "~S is not a proper action for effects in rule ~S.~%" 
		  (car action) (car *checked-op*)))))

(defun check-add-or-del (action)
  (declare (special *checked-op*))
  (cond ((/= (length action) 2)
	 (error "Action ~S has illegal syntax in rule ~S.~%"
		action (car *checked-op*))))
  (check-effect-expression (second action)))
	
(defun check-effect-expression (exp)
  (declare (special *arity-hash* *defined-vars* *checked-op* *effect-preds*))
  "Returns if every element of the exp is a symbol or prodigy
variable.  Otherwise generates and error."
  (cond ((notevery #'(lambda (x)
		       (or (strong-is-var-p x)
			   (infinite-type-object-p x *current-problem-space*)
			   (object-name-to-object x *current-problem-space*)))
		   (cdr exp))
	 (error "Not all arguments are symbols or vars in ~S in rule ~S.~%~
Perhaps an object should be declared in the domain file with pinstance?"
		exp (car *checked-op*)))
	((not (subsetp (all-vars (cdr exp)) *defined-vars*))
	 (let ((diff (set-difference (cdr exp) *defined-vars* :test #'var-eq)))
	   (error "The variable~P~{ ~S~} ~[are~;is~:;are~] not ~
generated for expression ~S in rule ~S.~%"
		  (length diff) diff (length diff) exp (car *checked-op*)))))

  (let ((arity (gethash (car exp) *arity-hash*)))
    (if arity
	(if (/= (length exp) arity)
	    (cond ((eq *behaviour-on-arity-change* :error)
		   (error "Inconsistent arity for expression ~S in rule ~S.~%~
Should have arity of ~D.~%" exp (car *checked-op*) arity))
		  ((eq *behaviour-on-arity-change* :warn)
		   (format t "Warning: different arity for ~
 predicate ~S in rule ~S: was ~D~%"
			   exp (car *checked-op*) arity))))
      (setf (gethash (car exp) *arity-hash*) (length exp))))

      (if (car exp) (pushnew (car exp) *effect-preds*)))


(defun var-eq (a b)
  ;; If either arg is NOT a prodigy variable returns T otherwise
  ;; returns (eq a b)
  (if (not (and (strong-is-var-p a) (strong-is-var-p b)))
      T
      (eq a b)))
  
(defun check-if (action)
  (declare (special *checked-op*))
  (if (/= (length action) 3)
      (error "Action ~S has illegal syntax in rule ~S.~%"
	     action (car *checked-op*)))
  (check-expression (second action) t)
  (dolist (add-or-del (third action))
    (check-add-or-del add-or-del)))

(defun check-forall-effect (action)
  (declare (special *checked-op* *defined-vars*))
  (if (/= (length action) 4)
      (error "In rule ~S, action ~S has incorrect syntax."
	     (car *checked-op*) action))
  (let ((*defined-vars* (append *defined-vars*
				(check-variable-generators (second action)
							   *defined-vars*))))
    (declare (special *defined-vars*))
    (check-expression (third action) t)
    (dolist (add-or-del (fourth action))
      (check-add-or-del add-or-del))))


;; This is the code to load control rules.  


(defmacro CONTROL-RULE (&body body)
  (check-control-rule body)
  (let ((var (gensym)))
    `(let ((,var (create-control-rule ',body)))
      (case (control-rule-type ,var)
	(:select-node
	 (add-rule-new ,var (problem-space-select-nodes
			     *current-problem-space*)))
	(:reject-node
	 (add-rule-new ,var (problem-space-reject-nodes
			     *current-problem-space*)))
	(:prefer-node
	 (add-rule-new ,var (problem-space-prefer-nodes
			     *current-problem-space*)))
	(:select-goal
	 (add-rule-new ,var (problem-space-select-goals
			     *current-problem-space*)))
	(:reject-goal
	 (add-rule-new ,var (problem-space-reject-goals
			     *current-problem-space*)))
	(:prefer-goal
	 (add-rule-new ,var (problem-space-prefer-goals
			     *current-problem-space*)))
	(:select-op
	 (add-rule-new ,var (problem-space-select-operators
			     *current-problem-space*)))
	(:reject-op
	 (add-rule-new ,var (problem-space-reject-operators
			     *current-problem-space*)))
	(:prefer-op
	 (add-rule-new ,var (problem-space-prefer-operators
			     *current-problem-space*)))
	(:select-binding
	 (add-rule-new ,var (problem-space-select-bindings
			     *current-problem-space*)))
	(:prefer-binding
	 (add-rule-new ,var (problem-space-prefer-bindings
			     *current-problem-space*)))
	(:reject-binding
	 (add-rule-new ,var (problem-space-reject-bindings
			     *current-problem-space*)))
	(:apply-or-subgoal
	 (add-rule-new ,var (problem-space-apply-or-subgoal
			     *current-problem-space*)))
	(:select-apply-op  ; karen
             (push ,var
		   (getf (problem-space-plist *current-problem-space*)
			 :select-apply-op)))
	(:reject-apply-op  ; karen
	 (push ,var
	       (getf (problem-space-plist *current-problem-space*)
		     :reject-apply-op)))
	(:refine-or-expand
	 (add-rule-new ,var (problem-space-refine-or-expand
			     *current-problem-space*)))
	(otherwise
	 (error "~S is a an unknown type of control rule.~%" ',body))))))


(defun FCONTROL-RULE (&rest body)
  (declare (special *current-problem-space*))
  (check-control-rule body)
  (let ((cr (create-control-rule body)))
    (case (control-rule-type cr)
      (:select-node
       (add-rule-new cr (problem-space-select-nodes
			 *current-problem-space*)))
      (:reject-node
       (add-rule-new cr (problem-space-reject-nodes
			 *current-problem-space*)))
      (:prefer-node
       (add-rule-new cr (problem-space-prefer-nodes
			 *current-problem-space*)))
      (:select-goal
       (add-rule-new cr (problem-space-select-goals
			 *current-problem-space*)))
      (:reject-goal
       (add-rule-new cr (problem-space-reject-goals
			 *current-problem-space*)))
      (:prefer-goal
       (add-rule-new cr (problem-space-prefer-goals
			 *current-problem-space*)))
      (:select-op
       (add-rule-new cr (problem-space-select-operators
			 *current-problem-space*)))
      (:reject-op
       (add-rule-new cr (problem-space-reject-operators
			 *current-problem-space*)))
      (:prefer-op
       (add-rule-new cr (problem-space-prefer-operators
			 *current-problem-space*)))
      (:select-binding
       (add-rule-new cr (problem-space-select-bindings
			 *current-problem-space*)))
      (:prefer-binding
       (add-rule-new cr (problem-space-prefer-bindings
			 *current-problem-space*)))
      (:reject-binding
       (add-rule-new cr (problem-space-reject-bindings
			 *current-problem-space*)))
      (:apply-or-subgoal
       (add-rule-new cr (problem-space-apply-or-subgoal
			 *current-problem-space*)))
      (:select-apply-op  ; karen
             (push cr
		   (getf (problem-space-plist *current-problem-space*)
			 :select-apply-op)))
      (:reject-apply-op  ; karen
             (push cr
		   (getf (problem-space-plist *current-problem-space*)
			 :reject-apply-op)))
      (:refine-or-expand
       (add-rule-new cr (problem-space-refine-or-expand
			 *current-problem-space*)))
      (otherwise
       (error "~S is a an unknown type of control rule.~%" body)))))

(defmacro add-rule-new (rule place)
  `(progn (setf ,place (remove (control-rule-name ,rule) ,place
			:key #'control-rule-name))
    (push ,rule ,place)))
		  


;; this code creates a control rule data structure.
;; The then slot only gets everything after the name of the object
;; which this rule controls (e.g. GOAL, OP,...) since 
(defun create-control-rule (rule)
  (declare (list rule))
  (make-control-rule :name (first rule)
		     :type (extract-type (third rule))
		     :if (second (second rule))
		     :then (third rule)))

(defun add-control-rule-to-rules (crule rule-name-list p-space)
  (dolist (rule-name rule-name-list)
	  (declare (type rule rule-name))
					; iterate over relevant
					; operators
	  (let ((rule (rule-name-to-rule rule-name p-space)))
	    (pushnew crule (rule-select-crules rule)))))

(defun extract-type (rhs)

  (unless (member (second rhs) '(user::select user::reject user::prefer
				 user::sub-goal user::apply user::protect))
    (error "~S is a bad action for a control rule.~%" (second rhs)))
  (unless (or (member (second rhs) '(user::sub-goal user::apply user::protect))
	      (member (third rhs) '(user::node user::nodes
				    operator user::operators user::op
				    goal user::goals
				    ;; goal and operator are exported from
				    ;; PRODIGY4 to user so no user::
				    ;; is needed
				    user::op
				    user::bindings
				    user::apply-op user::applied-op
				    user::apply-operator user::applied-operator)))
    (error "~S is a bad type for a control rule.~%" (third rhs)))

  ;; Note that the reason that the symbol GOAL is not put in the user
  ;; package is that we export the symbol GOAL from PRODIGY4.  It is
  ;; used as a macro in load-problem.lisp.
  
  (case (second rhs)
    (user::select
     (case (third rhs)
       ((user::node user::nodes) :select-node)
       ((user::goal user::goals) :select-goal)
       ((user::op user::operator user::operators) :select-op)
       (user::bindings :select-binding)
       ((user::apply-op
	 user::applied-op
	 user::apply-operator
	 user::applied-operator) :select-apply-op))) ; karen
    (user::reject
     (case (third rhs)
       ((user::node user::nodes) :reject-node)
       ((user::goal user::goals) :reject-goal)
       ((user::op user::operator user::operators) :reject-op)
       (user::bindings :reject-binding)
       ((user::apply-op
	 user::applied-op
	 user::apply-operator
	 user::applied-operator) :reject-apply-op))) ; karen
    (user::prefer
     (case (third rhs)
       ((user::node user::nodes) :prefer-node)
       ((user::goal user::goals) :prefer-goal)
       ((user::op user::operator user::operators) :prefer-op)
       (user::bindings :prefer-binding)))
    ((user::apply user::sub-goal user::protect)
     :apply-or-subgoal)
    ((user::refine user::expand)
     :refine-or-expand)))

;;; The following few functions enable keywords in the typing predicates so
;;; that they will be handled internally by Prodigy.  Currently, only
;;; `diff' is handled in this way, but other functions (such as
;;; gen-from-pred) can easily be added.           Rujith 94-03-01

(defconstant internal-generator-functions-alist
  '((user::diff . diff))
  "This specifies the generator functions that are supplied internally by
Prodigy.  They may be used wherever user-written functions may be.  However,
Prodigy will use this association list to substitute its own
internally-provided function.")

;;; All the fuss over this little function!
(defun diff (x &rest l) (not (member x l)))

;;; Does f denote a function that Prodigy provides internally, rather than one
;;; that the user is supposed to provide?
(defun is-internal-func-p (f)
  (assoc f internal-generator-functions-alist))

;;; If f denotes a function that Prodigy provides internally, then return the
;;; corresponding internal function, else return the function unchanged.
(defun substitute-internal (f)
  (let ((res (assoc f internal-generator-functions-alist)))
    (if res (cdr res) f)))


;; do simple syntax checks on the control rule

(defun check-control-rule (rule)
  (cond ((< (length rule) 3)
	 (error "Rule ~S is too short." (car rule)))
	((> (length rule) 3)
	 (error "Rule ~S is too long." (car rule)))
	((not (symbolp (car rule)))
	 (error "Name ~S of rule ~S is not a symbol." (car rule) rule)))

  (push (cons rule (check-lhs-syntax (second rule)))
	(problem-space-property :control-rule-abstraction-levels))
  (check-rhs-syntax (third rule)))


;; check the LHS of the rule
(defun check-lhs-syntax (lhs)
  (unless (eq (car lhs) 'user::if)
	  (error "Antecedent ~A doesn't begin with IF.~%"))
  (check-lhs-exp (cadr lhs)))


(defun check-lhs-exp (exp)
  (cond ((not (listp exp)) 0)
	((member (car exp) '(user::and user::or))
	 (check-lhs-list (cdr exp)))
	((eq (car exp) 'user::~)
	 (check-lhs-exp (second exp)))
	((member (car exp)
		 (problem-space-all-preds *current-problem-space*))
	 ;; This probably won't work, because you don't have type
	 ;; information in control rules. Probably the best I can do
	 ;; is take the maximum of all templates with this predicate name.
	 (template-abstraction-level exp nil))
	;; Jim changed this to print out a meta predicate only once
	;; per load, because it might be easier to spot typos that way
	(t
	 (unless (member (car exp)
		      (getf (problem-space-plist *current-problem-space*)
			    :read-meta-preds))
	 (push (car exp)
	       (getf (problem-space-plist *current-problem-space*)
		     :read-meta-preds))

         (if (is-internal-func-p (car exp)) ;;; Rujith de Silva 93/05/21
             (format t "Reading Prodigy-supplied predicate: ~A~%" (car exp))
           (format t "Reading Meta predicate: ~A~%" (car exp))))

	 (if (member (car exp) '(user::known user::true-in-state))
	     (check-lhs-exp (second exp))
	     0))))
	 


(defun check-lhs-list (exp)
  (let ((res 0) tmp)
    (dolist (subexp exp)
      (setf tmp (check-lhs-exp subexp))
      (if (> tmp res) (setf res tmp)))
    res))


;; check the RHS of the rule
;; I am going to make a slight change to the contrul syntax.  Rather
;; then:
;; (THEN (SELECT operator (OB <A> <B>))) we can say (THEN SELECT
;; operator (ON <A> <B>))


(defun check-rhs-syntax (rhs)
  (cond ((not (eq (car rhs) 'user::then))
	 (error "Consequent ~S doesn't begin with THEN.~%" rhs))
	((= (length rhs) 2)		; Must be apply-or-subgoal rule
	 (unless (member (second rhs) '(user::apply user::sub-goal
						    user::protect))
	   (error "If the \"then\" part has length 2, it should be an~
apply, subgoal or protect rule.~%")))
	((not (member (second rhs) '(user::select user::reject user::prefer)))
	 (error "~A is not a proper action.  It must be SELECT,~
REJECT, or PREFER.~%" (second rhs)))
	((not (member (third rhs) '(user::node user::nodes
				    goal user::goals ; exported from PRODIGY4
				    user::operator user::operators user::op
				    user::apply-op user::applied-op
				    user::apply-operator user::applied-operator ;; karen
				    user::bindings)))
	 (error "~A is not a proper entity to be controlled.  It must be~
NODE, GOAL, OPERATOR, or BINDINGS.~%"))))


;; A function which appears in a variable binding expression must be a
;; predicate.  It will recieve one value for each of its arguments and
;; returns either true or false.
;; For example we might define the DIFF function as:

;;  (defun diff (obj1 obj2)
;;    (not (eq obj1 obj2)))


;; It should be possible to "compile" a generator down to some a
;; single lisp function that returns a sequence of bindings to each
;; variable.  The sequence will be of the form

;;  (<var1> (val1 val2 val3 ...) <var2> (v1 v2 v3 ...))

;(defun compile-variable-generator (generator))
    
  
