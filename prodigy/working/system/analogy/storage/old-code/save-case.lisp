
(defvar *vars-not-to-use* nil)
(defvar insts-to-vars nil)

;;; Manuela -- based on Karen's Version 2.0
;;; Manuela -- fixed the storage of an applied-op-node
;;; to include the list of effects.
;;; Manuela -- stored now the application op
;;;         -- stores more data: result, initial state, goal
;;;         -- does footprint by goal
;;;         -- stores correspondence variables to instances
;;;            using *class-short-names* for the name of variables.
;;;         -- write of failed cases
;;;         -- writes in case-header
;;;         -- changed a lot: no build-tree or generate-additional-objects

(defun store-result (ofile result)
  (format ofile "~%   (time ~S)" (prodigy-result-time result))
  (format ofile "~%   (nodes ~S)" (prodigy-result-nodes result))
  (format ofile "~%   (exhaustedp ~S)" (prodigy-result-whole-tree-expanded-p result))
  (format ofile "~%   (solutionp ~S)" (prodigy-result-solutionp result))
  (format ofile "~%   (solution-length ~S)" (length (prodigy-result-solution result)))
  (format ofile "~%   (solution ")
  (if (prodigy-result-solutionp result)
      (store-solution ofile (p4::path-from-root
			     (cdr (prodigy-result-interrupt result)))))
  (format ofile ")"))

