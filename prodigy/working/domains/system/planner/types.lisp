;;; $Revision: 1.5 $
;;; $Date: 1995/04/20 20:11:09 $
;;; $Author: khaigh $
;;;
;;; REVISION HISTORY
;;;
;;;  $Log: types.lisp,v $
;;; Revision 1.5  1995/04/20  20:11:09  khaigh
;;; Added code to allow objects to stay the same between runs.
;;; Based on Alicia's run-same-objects2
;;;
;;; Revision 1.4  1995/03/13  00:39:39  jblythe
;;; General clean-ups, including a definition of gen-from-pred that can have
;;; more than one variable in the literal.
;;;
;;; Revision 1.3  1994/05/30  20:56:36  jblythe
;;; Added Tony Maida's patches to have Prodigy run with CMU Lisp 16 and 17.
;;;
;;; Revision 1.2  1994/05/30  20:30:49  jblythe
;;; Added CVS headers so the revision history and descriptions are included in
;;; each changed file.
;;;


;; This could be better, but let's wait for the new lisp system.
#-CLISP
(unless (find-package "PRODIGY4")
	(make-package "PRODIGY4" :nicknames '("P4") :use '("LISP")))

(in-package  "PRODIGY4")

(export '(ptype-of
	  object-type
	  fobject-type
	  object-is
	  objects-are
	  pinstance-of
	  is-type-p
	  infinite-type
	  child-type-p
	  some-child-type-p
	  type-of-object
	  ))
;; *******************************************************************
;; TYPE-OF Generates a new type called NEW-TYPE-NAME which is a
;; child of OLD-TYPE-NAME.

;; OBJECT-TYPE macro returns the type of the object.  See FOBJECT-TYPE.

;; FOBJECT-TYPE is the functional version of the macro OBJECT-TYPE.

;; OBJECT-IS the basic macro for adding objects as part of the state of a
;; particular problem.

;; OBJECTS-ARE allows multiple objects to be instantiated in one
;; command.  The syntax is (objects-are o1 o2 o3... type)

;; IS-TYPE-P accepts some lisp object and returns t if the object is a
;; symbol with an associated prodigy type.

;; CHILD-TYPE-P accepts two types and returns T if the first type is a
;; child of the second type.
;; *******************************************************************

;; Currently there are a number of restrictions on the type-object
;; hierarchy that are not set in stone but should be understood.

;; Objects may not be instances of more then one type.  This
;; restriction will probably be removed eventually.

;; Types may not be sub-types of more then one type.  It is not clear
;; if this will be removed.

;; You define a type by the form (subtype-of new-type old-type)

;; Types are represented by a structure.  Each type maintains the
;; following information:
;;                         name (a symbol).
;;                         parent (another type).
;;                         sub-types (list of types).
;;                         All of its parents, this duplicates data
;;                             with parent (list of types).
;;                         All the instances of the type (list of
;;                             prodigy objects).
;;                         All the instances of the types and the
;;                             instances of the sub types of the type
;;                             (list of prodigy objects).

;; Since each time has a name it is convenient to assign the type to
;; the symbol as well as include the symbol in the type structure.
;; This value is stored on the plist of the symbol using a value from
;; the problem space as an indicator.  This value can be gotten by
;; using the following macro (problem-space-type P-SPACE).  [See the
;; function type-name-to-type for more info.]  This scheme allows us
;; use the same type name in several different problem spaces.

#+(and allegro (version>= 4 1))
(setf (excl:package-definition-lock (find-package "COMMON-LISP")) nil)

(defstruct (type (:print-function print-type))
           (name nil)
	   (infinitep nil)
	   (super nil)
	   (sub nil)
	   (all-parents nil)
	   (real-instances nil) ; just this type (no children)
	   (instances nil) ; type and children
	   (permanent-instances nil)	; real instances that last forever.
	   (plist nil)
	   )

#+(and allegro (version>= 4 1))
(setf (excl:package-definition-lock (find-package "COMMON-LISP")) t)

(defun type-all-types (type)
  (declare (type type type))
  "Returns a list of the TYPE and all its parents."
  (cons type (type-all-parents type)))
	   
(defun print-type (type stream z)
  (declare (type type type)
	   (stream stream)
	   (ignore z))
  (princ "#<TYPE: " stream)
  (princ (string-downcase (type-name type)) stream)
  (princ ">" stream))

;; Prodigy objects are represented by a structure.  Each prodigy
;; object maintains the following inforamtion:
;;                         The name of the object (symbol)
;;                         Its type.

;; A prodigy object is an instance of a prodigy type.

(defstruct (prodigy-object (:print-function prodigy-object-print))
           (name nil)
           (type nil)
	   (plist nil))

