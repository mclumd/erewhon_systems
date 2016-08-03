(in-package user)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;			       SCROLLBUTTON.LISP
;;; 
;;;
;;; Functions to extend the user interface and coordinate with the tcl code 
;;; loaded in scrollbutton.tcl. The main function is is format-4-tcl.
;;;
;;;
;;; History:
;;; May 13 97 Jim: Pulled out the display forms from
;;;    compute-node-expression-4-tcl so they can be altered by users.

;;; May 15 97 Jim: Adding a standard way to send object information to
;;;   TCL to put in a window. Lisp must send a list, whose first
;;;   element is a form that can be evaluated to yield this object
;;;   again. TCL will use this if the user clicks on something asking
;;;   for more info or to change some value. The second element should
;;;   be the name, used for the window title. The remaining elements
;;;   should be slots. Each slot should be a list: the first element
;;;   should be a form that can be evaluated to yield the slot value,
;;;   assuming that the lisp global variable *tcl-item* has been bound to
;;;   the result of evaluating the form for the object, the second
;;;   element should be a slot name and the remaining elements denote
;;;   the value.

;;; The forms used to display nodes are made into global variables so
;;; they can be altered more easily.
(defvar *Tcl-display-forms* nil
  "Property list of display forms for different structures")

(setf (getf *Tcl-display-forms* 'p4::goal-node)
      '`((user::find-node ,(p4::goal-node-name *tcl-item*))	; form
	 ,(format nil "Goal Node (node ~S)"
		  (p4::goal-node-name *tcl-item*)) ; name
	 ;; remaining slots
	 ((p4::goal-node-goal *tcl-item*) "Goal" ,(p4::goal-node-goal *tcl-item*))
	 ((p4::goal-node-introducing-operators *tcl-item*)
	  (Introducing Operators)		;<-- This was ":relevant-to"
	  ,(p4::goal-node-introducing-operators *tcl-item*))
	 ((p4::goal-node-ops-left *tcl-item*) "Untried operators"
	  ,(p4::goal-node-ops-left *tcl-item*))
	 ((p4::goal-node-goals-left *tcl-item*) (Goals Left )
	  ,(p4::goal-node-goals-left *tcl-item*))
	 ((p4::goal-node-applicable-ops-left *tcl-item*)
	  (Applicable Operators Left)
	  ,(p4::goal-node-applicable-ops-left *tcl-item*))
	 )
      )

(setf (getf *Tcl-display-forms* 'p4::operator-node)
      '`((user::find-node ,(p4::goal-node-name *tcl-item*)) ; form
	 ,(format nil "Operator Node (node ~S)"
		  (p4::operator-node-name *tcl-item*))
	 ( (p4::operator-node-operator *tcl-item*) "Operator"
	   ,(p4::operator-node-operator *tcl-item*))
	 ((p4::operator-node-bindings-left *tcl-item*) (Bindings Left )
	  ,(p4::operator-node-bindings-left *tcl-item*))
	 ((p4::operator-node-ops-left *tcl-item*) "Operators Left"
	  ,(p4::operator-node-ops-left *tcl-item*)))
      )

