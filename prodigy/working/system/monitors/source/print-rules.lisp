(in-package USER)

;
; Functions to turn a list of literals, in either (pred args) or #<> format
; into one consistent form.
;

(defvar *loaded-print-rules* t)

;;; **************************************************************************
;; turn one literal from #<> into (pred args) format
;;; **************************************************************************
(defun create-literal-list (literal)
  (declare (type literal p4::literal))
  (cons (p4::literal-name literal)
	(map 'list  #'(lambda (val)
			(if (or (numberp val)(symbolp val))
			    val 
			    (p4::prodigy-object-name val)))
	     (p4::literal-arguments literal))))


;;; **************************************************************************
;; Make list into (pred args) format
;;; **************************************************************************
(defun format-literals-to-list (exp)
  (declare (list exp))
  (cond
    ( (null exp)
     nil)

					;single #<>
    ( (p4::literal-p exp)
     (create-literal-list exp))

					;(  (...)  )
    ( (and (listp (car exp))
	   (eq 1 (length exp)))
     (list (format-literals-to-list (car exp)) ))


					;(and anything)
    ( (eq 'and (car exp))
     (cons 'and (format-literals-to-list (cdr exp))) )

					;(or anything)
    ( (eq 'or (car exp))
     (cons 'or (format-literals-to-list (cdr exp))) )

					;single (~ #<>)
    ( (and (eq '~ (car exp)) (p4::literal-p (second exp)))
     (list '~ (create-literal-list (second exp))) )

					;single (pred args)
    ( (and (listp exp) (symbolp (car exp)))
     exp )

					;single (~ (pred args))
    ( (and (eq '~ (car exp)) (listp (second exp)) (symbolp (car (second exp))))
     exp )
    ( t
     (append (list (format-literals-to-list (car exp)))
	     (format-literals-to-list (cdr exp))))
    ))



;;; **************************************************************************
;
; Create a list (op val val val) from an instantiated operator
;
;;; **************************************************************************
(defun create-op-list (instantiated-op)
  (declare (type instantiated-op p4::instantiated-op))
  (cons (p4::operator-name (p4::instantiated-op-op instantiated-op))
	(mapcar #'(lambda (val)
		    (if (or (numberp val)(symbolp val))
			val 
			(p4::prodigy-object-name val)))
		(p4::instantiated-op-values instantiated-op))))



;;; **************************************************************************
;
;given exp, create mirror list with truth values from the given state.
;e.g.  (and a b (or c d)) ==> (and 1 nil (or 1 1))
;; works with #<> literals, and (p4::give-me-nice-state) from
;;
;;state-at-node in
;;(load "/afs/cs/user/rudis/prodigy/working/system/planner/state-manipulate.lisp")
;
;;; **************************************************************************
(defun create-state-p-mirror (exp state)
  (cond
    ( (null exp)
           nil)

    ;single #<>
    ( (p4::literal-p exp)
         (if (find exp state :test #'equalp)
	     (list t)
	     (list nil)) )

    ;(  (...)  )
    ( (and (listp (car exp))
	   (eq 1 (length exp)))
           (create-state-p-mirror (car exp) state) )

    ;single (~ #<>)
    ( (and (eq '~ (car exp)) (p4::literal-p (second exp)))
           (if (not (find (second exp) state :test #'equalp))
	       (list t)
	       (list nil)) )

    ;(AND anything)
    ( (eq 'and (car exp))
           (list (cons 'and (create-state-p-mirror (cdr exp) state)) ))

    ;(or anything)
    ( (eq 'or (car exp))
           (list (cons 'or (create-state-p-mirror (cdr exp) state)) ))

    (t
           (append (create-state-p-mirror (car exp) state)
                   (create-state-p-mirror (cdr exp) state)) )
  )
)

;;; **************************************************************************
;given exp, create list of literals that satisfy it
;e.g.  (and a b (or c d)) ==> (a b d)
;;; **************************************************************************
(defun create-satisfy-list (exp state)
  (cond
    ( (null exp)
           nil)

    ;(  (...)  )
    ( (and (eq 1 (length exp)) (listp (car exp)))
           (create-satisfy-list (car exp) state) )

    ;single #<>
    ( (p4::literal-p exp)
         (if (find exp state :test #'equalp)
	     (list exp)))

    ;single (~ #<>)
    ( (and (eq '~ (car exp)) (p4::literal-p (second exp)))
           (if (not (find (second exp) state :test #'equalp))
	       (list exp)))
    
    ;(AND anything)
    ( (eq 'and (car exp))
           (create-satisfy-list (cdr exp) state)) 

    ;(or anything)
    ( (eq 'or (car exp))
           (if (and (boundp 'user::*short-circuit-preconditions*)
		    (eq user::*short-circuit-preconditions* nil))
	       ;non-short-circuited
	       (create-satisfy-list (cdr exp) state)
	       
	       ;short-circuited
	       (do* ( (terms (cdr exp))
		      (term  (car terms)
			     (car (setf terms (cdr terms))))
		      (result    nil))
		    (result     ; when result non-nil, exit loop
		     result)    ; return value

		 (setf result
                       (create-satisfy-list term state))))
    )

    (t     (append (create-satisfy-list (car exp) state)
                   (create-satisfy-list (cdr exp) state)) )
  )
)

;;; **************************************************************************
;;return a list of preconditions, as literals (#<>), INCLUDING the static ones.
;;modified heavily from alicia's code
;;; **************************************************************************

(defun process-all-precond-list (exp instop)
  (declare (list exp))
  (cond
    ((null exp)
     nil)

    ;#<>
    ((p4::literal-p exp)
     (list exp))

    ;(#<>...)
    ((p4::literal-p (car exp))
     (cons (car exp) (process-all-precond-list (cdr exp) instop)))

    ;;e.g. ((and ...)) -- must check if list because of (arm-empty)
    ((and (eq 1 (length exp)) (listp (car exp)))
     (process-all-precond-list (car exp) instop))


    ;(and ...)
    ((eq 'and (car exp))
     (process-all-precond-list (cdr exp) instop))

    ;(or ... )
    ((eq 'user::or (car exp))
     (list (cons 'or (process-all-precond-list (cdr exp) instop))))

    ;(exists ...)
    ;   Note: can be calculated in same way as forall, but it's ORd
    ((eq 'user::exists (car exp))
     (let ((result (process-forall-precond exp instop)))
       (if (eq 1 (length result))
           (car result)
           (list (cons 'or result)))))

    ;(forall ...)
            ;?adding 'and' because of (or (forall X) C) ==> (or (and A B) C).
            ;?(list (cons 'and (process-forall-precond exp instop)))
            ;?means will get (and (forall X) C) ==> (and (and A B) C).
    ;; note forall may not work quite right... the instop-values might
    ;; not be right (which isn't my fault), so then this won't work.
    ((eq 'user::forall (car exp))
     (process-forall-precond exp instop))

    ;(~ #<>)
    ((and (eq 'user::~ (car exp)) (p4::literal-p (second exp)))
     (list exp))

    ;(~ (and ...))
    ((and (eq 'user::~ (car exp)) (eq 'user::and (car (second exp))))
     (demorgan (list '~ (process-all-precond-list (second exp) instop))))

    ;(~ (or ...))
    ((and (eq 'user::~ (car exp)) (eq 'user::or (car (second exp))))
     (demorgan (list '~ (process-all-precond-list (second exp) instop))))

    ;(~ (forall...))
    ((and (eq 'user::~ (car exp)) (eq 'user::forall (car (second exp))))
     (setf exp (list 'exists
                     (second (second exp))
                     (demorgan (list '~ (third (second exp))))))
     (process-all-precond-list exp instop))

    ;(~ (exists ...))
    ((and (eq 'user::~ (car exp)) (eq 'user::exists (car (second exp))))
     (setf exp (list 'forall
                     (second (second exp))
                     (demorgan (list '~ (third (second exp))))))
     (process-all-precond-list exp instop))
    
    ;(~ (~ ...))
    ((and   (eq 'user::~ (car exp))
            (listp (second exp))
            (eq 'user::~ (car (second exp))))
         (error "Doubly negated preconds. Please simplify"))
    
    ;(~ (pred args))
    ((and   (eq 'user::~ (car exp))
            (listp (second exp))
            (symbolp (car (second exp))))
         (list (list '~ (p4::instantiate-consed-literal (second exp)))))
    
    ;(pred args)
    ;must come last, since (car exp) can't be special
    ((and (listp exp) (symbolp (car exp)))
     (list (p4::instantiate-consed-literal exp)))
    
    ((listp (car exp))
     (append (process-all-precond-list (car exp) instop)
         (process-all-precond-list (cdr exp) instop)))

    (t (error "Preconds too complicated"))
))

;;; **************************************************************************
; To check if every variable in exists or forall is instantiated.
;;; **************************************************************************
(defun fully-instantiated (instantiation-list)
  (let ((result t))
    (dolist (x instantiation-list)
      (if (not (eq (type-of (car x)) 'p4::prodigy-object))
          (setf result nil)))
    result))

;;; **************************************************************************
;;When the precond is a forall, it is stored as such in the
;;instantiated-op-precond and binding-node-instantiated-preconds.
;;Can't use old-get-forall-goals because it checks the state.
;;; **************************************************************************
(defun process-forall-precond (expr instop)
  ;;exp is of the form (forall ((<var> typespec)) precond-exp)
  ;;builds a precond list from the body with all possible bindings for
  ;;the quantified variables. 
  ;;assoc finds quantifier generator for this forall (there may be
  ;;several foralls in the operator) and then funcall gets all
  ;;the possible bindings for each the vars

  (if (and (listp (third expr)) (eq 'user::~ (car (third expr))))
      (setf (second (third expr))
            (p4::substitute-binding
             (second (third expr))
             (mapcar
              #'(lambda (varspec val)
                  (cons (first varspec) val))
              (second (p4::rule-precond-exp (p4::instantiated-op-op instop)))
              (p4::instantiated-op-values instop))))

      (setf (third expr)
            (p4::substitute-binding
             (third expr)
             (mapcar
              #'(lambda (varspec val)
                  (cons (first varspec) val))
              (second (p4::rule-precond-exp (p4::instantiated-op-op instop)))
              (p4::instantiated-op-values instop))))
  )
                
  ; CHANGE, to deal with
  ;        (EXISTS ((#<P-O: A object> OBJECT)) (~ (HOLDING #<P-O: A object>)))
  (if (fully-instantiated (second expr))
      (list (process-all-precond-list (third expr) instop))
      (do* (  (gen (cdr (assoc (second expr)
                               (getf (p4::rule-plist
                                                (p4::instantiated-op-op instop))
				     :quantifier-generators)
			       :test #'equalp))) ;CHANGE
              (data   (if gen (funcall gen nil)))
              (choice (make-list (length data) :initial-element 0)
                      (p4::increment-choice choice data))
              (forall-bindings (p4::choice-bindings expr data choice)
                               (p4::choice-bindings expr data choice))
              result)
           ((null choice) result)
        (setf result
           (if (eq 'user::~ (car (third expr)))
               (nconc (process-all-precond-list
                       (list 'user::~
                             (p4::substitute-binding (second (third expr))
                                                     forall-bindings))
                       instop)
                      result)
;CHANGE : don't need (list (process...)) because  it returns a list.
               (nconc (process-all-precond-list
                       (p4::substitute-binding (third expr) forall-bindings)
                       instop)
                      result)
               ))
        ))
  )


;;; **************************************************************************
;;to spread (~ exp) into expression
;;for particular use if ((~exists)/(~forall) complicated-expression)
;;; **************************************************************************
(defun demorgan (exp)
  (if (not (eq '~ (car exp)))
      (error "DeMorgan formula doesn't start with ~"))
  (if (p4::literal-p (second exp))
      exp
      (let ( (return-list nil)
             (exp-2 (second exp)) )
        (if (not (special-list exp-2))
            (setf return-list (append return-list (list '~ (second exp))))
            (dolist (term exp-2)
              (cond
                ((p4::literal-p term)
                 (setf return-list (append return-list (list '~ term))))

                ((eq 'and term)
                 (setf return-list (append return-list (list 'or))))

                ((eq 'or term)
                 (setf return-list (append return-list (list 'and))))

                ((eq 'forall term)
                 (error "DeMorgan expression too complicated"))
                ((eq 'exists term)
                 (error "DeMorgan expression too complicated"))

                ;(~ (or/and/....)) OR (~ (pred args))
                ((and (eq (type-of term) 'cons) (eq '~ (car term)))
                 (setf return-list (append return-list (list (second term)))))

                ;(or/and/...)
                ((and (eq (type-of term) 'cons))
                 (setf return-list
                       (append return-list (list (demorgan (list '~ term))))))

                (t (setf return-list
                         (append return-list (list '~ term)))))))
        return-list)))

;;; **************************************************************************
;;determines if 1st element in list has special word
;;; **************************************************************************
(defun special-list (list)
  (member (car list) '(and or forall exists ~)))

