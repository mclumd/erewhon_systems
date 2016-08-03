(in-package :user)

 ;;; This file takes the plan from PRODIGY, and creates a normalized output form
;;; for each step in the plan and writes it to disk. The form is a simplified
;;; frame such that it is not recursive (assume that other frames are not
;;; values of attributes (roles).
;;;
;;; Normalized frame form
;;;
;;; (frame 
;;;  (attribute1 val1)
;;;  (attribute2 val2)
;;;  (attribute3 val3)
;;;  ... )
;;;
;;; An example normalized step is as follows:
;;;
;;; (STACK (<OB> BLOCKA) (<UNDEROB> BLOCKB))
;;;
;;; The executive function will (if your code is correct) generate a line for
;;; each plan step as follows:
;;;
;;; (:DATA DEFAULT (STACK (<OB> BLOCKA) (<UNDEROB> BLOCKB)))
;;;
;;; The first line of the file will contain the default style specification
;;; that you create (and place in the parameter *default-style*). This default
;;; should be an identity function that takes the frame and rewrites it as an
;;; exact duplicate of the frame. You also will create a style of your own
;;; choosing that writes the plan step in another format of your choice.
;;;
;;;
;;; Your program will probably (but not necessarily) need to access PRODIGY
;;; structures p4::operator, p4::instantiated-op, p4::prodigy-object. In dir
;;; /public/mcox/prodigy/working/system/planner/, see files load-domain.lisp,
;;; instantiate-op, and types.lisp. To see all of the defstruct definitions in
;;; the main planner, perform the following command in an emacs shell buffer:
;;; grep -i defstruct /public/mcox/prodigy/working/system/planner/*.lisp
;;;
;;;


#|
(unless (find-package "Transducer")
  (make-package "Transducer" :nicknames '("Trans")))

(in-package "Transducer")

;;; Make available in USER package.
(export '(ask-user-for-demo exec gen-file)
	"USER")
|#


(defparameter
    *Normalized-plan-stream* 
    nil)

(defparameter
    *default-domain*
    'blocksworld)

(defparameter
    *default-prob*
    'suss)


;;;
;;; Old default
;;; (:style 
;;;      (default
;;;	(start      (lambda (stream)
;;;		      )
;;;	 )
;;;	(head-print (lambda (head stream)
;;;		      )
;;;	 )
;;;	(role-print (lambda (role stream)
;;;		      )
;;;	 )
;;;	(done       (lambda (stream)
;;;		      )
;;;	 ) 
;;;	);default
;;;      )
;;;
(defparameter *default-style*
    '(:style 
      (*default-style*
	  (start      (lambda (stream)
			(format stream 
				"( ")
			)
	   )
	  (head-print (lambda (head stream)
			(format stream
				"~s "
				head)
			)
	   )
	  (role-print (lambda (role stream)
			(format stream "~s "  role))
	   )
	(done (lambda (stream)
		(format stream ")~%"))
	 ) 
	)				;default
      )

  )

(defparameter *CS790-style*
    '(:style 
      (*cs790-style*
	  (start      (lambda (stream)
			(format stream "~%( ")
			)
	   )
	  (head-print (lambda (head stream)
			(format stream "~s "  head)
			)
	   )
	(role-print (lambda (role stream)
		      (if (second role)
			  (format stream "~s "  (second role)))
		      )
	 )
	(done (lambda (stream)
		(format stream ")"))
	 ) 
	)				;CS790
      )
  "default for CS790 Term Proj"
  )

(defparameter *Boris-style* 
    '(:style 
      (*Boris-style* 
	  (start      (lambda (stream)
			(format stream "~%<")
			)
	   )
	  (head-print (lambda (head stream)
			(format stream "~s "  head)
			)
	   )
	(role-print (lambda (role stream)
		      (if (second role)
			  (format stream "~s"  (second role)))
		      )
	 )
	(done (lambda (stream)
		(format stream ">"))
	 ) 
	)				;Boris
      )
  "default for BORIS' demo"
  )

(defparameter *Jer-Sen-style* 
    '(:style 
      (*Jer-Sen-style* 
	  (start      (lambda (stream)
					;		     (setf *op-list* nil)
			)
	   )
	  (head-print (lambda (head stream)
			(setf *current-head*
			  (apply 
			   #'(lambda (symbol)
			       (gentemp 
				(string
				 (intern
				  (coerce
				   (append
				    (coerce
				     (string symbol)
				     'list)
				    (list #\.))
				   'string)))))
			   (list head)))
			)
	   )
	(role-print (lambda (role stream)
		      (format stream 
			      "~s ~s ~s~%"  
			      *current-head*
			      (second role)
			      (first role))
		      )
	 )
	(done       (lambda (stream)
		      nil
		      )
	 ) 
	)				;jer-sen
      )
  )


(defvar *current-style*
    '*cs790-style*)


(defparameter *default-data-line*
    (format nil "(:DATA ~A " *current-style*)
  )


(defmacro change-style (style-symbol)
  `(setf *default-data-line*
     ,(format nil 
	      "(:DATA ~A " 
	      (setf *current-style* style-symbol))
     )
  )
  
  

;;;
;;; Function normalize-and-write-step changes an instantiated PRODIGY operator
;;; (plan step) into a normalized form. The normal form is represented by a
;;; standard Frame structure. The value of "frame" is called the head. This is
;;; followed by an arbitrary number of roles. Roles are attribute value pairs.
;;;
;;; (frame 
;;;  (attribute1 val1)
;;;  (attribute2 val2)
;;;  (attribute3 val3)
;;;   ... )
;;;
;;; The current implementation does not allow facets or recursive frame values.
;;;
;;; The function writes the frame to a file (or any stream object) as
;;; determined by the argument "stream."
;;;
(defun normalize-and-write-step (op stream) 
  (declare (type p4::instantiated-op op)
	   (stream stream))
  
    (let ((plan-step 
	   (p4::instantiated-op-op op)))
      (format stream "~A" *default-data-line*)
      (format 
       stream 
       "~S" 
       (cons 
	(p4::operator-name 
	 plan-step)
	(mapcar 
	 #'(lambda (x y)
	     (list  
	      x 
	      (cond ((typep y 
			    'p4::prodigy-object)
		     (p4::prodigy-object-name y))
		    ((null y) 
		     nil)
		    ((listp y) 
		     '("et cetera"))
		    (t  
		     y))
	      ))
	 (p4::operator-vars plan-step)
	 (p4::instantiated-op-values op)
	 )
	)
       )
      (format stream ")~%")
      
      )
  )



;;;
;;; Traverses the steps in the plan, calling normalize-and-write-step to
;;; convert and save result to *out-stream*.
;;;
(defun save-normalized-plan (stream)
  (let* ((current-plan 
	  (or (rest (first p4::*all-solutions*)) ;Added [20jun00 cox]
	      (user::prodigy-result-solution *prodigy-result*)))
	 (plan-length (length current-plan)))
    (mapcar #'normalize-and-write-step
	    current-plan 
	    (make-list 
	     plan-length 
	     :initial-element 
	     stream)))
  )



;;;
;;; Save the PRODIGY plan to disk in normalized frame format. Default domain
;;; and problem can be overridden by optional arguments. When the
;;; save-current-plan-p predicate is non-nil, the function uses the plan
;;; already in place rather than running PRODIGY to produce another one.
;;;
(defun ask-user-for-demo (&optional
                          save-current-plan-p
                          (stream *Normalized-plan-stream*)
                          (my-domain *default-domain*)
                          (prob *default-prob*))
;  (format 
;   t 
;   "~%Running ~S in ~S domain ~%and saving to ~S " 
;   prob
;   my-domain
;   *Normalized-plan-file* )
  (when (not save-current-plan-p)
    (user::domain my-domain)
    (user::problem prob)
    (user::run))
  
  (format stream "(~%~S~%" (symbol-value *current-style*))
    
  (save-normalized-plan stream)

  (format stream ")~%")
    
  )