(defun store-solution (ofile solution-path)
  (let* ((plan (mapcan
		#'(lambda (node)
		    (if (p4::a-or-b-node-p node)
			(nreverse (mapcar #'p4::op-application-instantiated-op
					  (p4::a-or-b-node-applied node)))))
		solution-path)))
    (format ofile "~S" (mapcar #'get-visible-inst-op plan))))

(defun store-state-goal (ofile lits)
  (cond
    ((null lits) nil)
    ((and (= (length lits) 1)
	  (eq (caar lits) 'and))
     (store-state-goal ofile (cdar lits)))
    (t
     (format ofile "~S" lits))))

(defun assign-store-vars (ofile objects)
  (cond
    ((null objects) nil)
    ((eq (caar objects) 'objects-are)
     (assign-store-vars ofile (append (list (cdar objects)) (cdr objects))))
    (t
     (let* ((elt-class (car (last (car objects))))
	    (objs (butlast (car objects)))
	    (short-name (cdr (assoc elt-class *class-short-names*))))
       (format ofile "~%   ")
       (setf *vars-not-to-use* nil)
       (dolist (obj objs)
	 (let* ((var-number (get-var-number))
		(var-name
		 (read-from-string (format nil "<~S~S>" short-name var-number))))
	   (format ofile "~S " (cons obj var-name))
    	   (setf insts-to-vars (cons (cons obj var-name)
				       insts-to-vars)))))
     (assign-store-vars ofile (cdr objects)))))

(defun get-var-number ()
  (let ((numb (random 100)))
    (if (member numb *vars-not-to-use*)
	(get-var-number)
	(push numb *vars-not-to-use*))
    numb))
	  
(defun print-solution (ofile solution-path)
  (let* ((plan (mapcan
                  #'(lambda (node)
                      (if (p4::a-or-b-node-p node)
                          (nreverse (mapcar #'p4::op-application-instantiated-op
                                            (p4::a-or-b-node-applied node)))))
                  solution-path))
         (op nil) (vars nil) (vals nil)
         )
    (format ofile "~%;Solution:")
    (dolist (instop  plan)
      (setf op (p4::instantiated-op-op instop))
      (setf vars (p4::rule-vars op))
      (setf vals (p4::instantiated-op-values instop))
      (format ofile "~%;        <~S" (p4::operator-name op)  )
      (dolist (arg (cdr (p4::rule-params op)))
        (let ((value (elt vals (position arg vars))))
          (format ofile " ")
          (if (listp value)
              (format ofile "~S" arg)
              (if (p4::prodigy-object-p value)
                  (format ofile "~S" (p4::prodigy-object-name value))
                  (format ofile "~S" value)))))
      (format ofile ">"))
    (format ofile
            "~%;~%; Total of ~S nodes expanded~%;~%"
            (p4::nexus-name (car (last solution-path))))))

(defun write-to-file
    (prodigy-result objects
		    &key (case-name (concatenate 'string 
						     "case-"
						     (string-downcase
						      (symbol-name
						       (p4::problem-name
							(current-problem))))))
		    (failed nil))
  (write-case-header-to-file prodigy-result objects case-name failed)
  (unless failed 
    (let ((filename (concatenate 'string *problem-path*
				 "probs/cases/" case-name ".lisp"))
	  (solution-path
	   (p4::path-from-root
	    (cdr (prodigy-result-interrupt prodigy-result)))))
      (with-open-file (ofile filename :direction :output
			     :if-exists :rename-and-delete
			     :if-does-not-exist :create)
	(setf *print-case* :downcase)
	(when (and (problem-space-property :*output-level*)
		   (>= (problem-space-property :*output-level*) 2))
	  (format t "~% Storing case in file:")
	  (format t "~% ~S" filename))
	;;(format ofile "~%(defun build-tree ()")
	;;(format ofile "~%(if (null (p4::get-operator p4::*finish*))")
	;;(format ofile "~%    (p4::load-problem (current-problem)))") 
	;; puts *finish* into list
	;;(format ofile "~%(defvar p4::*node-counter*)")
	;;(format ofile "~%(proclaim '(fixnum p4::*node-counter*))")
	;;(format ofile "~%(setf p4::*node-counter* 0)")
	;;(format ofile "~%(generate-additional-objects (quote ~S))" objects)
	;;(format ofile "~%(setf case-objs (quote ~S))" objects)
	;;(format ofile "~%(p4::top-nodes 0) ~%")
	(list-down (find-node 3) (cdr (cdr (cdr solution-path))) ofile)
	;;(format ofile "~%(setf *old-case-root* (find-node 1))")
	;;(format ofile "~%)~%~%")
	;;(format ofile "(defun reinitialize-my-ptrs ()
        ;;(setf *old-case-ptr* *old-case-root*)
        ;;(setf *old-case-ptr* (car (p4::nexus-children *old-case-ptr*)))
        ;;(setf *old-case-ptr* (car (p4::nexus-children *old-case-ptr*))))
        ;;~%")
	(format t "~% Done with storing case.")))))

(defun write-case-header-to-file
    (prodigy-result objects
		   &optional (case-name (concatenate
					 'string "case-"
					 (string-downcase
					  (symbol-name
					   (p4::problem-name (current-problem))))))
		   (failed nil))
  (let ((filename (concatenate 'string *problem-path*
			       "probs/cases/headers/" case-name ".lisp")))
    (with-open-file (ofile filename :direction :output
			   :if-exists :rename-and-delete
			   :if-does-not-exist :create)
      (when (and (problem-space-property :*output-level*)
		 (>= (problem-space-property :*output-level*) 2))
	(if failed
	    (format t "~% Storing case header -- failed -- in file:")
	  (format t "~% Storing case header -- success -- in file:"))
	(format t "~% ~S" filename))
      (format ofile "~%(setf result '(")
      (store-result ofile *prodigy-result*)
      (format ofile "))~%")
      (format ofile "~%(setf goal '")
      (store-state-goal ofile (cdr (p4::problem-goal (current-problem))))
      (format ofile ")")
      (format ofile "~%(setf initial-state '")
      (store-state-goal ofile (cdr (p4::problem-state (current-problem))))
      (format ofile ")")
      (format ofile "~%~%(setf case-objects '~S)" objects)
      (format ofile "~%(setf insts-to-vars '(")
      (setf insts-to-vars nil)
      (assign-store-vars ofile objects)
      (format ofile "~%))~%")
      (format ofile "~%(setf footprint-by-goal '(")
      (unless failed
	(let ((solution-path
	       (p4::path-from-root
		(cdr (prodigy-result-interrupt prodigy-result)))))
	  (dolist (term (footprint solution-path t))
	    (format ofile "~%   ~S" term))))
      (format ofile "))~%")
      
      (when (and (problem-space-property :*output-level*)
		 (>= (problem-space-property :*output-level*) 2))
	(format t "~%Done with storing case header.")))))
      
(defun list-down (parent-node node-list ofile)
    (let ( (child-node (car node-list)) )
        (format ofile " ~%(setf (p4::nexus-children (find-node ~S))"
		(p4::nexus-name parent-node))
        (case (type-of child-node)
	  (p4::applied-op-node
                    (store-applied-op-node parent-node child-node ofile))
            (p4::binding-node
                    (store-binding-node    parent-node child-node ofile))
            (p4::operator-node
                    (store-operator-node   parent-node child-node ofile))
            (p4::goal-node
                    (store-goal-node       parent-node child-node ofile))
            (t      (format ofile "~% Unknown")))
        (if (not (null (cdr node-list)))
	    
            (list-down child-node (cdr node-list) ofile))
))

(defun store-applied-op-node (parent-node node ofile)
    (format ofile "~%  (list")
    (format ofile "~%    (p4::make-applied-op-node")
    (format ofile " ~%        :name ~S" (p4::nexus-name node))
    (format ofile " ~%        :parent (find-node ~S)"
                                                (p4::nexus-name parent-node))
    (format ofile ")")
    (format ofile ")) ~%" )

    (store-instantiated-op (p4::nexus-name node)
                           (p4::applied-op-node-instantiated-op node) ofile)
    (store-application (p4::nexus-name node)
		       (car (p4::applied-op-node-applied node)) ofile)
)

;;; Added by me -- only stores one application -- don't want the other ones?...

(defun store-application (node-name op-application ofile)
  (format ofile "~%(setf (p4::a-or-b-node-applied (find-node ~S))"
	  node-name)
  (format ofile "~%      (list (p4::make-op-application")
  (format ofile "~%                :instantiated-op")
  (format ofile "~%                 (p4::applied-op-node-instantiated-op")
  (format ofile "~%                  (find-node ~S))" node-name)
  (when (p4::op-application-delta-adds op-application)
    (format ofile "~%                :delta-adds (list")
    (write-effects (format-literals-to-list
		    (p4::op-application-delta-adds op-application))
		   ofile 17)
    (format ofile ")"))
  (when (p4::op-application-delta-dels op-application)
    (format ofile "~%                :delta-dels (list")
    (write-effects (format-literals-to-list
		    (p4::op-application-delta-dels op-application))
		   ofile 17)
    (format ofile ")"))
  (format ofile ")))~%")
)

(defun write-effects (p-list ofile num-indent)
  (cond
    ((and (eq 1 (length p-list)) (listp (car p-list)))
     (write-effects (car p-list) ofile num-indent))

    ((and (eq 'user::~ (car p-list)) (listp (second p-list))
	  (symbolp (car (second p-list))))
     (print-num-indent-spaces num-indent ofile)
     (format ofile "(list '~~ (p4::instantiate-consed-literal '~S))"
	     (second p-list)))

    ((and (listp p-list) (symbolp (car p-list)))
     (print-num-indent-spaces num-indent ofile)
     (format ofile "(p4::instantiate-consed-literal '~S)" p-list))

    (t
     (write-effects (car p-list) ofile num-indent)
     (write-effects (cdr p-list) ofile num-indent))
    ))


(defun store-operator-node (parent-node node ofile)
    (format ofile "~%  (list")
    (format ofile "~%    (p4::make-operator-node")
    (format ofile " ~%        :name ~S" (p4::nexus-name node))
    (format ofile " ~%        :parent (find-node ~S)"
                                                (p4::nexus-name parent-node))
    (format ofile " ~%        :operator (p4::get-operator ~S)"
                        (p4::operator-name (p4::operator-node-operator node)))
    (format ofile ")))~%")
)

(defun store-binding-node (parent-node node ofile)
    (format ofile "~%  (list")
    (format ofile "~%    (p4::make-binding-node")
    (format ofile " ~%        :name ~S" (p4::nexus-name node))
    (format ofile " ~%        :parent (find-node ~S)"
                                            (p4::nexus-name parent-node))
    (format ofile "~%        :instantiated-preconds ")
    (write-preconds (format-literals-to-list (p4::binding-node-instantiated-preconds node)) ofile 12)
    (format ofile "))) ~%" )
    (store-instantiated-op (p4::nexus-name node)
                           (p4::binding-node-instantiated-op node) ofile)
)

(defun store-goal-node (parent-node node ofile)
    (format ofile "~%  (list")
    (format ofile "~%    (p4::make-goal-node")
    (format ofile " ~%        :name ~S" (p4::nexus-name node))
    (format ofile " ~%        :parent (find-node ~S)"
                                            (p4::nexus-name parent-node))
    (format ofile " ~%        :goal ")
    (write-preconds (format-literals-to-list (p4::goal-node-goal node)) ofile 12)
    
    (if (not (null (p4::goal-node-introducing-operators node)))
      (progn
        (format ofile " ~%        :introducing-operators (list " )
        (scan-list-write-node (p4::goal-node-introducing-operators node) ofile)
        (format ofile ")")
      ))
    (format ofile ")")     ; make-goal-node
    (format ofile ")")     ; list
    (format ofile ") ~%" ) ; setf
    (when (not (null (p4::literal-neg-goal-p (p4::goal-node-goal node))))
      (format ofile "~%(setf (p4::literal-neg-goal-p")
      (format ofile "~%       (p4::goal-node-goal (find-node ~S)" (p4::nexus-name node))
      (format ofile "~%       '~S)))~%"
	      (p4::literal-neg-goal-p (p4::goal-node-goal node))))
)

(defun store-instantiated-op (node-name insop ofile)
  (if (not (null insop))
    (progn
      (format ofile "~%(setf (p4::a-or-b-node-instantiated-op (find-node ~S))"
                                                                    node-name)
      (format ofile "~%      (p4::make-instantiated-op")
      (format ofile "~%          :op (p4::get-operator ~S)" 
                            (p4::operator-name (p4::instantiated-op-op insop)))
      (format ofile "~%          :binding-node-back-pointer (find-node ~S)"
        (p4::nexus-name (p4::instantiated-op-binding-node-back-pointer insop)))
      (if (not (null (p4::instantiated-op-values insop)))
        (progn
          (format ofile "~%          :values (list ")
          (write-ins-op-values (p4::instantiated-op-values insop) ofile)
          (format ofile ")")))
      (format ofile "~%          :precond ")
          (write-preconds (format-literals-to-list
			   (p4::instantiated-op-precond insop))
			  ofile 12)
      (format ofile "))~%"))
))

(defun write-ins-op-values (insopvals ofile)
    (case (type-of  (car insopvals))
        (p4::prodigy-object (format ofile
"~%                    (p4::object-name-to-object '~S *current-problem-space*)"
                                    (p4::prodigy-object-name (car insopvals))))
        (fixnum  (format ofile "~%                    ~S " (car insopvals)))
        (null    (format ofile "~%                    nil"))
    ) 
    (if (not (null (cdr insopvals)))
        (write-ins-op-values (cdr insopvals) ofile))
)

(defun print-num-indent-spaces (num ofile)
  (let ((x nil))
    (format ofile "~%")
    (do ((x 1 (+ x 1)))
	((> x num) nil)
      (format ofile " "))))

(defun write-preconds (p-list ofile num-indent)
  (cond
    ( (and (eq 1 (length p-list)) (listp (car p-list)))
     (write-preconds (car p-list) ofile num-indent))
    
    ( (eq 'user::and (car p-list))
     (print-num-indent-spaces num-indent ofile)
     (format ofile "(list 'and ")
      (write-preconds (cdr p-list) ofile (+ num-indent 2))
      (format ofile ")"))

    ( (eq 'user::or (car p-list))
     (print-num-indent-spaces num-indent ofile)
      (format ofile "(list 'or ")
      (write-preconds (cdr p-list) ofile (+num-indent 2))
      (format ofile ")"))

    ( (eq 'user::forall (car p-list))
     (print-num-indent-spaces num-indent ofile)
      (format ofile "'~S" p-list))

    ((and (eq 'user::~ (car p-list)) (listp (second p-list)) (symbolp (car (second p-list))))
     (print-num-indent-spaces num-indent ofile)
     (format ofile "(list '~~ (p4::instantiate-consed-literal '~S))" (second p-list)))

    ((and (listp p-list) (symbolp (car p-list)))
     (print-num-indent-spaces num-indent ofile)
     (format ofile "(p4::instantiate-consed-literal '~S)" p-list))

    (t
     (write-preconds (car p-list) ofile num-indent)
     (write-preconds (cdr p-list) ofile num-indent))
    ))
		   
      

(defun write-literal (lit &optional (ofile t))
    (format ofile "~S " (p4::literal-name lit))
    (dotimes (argnum (length (p4::literal-arguments lit)))
      (let ((arg (elt (p4::literal-arguments lit) argnum)))
         (format ofile "~S " (p4::prodigy-object-name arg))))
)

(defun scan-list-write-node (node-list ofile)
    (format ofile "(find-node ~S) " (p4::nexus-name (car node-list)))
    (if (not (null (cdr node-list)))
        (scan-list-write-node (cdr node-list) ofile))
)

(defun generate-additional-objects (case-objects)
  (let* ((p-space *current-problem-space*)
	 (new-objects (mapcar #'reverse case-objects)))
    (dolist (type-inst new-objects)
      (let ((inst-type (p4::type-name-to-type (car type-inst) p-space)))
	(dolist (inst (cdr type-inst))
	  (let ((ob (p4::object-name-to-object inst p-space)))
	    (if (not ob)
		(setf user::*case-object-list* 
		      (cons (print (p4::create-object inst inst-type p-space))
			    user::*case-object-list*))
		(setf user::*case-object-list* (adjoin ob user::*case-object-list*))))
			  )))))
