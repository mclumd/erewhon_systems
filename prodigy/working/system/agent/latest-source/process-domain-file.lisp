(in-package :user)

;;; 
;;; NOTE that the *domain-name* variable is defined in registrar.lisp and so
;;; this file (i.e., process-domain-file) must be loaded after loading
;;; registrar.lisp

;;;; 
;;;; Initialize the code by calling (init-domain-extract) before using
;;;; any function below or in file goal-extract.lisp.
;;;; 

;;;; 
;;;; This file along with file goal-extract.lisp contains the code
;;;; that processes a PRODIGY domain file in order to extract
;;;; information used to characterize objects, states, and goals for
;;;; that domain. This information is passed to and used by the GTrans
;;;; series of programs.
;;;; 


#|

(defmacro gtype-of (new-type-name old-type-name)
  `(progn
     (setf (get (quote ,new-type-name) 'parent) 
       (quote ,old-type-name))
     (setf (get (quote ,old-type-name) 'children)
       (cons (quote ,new-type-name)
	     (get (quote ,old-type-name) 'children))))
  )

|#


(defvar *obj-command-server* nil)

(defvar *socket-code-loaded-p* nil
  "When nil, load files for socket code.")

;;; 
;;; Appears to be unused parameter:
;;; (defparameter *path* "/usr/local/mcox/prodigy/working/domains/goal-trans/domain.lisp")
;;; 


;;; 
;;; The GTrans domain is a simple version of the goal-trans domain. It
;;; is used by the GTrans and associated programs.
;;; 
;;; Changed to use *world-path* instead of *prodigy-base-directory* NOTE that
;;; the *domain-name* variable is defined in registrar.lisp. [cox 27mar01]
;;; 
(defparameter *domain-file*
    (concatenate 'string
      *world-path*
      (string-downcase
       (format nil "~s" *domain-name*))
      "/domain.lisp")
  )


;;; 
;;; Contains leaves in the semantic net.
;;; 
;;; Used in predicate not-leaf-p of file goal-extract.lisp.
;;; 
(defvar *leaf-list* nil 
  "Stores the leaf type-nodes of the semantic net of a domain file")


;;; 
;;; This association list stores associations between type-nodes (the
;;; key) in the semantic hierarchy of a domain file and the children
;;; (datum) of the type-nodes. If A isa B and C isa B, then an entry
;;; (b a c) exists in *type-hier*.
;;; 
(defvar *type-hier* nil
  "The type hierarchy association list of a domain file.")


;;; 
;;; The function init-domain-extract initializes the two knowledge
;;; structures *leaf-list* and *type-hier*. Call function before using
;;; code in process-domain-file.lisp and goal-extract.lisp.
;;; 
;;; NEED TO CHANGE NAME.
;;; 
(defun init-domain-extract (&optional
			    (domain-file-name 
			     *domain-file*))
  (create-type-a-list)
  (CREATE-PRED-A-LIST)
  (setf *leaf-list* 
    (extract-types 
     domain-file-name))
  )


;;; 
;;; Function create-type-a-list must be called during initialize time
;;; so that the *type-hier* is established.
;;; 
;;; In a given domain file, each entry in the type hierarchy is like
;;; the following:
;;; 
;;; (ptype-of FORCE-MODULE :top-type)
;;; 
;;; Function create-type-a-list assembles an association list that
;;; relates types in the hierarchy with their immediate children.
;;; Leaves in the hierarchy do not have entries because they have no
;;; children.
;;; 
(defun create-type-a-list (&optional
			   (domain-f-name 
			    *domain-file*))
  (setf *type-hier* nil)
  (with-open-file
      (domain-file domain-f-name
       :direction :input)
    (do ((next nil 
	       (read domain-file 
		     nil 
		     *end-of-file* 
		     nil)))
	((eof-p next)
	 nil)
      (if (ptype-list-p next)		;this predicate also assures that next
					;is not the eof char
	  (setf *type-hier*
	    (acons (third next)
		   (cons (second next) 
			 (get-children-from
			   (third next)))
		   *type-hier*)))
      )
    )
  *type-hier*
  )



;;; 
;;; Function get-children-from is an access function for the
;;; association-list created by function create-type-a-list. Given a
;;; node in the type hierarchy represented in *type-hier*, it returns
;;; the children.
;;; 
(defun get-children-from (node
			  &optional
			  is-predicate-not-arg-p)
  (rest
   (assoc node
	  (if is-predicate-not-arg-p
	      *pred-hier*
	    *type-hier*)))
  )




;;; 
;;; Top-level functions & predicates
;;;


;;; THIS IS OBSOLETE I THINK.
(defun send-obj-strings (&optional 
			 (port *default-port*)
			 (silent-p t)
					;(fname (string (get-socket-message)))
			 )
  (spawn-socket-server '*obj-command-server* port)
  (format t "Spawned obj-socker server.")
  (mp::process-sleep 3)
;  (wait-for-socket-connection *send-socket*)
  (let* ((msg (get-socket-message 
	       silent-p))
	 (extracted-list 
	  (extract-types msg))
	 )
    (format t "File path = ~s~%" msg)
    (dolist (each-obj-type extracted-list)
      (send-to-socket 
       (concatenate 
	   'string 
	 (string each-obj-type) 
	 " "))
      )
    (send-to-socket "end ")
;    (send-to-socket "end** ")
    )
  (setf *last-line-from-socket* nil)
  (mp::process-sleep 3)
;  (kill-socket-server *obj-command-server*)
  )

;;; This version creates the object list so that create-data-file can store
;;; it. This routine takes the place of send-obj-strings which uses sockets.
;;;
;;; This routine is no longer used. It was creating a list of strings, which is
;;; no longer needed. Use extract-types instead.
(defun generate-obj-list (&optional
			  (msg *domain-file*))
  (format t "File path = ~s~%" msg)
  (let ((alist nil))
    (dolist (each-obj-type (extract-types msg))
      (setf alist
	(cons
	 (concatenate 
	     'string 
	   (string each-obj-type) 
	   " ")
	 alist))
      )
    )
  )



;;;
;;; Example of relevant "next" variable: 
;;; (ptype-of OBJECT :top-type)
;;;
;;; This should be implemented as an agent.
;;;
;;; Assumes that types introduced before used.
;;;
;;; Assumes that no object is an intermediate type
;;; For example, given
;;;
;;;  (ptype-of a :top-type)
;;;  (ptype-of b a)
;;;
;;; an instantiated object can be of type b, but not of type a. 
;;; NOTE that I actually did this in a few of the domains (the goal-trans
;;; domain?  Which other?)
;;;
(defun extract-types (&optional (domain-file-name *domain-file*))
  (with-open-file
      (domain-file domain-file-name
       :direction :input)
    (do* ((next nil 
		(read domain-file 
		      nil 
		      *end-of-file* 
		      nil)) 
	  (types nil 
		 (if (ptype-list-p next) ;this predicate also assures that next
					 ;is not the eof char
		     (cond  ((eq (third next) 
				 :top-type)
			     (cons (second next) types))
			    ((intermediate-type-p (third next) types)
			     (substitute (second next) (third next) types))
			    (t		;Could exist siblings that are both isa
					;X and not :top-type. On encountering 
					;the first sibling, the sibling will be
					;intermediate-type-p, whereas, 
					;subsequent siblings will be neither 
					;intermediate nor :top-type (and thus 
					;will be here).
			     (cons (second next) types)))
		   types))
	  )
	((eof-p next)
	 (remove-duplicates 
	  types))
      )
    )
  )

;;;
;;; Example PRODIGY statement in domain.lisp
;;; (ptype-of new-type old-type)
;;; 
;;; Predicate intermediate-type-p returns true only if the parent (old-type) of
;;; the new type is already in the type-list
;;;

(defun intermediate-type-p (old-type type-list)
  (if (member old-type type-list :test #'eql)
      t)
  )


;;;
;;; Returns t when the LISP object just read from domain.lisp is of the form 
;;; (ptype-of identifier1 identifier2)
;;;
(defun ptype-list-p (alist)
    (if (and 
	 (consp alist)			;This clause also assures not eof
	 (eql (length alist) 3)
	 (eq (first alist) 
	     'ptype-of))
	t)
    )


(defvar *end-of-file* (gensym)
  "Unique end of file character.")

(defun eof-p (x)
  (eq x *end-of-file*))






(defvar *pred-hier* nil
  "The predicate hierarchy association list of a domain file.")


(defun gtype-list-p (alist)
    (if (and 
	 (consp alist)			;this clause also assures not eof
	 (eql (length alist) 3)
	 (eq (first alist) 
	     'gtype-of))
	t)
    )

(defun get-gchildren-from (node)
  (rest
   (assoc node
	  *pred-hier*))
  )



(DEFUN CREATE-PRED-A-LIST (&OPTIONAL
			   (DOMAIN-F-NAME *DOMAIN-FILE*))
  (SETF *PRED-HIER* NIL)
  (WITH-OPEN-FILE
      (DOMAIN-FILE DOMAIN-F-NAME
       :DIRECTION :INPUT)
    (DO ((NEXT NIL 
	       (READ DOMAIN-FILE 
		     NIL 
		     *END-OF-FILE* 
		     NIL)))
	((EOF-P NEXT)
	 NIL)
      (IF (GTYPE-LIST-P NEXT)		;THIS PREDICATE ALSO ASSURES THAT NEXT
					;IS NOT THE EOF CHAR
	  (SETF *PRED-HIER*
	    (ACONS (THIRD NEXT)
		   (CONS (SECOND NEXT) 
			 (GET-GCHILDREN-FROM
			   (THIRD NEXT)))
		   *PRED-HIER*)))
      )
    )
  *PRED-HIER*
  )



(defun create-type-tree (&optional 
			 is-predicate-not-arg-p
			 (root ':top-type)
			 (children
			  (get-children-from 
			   root
			   is-predicate-not-arg-p)))
  (cond ((null children)
	 root
	 )
	(t
	 (cons root
	       (create-branches
		children
		is-predicate-not-arg-p))))
  )




(defun create-branches (children 
			&optional 
			is-predicate-not-arg-p)
  (mapcar #'create-type-tree
	  (make-list 
	   (length children) 
	   :initial-element
	   is-predicate-not-arg-p)
	  children)
  )

(defun find-subtree-for (my-type 
			 &optional
			 is-predicate-not-arg-p
			 (trees 
			  (list 
			   (create-type-tree 
			    is-predicate-not-arg-p))) ; nil by default
			 &aux
			 (current-tree (first trees)))
  (cond ((null trees)
	 nil)
	((null current-tree)
	 (find-subtree-for
	  my-type
	  is-predicate-not-arg-p
	  (rest trees)))
	((atom current-tree)
	 (if (eql my-type current-tree)
	     (list my-type)
	   (find-subtree-for 
	    my-type
	    is-predicate-not-arg-p
	    (rest trees))))
	((eql my-type (first current-tree))
	 current-tree)
	(t
	 (find-subtree-for
	  my-type
	  is-predicate-not-arg-p
	  (append
	   (rest current-tree)
	   (rest trees)))))
  )
  

;;; 
;;; 
;;; 
(defun goal->goal-with-tree-args (goal
				  &aux
				  (trees
				   (list 
				    (create-type-tree 
				     nil))))
  (cons 
   (or 
    (find-subtree-for 
     (first goal) 
     ;; t specifies that the call is for a predicate rather than an arg and we
     ;; do not pass the trees. The function will calculate that itself.
     t ) 
    (list (first goal)))
   (calc-tree-args
    (rest goal)
    trees))
  )


;;; 
;;; Function calc-tree-args is used by function goal->goal-with-tree-args to
;;; calculate the type trees for the arguments of a goal. Given a list of
;;; arguments, it calls find-subtree-for for the first argument to produce a
;;; type tree. It then cons that tree on the front of a list produced by
;;; recursively calling itself on the rest of the arguments.
;;; 
(defun calc-tree-args (args trees)
  (cond ((null args)
	 nil)
	(t
	 (cons
	  (find-subtree-for
	   (first args)
	   nil
	   trees)
	  (calc-tree-args
	   (rest args)
	   trees))))
  )

;;; 
;;; The main fuinction to call to create the info that GTrans will receive
;;; during a TREE-GOAL-REQUEST
;;; 
(defun generate-all-tree-goals (&aux 
				return-list)
  (dolist (each-op (append 
		    (gen-inf-rule-list)
		    (gen-op-list)))
    (setf return-list
      (append (create-goal-list-of-op
	       (get-goals each-op)
	       (get-vars each-op))
	      return-list)))
  (remove-duplicates
   (mapcar
    #'goal->goal-with-tree-args
    return-list)
   :test
   #'equal)
  )


(defun gen-inf-rule-list (&optional 
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
			    (eq 'INFERENCE-RULE
				(first next)))
			   (cons next op-list)
			 op-list))
	  )
	((eof-p next)
	 op-list)
      )
    )
  )


;;; See /usr/local/users/mcox/Research/ABMIC/Chen/pdl-extension.lisp instead
;;; for macro gtype-of. [cox 27mar01]

#|
(defmacro gtype-of (new-type-name old-type-name)
  (declare (special *current-problem-space*))
  "SUBTYPE-OF Generates a new type called NEW-TYPE-NAME which is a child of
OLD-TYPE-NAME."
  `(cond ((and (not (eq :top-type ',old-type-name))
	       (not (super-type ',old-type-name *current-problem-space*)))
	  (error "~S is not a type in problem space ~S.~%" ',old-type-name
	   (problem-space-name *current-problem-space*)))
         ((and (is-type-p ',new-type-name *current-problem-space*)
	  (not (eq (super-type ',new-type-name *current-problem-space*)
		   ',old-type-name)))
	  (error "~S already has parent ~S.~%" ',new-type-name
	         (super-type ',new-type-name *current-problem-space* )))
         ((and (is-type-p ',new-type-name *current-problem-space*)
	   (eq (super-type ',new-type-name *current-problem-space*)
		   ',old-type-name))
	  nil) ;; Type already defined so not doing anything
         (t
	  (create-type ',new-type-name ',old-type-name *current-problem-space*))))





(defun create-type (new-type-name old-type-name p-space)
  (let* ((parent-type (type-name-to-type old-type-name p-space))
	 (type (make-type :super parent-type
			  :infinitep nil
			  :name new-type-name
			  :all-parents (cons parent-type
					    (type-all-parents parent-type)))))
    (setf (type-name-to-type new-type-name p-space) type)
    (push type (all-subtypes old-type-name p-space))))

|#




