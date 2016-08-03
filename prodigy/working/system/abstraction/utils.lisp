;;;
;;; These are the functions that need to be around specifically to
;;; support using abstraction, as well as convenience functions for
;;; the abstraction package.
;;;

;;; This file uses the abs-node structure defined in gen-hiers.lisp.

#-clisp
(unless (find-package "PRODIGY4")
  (make-package "PRODIGY4" :nicknames '("P4") :use '("LISP")))
(in-package "PRODIGY4")

(export '(abs-hierarchy		; gets the hierarchy. Can be used with setf.
	  abs-level		; gets the level. Can be used with setf.
	  hierarchy	        ; computes the hierarchy in a default way.
	  print-hierarchy       ; prints the hierarchy nicely.
	  load-hierarchy        ; allows user-specified hierarchies.
	  ))

;;; I make a new copy of the preconditions, used in the new version of
;;; instantiate-preconditions, where each subpart is labelled with an
;;; abstraction level so as only to compute it once.
(defun add-abstraction-levels-to-operators (pspace)
  (declare (type problem-space pspace))

  (dolist (set (list (problem-space-operators pspace)
		     (problem-space-eager-inference-rules pspace)
		     (problem-space-lazy-inference-rules pspace)))
    (dolist (rule set)
      (let* ((decs (list (second (rule-precond-exp rule))))
	     (effect-decs (cons (second (rule-effects rule)) decs))
	     (conditional-effects
	      (mapcan #'(lambda (effect)
			  (case (car effect)
			    (user::if
			     (list
			      (cons effect
				    (annotate-preconds-rec
				     (second effect) effect-decs t))))
			    (user::forall
			     (list
			      (cons effect
				    (annotate-preconds-rec
				     (third effect)
				     (cons (second effect) effect-decs)
				     t))))))
		      (third (rule-effects rule)))))
	(if conditional-effects
	    (setf (getf (rule-plist rule) :annotated-conditional-effects)
		  conditional-effects))
	(setf (getf (rule-plist rule) :annotated-preconds)
	      (annotate-preconds-rec
	       (third (rule-precond-exp rule)) decs t))))))

