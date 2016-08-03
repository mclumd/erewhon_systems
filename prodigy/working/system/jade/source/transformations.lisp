(in-package "FRONT-END")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;;		The Front-End of the PRODIGY-Analogy/ForMAT TIE
;;;;
;;;;			  File: TRANSFORMATIONS.LISP
;;;;
;;; 
;;; This program is designed  to provide an interface   between PRODIGY-Analogy
;;; and ForMAT. ForMAT sends to PRODIGY a series of protocol records that trace
;;; the use of the program by deployment planners.   The task of  PRODIGY is to
;;; assist   the human planner  to modify    old planning  cases from  ForMAT's
;;; case-base to  meet the constraints  of  the user in a mixed-initiative mode
;;; and  in real-time.  This file implements   the transformations  from ForMAT 
;;; output to Prodigy input.
;;;
;;;			     Interface Protocol
;;; 
;;; The form  of  the traces  (i.e.,  fgoal-actions)  passed  to PRODIGY  is as 
;;; follows:
;;; 
;;; (<"time-string"> <:ForMAT-command> <arguments>*)
;;; 
;;;
;;; The form of the communications passed back to ForMAT is as follows:
;;;
;;; (:ON-ACTION <fgoal-action> <messages>*)
;;;
;;; where messages are of the form (:MESSAGE <id-num> <"text-string">)
;;;
;;;
;;; 
;;; The most complicated ForMAT trace is the :SAVE-GOALS command which has the
;;; following protocol (NOTE that GOAL-FILE-NAME below could be equal to the
;;; string "execute query, no file"):
;;; 
;;; (<"time-string"> :SAVE-GOALS 
;;;    GOAL-FILE-NAME (ID PLAN-NAME 
;;;                     (:DESCRIPTION "description-string") 
;;;                     (:GOALS GOAL1 GOAL2 ... GOALn) 
;;;                     (:GUIDANCE-FILE "filename-string")))
;;; 
;;;
;;; A GOAL has the following format.
;;; 
;;; (GOAL-ID GOAL-TYPE PLAN-NAME unknown-field CHILDREN PARENTS (ARGUMENTS))
;;; 
;;; TIME-STAMP   is a  string  corresponding to     the time  the  command  was
;;; processed. :SAVE-GOALS is the   ForMAT command executed.  GOAL-FILE-NAME is
;;; the local file in  which the  plan has been   stored.  The ID is a  unique,
;;; numeric identifier.  The  PLAN-NAME is the symbolic name  of the  plan. The
;;; :DESCRIPTION is the text of the  guidance.  The :GUIDANCE-FILE is the local
;;; filename where the guidance is stored (and, subsequently, where to look for
;;; updates).
;;; 
;;; Example:
;;; 
;;; ("6/3/1996: 16:19:43" :SAVE-GOALS
;;;  "/NFS/ai/systems/cbr/format1.4.1/data/prodigy/steve-test5"
;;;  (4 ABCDE
;;;   (:DESCRIPTION
;;;    "goal: need a hawk unit and one brigade to send to korea to secure the
;;; military airport of Chunchon. Deploy F-16s to this airport.")
;;;   (:GOALS 
;;;    (49 :SECURE-TOWN-CENTER-HALL ABCDE NIL NIL NIL NIL)
;;;    (48 :SEND-DOG-TEAM ABCDE NIL NIL (47) NIL)
;;;    (47 :SEND-SECURITY-POLICE ABCDE NIL (48) (43) NIL)
;;;    (46 :SEND-MILITARY-POLICE ABCDE NIL NIL (43) NIL)
;;;    (45 :DEPLOY-F-15 ABCDE NIL NIL (44) ((AIRCRAFT-TYPE F15)))
;;;    (44 :DEPLOY-TFS ABCDE NIL (45) NIL NIL)
;;;    (43 :SECURE-AIRPORT ABCDE NIL (46 47) NIL
;;;     ((GEOGRAPHIC-LOCATION BOSNIA) (AIRCRAFT-TYPE B52)
;;;      (AC-QUANTITY |3|))))
;;;   (:GUIDANCE-FILE "testa-guidance")))
;;; 
;;; 
;;; 
;;; NOTE  that *current-problem-space*   is the global variable   that contains 
;;; PRODIGY's main data structures. 
;;;
;;; NOTE that identifiers of the package "P4" reference the package for PRODIGY
;;; Version 4.0.
;;;
;;;
;;; NOTE that the most valuable user functions are  reset-domain,  create-case-
;;; list  (in file retrieve.lisp),  compile-all,  and  print-messages  (in file
;;; utils.lisp).   Most, although not all,  other functions support one or more
;;; of these.  See  file set-problem.lisp for  two other useful function in the
;;; front-end: functions set-problem and create-problem-file.
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; GLOBAL VARIABLES
;;;; AND PARAMETERS
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;



;;;
;;; The global variable *front-end-initialized* signals that the 
;;; PRODIGY/ForMAT has been initialized when its value is t; otherwise
;;; the system is assumed to be unitialized.
;;;
(defvar *front-end-initialized* nil
  "Flag indicates whether the front-end is initialized.")





;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; UTILITIES
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;



;;;
;;; Function get-plan-name is an access function for ForMAT goal actions, 
;;; returning the name of the plan for which the :SAVE-GOALS command was 
;;; issued. See the top-level comments for the structure of the fgoal-action.
;;; 
(defun get-plan-name (fgoal-action)
  (second                    ; Extract plan name (id).
   (fourth fgoal-action))    ; Extract goal.
  )




;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; PREDICATES
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;



;;;
;;; Predicate is-token-p returns t if symbol argument is a legitimate PRODIGY 
;;; object, nil otherwise.
;;;
(defun is-token-p (symbol)
  "Return t if symbol is a token."
  (if (get-token symbol)
      t
    nil)
  )


(defun common-ancestor (obj1 obj2)
  (cond ((isa-p obj1 obj2)
	 obj1)
	((isa-p obj2 obj1)
	 obj2)
	(t
	 (find-intersecting-type 
	  (p4::type-name 
	   (p4::prodigy-object-type (get-token obj1)))
	  obj2)))
  )

(defun find-intersecting-type (type obj)
  (if (isa-p type obj)
      type
    (find-intersecting-type 
     (p4::type-name 
      (is-type-p type 
		 *current-problem-space*)) 
     obj))
  )


	
;;;
;;; Predicate isa-p tests whether or not object isa type. The object may be 
;;; either a direct child of type, or it may be indirectly related through 
;;; intermediate supertypes in the type hierarchy. Thus, if Tweety isa Canary 
;;; and Canary isa Bird then (isa-p Bird Tweety) is true. The predicate returns 
;;; nil if there is no connection between object and type in the path from 
;;; object to :top-type in the hierarchy.
;;;
(defun isa-p (type 
	      object 
	      &aux
	      (prodigy-object 
	       (get-token object)))
  "Returns t if object is of type or inherits the type through ancestry."
  (declare (special *current-problem-space*))
;; This assertion statement is getting unweildy.
;  (assert (and 
;	   (or (is-token-p type)
;	       (is-type-p type *current-problem-space*))
;	   (or prodigy-object
;	       (is-type-p object *current-problem-space*)))
;	  (type object))
  (cond ((or (eq type ':top-type)
	     (eq type object)
	     ;;Added to allow (isa-p '(or location country) 'location) 
	     ;;[cox 1mar98]
	     (and (consp type)
		  (eq (first type) 'or)
		  (member object (rest type)))
	     ;; or (isa-p 'location '(or location country)) 
	     (and (consp object)
		  (eq (first object) 'or)
		  (member type (rest object))))
	 t)
	((is-token-p type)
	 nil)
	(prodigy-object
	 (if (p4::object-type-p 
	      prodigy-object
	      (is-type-p type *current-problem-space*))
	     t))
	(t
	 (is-parent-of-p object type)))
  )



;;; 
;;; Predicate is-parent-of-p is the recursive function that actually calculates
;;; the isa  relationship for predicate  isa-p.  The PRODIGY function is-type-p
;;; is not actually a predicate.  It returns the  type structure  of  its first
;;; argument when true, rather than t itself. Thus given a symbol such as 'F16,
;;; is-type-p returns #<TYPE: f16>. Alternatively, the function  p4::super-type
;;; returns the superclass   of the argument     (i.e.,  given 'f16. it returns 
;;; #<TYPE: air-force-module>). The PRODIGY predicate child-type-p returns t if
;;; the first argument is a proper child (direct ancestor) of the second.
;;;
;;; NOTE that this function only works if object is itself a type. Comment 
;;; better later.
;;;  
;;; Added cond clause and the first test form to allow (is-parent-of-p BUILDING
;;; (OR LOCATION COUNTRY)). [cox 1mar98]
;;;
(defun is-parent-of-p (object type &aux p-type1 p-typ2)
  "Returns t if object can inherit type as a direct or indirect ancestor."
  (declare (special *current-problem-space*))
  (cond ((and (consp type)
	      (eq (first type) 'or))
	 (some #'is-parent-of-p
	       (make-list (1- (length type))
			  :initial-element
			  object)
	       (rest type)))
	((eq object ':top-type)
	 nil)
	((and
	  (setf p-type1 (is-type-p object *current-problem-space*))
	  (setf p-type2 (is-type-p type *current-problem-space*)))
	 (or
	  (child-type-p p-type1 p-type2)
	  (is-parent-of-p 
	   (p4::type-name 
	    (p4::super-type object *current-problem-space*))
	   type))))
  )




;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; ACCESS FUNCTIONS for
;;;;  PRODIGY SYSTEM
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;



;;;
;;; Function get-preconditions returns the preconditions of the operator, 
;;; prodigy-op, in either the form (and (precond1 arg11-type arg12-type...)...)
;;; or, if single precondition, (precond arg1-type arg2-type ...)
;;;
;;; When coming from a PRODIGY operator, such as the parameter prodigy-op, the 
;;; precondition expression, p-expr, assumes the following form:
;;; (PRECONDS {binding-list} expression).  For example:
;;;
;;; (first (get-prodigy-ops))
;;; --> #<OP: SECURE-STRONGHOLD>
;;;
;;; (p4::operator-precond-exp (first (get-prodigy-ops)))
;;; --> (PRECONDS ((<STRONGHOLD> BUILDING) 
;;;                (<INFANTRY-FORCE> INFANTRY)
;;;                (<SECURITY-FORCE> POLICE-FORCE-MODULE) 
;;;                (<LOC> LOCATION))
;;;      (AND (LOC-AT <STRONGHOLD> <LOC>) 
;;;           (IS-DEPLOYED <INFANTRY-FORCE> <LOC>)
;;;           (IS-DEPLOYED <SECURITY-FORCE> <LOC>)))
;;;
;;; (get-preconditions (first (get-prodigy-ops)))
;;; --> (AND (LOC-AT BUILDING LOCATION) 
;;;          (IS-DEPLOYED INFANTRY LOCATION)
;;;          (IS-DEPLOYED POLICE-FORCE-MODULE LOCATION))
;;;
;;; However, a caller of the function may also pass  a nil operator and instead
;;; explicitly furnish the p-expr argument.  The  p-expr may thus take the form
;;; (EXISTS {binding-list} expression).  This  strategy is useful for using the
;;; get-preconditions  function     as  a  translation   function    to convert
;;; existentially   quantified    goals   obtained   by   the    function  call
;;; (get-current-goals) to an abstract form. For example:
;;;
;;; (get-current-goals) 
;;; --> (EXISTS ((<HAWK-BATTALION.1008> HAWK-BATTALION)) 
;;;             (IS-DEPLOYED <HAWK-BATTALION.1008> SAUDI-ARABIA))
;;;
;;; (get-preconditions nil (get-current-goals))
;;;  --> (IS-DEPLOYED HAWK-BATTALION SAUDI-ARABIA)
;;;
;;; If p-expr starts with neither constants 'exists nor 'preconds, then the 
;;; goal is asssumed to be in suitable form for return. This would occur, for 
;;; instance, when an operator has literal goals with instances as arguments
;;; (e.g., (is-deployed f16-A-Squadron bosnia)).
;;;
(defun get-preconditions (prodigy-op 
			  &optional
			  (p-expr (p4::operator-precond-exp 
				   prodigy-op)))
  (if (not (or (eq 'user::EXISTS (first p-expr)) 
	       (eq 'user::PRECONDS (first p-expr))))
      p-expr
    (substitute-types-4-vars 
     (second p-expr) 
     (third p-expr)))
  )


;;;
;;; Function substitute-types-4-vars takes as input a binding list and a 
;;; PRODIGY expression, and produces as output the expression with all 
;;; variables in the expression replaced with values from the binding list.
;;; This function is most useful when creating abstract goals from 
;;; existentially quantified goals during function get-preconditions. See
;;; examples in comments of the get-preconditions function.
;;; 
(defun substitute-types-4-vars (binding-list expression)
  (cond ((null binding-list)
	 expression)
	(t
	 (let ((binding1 (first binding-list)))
	   (substitute-types-4-vars 
	    (rest binding-list)
	    (subst (if (listp (second binding1))
		       ;;Then it is '(AND TYPE ...)
		       (second (second binding1))
		     (second binding1))
		   (first binding1)
		   expression)))))
  )



;;;
;;; Access function get-token returns the PRODIGY object structure named by the
;;; argument.
;;;
(defun get-token (object-name)
  "Return the object structure named by argument."
  (declare (special *current-problem-space*))
  (cond ((p4::prodigy-object-p object-name)
	 object-name)
	((and (symbolp object-name)
	      (not (null object-name)))
	 (p4::object-name-to-object 
	  object-name
	  *current-problem-space*)))
  )



;;;
;;; Access function get-prodigy-ops returns a list of the current operators in
;;; PRODIGY's problem space. The first operator is the *FINISH* operator and is
;;; not returned.
;;;
(defun get-prodigy-ops ()
  (declare (special *current-problem-space*))
  (rest (p4::problem-space-operators 
	 *current-problem-space*))
  )




;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; PRIMARY PRODIGY and 
;;;; ForMAT-SPECIFIC 
;;;; FUNCTIONS
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;



(defun parent-of-instance (prodigy-object)
  (p4::type-name 
   (p4::prodigy-object-type 
    (get-token prodigy-object)))
  )


;;;This is the old version of return-goal
#|
(defun return-goal (prodigy-op)
  (if (null prodigy-op) nil
    ;; new-goal = (state-name <var1> <var2>...<varn>)
    (let* ((add-list (p4::operator-add-list
		      prodigy-op))
	   (del-list (p4::operator-del-list
		      prodigy-op))
	   (new-goal 
	    (if del-list
		`(USER::~ ,(p4::effect-cond-effect 
		      (first
		       (first
			(or (p4::operator-add-list
			     prodigy-op)
			    (p4::operator-del-list
			     prodigy-op))))))
	      (p4::effect-cond-effect 
	       (first
		(first
		 (or (p4::operator-add-list
		      prodigy-op)
		     (p4::operator-del-list
		      prodigy-op))))))))
      (cons 
       (first new-goal)			; That is, state-name
       (mapcar
	#'(lambda (each-arg)
	    (let ((constraint		;i.e., the "datum" of an association list.
		   (second
		    (assoc each-arg
			   (append
			    (second
			     (p4::operator-precond-exp  
			      prodigy-op))
			    (second
			     (p4::operator-effects
			      prodigy-op)))
			   ))))
	      (if (and (listp constraint)
		       (eq (first constraint) 'and))
		  (second constraint)
		constraint)))
	(rest new-goal)))))
  )
|#

;;;
;;; Function return-goal takes a PRODIGY operator and returns the first state
;;; in the add-list. This state is considered the primary state change
;;; instantiated by the function. If no add list exists it returns the negation
;;; of the first state on the delete list.
;;;
;;; The association list in the lambda function below is of the following form 
;;; ((<local-var> constraint-expression)*) Thus, the elements are pairs whose
;;; key is the local variable and the datum is the variable's constraint. The
;;; constrain is either a type or an conjunction whose first element is
;;; the type. The association list is the concatenation of the variables from 
;;; the precondition expression and the effects list. 
;;;
;;; The return-goal function then uses variables 1 thru n of the new-goal below
;;; to key the type in the association list.  The function then returns the 
;;; value in the form (state-name <var1-type> <var2-type> .. <varn-type>).
;;;
(defun return-goal (prodigy-op &optional neg-goal-p &aux temp)
  (if (null prodigy-op) nil
    ;; new-goal = (state-name <var1> <var2>...<varn>)
    (let* ((add-list (p4::operator-add-list
		      prodigy-op))
	   (del-list (p4::operator-del-list
		      prodigy-op))
	   (pos-goal 
	    (if add-list
		(p4::effect-cond-effect 
		 (first
		  (first
		   add-list )))))
	   (neg-goal
	    (if del-list
		(p4::effect-cond-effect 
		 (first
		  (first del-list)))))
	   (new-goal 
	    (or (and neg-goal-p
		     neg-goal)
		(and (not pos-goal)
		     neg-goal)
		(and (not neg-goal-p)
		     pos-goal))))
      (if new-goal
	  (setf temp
		(cons 
		 (first new-goal)	; That is, state-name
		 (mapcar
		  #'(lambda (each-arg)
		      (let ((constraint	;i.e., the "datum" of an association list.
			     (second
			      (assoc each-arg
				     (append
				      (second
				       (p4::operator-precond-exp  
					prodigy-op))
				      (second
				       (p4::operator-effects
					prodigy-op)))
				     ))))
			(if (and (listp constraint)
				 (eq (first constraint) 'and))
			    (second constraint)
			  constraint)))
		  (rest new-goal)))))
      (if (and temp
	       (or (and neg-goal-p
			neg-goal)
		   (and (not pos-goal)
			neg-goal)))
	  `(USER::~ ,temp)
	temp)))
  )



;;;
;;; Function return-corresponding-op returns the prodigy operator corresponding
;;; to name of the ForMAT goal passed to it. Therefore given 'send-hawk, the 
;;; function returns #<OP: SEND> (note that this is the operator itself, not
;;; the name of the operator.)
;;;
(defun return-corresponding-op (fgoal-name
				&aux
				(op-list
				 (get-prodigy-ops)))
  (cond ((eq :combat-mission-support fgoal-name)
	 (setf fgoal-name :support-combat-mission))
	;23feb cox
	((eq :isolate-the-battlefield fgoal-name)
	 (setf fgoal-name :isolate-battlefield))
	((eq :assist-legitimate-government fgoal-name)
	 (setf fgoal-name :do-assist))
	((eq :defend-strongpoints-and-locs fgoal-name)
	 (setf fgoal-name :defend-strongpoints-and-locs))
	((eq :protect-strongpoints-and-locs fgoal-name)
	 (setf fgoal-name :protect-strongpoints-and-locs))
	((eq :protect-and-defend-strongpoints-and-locs fgoal-name)
	 (setf fgoal-name :protect-and-defend-strongpoints-and-locs))
	((eq :evacuate-non-combatants fgoal-name)
	 (setf fgoal-name :evacuate-non-combatants-by-airlift))
	((eq :evacuate-designated-foreign-nationals fgoal-name)
	 (setf fgoal-name :evacuate-non-combatants-by-airlift))
	((eq :provide-security-for-us-military-personnel fgoal-name)
	 (setf fgoal-name :provide-security-for-us-military-personnel))
	((eq :evacuate-us-citizens fgoal-name)
	 (setf fgoal-name :evacuate-non-combatants-by-airlift))
	)
  (case fgoal-name 
	(:support-combat-mission (setf fgoal-name 'user::support-combat-mission))
	(:isolate-battlefield (setf fgoal-name 'user::isolate-battlefield))
	(:do-assist (setf fgoal-name 'user::do-assist))
	(:defend-strongpoints-and-locs (setf fgoal-name 'user::defend-strongpoints-and-locs))
	(:protect-strongpoints-and-locs (setf fgoal-name 'user::protect-strongpoints-and-locs))
	(:protect-and-defend-strongpoints-and-locs 
	 (setf fgoal-name 'user::protect-and-defend-strongpoints-and-locs))
	(:support-combat-mission (setf fgoal-name 'user::support-combat-mission))
	(:support-neo (setf fgoal-name 'user::support-neo))
	(:evacuate-non-combatants-by-airlift (setf fgoal-name 'user::evacuate-non-combatants-by-airlift))
	(:conduct-neo (setf fgoal-name 'user::conduct-neo))
	(:provide-medical-assistance (setf fgoal-name 'user::provide-medical-assistance))
	(:combat-mission-support (setf fgoal-name 'user::do-combat-mission-support))
	(:air-defense (setf fgoal-name 'user::air-defense))
	(:naval-blockade (setf fgoal-name 'user::naval-blockade))
	(:air-blockade (setf fgoal-name 'user::air-blockade))
	(:provide-security-for-us-military-personnel
	 (setf fgoal-name 'user::provide-security-for-us-military-personnel))
	(:maintain-law-and-order (setf fgoal-name 'user::maintain-law-and-order))
	(:evacuate-pax-from-country (setf fgoal-name 'user::evacuate-pax-from-country)))
  ;;Wrapped case form around nth in default case. cox
  (case fgoal-name 
	((user::isolate-battlefield user::do-assist user::defend-strongpoints-and-locs 
				    user::protect-and-defend-strongpoints-and-locs
				    user::protect-strongpoints-and-locs user::support-combat-mission 
				    user::support-neo user::evacuate-non-combatants-by-airlift 
				    user::conduct-neo user::provide-medical-assistance 
				    user::air-defense user::naval-blockade 
				    user::air-blockade user::maintain-law-and-order 
				    user::provide-security-for-us-military-personnel
				    user::evacuate-pax-from-country )
	 (nth
	  (- (length op-list)
	     (length
	      (member fgoal-name
		      (mapcar
		       #'(lambda (each-op)
			   (p4::operator-name each-op))
		       op-list))))
	  op-list))
	 (t
	 (nth
	  (- (length op-list)
	     (length
	      (member (grab-segment
		       fgoal-name 1)
		      (mapcar
		       #'(lambda (each-op)
			   (p4::operator-name each-op))
		       op-list))))
	  op-list)))
)



;;;
;;; Function generate-goal returns a PRODIGY-consistent state goal, given a 
;;; ForMAT-specific goal (of name fgoal-name). The fgoal is usually some goal
;;; to perform an action like deploy-f-15. 
;;;
(defun generate-goal (fgoal-name)
  (if (or (eq fgoal-name :secure-town-center-hall)
	  (eq fgoal-name :secure-town-center))
      '(user::town-center-secure-at user::location)
    (return-goal
     (return-corresponding-op fgoal-name)))
    )


;;;
;;; Function supplement-arg-list adds missing arguments to ForMAT goals. 
;;; Sometimes ForMAT will not include all arguments, even if when implicit in a
;;; name. For instance PRODIGY may be sent the fgoal SEND-DOG-TEAM along with
;;; arguments (GEOGRAPHIC-LOCATION KOREA) (FORCE-QUANTITY |1|). No force 
;;; argument is included because a dog-team is not technically a force object.
;;; However, the try-extract-from-goal-name function will be able to infer the
;;; dog-team argument if given a force of none. Function supplement-arg-list 
;;; adds this information and other when needed arguments are missing.
;;;
(defun supplement-arg-list (fgoal-name arg-list)
  (if (not (eq fgoal-name :deploy-tfs))
      (or (case (grab-segment fgoal-name 1)
		(send (if (not (assoc 'force arg-list))
			  (cons '(force none) arg-list)))
		(suppress (if (not (assoc 'force arg-list))
			      (cons '(force none) arg-list)))
		(deploy (if (not (assoc 'ac-type arg-list))
			    (cons '(aircraft-type none) arg-list)))
		)
	  arg-list)
    arg-list)
  )


;;;
;;; Function extract-arguments 
;;; 
(defun extract-arguments (fgoal-name arg-list)
  (mapcar
   #'(lambda (each-arg)
       (cond ((eq (first each-arg) 
		  'geographic-location)
	      (second each-arg))
	     ((eq (grab-last-segment 
		   (first each-arg))
		  'quantity)
	      (symbol-2-integer (second each-arg)))
	     (t
	      (second each-arg))))
   (filter 
    arg-list
;    (supplement-arg-list fgoal-name arg-list)
	   #'(lambda (each-list-item)
	       (if (eq 'NONE 
		       (second each-list-item))
		   (try-extract-from-goal-name
		    fgoal-name each-list-item)
		 each-list-item))))
  )



;;;
;;; 
;;; Function try-extract-from-goal-name attempts to return a complete argument 
;;; whose value has been extracted from ForMAT's goal name. This function is 
;;; called only when the attribute value passed to PRODIGY by ForMAT is equal 
;;; to 'NONE. In some cases, however, the value is implicit in the name of the 
;;; goal. This function will try to get it.
;;;
;;; The cases where the extraction is possible is when the goals is to send a 
;;; force or when it is to deploy an aircraft type. For example, with the goal
;;; (:SEND-HAWK (FORCE NONE)), the system can infer (FORCE HAWK).
;;;
;;; The function returns nil if either case of extraction fails. This is 
;;; important so that the filter removes the attribute with value NONE if no
;;; other value can be inferred.
;;; 
(defun try-extract-from-goal-name (fgoal-name argument)
  (if (or
       (and (eq 'SEND (grab-segment fgoal-name 1))
	    (eq 'FORCE (first argument)))
       (and (eq 'SUPPRESS (grab-segment fgoal-name 1))
	    (eq 'FORCE (first argument)))
       (and (eq 'DEPLOY (grab-segment fgoal-name 1))
	    (eq 'AIRCRAFT-TYPE (first argument))))
      (setf (second argument)
	    (let ((remainder
		   (delete-segment fgoal-name 1)))
	      ;; Because :deploy-f-15 and :deploy-f-16 have extra
	      ;; dashes, we need to adjust for this.
	      (format t "Remainder: ~s~%" remainder)
	      (if (eq remainder 'f-16)
		  'f16
		(if (eq remainder 'f-15)
		    'f15
		  remainder)))))
  )



;;;
;;; Function ForMAT-2-PRODIGY-goal generates a prodigy goal and extracts
;;; arguments for it from the fgoal passed to it.
;;; 
(defun ForMAT-2-PRODIGY-goal (fgoal)
  (cons (generate-goal        ; Generate state goal from ForMAT action goal
	 (second fgoal))
	(extract-arguments
	 (second fgoal)
	 (seventh fgoal)))
  )



;;;
;;; Function substitute-bindings replaces PRODIGY goal variables with ForMAT-
;;; specific arguments. The function ForMAT-2-PRODIGY-goal returns a list of the
;;; following form: 
;;;
;;; ((IS-DEPLOYED GROUND-FORCE-MODULE AIRPORT) SECURITY-POLICE 1 SAUDI-ARABIA)
;;;
;;; The first element of the list is the prodigy-goal and the rest of the list 
;;; is ForMAT's list of arguments that comprises the candidate list from which
;;; this function chooses substitutions. The prodigy-goal is returned with 
;;; appropriate replacements. (I.e., (IS-DEPLOYED SECURITY-POLICE AIRPORT))
;;; NOTE that I think that this example has changed. Update later.
;;;
(defun specialize-bindings (prodigy-goal candidate-list)
  (if (not (null prodigy-goal))
      (setf (rest prodigy-goal)
	    (mapcar
	     #'(lambda (each-arg)
		 (or (substitute-from candidate-list each-arg)
		     each-arg))
	     (rest prodigy-goal))))
  prodigy-goal
  )



;;;
;;; Function substitute-from returns the first item from the candidate-list 
;;; that is of the given type, either directly or indirectly. That is, it 
;;; chooses an item that is a child or subtype of type. Therefore the call
;;; (substitute-from '(security-police 12 F-15 F-16) 'air-force-module) returns
;;; the value F-15. 
;;;
(defun substitute-from (candidate-list type)
  (cond ((null candidate-list)
	 nil)
	((numberp (first candidate-list))
	 (substitute-from (rest candidate-list) type))
	((and 
	  (atom type)
	  (isa-p type (first candidate-list)))
	 (first candidate-list))
	((and (consp type)
	      (eq (first type) 'or))
	 (some #'substitute-from 
	       (make-list (1- (length type))
			  :initial-element
			  candidate-list)
	       (rest type)))
	      
	(t 
	 (substitute-from (rest candidate-list) type)))
  )



;;;
;;; Given a goal such as (loc-at airport1 LOCATION), generate the abstract goal
;;; (EXISTS ((<LOCATION.11436> LOCATION)) (loc-at airport1 <LOCATION.11436>)),
;;; that is, (exists ({var-list} (predicate {arg-list}))) such that each var in
;;; var-list has been substituted for the corresponding type identifier in the 
;;; goal g.
;;; 
;;; If, however, all arguments in the goal are tokens (instances), return the 
;;; unchanged goal, g.
;;;
(defun make-existential-goal (g 
			   &aux var-list 
			   (predicate (first g))
			   (args (rest g))
			   at-least1-type)
  (declare (special *current-problem-space*))
  (dolist (each-arg args)
	  (when (is-type-p 
		 each-arg
		 *current-problem-space*)
		(setf at-least1-type t)
		(setf var-list 
		      (cons (list 
			     (make-var each-arg)
			     each-arg)
			    var-list))
		(setf args
		      (subst (first (first var-list))
			     each-arg
			     args))))
  (if at-least1-type
      `(user::exists ,var-list (,predicate ,@args))
    g)
  )



;;;
;;; If t, then translate existential goals received from ForMAT into literals,
;;; perform actual case matching and retrieval instead of using *case-list* to
;;; match against goals only, and finally, perform actual case replay. These
;;; last two actions are implemented in prodigy-suggestions.lisp rather than
;;; here.
;;;
(defparameter *Use-Case-Replay* t)

;;;
;;; Function translate-goal translates goals from a ForMAT action statement
;;; into the PRODIGY goal form.
;;; 
;;; To see example of fgoal-action, see top-level comment of this file. 
;;; However, an example of the extracted auxilliary variable fgoals is as 
;;; follows (NOTE that integers, e.g., FORCE-QUANTITY, are represented as 
;;; symbols):
;;; 
;;;  ((189 :SEND-INFANTRY PLANF
;;;    ((GCE PLANF) (M04 PLANF) (T0F PLANF) )
;;;    NIL
;;;    (186)
;;;    ((GEOGRAPHIC-LOCATION SRI-LANKA) (FORCE INFANTRY-BATTALION)
;;;     (FORCE-QUANTITY |1|)))
;;;   (188 :SEND-SECURITY-POLICE PLANF
;;;    ((GCE PLANF) (MM04 PLANF) (T0F PLANF) )
;;;    NIL
;;;    (186)
;;;    ((GEOGRAPHIC-LOCATION SRI-LANKA) (FORCE SECURITY-POLICE)
;;;     (FORCE-QUANTITY |1|)))
;;;   (187 :SEND-MILITARY-POLICE PLANF
;;;    ((M04 PLANF) (SEC PLANF) (T0F PLANF) )
;;;    NIL
;;;    (186)
;;;    ((GEOGRAPHIC-LOCATION SRI-LANKA) (FORCE MILITARY-POLICE)
;;;     (FORCE-QUANTITY |1|)))
;;;   (186 :SUPPRESS-TERRORISM PLANF
;;;    ((GCE PLANF) (M04 PLANF) (SEC PLANF) (T0F PLANF) )
;;;    (187 189 188)
;;;    NIL
;;;    ((GEOGRAPHIC-LOCATION SRI-LANKA)))
;;;   )
;;;
;;; Across the fgoals first map each from ForMAT to PRODIGY form, then map each
;;; result to a goal with specialized bindings substituted, and the finally map 
;;; each of these results to an abstract form if appropriate.
;;;
(defun translate-goals (fgoal-action 
			&aux 
			(fgoals 
			 (setf *latest-ForMAT-goals*
			       (rest (fourth (fourth fgoal-action)))))
			(prod-goals
			 ;; Moved to an auxiliary variable from function
			 ;; body. [cox 26apr98]
			 (mapcar
			  #'make-existential-goal
			  (mapcar
			   #'(lambda (each-item)
			       (specialize-bindings
				(first each-item)
				(rest each-item)))
			   (mapcar 
			    #'ForMAT-2-PRODIGY-goal
			    fgoals)))))
  (cons 'and                            ; A goal list is a conjunction of goals. 
	(if (and 
	     *JADE-demo-p*		; Added Jade condition [cox 26apr98]
	     *Use-Case-Replay*)		; Can turn off without turning rest
					; off.
	    (mapcar
	     #'make-literal             ; Translate to literal form from the 
	     prod-goals)                ; existential form prod-goals are in.
	  prod-goals))
  )



;;;
;;; Function reset-domain establishes the starting object and state
;;; configuration. For the front-end to be able to translate ForMAT goals, it
;;; must have a current definition of those object in the initial state. By
;;; calling set-problem with a nil argument build-problem-statement creates
;;; those objects and a goal guaranteed to be true. Thus the subsequent call of
;;; run creates a LISP problem structure and attaches it to the current problem
;;; space and "solves" the trivial goal.
;;;
;;; Function reset-domain is useful to the user when operators or control 
;;; rules are changed. The function will reload the domain, reset some PRODIGY
;;; parameters, and then re-establish the conditions under which the front-end 
;;; to ForMAT can operate.
;;;
(defun reset-domain (&optional (domain-name 'user::tfs))
  (declare (special *always-remove-p* *front-end-initialized*))
  ;; Load problem file in case changes were made to objects, states, or goals.
  (load (concatenate 
	 'string 
	 *format-directory* 
	 "source/problem-file.lisp"))
  (user::domain domain-name)
  (setf *front-end-initialized* nil)
  (output-level 3)
  (setf user::*always-remove-p* t)
  (setf (user::pspace-prop :depth-bound) 100)
  (when (not *front-end-initialized*)
	(setf *front-end-initialized* t)
	(user::set-problem nil)
	;;Replaced run call with load-problem. [cox 6jun98]
	(p4::load-problem 
	 (user::current-problem) nil)
;;;	(run)
	))


(defun print-full-op (rule &optional print-all)
  (princ "#<")
  (princ "OP: ")
  (princ (p4::rule-name rule))
  (terpri)
  (when (p4::rule-params rule)
	(princ 'params)
	(princ (p4::rule-params rule)))
  (terpri)
  (when (p4::rule-precond-exp rule)
	(princ 'precond-exp)
	(princ (p4::rule-precond-exp rule)))
  (terpri)
  (when (p4::rule-precond-vars rule)
	(princ 'precond-vars)
	(princ (p4::rule-precond-vars rule)))
  (terpri)
  (when (p4::rule-vars rule)
	(princ 'vars)
	(princ (p4::rule-vars rule)))
  (terpri)
  (when (p4::rule-binding-lambda rule)
	(princ 'binding-lambda)
	(princ (p4::rule-binding-lambda rule)))
  (terpri)
  (when (p4::rule-effects rule)
	(princ 'effects)
	(princ (p4::rule-effects rule)))
  (terpri)
  (when (p4::rule-add-list rule)
	(princ 'add-list)
	(princ (p4::rule-add-list rule)))
  (terpri)
  (when print-all
	(when (p4::rule-del-list rule)
	      (princ 'del-list)
	      (princ (p4::rule-del-list rule)))
	(terpri)
	(when (p4::rule-effect-var-map rule)
	      (princ 'effect-var-map)
	      (princ (p4::rule-effect-var-map rule)))
	(terpri)
	(when (p4::rule-select-bindings-crs rule)
	      (princ 'select-bindings-crs)
	      (princ (p4::rule-select-bindings-crs rule)))
	(terpri)
	(when (p4::rule-reject-bindings-crs rule)
	      (princ 'reject-bindings-crs)
	      (princ (p4::rule-reject-bindings-crs rule)))
	(terpri)
	(when (p4::rule-simple-tests rule)
	      (princ 'simple-tests)
	      (princ (p4::rule-simple-tests rule)))
	(terpri)
	(when (p4::rule-unary-tests rule)
	      (princ 'unary-tests)
	      (princ (p4::rule-unary-tests rule)))
	(terpri)
	(when (p4::rule-join-tests rule)
	      (princ 'join-tests)
	      (princ (p4::rule-join-tests rule)))
	(terpri)
	(when (p4::rule-neg-simple-tests rule)
	      (princ 'neg-simple-tests)
	      (princ (p4::rule-neg-simple-tests rule)))
	(terpri)
	(when (p4::rule-neg-unary-tests rule)
	      (princ 'neg-unary-tests)
	      (princ (p4::rule-neg-unary-tests rule)))
	(terpri)
	(when (p4::rule-neg-join-tests rule)
	      (princ 'neg-join-tests)
	      (princ (p4::rule-neg-join-tests rule)))
	(terpri)
	(when (p4::rule-generator rule)
	      (princ 'generator)
	      (princ (p4::rule-generator rule)))
	(terpri)
	(when (p4::rule-plist rule)
	      (princ 'plist)
	      (princ (p4::rule-plist rule)))
	(princ ">")
	(terpri)
	(terpri)
	)
  )

