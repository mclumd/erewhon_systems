(defun goal-from-literal (literal)
  (cons (p4::literal-name literal)
	(list-args-names
	 (sv-to-list (p4::literal-arguments literal)))))

;; same function as goal-from-literal?
(defun get-visible-goal (literal)
  (let* ((lit-name (p4::literal-name literal))
	 (lit-args-list (sv-to-list (p4::literal-arguments literal)))
	 (visible-goal (list lit-name)))
    (dolist (arg lit-args-list)
      (if (p4::prodigy-object-p arg)
	  (push (p4::prodigy-object-name arg) visible-goal)
	  (push arg visible-goal)))
    (reverse visible-goal)))

(defun sv-to-list (vector)
  ;;converts a simple vector into a list
  (declare (type vector simple-vector))
  (do ((index 0 (+ 1 index))
       (list nil (append list (list(svref vector index)))))
      ((= index (array-dimension vector 0) ) list)))

(defun list-args-names (objects)
  (mapcar #'(lambda (obj)
	      (cond ((p4::prodigy-object-p obj)
		     (p4::prodigy-object-name obj))
		    (t obj)))
	  objects))

#|
(defun list-args-names (prodigy-objects)
  (map 'list #'p4::prodigy-object-name prodigy-objects))
|#

(defun show-visible-state ()
  (let ((state (show-state))
	(visible-state nil))
    (dolist (lit state)
      (push (get-visible-goal lit) visible-state))
    visible-state))

(defun get-visible-inst-op (instop)
  (cons (p4::operator-name (p4::instantiated-op-op instop))
	(list-args-names (p4::instantiated-op-values instop))))

(defun visible-inst-op-applicable-p (visible-inst-op)
  (member visible-inst-op
	  *current-applicable-ops*
	  :test
	  #'(lambda (opa inst-opb)
	      (equal opa (get-visible-inst-op inst-opb)))))

