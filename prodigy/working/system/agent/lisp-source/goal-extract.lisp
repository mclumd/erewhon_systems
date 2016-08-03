(in-package :user)

;;;; 
;;;; The main user functions are generate-all-goals,
;;;; generate-all-states, gen-op-list, and gen-OP-part.
;;;; 



;;; 
;;; Function get-OP-part takes an operator definition and extracts a
;;; part of the definition.
;;; 
;;; The part argument is one of either 'preconds, 'effects, or
;;; 'params.
;;; 
;;; The op-def argument is the operator definition extracted from the
;;; domain.lisp file.
;;; 
(defun get-OP-part (op-def part
		    &aux 
		    (first-item
		     (first op-def))
		    )
  (cond ((null op-def)
	 nil)
	((or (null first-item)
	     (atom first-item))
	 (get-OP-part (rest op-def) 
		      part))
	((consp first-item)
	 (if (eq part 
		 (first first-item))
	       first-item
	     (get-OP-part (rest op-def) part)))
	(t
	 (format t "ERROR in get-OP-part")))
  )



;;; Down and dirty precond fetcher.
(defun get-preconds (op-def
		     &optional 
		     (state-part
		       (third 
			(get-OP-part 
			 op-def 'preconds))))
  (if (eq 'and
	  (first state-part))
      (rest state-part)
    (list state-part))
  )



;;; 
;;; Function get-goals extracts the effects part of an operator
;;; definition. From the effects, it then extracts the add and delete
;;; lists, putting them in the local variable add-del-lists. From this
;;; list it extracts all add states.
;;; 
(defun get-goals (op-def 
		  &optional 
		  (add-del-lists
		   (third (get-OP-part op-def 'effects)))
		  )
  (cond ((null add-del-lists)
	 nil)
	((eq 'add (first (first add-del-lists)))
	 (cons (second (first add-del-lists))
	       (get-goals 
		op-def
		(rest add-del-lists))))
	(t
	 (get-goals 
	  op-def
	  (rest add-del-lists))))
  )



;;; 
;;; Returns an association list. The elements associate an operator
;;; variable <var> with the type of the variable: (<var> . TYPE)
;;; 
;;; The unusual feature of the association list, unlike normal
;;; association lists, is that multiple entries for the same key are
;;; all significant. Therefore 
;;; 
#|
(get-vars 
 '(OPERATOR DAMAGE 
   (PARAMS <CROSSING> <AIR-FORCE>)
   (PRECONDS
    ((<AIR-FORCE> TACTICAL-FIGHTER) (<LOCAL-AIR-BASE> AIRPORT)
     (<LOC> LOCATION) (<RIVER> WATER-BARRIER)
     (<CROSSING> (OR BRIDGE FORD)))
    (AND (ENABLES-MOVEMENT-OVER <CROSSING> <RIVER>)
     (NEAR <LOCAL-AIR-BASE> <RIVER>)
     (IS-DEPLOYED <AIR-FORCE> <LOCAL-AIR-BASE>)))
   (EFFECTS NIL ((ADD (IS-DAMAGED <AIR-FORCE> <CROSSING>)))))
 )
==>
((<AIR-FORCE> . TACTICAL-FIGHTER) (<LOCAL-AIR-BASE> . AIRPORT)
 (<LOC> . LOCATION) (<RIVER> . WATER-BARRIER) (<CROSSING> . BRIDGE)
 (<CROSSING> . FORD))
|#
;;; 
;;; The returned list contains two entries for CROSSING because of
;;; the OR clause.
;;; 
(defun get-vars (op-def
		 &optional 
		 (var-list ; both precond vars and effects vars.
		  (append
		   (second 
		    (get-OP-part op-def 'preconds))
		   (second 
		    (get-OP-part op-def 'effects))
		   ))
		 )
  (cond ((null var-list)
	 nil)
	(t
	 (append 
	  (reduce-spec (first var-list))
	  (get-vars op-def (rest var-list)))
	  ))
  )



;;; 
;;; The var argument is a list of two elements with the form
;;; (<var-name> constraint). Constraint can be an atom, a list
;;; starting with 'and or a list starting with 'or. Therefore
;;; 
;;; (<var-name> TYPE)
;;; (<var-name> (and TYPE ...))
;;; (<var-name> (or TYPE1 TYPE2)
;;; 
;;; are all acceptable.
;;; 
;;; Returns a list of dotted pairs. This may be more than one dotted
;;; pair in the case of a disjunction. For example var could be
;;; (<my-var> (or type1 type2)), so, the corresponding returned value
;;; would be ((<my-var> . type1) (<my-var> . type2). 
;;; 
(defun reduce-spec (var
		    &aux
		    (var-name
		     (first var))
		    (constraint
		     (second var))
		    )
  (cond ((atom constraint)
	 (list
	  (cons var-name constraint))
	 )
	((and (consp constraint)
	       (eq 'and (first constraint)))
	 (list
	  (cons var-name
		(second constraint)))
	 )
	((and (consp constraint)
	       (eq 'or (first constraint)))
	 (list
	  (cons var-name
		(second constraint))
	  (cons var-name
		(third constraint)))
	 )
	(t
	 (format t "ERROR with reduce-spec"))
	)
  )



;;; 
;;; Predicate non-leaf-p returns t iff arg is a lowest-level type
;;; (i.e., one without a child in the domain.lisp file
;;; type-hierarchy).
;;; 
(defun not-leaf-p (arg)
  (not 
   (member arg 
	   *leaf-list*))
  )


;;; 
;;; Function get-leaves-from takes a type from the type hierarchy and
;;; returns a list of all the leaves that are descendants from the
;;; node.
;;; 
(defun get-leaves-from (intermediate-type)
  (cond ((null intermediate-type)
	 nil)
	((consp intermediate-type)
	 (append
	  (get-leaves-from 
	   (first intermediate-type))
	  (get-leaves-from 
	   (rest intermediate-type))))
	((not-leaf-p intermediate-type)
	 (let ((children
		(get-children-from 
		 intermediate-type)))
	   (append
	    (get-leaves-from
	     (first children))
	    (get-leaves-from
	     (rest children)))))
	(t
	 (list intermediate-type)))
  )



;;; 
;;; Function translate-to-leaf-goals takes a goal state that can have
;;; intermediate type arguments. It returns a list of goals that have
;;; hierarchy leaves as arguments instead. For example given
;;; the state (is-secure airport ground-force-module), it returns the
;;; list ((is-secure airport infantry) (is-secure airport police)).
;;;
(defun translate-to-leaf-goals (goal
				&optional 
				(g-predicate (first goal))
				&aux
				g-list)
  (cond ((eql (length goal) 2)		; Works with 1-arg predicates.
	 (let ((arg (second goal)))
	   (dolist (each-arg-leaf 
		       (get-leaves-from 
			arg))
	     (setf g-list
	       (cons (list g-predicate
			   each-arg-leaf)
		     g-list)))
	   g-list))
	((eql (length goal) 3)		; works with 2-arg goals.
	 (let ((arg1 (second goal))
	       (arg2 (third goal)))
	   (cond ((and (not-leaf-p arg1)
		       (not-leaf-p arg2))
		  (dolist (each-arg1-leaf 
			      (get-leaves-from arg1))
		    (dolist (each-arg2-leaf 
				(get-leaves-from arg2))
		      (setf g-list
			(cons (list g-predicate
				    each-arg1-leaf
				    each-arg2-leaf)
			      g-list)))
		    )
		  g-list)
		 ((not-leaf-p arg1)
		  ;; So arg2 must be a leaf.
		  (dolist (each-leaf 
			      (get-leaves-from arg1))
		    (setf g-list
		      (cons (list g-predicate
				  each-leaf
				  arg2)
			    g-list))
		    )
		  g-list)
		 ((not-leaf-p arg2)
		  ;; So arg1 must be a leaf.
		  (dolist (each-leaf 
			      (get-leaves-from arg2))
		    (setf g-list
		      (cons (list g-predicate
				  arg1
				  each-leaf)
			    g-list))
		    )
		  g-list)
		 (t 
		  ;; Both are leaves
		  (list goal))
		 )
	   )
	 )
	(t (list goal))
	)
  )
    
    
(defun expand-intermediates-from-goals (g-list)
  (cond ((null g-list)
	 nil)
	(t
	 (append 
	  (translate-to-leaf-goals
	   (first g-list))
	  (expand-intermediates-from-goals 
	   (rest g-list)))))
  )




;;; For each operator, many effects can exist. This function builds a list of
;;; goals for an op given a list of the op's goal names and a list of
;;; corresponding variables.
(defun create-goal-list-of-op (goal-list var-list)
  (mapcar #'variablize-goal
	  goal-list
	  (make-list (length goal-list)
		     :initial-element var-list))
  )

;;; 
;;; (variablize-goal 
;;;     (is-secure <airport> <external-security-force>)
;;;     ((<airport> . AIRPORT) (<internal-security-force> . POLICE)
;;;      (<external-security-force> . INFANTRY)))
;;; 
;;; ==> (is-secure AIRPORT INFANTRY)
;;; 
(defun variablize-goal (goal var-list)
  (cons (first goal)
	(g-substitute 
	 (rest goal) 
	 var-list))
  )


;;;
;;; Takes the goal arguments and returns variablized args.
;;;
(defun g-substitute (goal-args var-assoc-list)
  (cond ((null goal-args)
	 nil
	 )
	(t
	 (cons (rest (assoc (first goal-args) var-assoc-list))
	       (g-substitute 
		(rest goal-args) var-assoc-list))
	 )
	)
  )



;;; 
;;; Function generate-all-goals will return a list of potential goals
;;; that can be acheived by a given domain. The goals are obtained
;;; from the add lists of all operators in a domain file. Currently
;;; the delete lists are not considered.
;;; 
(defun generate-all-goals (&optional 
			   (domain-file-name *domain-file*)
			   (op-list 
			    (append 
			     (gen-inf-rule-list)
			     (gen-op-list
			      domain-file-name)))
			   )
  (let ((current-op (first op-list))	;Works when op-list is empty because 
					;(first nil) returns nil.
	)
    (cond ((null op-list)
	   nil
	   )
	  (t
	   (append
	    (expand-intermediates-from-goals
	     (create-goal-list-of-op
	      (get-goals current-op)
	      (get-vars current-op))
	     )
	    (generate-all-goals
	     domain-file-name
	     (rest op-list)))
	   ))
    )
  )


;;; 
;;; This is a quick copy of generate-all-goals with small
;;; changes. NOTE that the returned list may have duplicates.
;;; 
(defun generate-all-states (&optional 
			   (domain-file-name *domain-file*)
			   (op-list 
			    (gen-op-list
			     domain-file-name))
			   )
  (let ((current-op (first op-list))	;Works when op-list is empty because 
					;(first nil) returns nil.
	)
    (cond ((null op-list)
	   nil
	   )
	  (t
	   (append
	    (expand-intermediates-from-goals
	     (create-goal-list-of-op
	      (append
	       (get-preconds current-op)
	       (get-goals current-op))
	       (get-vars current-op))
	     )
	    (generate-all-states
	     domain-file-name
	     (rest op-list)))
	   ))
    )
  )


 ;;; 
;;; Function gen-op-list reads a domain file and outputs a list of
;;; all operator definitions in the file.
;;; 
(defun gen-op-list (&optional 
		    (domain-file-name
		     *domain-file*))
  (with-open-file
      (domain-file domain-file-name
       :direction :input)
    (do* ((next nil 
		(read domain-file 
		      nil 
		      *end-of-file* 
		      nil))
	  (op-list nil (if (and
			    (consp next)
			    (eq 'OPERATOR
				(first next)))
			   (cons next op-list)
			 op-list))
	  )
	((eof-p next)
	 op-list)
      )
    )
  )