(defun prodigy-object-print (p-o stream z)
  (declare (type prodigy-object p-o)
	   (type stream stream)
	   (ignore z))

  (let ((*standard-output* stream))
    (princ "#<P-O: ")
    (princ (string-upcase (prodigy-object-name p-o)))
    (princ " ")
    (princ (string-downcase (type-name (prodigy-object-type p-o))))
    (princ ">")))



;; The following functions are defined to always accept a symbol for a
;; type and not a type structure.

(defmacro type-name-to-type (type-name p-space)
  "Takes a type-name and returns the associated type structure, if the
type is an infinite type then it returns the lisp predicate that
defines the type."
  `(get ,type-name (problem-space-type ,p-space)))

(defmacro all-subtypes (type-name p-space)
   `(type-sub (get ,type-name (problem-space-type ,p-space))))

(defmacro super-type (type-name p-space)
   `(type-super (get ,type-name (problem-space-type ,p-space))))

(defun remove-types (type-name p-space)
  "This removes the named type all all types below it in the hierarchy."
  (remove-type (type-name-to-type type-name p-space) p-space))

(defun remove-type (type p-space)
  (declare (type type type)
	   (type problem-space p-space))
  (if (null type)
      (error "Cannot remove type ~S.~%" type))
  (map nil #'(lambda (x) (remove-type x p-space)) (type-sub type))
  (remprop (type-name type) (problem-space-type p-space)))

(defun is-type-p (type-thingy p-space)
  "IS-TYPE-P accepts some lisp object and returns t if the object is a
symbol with an associated prodigy type."
  (and (symbolp type-thingy)
       (type-name-to-type type-thingy p-space)))


(defun some-child-type-p (candidate-child parent-seq)
  (declare (type type candidate-child)
	   (type sequence parent-seq))

  (some #'(lambda (x) (child-type-p candidate-child x)) parent-seq))

(defun child-type-p (candidate-child parent)
  "CHILD-TYPE-P returns T if CANDIDATE-CHILD is a proper child of the
type PARENT." 
  (declare (type type candidate-child parent))
  (if (not (and (typep candidate-child 'type)
		(typep parent 'type)))
      (error "One or both of ~S and ~S is not a prodigy type.~%"
	     candidate-child parent))
  (if (and (member parent (type-all-parents candidate-child))
	   (not (eq parent candidate-child)))
      t
    nil))

(defmacro ptype-of (new-type-name old-type-name)
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


(defmacro INFINITE-TYPE (type-name func)
  `(prog nil
      (declare (special *current-problem-space*))
      (pushnew ,func (problem-space-infinite-type-preds *current-problem-space*))
      (create-inf-type ',type-name ,func *current-problem-space*)
      (setf (type-name-to-type ',type-name *current-problem-space*) ,func)))
 
(defun create-inf-type (new-type-name func p-space)
  (let* ((parent-type (type-name-to-type :top-type p-space))
	 (type (make-type :super parent-type
			  :infinitep t
			  :name new-type-name
			  :instances func
			  :all-parents (list parent-type))))
    (setf (type-name-to-type new-type-name p-space) type)
    (push type (all-subtypes :top-type p-space))))

(defun clear-types (super-type p-space)
  "Clear-types takes a list of types and removes them all."
  (dolist (type (all-subtypes super-type p-space))
    (clear-types type p-space)
    (remove-types super-type p-space)))

(defmacro object-is (object-name type-name)
  "OBJECT-IS the basic macro for adding objects as part of the state of a
particular problem."
  (declare (special *current-problem-space*))
  `(let* ((p-space *current-problem-space*) ; the let makes code neater
	  (type (type-name-to-type ',type-name p-space)))
    (declare (type problem-space p-space)
             (type type type))
    (cond ((not (is-type-p ',type-name p-space))
	   (error "Cannot create object with invalid type ~S.~%" ',type-name)))

    (create-object ',object-name type *current-problem-space*)))

(defun fobject-is (object-name type-name)
  "OBJECT-IS the basic macro for adding objects as part of the state of a
particular problem."
  (declare (special *current-problem-space*))
  (let* ((p-space *current-problem-space*) ; the let makes code neater
	  (type (type-name-to-type type-name p-space)))
    (declare (type problem-space p-space)
             (type type type))
    (cond ((not (is-type-p type-name p-space))
	   (error "Cannot create object with invalid type ~S.~%" type-name)))

    (create-object object-name type *current-problem-space*)))

(defmacro object-name-to-object (object-name p-space)
  `(get ,object-name (problem-space-object ,p-space)))

(defmacro OBJECTS-ARE (&rest objects-and-type)
  "OBJECTS-ARE allows multiple objects to be instantiated in one
command.  The syntax is (objects-are o1 o2 o3... type)"
  (let ((type (car (last objects-and-type)))
	(objects (butlast objects-and-type)))

    `(progn
      ,.(mapcar #'(lambda (x) `(object-is ,x ,type)) objects))))

(defmacro pinstance-of (&body spec)
  "Creates objects of type specified by the last argument. This macro
differs from objects-are and object-is in problems in that the objects
here are permanent - they persist through different problems. You
should declare, for example, objects that appear in operators with
this function."
  `(let* ((pspace *current-problem-space*)
	  (typename (car (last ',spec)))
	  (type (type-name-to-type typename pspace))
	  (objects (butlast ',spec)))
    (if (not (is-type-p typename pspace))
	(error "Not a valid type: ~S~%" typename)
	(dolist (object objects)
	  (push (create-object object type pspace)
		(type-permanent-instances type))))))

(defun permanent-object-p (object)
  "Non-nil if this object was declared with pinstance-of."
  (declare (type prodigy-object object))
  (if (member object (type-permanent-instances (prodigy-object-type object)))
      t
      nil))
    
(defun create-object (name type p-space)
  "Create object creates a new prodigy object.  If an object with name
NAME already exists, and has a type different from TYPE an error is
signaled. If an object of the same name and type already exists, it is returned.
This guarantees that every object will have a unique name."

  (let ((ob (find name (type-instances (type-name-to-type :top-type p-space))
		  :key #'prodigy-object-name)))
    (if ob
	(if (not (eq type (prodigy-object-type ob)))
	    (error "The object name ~S is already used by an object in the ~
              system.~%" name)
	    (progn (setf (object-name-to-object name p-space) ob)
		   ob))
	;; Only make a new object if ob was not found of any type.
	(let ((object (make-prodigy-object :name name
					   :type type)))
	  (push object (type-real-instances type))
	  (push object (type-instances type))
	  (setf (object-name-to-object name p-space) object)
	  (dolist (tp (type-all-parents type))
	    (push object (type-instances tp)))
	  object))))


;;; check if obj is of type type.  accept both real prodigy obj/type
;;; and symbols. 
(defun type-of-object (obj type)
  (declare (special *current-problem-space*))
  (let ((real-ob (make-real-object obj *current-problem-space*))
	(real-type (if (typep type 'type)
		       type
		       (type-name-to-type type *current-problem-space*))))
    (if (null real-type)
	(error "~% ~S is not a prodigy type." type)
	(object-type-p real-ob real-type))))

;; It is possible that the disjunct in object type is unnecessary.
;; ALL-PARENTS may include the type itself.
(defun object-type-p (object type)
  (declare (type prodigy-object object)
	   (type type type))
  "Verifies that OBJECT is of a type TYPE or of a childtype of TYPE."
  (if (or (eq (prodigy-object-type object) type)
	  (member type 
		  (type-all-parents (prodigy-object-type object))))
      t
      nil))

(defun make-real-object (thing p-space)
  (declare (type problem-space p-space))
  "Returns thing if thing is a prodigy-object, if not looks for it the
list of all prodigy-objects and returns an object it its there, if not
it checks to see if it is an infinite type and returns it if it is, if
not it generates an error."

  (cond ((typep thing 'prodigy-object)
	 thing)
	((find thing (type-instances (type-name-to-type :TOP-TYPE p-space))
	       :key #'prodigy-object-name
	       :test #'equal))
	((infinite-type-object-p thing p-space)
	 thing)
	((or (eq *incrementally-create-objects* t)
	     (eq *incrementally-create-objects* :warn)
	     (eq *incrementally-create-objects* :silent))
	 (if (not (eq *incrementally-create-objects* :silent))
	     (format t "~%Warning: ~S is not an object in problem space ~S."
		     thing (problem-space-name p-space)))
	 (let* ((objects (problem-objects (current-problem)))
		(type (p4::type-name-to-type
		       (car (mapcan #'(lambda (o)
					(when (member thing o)
					  (last o)))
				    objects))
		       *current-problem-space*)))
	   (create-object thing type p-space)))
	(t (error "~S is not an object in problem space ~S.~%"
		  thing (problem-space-name p-space)))))

;;; Jim 3/8/91: I changed the name of this function to reflect that it
;;; tests objects, not types.
(defun infinite-type-object-p (thing p-space)
  (some #'(lambda (x) (funcall x thing))
	 (problem-space-infinite-type-preds p-space)))


(defun is-infinite-type-p (type-name p-space)
  (let ((ty (is-type-p type-name p-space)))
    (if (member ty (problem-space-infinite-type-preds p-space))
	t)))

(defun has-infinite-types-p (p-space)
  (problem-space-infinite-type-preds p-space))