(setf (getf *Tcl-display-forms* 'p4::applied-op-node)
      '(let ((application-structs (p4::applied-op-node-applied *tcl-item*)))
	 `((user::find-node ,(p4::goal-node-name *tcl-item*))	; form
	   ,(format nil "Applied Op Node (node ~S)"
		    (p4::operator-node-name *tcl-item*))
	   ((p4::applied-op-node-instantiated-op *tcl-item*)
	    "Instantiated op"
	    ,(p4::applied-op-node-instantiated-op *tcl-item*))
	   ((p4::applied-op-node-applied *tcl-item*)
	    "Application structures" ,application-structs)
	   ,@(assemble-adds-and-dels application-structs)))
      )

(setf (getf *Tcl-display-forms* 'p4::binding-node)
      '`((user::find-node ,(p4::goal-node-name *tcl-item*))	; form
	 ,(format nil "Binding Node (node ~S)"
		  (p4::goal-node-name *tcl-item*))
	 ((p4::binding-node-instantiated-op *tcl-item*)
	  "Instantiated op"
	  ,(p4::binding-node-instantiated-op *tcl-item*))
	 ((p4::binding-node-instantiated-preconds *tcl-item*)
	  "Instantiated Preconditions"
	  ,(p4::binding-node-instantiated-preconds *tcl-item*))
	 )
      )

(setf (getf *Tcl-display-forms* 'p4::protection-node)
      '`((user::find-node ,(p4::protection-node-name *tcl-item*))
	 ,(format nil "Protection Node (node ~S)"
		  (p4::protection-node-name *tcl-item*))
	 ((p4::protection-node-goal *tcl-item*) "Goal Protected"
	  ,(p4::protection-node-goal *tcl-item*))
	 ((p4::protection-node-instantiated-op *tcl-item*)
	  "Protected from" ,(p4::protection-node-instantiated-op *tcl-item*))
	 ((p4::protection-node-old-preconds *tcl-item*)
	  "Old preconditions" ,(p4::protection-node-old-preconds *tcl-item*))
	 ((p4::protection-node-new-preconds *tcl-item*)
	  "New preconditions" ,(p4::protection-node-new-preconds *tcl-item*))
	 ))
	 

(setf (getf *Tcl-display-forms* 'p4::instantiated-op)
      '`(nil	     ; object can only be gotten relative to others
	 "Instantiated operator"
	 ((p4::instantiated-op-op *tcl-item*) "Operator"
	  ,(p4::instantiated-op-op *tcl-item*))
	 ((p4::instantiated-op-values *tcl-item*) "Values"
	  ,(p4::instantiated-op-values *tcl-item*))
	 ((p4::instantiated-op-binding-node-back-pointer *tcl-item*)
	  "Binding node"
	  ,(p4::instantiated-op-binding-node-back-pointer *tcl-item*))))

(setf (getf *Tcl-display-forms* 'symbol)
      '`(nil				; form
	 "Symbol"
	 ((symbol-name *tcl-item*) "Name"
	  ,(symbol-name *tcl-item*))
	 ((ret-symbol-val *tcl-item*) "Value"
	  ,(ret-symbol-val *tcl-item*))
	 ((symbol-package *tcl-item*) "Package"
	  ,(symbol-package *tcl-item*))
	 ((symbol-plist *tcl-item*) "Property List"
	  ,(symbol-plist *tcl-item*))
	 ((ret-function *tcl-item*) "Function"
	  ,(ret-function *tcl-item*))
	 ))

(defun ret-function (funct)
  (if (fboundp funct)
      (symbol-function funct)
    'No_Function_Definition)
  )


(defun ret-symbol-val (symb)
  (if (boundp symb)
      (symbol-value symb)
    'Unbound)
  )


(setf (getf *Tcl-display-forms* 'function)
      '`(nil				; form
	 "Function"
	 ((function-lambda-expression *tcl-item*) "Value"
	  ,(function-lambda-expression *tcl-item*))
	 ))


(setf (getf *Tcl-display-forms* 'fixnum)
      '`(nil				; form
	 "Fixnum"
	 ((eval *tcl-item*) "Value"
	  ,*tcl-item*)
	 ))

(setf (getf *Tcl-display-forms* 'p4::control-rule)
      '`(nil				; form
	 "Control rule"
	 ((p4::control-rule-name *tcl-item*) "Name"
	  ,(p4::control-rule-name *tcl-item*))
	 ((p4::control-rule-type *tcl-item*) "Type"
	  ,(p4::control-rule-type *tcl-item*))
	 ((p4::control-rule-if *tcl-item*) "Antecedent"
	  ,(p4::control-rule-if *tcl-item*))
	 ((p4::control-rule-then *tcl-item*) "Consequent"
	  ,(p4::control-rule-then *tcl-item*))))

(setf (getf *Tcl-display-forms* 'operator)
      '`(nil				; form
	 "Operator"
	 ((p4::operator-name *tcl-item*) "Name"
	  ,(p4::operator-name *tcl-item*))
	 ((p4::operator-params *tcl-item*) "Printed parameters"
	  ,(p4::operator-params *tcl-item*))
	 ((p4::operator-precond-exp *tcl-item*)
	  "Preconditions"
	  ,(p4::operator-precond-exp *tcl-item*))
	 ((p4::operator-effects *tcl-item*)
	  "Effects"
	  ,(p4::operator-effects *tcl-item*))
	 ((p4::operator-plist *tcl-item*)
	  "Property list"
	  ,(p4::operator-plist *tcl-item*))
	 ))
	 
	  

(setf (getf *Tcl-display-forms* 'p4::literal)
      '`((p4::instantiate-consed-literal         ; form (ugly and not used)
	  ',(cons (p4::literal-name *tcl-item*)
		  (let ((args (p4::literal-arguments *tcl-item*))
			(argnames nil))
		    (dotimes (i (length args))
		      (push (if (p4::prodigy-object-p (elt args i))
				(p4::prodigy-object-name (elt args i))
			      (elt args i))
			    argnames))
		    (nreverse argnames))))
	 "Literal"
	 ((p4::literal-name *tcl-item*) "Name" ,(p4::literal-name *tcl-item*))
	 ((p4::literal-state-p *tcl-item*) "Value in current state"
	  ,(p4::literal-state-p *tcl-item*))
	 ;; one slot for each argument
	 ,@(let ((args (p4::literal-arguments *tcl-item*))
		 (args-list nil))
	     (dotimes (i (length args))
		      (push
		       (list `(numbered-arg *tcl-item* ,i)
			     i (elt args i))
		       args-list))
	     (nreverse args-list))))

;;; I can't pass nested bracket in the accessor specification, so this
;;; helper function is needed.
(defun numbered-arg (literal i) (elt (p4::literal-arguments literal) i))

(setf (getf *Tcl-display-forms* 'p4::prodigy-object)
      '`(nil
	 "Prodigy object"
	 ((p4::prodigy-object-name *tcl-item*) "Name"
	  ,(p4::prodigy-object-name *tcl-item*))
	 ((p4::prodigy-object-type *tcl-item*) "Type"
	  ,(p4::prodigy-object-type *tcl-item*))
	 ((p4::prodigy-object-plist *tcl-item*) "Property list"
	  ,(p4::prodigy-object-plist *tcl-item*))
	 ((get-facts-about-object *tcl-item*)	; an example of delaying info.
	  "Literals that mention this object" "Click here")))	

(setf (getf *Tcl-display-forms* 'type)
      '`(nil
	 "Prodigy type"
	 ((p4::type-name *tcl-item*) "Name" ,(p4::type-name *tcl-item*))
	 ((p4::type-super *tcl-item*) "Super type" ,(p4::type-super *tcl-item*))
	 ((p4::type-sub *tcl-item*) "Sub types" ,(p4::type-sub *tcl-item*))
	 ((p4::type-real-instances *tcl-item*) "Instances of this exact type"
	  ,(p4::type-real-instances *tcl-item*))
	 ((p4::type-instances *tcl-item*) "Instances of this type and all subtypes"
	  ,(p4::type-instances *tcl-item*))
	 ((p4::type-permanent-instances *tcl-item*)
	  "Instances which are permanent objects"
	  ,(p4::type-permanent-instances *tcl-item*))))

(setf (getf *Tcl-display-forms* 'p4::op-application)
      '`(nil
	 ,(format nil "Application of ~S"
		  (p4::rule-name
		   (p4::instantiated-op-op
		    (p4::op-application-instantiated-op *tcl-item*))))
	 ((p4::op-application-instantiated-op *tcl-item*)
	  "Instantiated op"
	  ,(p4::op-application-instantiated-op *tcl-item*))
	 ((p4::op-application-delta-adds *tcl-item*)
	  "Literals added"
	  ,(p4::op-application-delta-adds *tcl-item*))
	 ((p4::op-application-delta-dels *tcl-item*)
	  "Literals deleted"
	  ,(p4::op-application-delta-dels *tcl-item*))
	 ((p4::op-application-binding-node *tcl-item*)
	  "Binding node"
	  ,(p4::op-application-binding-node *tcl-item*))
	 ))
	 

;;; This helper function implements a virtual slot, with all the
;;; literals mentioning the object.
(defun get-facts-about-object (object)
  (let ((facts nil))
    (maphash #'(lambda (key value)
		 (maphash #'(lambda (key value)
			      (let ((args (p4::literal-arguments value)))
				(dotimes (i (length args))
					 (when (eq object (elt args i))
					       (push value facts)
					       (return)))))
			  value))
	     (p4::problem-space-assertion-hash *current-problem-space*))
    facts))

;;; Display a list by having a slot for each element. This will break
;;; for cons pairs.
(setf (getf *Tcl-display-forms* 'cons)
      '`(nil			; don't know how to get it back
	 "List"
	 ,@(let ((res nil))
	     (dotimes (i (length *tcl-item*))
		      (push (list `(elt *tcl-item* ,i)
				  i (elt *tcl-item* i))
			    res))
	     (nreverse res))))


;;;
;;; Function format-4-tcl is the main function called by the user interface
;;; when displaying node pointed to in the goal tree canvas. This function 
;;; creates a list structure having three subcomponents. The first is the 
;;; representation for the node named by argument node-id. The second is the 
;;; name of the parent of node. The third is a list of children of the node.
;;; Note that the representation of the node itself is mainly created by a call
;;; to compute-expression and then appended with the rationale, case-links, and
;;; fired preference-rule names if they exist.
;;;
(defun format-4-tcl (node-id)
  (let* ((node (find-node node-id))
	 (tcl-expression (compute-expression-4-tcl node))
	 (node-parent (let ((temp (p4::nexus-parent node)))
			(and temp (p4::nexus-name temp))))
	 (node-children (node-names (p4::nexus-children node)))
	 (rationale  (getf (p4::nexus-plist node) :termination-reason))
	 (why-chosen (getf (p4::nexus-plist node) :why-chosen))
	 (case-links (getf (p4::nexus-plist node) :guided)))
    `((,@tcl-expression
       ,@(if why-chosen `(((node-property *tcl-item* :why-chosen)
			   "Why Chosen" ,why-chosen)))
       ,@(if case-links `(((node-property *tcl-item* :guided)
			   case-links ,case-links)))
       ,@(if rationale  `(((node-property *tcl-item* :termination-reason)
			   termination-reason ,rationale)))
       )
      ,node-parent
      ,node-children)
    ))

;;; Another helper to avoid nested lists
(defun node-property (node property) (getf (p4::nexus-plist node) property))

;;;
;;; Function binding-node-name-4-tcl returns the name of the binding-node, 
;;; given a node identifier so that it can be transferred to the tcl ui.
;;;
(defun binding-node-name-4-tcl (node-id 
				&aux 
				(node (find-node node-id)))
  (if (p4::binding-node-p node)
      (p4::rule-name 
       (p4::instantiated-op-op 
	(p4::binding-node-instantiated-op node ))))
  )


;;; Function compute-expression-4-tcl returns a list form of a given
;;; lisp object, to be displayed in a TCL inspect. The relevant fields
;;; of each type of decision node are represented in the property list
;;; *Tcl-display-forms*.

(defun compute-expression-4-tcl (*tcl-item*
				 &aux (type (type-of *tcl-item*)))
  (declare (special *tcl-item*))
  (if (getf *Tcl-display-forms* type)
      (eval (getf *Tcl-display-forms* type))
    '(Unknown-Item-Type)))

;;;  Function assemble-adds-and-dels recursively traverses list of
;;; application structures and builds a list having two sublists for
;;; each item. The first sublist is for the adds while the second is
;;; for the deletions. The returned list can then be spliced into the
;;; backquoted list template used for applied-op-nodes. NOTE - ASSUMES
;;; THAT THE FORMS ARE SLOTS OF THE APPLIED-OP-NODE WINDOW.

(defun assemble-adds-and-dels (a-struct-list 
			       &optional 
			       (application_num 1))
  "Assemble adds and deletes from an application structure list."
  (cond ((null a-struct-list)
	 nil)
	;; Again I had to create a helper function that doesn't have
	;; nesting - confounded tcl-to-lisp list flattener!
	(t (cons 
	    `((app-op-app-add ,application_num *tcl-item*)
	      ,(format nil "Assertions Added For Structure ~S" application_num)
	      ,(p4::op-application-delta-adds (first a-struct-list)))
	    (cons 
	     `((app-op-app-del ,application_num *tcl-item*)
	       ,(format nil "Assertions Deleted For Structure ~S"
			application_num)
	       ,(p4::op-application-delta-dels 
		 (first a-struct-list)))
	     (assemble-adds-and-dels (rest a-struct-list)
				     (+ 1 application_num))))))
  )


(defun app-op-app-add (appnum node)
  (p4::op-application-delta-adds
   (elt (p4::applied-op-node-applied node) (- appnum 1))))

(defun app-op-app-del (appnum node)
  (p4::op-application-delta-dels
   (elt (p4::applied-op-node-applied node) (- appnum 1))))

;;; Create the list that represents the "value" of a search node.
;;; Since this will fill a slot, it must have 3 values: how to get the
;;; value, the name and value of the slot.

(defun format-value-4-tcl (value)
  (list
   nil					; don't know how to get it again
   (type-of value)
   value)
  )


;;;
;;; Return a list of node names corresponding to the input list of nodes.
;;;
(defun node-names (alist)
  (cond ((null alist)
	 nil)
	(t
	 (cons (p4::nexus-name (first alist))
	       (node-names (rest alist)))))
  )


;;;
;;; Function to test the code in function format-4-tcl for all nodes in the 
;;; search tree.
;;;
(defun print-s-tree (&optional (s-tree-node (search-tree-root)))
  (cond ((null s-tree-node)
	 nil)
	((listp s-tree-node)
	 (mapcar #'print-s-tree s-tree-node))
	(t
	 (format t 
		 "~%~s~%"
		 (format-4-tcl s-tree-node))
	 (print-s-tree (p4::nexus-children s-tree-node))))
  )
  

(defun search-tree-root ()
  "Return the root of the prodigy search tree."
  (getf (p4::problem-space-plist 
	 *current-problem-space*)
	:root)
  )