;;;*****************************************************************
;;; This function gets the type name of an object given its name.
;;; In the blocksworld (get-type-of-object 'a) returns object.

(defun get-type-of-object (obj)
  (if (p4::object-name-to-object obj *current-problem-space*)
      (p4::type-name
       (p4::prodigy-object-type
	(p4::object-name-to-object obj *current-problem-space*)))
      nil))

;;;*****************************************************************
;;; This function gets the goals or the state as a list of literals
;;; without ands and state or goals...
;;; It applies to a list of format (state (and (ble) (blo))) returning
;;; ((ble) (blo)) or (goal (bla)) returning ((bla))
;;; It will just ignore "state" and "goal" so it could also be anything
;;; different, such as (bla (and (blo) (ble))) returning ((blo) (ble))

(defun get-lits-no-and (messy-rep)
  (let ((lits (cdr messy-rep)))
    (if (eq (caar lits) 'and)
	(setf lits (cdr (car lits))))
    lits))

;;; ***********************************************************
;;; Following the subgoaling structure up to top-level goals
;;; (see page 51 yellow research note book)
;;; top-level goals are returned as a list of LITERAL structures
;;; ***********************************************************
#|
(defun literal-to-top-level-goals (literal)
  (let ((intro-inst-ops (p4::literal-goal-p literal)))
    (cond
      ((and (= (length intro-inst-ops) 1)
	    (eq (p4::operator-node-name
		 (p4::instantiated-op-op
		  (car intro-inst-ops)))
		'p4::*finish*)
	    (list literal)))
      (t 
       (map 'list
	    #'binding-node-to-top-level-goals
	    (map 'list
		 #'p4::instantiated-op-binding-node-back-pointer
		 (p4::literal-goal-p literal)))))))
|#

(defun binding-node-to-top-level-goals (binding-node)
  (operator-node-to-top-level-goals
   (p4::binding-node-parent binding-node)))

(defun operator-node-to-top-level-goals (operator-node)
  (goal-node-to-top-level-goals
   (p4::operator-node-parent operator-node)))

(defun goal-node-to-top-level-goals (goal-node)
  (let ((intro-binding-nodes
	 (p4::goal-node-introducing-operators goal-node)))
    (cond
      ((= 1 (length intro-binding-nodes))
       (if (eq (p4::operator-node-name
		(p4::instantiated-op-op
		 (p4::binding-node-instantiated-op
		  (car intro-binding-nodes))))
	       'p4::*finish*)
	   (p4::goal-node-goal goal-node)
	   (binding-node-to-top-level-goals (car intro-binding-nodes))))
      (t 
       (map 'list
	    #'binding-node-to-top-level-goals
	    intro-binding-nodes)))))

(defun applied-op-node-to-top-level-goals (applied-op-node)
  (inst-op-to-top-level-goals 
   (p4::applied-op-node-instantiated-op applied-op-node)))

(defun inst-op-to-top-level-goals (inst-op)
  (let ((res (binding-node-to-top-level-goals
	      (p4::instantiated-op-binding-node-back-pointer
	       inst-op))))
    (if (listp res) res (list res))))

;;;***********************************************************

	
(defun literal-to-top-level-goals (literal)
  (let ((result nil)
	(top-level-goals (nested-literal-to-top-level-goals literal)))
    (flatten-literals top-level-goals))
)


(defun flatten-literals (litlist)
  (cond	((typep litlist 'p4::literal)
	 (list litlist))
	((null litlist)
	 nil)
	((and (listp litlist)
	      (member (car litlist) '(~ not)))
	 (list litlist))
	((listp litlist)
	 (append (flatten-literals (car litlist))
		 (flatten-literals (cdr litlist))))
	(t
	 (format t  "~%Something strange: ~S" litlist))))


;; this will return something horribly nested occasionally.
(defun nested-literal-to-top-level-goals (literal)
  (let ((intro-inst-ops (p4::literal-goal-p literal)))
    (cond
      ((and (= (length intro-inst-ops) 1)
	    (eq (p4::operator-node-name
		 (p4::instantiated-op-op
		  (car intro-inst-ops)))
		'p4::*finish*)
	    (list literal)))
      (t
       (mapcar
	    #'binding-node-to-top-level-goals
	    (mapcar
		 #'p4::instantiated-op-binding-node-back-pointer
		 (p4::literal-goal-p literal)))))))

;;;***********************************************************
;;; This function gets a visible instantiated op,
;;; such as (move-rocket loca locb), and returns the 
;;; corresponding instantiated-op structure. Searches 
;;; in the list of *current-applicable-ops*.

(defun get-current-applicable-inst-op (visible-inst-op)
  (find visible-inst-op *current-applicable-ops*
	:test #'(lambda (x y)
		  (equal x (get-visible-inst-op y)))))

;;;***********************************************************

(defun goal-to-vlist (goal)
;;converts a goal in a l-literal form, but with prodigy-object arguments
  (let ((vliteral (cons (p4::literal-name goal)
			(sv-to-list (p4::literal-arguments goal)))))
  (if (p4::literal-neg-goal-p goal)
      (list '~ vliteral)
      vliteral)))

;;;***********************************************************

(defun equal-literals-p (literalx literaly)
  (equal (goal-from-literal literalx)
	 (goal-from-literal literaly)))

(defun equal-literal-goal-p (literalx goaly)
  (equal (goal-from-literal literalx) goaly))

(defun equal-instantiated-ops-p (inst-opx inst-opy)
  (and (equal (p4::operator-name (p4::instantiated-op-op inst-opx))
	      (p4::operator-name (p4::instantiated-op-op inst-opy)))
       (same-values-p (p4::instantiated-op-values inst-opx)
		      (p4::instantiated-op-values inst-opy))))

;;; list-values-x and list-values-y are lists of elements of type prodigy-object.
(defun same-values-p (list-values-x list-values-y)
  (cond
    ((null list-values-x) t)
    ((equal (car list-values-x)
	    (car list-values-y))
     (same-values-p (cdr list-values-y) (cdr list-values-y)))
     ((equal (p4::prodigy-object-name (car list-values-x))
 	    (p4::prodigy-object-name (car list-values-y)))
      (same-values-p (cdr list-values-x) (cdr list-values-y)))
    (t nil)))

;;;***********************************************************
(defvar *class-short-names* nil)

(defun set-class-short-names ()
  (let ((types (mapcar #'p4::type-name
                       (all-types (p4::type-name-to-type
                                         ':top-type
                                         *current-problem-space*)))))
    (setf *class-short-names*
          (mapcar #'(lambda (type)
                      (cons type type))
                  types))))

(defun get-subtypes (type)
  (if (p4::type-sub type)
      (p4::all-subtypes (p4::type-name type)
                        *current-problem-space*)
      nil))

(defun all-types (type)
  (let* ((types (get-subtypes type))
         (child-types (mapcan #'all-types types)))
    (append types child-types)))