(defun annotate-preconds-rec (exp decs parity)
  (declare (list exp decs)
	   (type problem-space pspace))
  (cond
    ((member (car exp) '(user::and user::or))
     ;; For an and, the abstraction level is the maximum of its parts.
     ;; For an or, the abstraction level is the minimum of its parts.
     (let ((args (mapcar #'(lambda (bit)
			     (annotate-preconds-rec bit decs parity))
			 (cdr exp))))
       (if args
	   (cons (apply
		  (if (eq (eq (car exp) 'user::and) parity)
		      #'max #'min)
		  (mapcar #'car args))
		 (cons (car exp) args))
	   (list 0 (car exp)))))
    ((eq (car exp) 'user::~)
     (let ((sub (annotate-preconds-rec (second exp) decs (not parity))))
       (list (car sub) 'user::~ sub)))
    ((member (car exp) '(user::exists user::forall))
     (let ((sub (annotate-preconds-rec (third exp) (cons (second exp) decs)
				       parity)))
       (list (car sub) (first exp) (second exp) sub)))
    (t
     ;; Calculate the abstraction level for a literal template and
     ;; stick it on the front.
     (cons (template-abstraction-level exp decs) exp))))

;;; A better representation of the hierarchy would make this quicker,
;;; but it's a once-only-then-cache thing anyhow.

;;; 23-Jan-92 Jim: I added the check for infinite types so that
;;; abstraction is avoided when there are infinite types. See the
;;; comment for create-hierarchy for a few more details.

(defun template-abstraction-level (exp decs)
  (declare (list exp decs)
	   (special *current-problem-space*))
  (cond ((has-infinite-types-p *current-problem-space*)
	 0)
	;; static predicates always get the highest possible
	;; abstraction level. Jim 3/3/92.
	((member (car exp) (problem-space-static-preds *current-problem-space*))
	 (max 0 (1- (length (problem-space-property :abs-hier)))))
	(t
	 (let ((processed-exp
		(cons (car exp)
		      (mapcar
		       #'(lambda (arg)
			   (let ((thing (arg-to-type arg decs nil *current-problem-space*
						     (problem-space-property :schema-abstractions))))
			     (if (symbolp thing)
				 (type-name-to-type thing *current-problem-space*)
				 thing)))
		       (cdr exp)))))
	   ;; Note the from-end t. I take the rightmost so I don't drop a
	   ;; literal until there is no more abstract template that it matches.
	   (or (position-if
		#'(lambda (group)
		    (member-if #'(lambda (schema)
				   (template-schema-p processed-exp decs schema))
			       group))
		(problem-space-property :abs-hier) :from-end t)
	       ;; If not mentioned in the constraints, stick it in the lowest
	       ;; possible place (heuristic).
	       0)))))

;;; tests if the template is an instance of the literal schema
;;; (see literal-schema-p)
;;; changed by Jim, 26/2/92 to cope with unions in both the expression
;;; and the schema.

;;; changed 3/3/92 to match a more general template with a less
;;; general schema. This is so that we are correct at placing the goal
;;; in the worst case. In fact, the previous idea that I could cache
;;; the abstraction levels of preconditions is wrong, because if you
;;; have a type hierarchy, the abstraction level can depend on the
;;; bindings.

(defun template-schema-p (exp decs schema)
  (declare (ignore decs))
  (and (eq (car exp) (abs-node-name schema))
       (every #'(lambda (exparg schemarg)
		  (or 
		   (match-type exparg schemarg)
		   (match-type schemarg exparg)))
	      (cdr exp)
	      (abs-node-args schema))))

;;; Each argument could be a symbol, a complex type list structure, or
;;; a type.
(defun match-type (exparg schemarg)
  (declare (special *current-problem-space*))
  (let* ((pspace *current-problem-space*)
	 (schemobjp (prodigy-object-p schemarg))
	 (exptype (cond ((prodigy-object-p exparg)
			 (prodigy-object-type exparg))
			((symbolp exparg)
			 (type-name-to-type exparg pspace))
			(t exparg)))
	 (schemtype (cond (schemobjp nil)
			  ((symbolp schemarg)
			   (type-name-to-type schemarg
					      *current-problem-space*))
			  (t schemarg))))
    (cond ((and (listp exparg) (eq (car exparg) 'user::or))
	   (every #'(lambda (sub)
		      (match-type sub schemarg))
		  (cdr exparg)))
	  ((and (listp schemarg) (eq (car schemarg) 'user::or))
	   (every #'(lambda (sub)
		      (match-type exparg sub))
		  (cdr schemarg)))
	  ((and (listp exptype) (eq (car exptype) 'user::comp))
	   (match-type (second exptype) schemtype))
	  ((and (listp schemtype) (eq (car schemtype) 'user::comp))
	   (match-type exptype (second schemtype)))
	  ((and (not (listp schemtype)) (not (listp exptype)))
	   (if schemobjp
	       (eq exparg schemarg)
	       (cond ((equal exparg schemarg) t)
		     ((and (atom exptype) (atom schemtype))
		      (child-or-same-type-p exptype schemtype))))))))

(defun child-or-same-type-p (child parent)
  (or (eq child parent)
      (child-type-p child parent)))

;;; this will generate an error if the literal is not an instance of
;;; some schema in the total order, and so it should. This version
;;; implements caching on the assumption that the abstraction-level
;;; field of a literal is set to nil when a new abstraction space is
;;; set up, and initialised to nil.

;;; This is too slow, because it currently finds the right schema by
;;; linear lookup, instead of for example following pointers from the
;;; predicate and the types of the args. This will be fine for the
;;; first version, though, I guess.
(defun compute-abstraction-level (literal pspace)
  (declare (type literal literal)
	   (type problem-space pspace))

  (cond ((literal-abs-level literal))
	;; Jim 9/93 added this check clause. Otherwise static
	;; predicates can end up with an abstraction level of -1.
	((null (problem-space-property :abs-hier))
	 (setf (literal-abs-level literal) 0))
	((and (member (literal-name literal)
		      (problem-space-static-preds pspace)))
	 (setf (literal-abs-level literal)
	       (1- (length (problem-space-property :abs-hier)))))
	;; this drops through to the next clause if the position-if
	;; returns nil.
	((let ((total-order (problem-space-property :abs-hier)))
	   (setf (literal-abs-level literal)
		 (position-if #'(lambda (group)
				  (member-if #'(lambda (schema)
						 (lit-schema-p
						  literal schema pspace))
					     group))
			      total-order :from-end t))))
	(t (setf (literal-abs-level literal) 0))))

;;; tests if the literal is an instance of the literal schema. 
(defun lit-schema-p (literal schema pspace)
  (declare (type literal literal)
	   (type abs-node schema)
	   (type problem-space pspace))
  (and (eq (literal-name literal) (abs-node-name schema))
       (every #'(lambda (litarg schemarg)
		  (let ((lit-type (prodigy-object-type litarg)))
		  (cond ((prodigy-object-p schemarg)
			 (eq litarg schemarg))
			((and (listp schemarg) (eq (car schemarg) 'user::or))
			 (every #'(lambda (poss)
					 (child-or-same-type-p
					  lit-type (type-name-to-type
						    poss pspace)))
				(cdr schemarg)))
			(t
			 (child-or-same-type-p
			  lit-type (type-name-to-type schemarg pspace))))))
	      (literal-arguments literal)
	      (abs-node-args schema))))


(defun check-primary-effects-and-axioms (problem-space)
  "Checks the primary effects list, and also adds the list of primary
effects for each operator"
  (declare (type problem-space problem-space))

  ;; Check the primary effects
  (dolist (primary (getf (problem-space-plist problem-space)
			 :primary-effects))

    ;; Check the predicate schema exists
    (cond ((not (member (caar primary)
			(problem-space-all-preds problem-space)))
	   (format t
		   "~%Warning: unknown predicate in primary-effects: ~S~%"
		   (caar primary)))
	  ((some #'(lambda (type-name)
		     (unless (type-name-to-type type-name problem-space)
		       (format t
       "~%Warning: Unknown object type in primary-effects: ~S~%" type-name)
		       t))
		 (cdar primary)))
	  ;; Check the operators exist and update their primary-effects list
	  (t
	   (do ((ops (cdr primary) (cdr ops)))
	       ((null ops))
	     (let ((op (rule-name-to-rule (car ops) problem-space)))
	       (cond (op
		      (setf (car ops) op)
		      (push (car primary)
			    (getf (rule-plist op) :primary-effects)))
		     (t
		      (format t
    "~%Warning: the operator named ~S in the primary effects does not exist.~%"
			      (car ops)))))))))

  ;; Check the axioms
  (dolist (axiom (getf (problem-space-plist problem-space) :axioms))
    (dolist (declaration (first axiom))
      (unless (strong-is-var-p (first declaration))
	(format t "~%Warning: ~S in axioms is not a variable~%"
		(first declaration)))
      (unless (type-name-to-type (second declaration) *current-problem-space*)
	(format t "~%Warning: ~S in axioms is not a valid type~%"
		(second declaration))))
    (dolist (schema (cons (second axiom) (third axiom)))
      (unless (member (car schema) (problem-space-all-preds problem-space))
	(format t "~%Warning: unknown predicate in domain axioms: ~S~%"
		(car schema)))
      (dolist (var-name (cdr schema))
	(unless (assoc var-name (first axiom))
	  (format t
   "~%Warning: variable with no type declaration in domain axioms: ~S~%"
	   var-name))))))
  

(defun load-hierarchy (hier &key independent)
  "Takes a list of lists of template schemas and makes them the
hierarchy, lowest cluster first."
  (declare (list hier))
  (setf (problem-space-property
	 (if independent :problem-independent-hierarchy
	     :abs-hier))
	(mapcar #'(lambda (cluster)
		    (mapcar #'exp-to-absnode cluster))
		hier)))

(defun exp-to-absnode (exp)
  (let ((node (make-abs-node :name (car exp) :args (cdr exp))))
    ;; The actual hierarchies use symbols, but I'll do the conversions
    ;; by way of testing.
    (unless (member (car exp)
		     (problem-space-all-preds *current-problem-space*))
      (format t "~%Warning: unknown predicate name: ~S~%" (car exp)))
    (dolist (arg (cdr exp))
      (unless (or (type-name-to-type arg *current-problem-space*)
		  (object-name-to-object arg *current-problem-space*))
	(format t "~%Warning: ~S is not yet a type or object in the domain~%"
		arg)))
    node))

(defmacro abs-hierarchy (&key independent)
  (if independent
    '(problem-space-property :problem-independent-hierarchy)
    '(problem-space-property :abs-hier)))

(defmacro abs-level ()
  '(problem-space-property :abstraction-level))

(defun print-hierarchy (&key (pspace *current-problem-space*)
			     (verbose nil))
  "Prints the abstraction hierarchy out."
  (let* ((hier (getf (problem-space-plist pspace) :abs-hier))
	 (highest (1- (length hier))))
    (do ((hierarchy (reverse hier) (cdr hierarchy))
	 (level highest (1- level)))
	((null hierarchy))
      (format t "~2D:~%" level)
      (dolist (node (car hierarchy))
	(princ "   ")
	(print-short-abs-node node)
	(when verbose
	  (terpri)
	  (princ "    {")
	  (dolist (out-node (abs-node-out node))
	    (print-short-abs-node out-node) (princ #\Space))
	  (princ "}"))
	(terpri)))))

(defun print-numeric-hierarchy (&key (pspace *current-problem-space*)
			     (verbose nil))
  "Prints the abstraction hierarchy out."
  (let* ((hier (getf (problem-space-plist pspace) :abs-hier))
	 (highest (1- (length hier))))
    (do ((hierarchy (reverse hier) (cdr hierarchy))
	 (level highest (1- level)))
	((null hierarchy))
      (dolist (node (car hierarchy))
	(princ "   ")
	(princ (abs-node-dfnumber node))
	(when verbose
	  (terpri)
	  (princ "    {")
	  (dolist (out-node (abs-node-out node))
	    (princ (abs-node-dfnumber out-node)) (princ #\Space))
	  (princ "}"))
	(terpri)))))
    

(defun hierarchy ()
  (declare (special *current-problem-space*))
  (create-hierarchy *current-problem-space* (current-problem)))