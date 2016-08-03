(in-package 'user)

;;; These functions automatically generate problem sets
;;; in the process planning domain.

;;; Started with file from Daniel, adapted from Manuela's for NoLimit.
;;; 

(defstruct (problem-tools)
  ;;one field for each type of drill-bit, that contains the sizes
  ;;(diameters, angles, etc) needed to solve each problem
  spot-drill
  twist-drill
  High-Helix-Drill
  tap-diameter
  countersink-angle
  counterbore-size
  reamer-diameter
  plain-mill)
  
;;values from problems in probs directory (for Prodigy 4.0 and 2.0)
(defvar *diameters* '(9/64 1/4 1/6 1/8 1/32))
(defvar *counterbore-sizes* '(1/2 1/4 3/8))
(defvar *angles* '(82))
(defvar *depths* '(1/4 0.3 0.5 1))
(defvar *locations*
  '((1/2 1.5)(0.5 0.25)(1.375 0.25)(2.25 0.25)(2.42 0.25)))

(defstruct (hole-data)
  (name :type number)
  (part :type number)
  (side :type number)
  loc-x loc-y depth diameter angle counterbore-size)

(setf *print-case* :downcase)

;;;***************************************************************      

(defun create-probset ()
  (format t "~%~% Enter the specifications:~%")
  (let* ((name (ask-for "Enter problem set filename (no extension): "))
	 (filename
	  (format nil "~aprobsets/~(~a~).lisp" *problem-path* name))
	 (no-probs (ask-for "Number of problems in this set? "))
	 (prob;;(ask-for "Prefix for name of problems? ")
	  (format nil "~a-" name))
	 (fixedp (ask-for "Fixed number of goals t/nil? "))
	 (max-no-goals (if fixedp
			   (ask-for "Number of goals per problem? ")
			   (ask-for "Maximum number of goals per problem? ")))
	 (min-no-goals (if (not fixedp)
			   (ask-for "Minimum number of goals per problem? ")))
	 (fixed-goal-p (ask-for "Fixed goal (goal-name/goal/nil)? "))
	 ;;parts
	 (max-no-parts
	  (ask-for-default "Maximum number of parts? " 1))
	 (min-no-parts
	  (if (> max-no-parts 1)
	      (ask-for-default "Minimum number of parts? " 1) 1))
	 (shapes
	  (ask-for-default
	   "Shapes for parts (rectangular/cylindrical/any)? "
	   'rectangular))
	 ;;holes
	 (max-no-holes
	  (ask-for-default "Maximum number of holes? " 1))
	 (sides-for-holes (ask-which-sides))
	 (types-of-holes
	  (if (and (> max-no-holes 0) (not fixed-goal-p))
	      (ask-type-of-holes)))
	 (size-of-goals-p
	  (if (not fixed-goal-p)
	      (eq (ask-for-default "Allow size-of goals? " 'yes)
		  'yes))) 
	 ;;machines
	 (max-no-drills
	  (ask-for-default "Maximum number of drills (machines)? " 1))
	 (max-no-milling-machines
	  (ask-for-default "Maximum number of milling machines? " 1))
	 ;;holding devices
	 (max-no-vises
	  (ask-for-default "Maximum number of vises? " 1))
	 ;;tools
	 (max-no-spot-drills
	  (ask-for-default "Maximum number of spot-drills? " 1))
	 (max-no-twist-drills
	  (ask-for-default "Maximum number of twist-drills? " 1))
	 (max-no-plain-mills
	  (ask-for-default "Maximum number of plain-mills? " 1))
	 (max-no-counterbores
	  (ask-for-default "Maximum number of counterbores? " 1))
	 (max-no-countersinks
	  (ask-for-default "Maximum number of countersinks? " 1))
	 (max-no-taps
	  (ask-for-default "Maximum number of taps? " 1))
	 (max-no-reamers
	  (ask-for-default "Maximum number of reamers? " 1))

	 ;;	 (common-instances (constant-cities-and-locations no-cities))
	 ;;	 (common-state (common-state no-cities))
	 )
    (with-open-file (ofile filename :direction :output 
			   :if-exists :rename-and-delete
			   :if-does-not-exist :create)
      ;;
      ;; Header of the file
      ;;
      (format ofile ";;; Problem set of the hd-machining domain~%~%")
      (format
       ofile
       ";;; The problem set creation parameters were as follows: ~a problems.~%~
        ;;; Fixed number of goals: ~a. No of goals per problem: ~a. ~
            Min goals per problem: ~A. Fixed goal: ~s.~%~
        ;;; Max parts: ~a. Min parts: ~a. Shapes: ~a. Max holes: ~a. ~
            Sides for holes: ~a~%"
       no-probs fixedp max-no-goals min-no-goals fixed-goal-p
       max-no-parts min-no-parts shapes max-no-holes sides-for-holes)
      (cond
	((> (length types-of-holes) 5)
	 (format ofile ";;; Types: (~s ~s ~s ~s ~s~%" (car types-of-holes)
		 (second types-of-holes)(third types-of-holes)(fourth types-of-holes)
		 (fifth types-of-holes))
	 (format ofile ";;;         ~s)~%" (sixth types-of-holes)))
	(t (format ofile ";;; Types: ~s~%" types-of-holes)))
      (format
       ofile
       ";;; Size-of goals: ~a.~%~
        ;;; Max drills: ~a. Max milling machines: ~a. Max vises: ~a.~%~
        ;;; Max spot-drills: ~a. Max twist-drills: ~a. Max ~
            plain-mills: ~a.~%~
	;;; Max counterbores: ~a. Max countersinks: ~a. Max taps: ~a. ~
            Max reamers: ~a.~%"
       size-of-goals-p max-no-drills max-no-milling-machines
       max-no-vises max-no-spot-drills
       max-no-twist-drills max-no-plain-mills max-no-counterbores
       max-no-countersinks max-no-taps max-no-reamers)
      
      (format ofile "~2%(setf *all-problems* '(")

      (do ((count-prob 0)
	   no-parts no-holes no-drills no-milling-machines no-vises
	   no-spot-drills no-twist-drills no-plain-mills
	   no-counterbores no-countersinks no-taps no-reamers
	   no-goals holes goals state
	   (*impossible-prob-p* nil nil))
	  ((eq count-prob no-probs)
	   ;;close file 
	   )
	(declare (special *impossible-prob-p*))

	(setf no-parts (how-many max-no-parts min-no-parts))
	(setf no-holes (random-from-max max-no-holes))
	(setf no-drills (random-from-max max-no-drills))
	(setf no-milling-machines (random-from-max max-no-milling-machines))
	(setf no-vises (random-from-max max-no-vises))
	(setf no-spot-drills (random-from-max max-no-spot-drills))
	(setf no-twist-drills (random-from-max max-no-twist-drills))
	(setf no-plain-mills (random-from-max max-no-plain-mills))
	(setf no-counterbores (random-from-max max-no-counterbores))
	(setf no-countersinks (random-from-max max-no-countersinks))
	(setf no-taps (random-from-max max-no-taps))
	(setf no-reamers (random-from-max max-no-reamers))
	(setf no-goals (if fixedp max-no-goals
			   (how-many max-no-goals min-no-goals)))

	(setf holes
	      (create-holes-data no-holes no-parts sides-for-holes))
	
	(setf goals (create-goals-for-prob
		     fixed-goal-p no-goals no-parts holes
		     types-of-holes size-of-goals-p)) 

	(setf state
	      (append
	       ;;initial setup of tools and holding devices
	       (add-dynamic-part-of
		goals no-spot-drills no-twist-drills no-counterbores
		no-countersinks no-taps no-reamers no-plain-mills
		no-vises no-drills no-milling-machines)		 
	       (assign-holes-state goals)))
	(setf state 
	      (assign-parts-state
	       no-parts no-drills no-milling-machines no-vises
	       shapes state)) 
	  
	(unless (or *impossible-prob-p*
		     ;;goal is true in initial state
		     (null (set-difference goals state :test #'equal)))
	  (output-problem-to-file
	   ofile prob count-prob no-drills no-milling-machines
	   no-spot-drills no-twist-drills no-taps no-countersinks
	   no-counterbores no-reamers no-plain-mills no-vises no-parts
	   no-holes state goals no-probs)				  
	  (incf count-prob)))
      (format ofile "))~%"))))
  
;;; ****************************************************************

(defun output-problem-to-file
    (ofile prob count-prob no-drills no-milling-machines
	   no-spot-drills no-twist-drills no-taps no-countersinks
	   no-counterbores no-reamers no-plain-mills no-vises no-parts
	   no-holes state goals no-probs)
  (format ofile
	  "~%   (setf (current-problem)~%     ~
             (create-problem~%       (name ~a~d)~%       (objects"
	  prob count-prob)

  ;;output instances

  (format ofile "~%        (");;MACHINES
  (dotimes (counter no-drills)
    (format ofile "drill~s " counter))
  (format ofile "drill)")
  (format ofile "~%        (")
  (dotimes (counter no-milling-machines)
    (format ofile "mm~s " counter))
  (format ofile "milling-machine)")

  (format ofile "~%~%        (");;TOOLS
  (dotimes (counter no-spot-drills)
    (format ofile "spot-drill~s " counter))
  (format ofile "spot-drill)")
  (format ofile "~%        (")
  (dotimes (counter no-twist-drills)
    (format ofile "twist-drill~s " counter))
  (format ofile "twist-drill)")
  (format ofile "~%        (")
  (dotimes (counter no-taps)
    (format ofile "tap~s " counter))
  (format ofile "tap)")
  (format ofile "~%        (")
  (dotimes (counter no-counterbores)
    (format ofile "counterbore~s " counter))
  (format ofile "counterbore)")
  (format ofile "~%        (")
  (dotimes (counter no-countersinks)
    (format ofile "countersink~s " counter))
  (format ofile "countersink)")
  (format ofile "~%        (")
  (dotimes (counter no-reamers)
    (format ofile "reamer~s " counter))
  (format ofile "reamer)")
  (format ofile "~%        (")
  (dotimes (counter no-plain-mills)
    (format ofile "plain-mill~s " counter))
  (format ofile "plain-mill)")


  (format ofile "~%~%        (");;HOLDING-DEVICES
  (dotimes (counter no-vises)
    (format ofile "vise~s " counter))
  (format ofile "vise)")

  (format ofile "~%~%        (brush1 brush)~%        ~
                  (soluble-oil soluble-oil)~%        ~
                  (mineral-oil mineral-oil)")

  (format ofile "~%        (");;PARTS
  (dotimes (counter no-parts)
    (format ofile "part~S " counter))
  (format ofile "part)")
  (format ofile "~%        (");;HOLES
  (dotimes (counter no-holes)
    (format ofile "hole~s " counter))
  (format ofile "hole)")

  (format ofile ")")

  ;;output initial state
	  
  (format ofile "~2%       (state~%        (and~%          ~
                            (always-true)")

  (dolist (lit state)(format ofile "~%          ~s" lit))
  (format ofile "))~%")

  ;;output goal

  (format ofile "~%       (goal ")
  (cond
    ((= (length goals) 1)
     (format ofile "~S)" (car goals)))
    (t
     (format ofile "~%        (and")
     (dolist (g goals)(format ofile "~%          ~S" g))
     (format ofile "))")))
  (format ofile "))")
  (if (< count-prob (1- no-probs))
      (format ofile "~2%;;****************************************")))



;;; ***************************************************************

(defun how-many (max min)
  (if (eq max min) max (+ min (random (1+ (- max min))))))

;;; ***************************************************************
;;; Divide number of holes among parts

(defun create-holes-data (no-holes no-parts sides-for-holes)
  (let (all-holes (hole-count 0))
    (multiple-value-bind (holes-per-part rest)
	(truncate (/ no-holes no-parts))
      ;;divide holes evenly among the parts
      (dotimes (part no-parts all-holes)
	(do ((n 0) res hole-struct
	     (loc-pair  (get-random-from-list *locations*)
			(get-random-from-list *locations*)))       
	    ((eq n holes-per-part)
	     (setf all-holes (append all-holes (reverse res))))
	  (setf hole-struct
		(create-hole-data
		 hole-count part (get-random-from-list sides-for-holes)
		 loc-pair))
	  (unless (member hole-struct res :test #'incompatible-holes-p)
	    (push hole-struct res)
	    (incf n)(incf hole-count))))
      ;;get random parts for the remaining holes
      (do (hole-struct
	   (loc-pair  (get-random-from-list *locations*)
		      (get-random-from-list *locations*)))       
	  ((eq hole-count no-holes) all-holes)    
	  (setf hole-struct
		(create-hole-data
		 hole-count (get-random-number no-parts 'part)
		 (get-random-from-list sides-for-holes)
		 loc-pair))
	  (unless (member hole-struct all-holes :test #'incompatible-holes-p)
	    (push hole-struct all-holes)
	    (incf hole-count))))))

(defun create-hole-data (n part side loc-pair)
  (declare (special *depths* *diameters* *angles* *counterbore-sizes*))
  (make-hole-data
   :name n
   :part part
   ;;warning: will have to check for part shape here
   :side side
   :loc-x (car loc-pair)
   :loc-y (second loc-pair)
   :depth (get-random-from-list *depths*)
   :diameter (get-random-from-list *diameters*)
   :angle (get-random-from-list *angles*)
   :counterbore-size (get-random-from-list *counterbore-sizes*)))


#|
;;changed so it creates no-holes holes for each part (because it
;;tended to get all the goals for the same part)

(defun create-holes-data (no-holes no-parts sides-for-holes)
  (let (all-holes)
    (dotimes (part no-parts all-holes)
      (do ((n 0) res hole-struct
	   (loc-pair  (get-random-from-list *locations*)
		      (get-random-from-list *locations*)))       
	  ((eq n no-holes)
	   (setf all-holes (append all-holes (reverse res))))
    
	(setf hole-struct
	      (make-hole-data
	       :name n
	       :part part
	       ;;warning: will have to check for part shape here
	       :side (get-random-from-list sides-for-holes)
	       :loc-x (car loc-pair)
	       :loc-y (second loc-pair)
	       :depth (get-random-from-list *depths*)
	       :diameter (get-random-from-list *diameters*)
	       :angle (get-random-from-list *angles*)
	       :counterbore-size (get-random-from-list
				  *counterbore-sizes*))) 
	(unless (member hole-struct res :test #'incompatible-holes-p)
	  (push hole-struct res)
	  (incf n))))))

(defun create-holes-data (no-holes no-parts sides-for-holes)
  (do ((n 0) res hole-struct
       (loc-pair  (get-random-from-list *locations*)
		  (get-random-from-list *locations*)))       
      ((eq n no-holes) (reverse res))
    
    (setf hole-struct
	  (make-hole-data
	   :name n
	   :part (get-random-number no-parts 'part)
	   ;;warning: will have to check for part shape here
	   :side (get-random-from-list sides-for-holes)
	   :loc-x (car loc-pair)
	   :loc-y (second loc-pair)
	   :depth (get-random-from-list *depths*)
	   :diameter (get-random-from-list *diameters*)
	   :angle (get-random-from-list *angles*)
	   :counterbore-size (get-random-from-list
			      *counterbore-sizes*))) 
    (unless (member hole-struct res :test #'incompatible-holes-p)
      (push hole-struct res)
      (incf n))))
|#

(defun incompatible-holes-p (h1 h2)
  (declare (type hole-data h1 h2))
  (and (eq (hole-data-part h1)(hole-data-part h2))
       (eq (hole-data-side h1)(hole-data-side h2))
       (eq (hole-data-loc-x h1)(hole-data-loc-x h2))
       (eq (hole-data-loc-y h1)(hole-data-loc-y h2))))

       
	
	
	  
       

;;; ***************************************************************
;;; Allow only a hole-predicate from types-of-holes

(defun create-goals-for-prob
    (fixed-goal-p no-goals no-parts holes types-of-holes 
		  size-of-goals-p)
  (declare (number no-goals no-holes no-parts)
	   (list types-of-holes)(atom size-of-goals-p)
	   (special *impossible-prob-p*))
  (cond
    ((= no-goals 1)
     (list 
      (if fixed-goal-p
	  (if (atom fixed-goal-p);;it is a pred name
	      (create-one-literal no-parts holes 
				  (list fixed-goal-p))
	      fixed-goal-p)
	  (create-one-literal
	   no-parts holes
	   (append types-of-holes (if size-of-goals-p '(size-of)))))))
    ;;several goals for the same predicate
    ((and fixed-goal-p (atom fixed-goal-p) (> (length holes) 1))
     (create-several-goals
      no-goals no-parts holes (list fixed-goal-p)))
    ;;several goals but for the same literal: no sense
    (fixed-goal-p
     (setf *impossible-prob-p* t)
     (format t "There would be duplicated goals. Problem discarded.~%"))
    (t
     (create-several-goals
      no-goals no-parts holes 
      (append types-of-holes (if size-of-goals-p '(size-of)))))))

(defun create-several-goals (no-goals no-parts holes predicates)
;  (trace get-random-from-list)
  (do ((all-goals nil)
       (new-goal-literal
	(create-one-literal no-parts holes predicates)
	(create-one-literal no-parts holes predicates)))
      ((eq (length all-goals) no-goals)
;       (untrace get-random-from-list)
       all-goals)
    ;;check whether goal is duplicated or inconsistent
    (or (null new-goal-literal)
	(member new-goal-literal all-goals :test #'equal)
	(inconsistent-p new-goal-literal all-goals)
	(push new-goal-literal all-goals))))

(defun inconsistent-p (new-goal-literal all-goals)
  (or
   ;;check whether there are two size-of goals for the same dimension

   (and (eq (car new-goal-literal) 'size-of)
	(member new-goal-literal all-goals
		:test #'(lambda (newg g)
			  (and;;same part and dimension
			   (eq (second g)(second newg))
			   (eq (third g)(third newg))))))
   ;; same hole cannot be counterbored and countersinked
   (and (eq (car new-goal-literal) 'is-counterbored)
	(member new-goal-literal all-goals
		:test #'(lambda (newg g)
			  (and (eq (car g) 'is-countersinked)
			       ;;same hole
			       (eq (third g)(third newg))))))
   (and (eq (car new-goal-literal) 'is-countersinked)
	(member new-goal-literal all-goals
		:test #'(lambda (newg g)
			  (and (eq (car g) 'is-counterbored)
			       ;;same hole
			       (eq (third g)(third newg))))))
   ;; same hole cannot be reamed and tapped 
   (and (eq (car new-goal-literal) 'is-tapped)
	(member new-goal-literal all-goals
		:test #'(lambda (newg g)
			  (and (eq (car g) 'is-reamed)
			       ;;same hole
			       (eq (third g)(third newg))))))
   (and (eq (car new-goal-literal) 'is-reamed)
	(member new-goal-literal all-goals
		:test #'(lambda (newg g)
			  (and (eq (car g) 'is-tapped)
			       ;;same hole
			       (eq (third g)(third newg))))))))
  

;;;***************************************************************      

(defun ask-for (string)
  (format t "~% ~A" string)
  (read))

(defun ask-for-default (string default)
  (format t "~% ~a[~a] " string default)
  (or (car (read-atoms)) default))
	
(defun ask-type-of-holes nil
  (format t "~% What type of hole goal:~%")
  (remove
   nil
   (mapcar
    #'(lambda (type)
	(if (eq (ask-for-default (format nil "- ~a? " type) 'yes)
		'yes) 
	    type))
    '(has-spot has-hole is-counterbored is-countersinked is-tapped
      is-reamed)))) 

(defun ask-which-sides ()
  (finish-output)
  (format t "~% Enumerate sides for holes: [any] ")
  (or (read-atoms) '(1 2 3 4 5 6)))
  
;;;***************************************************************
;;; same hole cannot be counterbored and countersinked, or tapped and
;;; reamed 

(defun create-one-literal (no-parts holes possible-predicates)
  ;;return a list (pred-name arg1 arg2 ...)
  (declare (list holes possible-predicates)(number no-parts))
  (if possible-predicates
      (let ((pred (nth (random (length possible-predicates))
			possible-predicates))
	    hole)
	(declare (type hole-data hole))
	(case pred
	  (has-spot
	   (setf hole (get-random-from-list holes))
	   (list 'has-spot
		 (name-one 'part (hole-data-part hole))
		 (name-one 'hole (hole-data-name hole))
		 (name-one 'side (hole-data-side hole))
		 (hole-data-loc-x hole)(hole-data-loc-y hole)))
	  ((has-hole is-tapped is-reamed)
	   (setf hole (get-random-from-list holes))
	   (list pred
		 (name-one 'part (hole-data-part hole))
		 (name-one 'hole (hole-data-name hole))
		 (name-one 'side (hole-data-side hole))
		 (hole-data-depth hole)
		 (hole-data-diameter hole)
		 (hole-data-loc-x hole)(hole-data-loc-y hole)))
	  (is-countersinked
	   (setf hole (get-random-from-list holes))
	   (list pred
		 (name-one 'part (hole-data-part hole))
		 (name-one 'hole (hole-data-name hole))
		 (name-one 'side (hole-data-side hole))
		 (hole-data-depth hole)
		 (hole-data-diameter hole)
		 (hole-data-loc-x hole)(hole-data-loc-y hole)
		 (hole-data-angle hole)))
	  (is-counterbored
	   (setf hole (get-random-from-list holes))
	   (list pred
		 (name-one 'part (hole-data-part hole))
		 (name-one 'hole (hole-data-name hole))
		 (name-one 'side (hole-data-side hole))
		 (hole-data-depth hole)
		 (hole-data-diameter hole)
		 (hole-data-loc-x hole)(hole-data-loc-y hole)
		 (hole-data-counterbore-size hole)))
	  (size-of
	   (append
	    (list 'size-of
		  (name-one 'part (get-random-number no-parts 'part)))
	    (goal-dim-and-size)))
	  (t  (break "Can't create ~A goal yet." pred))))))
	  
	  
#|
(defun create-one-literal (no-parts no-holes possible-predicates)
  ;;return a list (pred-name arg1 arg2 ...)
  (if possible-predicates
      (let ((pred (nth (random (length possible-predicates))
			possible-predicates)))
	(case pred
	  (has-spot
	   (append
	    (list 'has-spot
		  (name-one 'part (get-random-number no-parts 'part))
		  (name-one 'hole (get-random-number no-holes 'hole))
		  (name-one 'side (get-random-side 'rectangular)))
	    (get-random-from-list *locations*)))
	  
	  ((has-hole is-tapped is-reamed)
	   (append 
	    (list pred
		  (name-one 'part (get-random-number no-parts 'part))
		  (name-one 'hole (get-random-number no-holes 'hole))
		  (name-one 'side (get-random-side 'rectangular))
		  (get-random-from-list *depths*)
		  (get-random-from-list *diameters*))
	    (get-random-from-list *locations*)))
	  (is-countersinked
	   (append 
	    (list 'is-countersinked
		  (name-one 'part (get-random-number no-parts 'part))
		  (name-one 'hole (get-random-number no-holes 'hole))
		  (name-one 'side (get-random-side 'rectangular))
		  (get-random-from-list *depths*)
		  (get-random-from-list *diameters*))
	    (get-random-from-list *locations*)
	    (list (get-random-from-list *angles*))))
	  (is-counterbored
	   (append 
	    (list 'is-counterbored
		  (name-one 'part (get-random-number no-parts 'part))
		  (name-one 'hole (get-random-number no-holes 'hole))
		  (name-one 'side (get-random-side 'rectangular))
		  (get-random-from-list *depths*)
		  (get-random-from-list *diameters*))
	    (get-random-from-list *locations*)
	    (list (get-random-from-list *counterbore-sizes*))))
	  (size-of
	   (append
	    (list 'size-of
		  (name-one 'part (get-random-number no-parts 'part)))
	    (goal-dim-and-size)))
	  (t  (break "Can't create ~A goal yet." pred))))))
|#

(defun random-from-max (max)
  (if (zerop max) 0 (1+ (random max))))

(defun get-random-number (max-number type)
  (let ((used-type-instances (get 'used-instances type)))
    (if (/= (length used-type-instances) max-number)
	(let ((random-inst (random max-number)))
	  (if (member random-inst (get 'used-instances type))
	      (get-random-number max-number type)
	      random-inst)))))

(defun get-random-side (shape)
  (case shape
    (rectangular (1+ (random 6))) 
    (t (break "dont know about ~A shape yet" shape))))

(defun get-random-side-pair (side)
  ;;from rule SIDES-FOR-HD
  (get-random-from-list
   (case side
;    (side0 )
     (side1 '(side2-side5 side3-side6))
     (side2 '(side1-side4 side3-side6))
     (side3 '(side2-side5 side1-side4))
     (side4 '(side2-side5 side3-side6))
     (side5 '(side1-side4 side3-side6))
     (side6 '(side2-side5 side1-side4)))))

  
(defun get-random-from-list (list)
  (if list (nth (random (length list)) list)))

(defun name-one (name number)
  (read-from-string (format nil "~A~A" name number)))

;;;***************************************************************
;;;(has-spot <part> <hole> <side> <loc-x> <loc-y>)
;;;(has-hole <part> <hole> <side> <hole-depth> <hole-diameter> 
;;;          <loc-x> <loc-y>)
;;;(is-countersinked <part> <hole> <side> <hole-depth> <hole-diameter> 
;;;                  <loc-x> <loc-y> <angle>)
;;;(is-counterbored <part> <hole> <side> <hole-depth> <hole-diameter>
;;;                 <loc-x> <loc-y> <counterbore-size>)
;;;(is-tapped <part> <hole> <side> <hole-depth> <hole-diameter> 
;;;           <loc-x> <loc-y>)
;;;(is-reamed <part> <hole> <side> <hole-depth> <hole-diameter> 
;;;           <loc-x> <loc-y>)

(defun assign-holes-state (goals)
  ;;decide whether spot-hole already exists, hole exists (for tap) etc
  (let (res)
    (dolist (g goals res)
      (case (car g)
	(has-hole
	 (if (flip-coin)
	     ;;appropriate spot hole exists with probability 1/2
	     (push (list 'has-spot (second g)(third g)(fourth g)
			 (seventh g)(eighth g))
		   res)))
	((is-counterbored is-tapped is-reamed is-countersinked)
	 (let ((has-hole-g (cons 'has-hole (subseq g 1 8)))
	       (has-spot-g (list 'has-spot (second g)(third g)(fourth g)
				 (seventh g)(eighth g))))
	   (cond
	     ((or (member has-spot-g goals :test #'equal)
		  (member has-hole-g goals :test #'equal)))
	     ;;no hole or spot-hole exists with probability 1/2
	     ((flip-coin))	    
	     ;;appropriate hole exists with probability 1/4
	     ((flip-coin)
	      (pushnew has-hole-g res :test #'equal))
	     ;;appropriate spot hole exists with probability 1/4
	     (t (pushnew has-spot-g res :test #'equal)))))
	;;other (non-hole) goals
	(t nil)))))

(defun assign-parts-state
    (no-parts no-drills no-milling-machines no-vises shapes state)
  ;;return updated state
  ;;material, current dimensions
  ;;shapes is one of (rectangular, cylindrical, both)
  ;;I need to specify the dimensions so it can infer shape-of
  (let ((machines
	 (append (build-instance-list 'drill no-drills)
		 (build-instance-list 'mm no-milling-machines))))
    (dotimes (part-number no-parts state)
      (let* ((part-name  (name-one 'part part-number))
	     (shape (case shapes
		      ((rectangular cylindrical) shapes)
		      (both (case (random 2)
			      (0 'rectangular)(1 'cylindrical)))
		      (t (error "Shape ~A not allowed" shapes))))
	     (machine (get-random-from-list machines))
	     side hd-lit
	     (new-lits
	      (append
	       (list (list 'material-of part-name 'aluminum))
	       (mapcar #'(lambda (dim)
			   (list 'size-of part-name dim (dim-size dim)))
		       (if (eq shape 'rectangular)
			   '(LENGTH WIDTH HEIGHT)
			   '(LENGTH DIAMETER)))
	       
	       ;;should we bias this so that in some occasions the
	       ;;part is held by the machine, side, etc required by
	       ;;the goal? 

	       (case (get-random-from-list (list :holding :on-table nil))
		 (:holding
		  (setf hd-lit
			(find-if
			 #'(lambda (lit)
			     (and (eq 'has-device (car lit))
				  (eq machine (second lit))))
			 state))
		  (setf machines (remove machine machines))
		  ;;(holding <machine> <holding-device> <part> <side> <side-pair>)
		  (cond
		    (hd-lit
		     (list (list
			    'holding machine
			    (third hd-lit) 
			    part-name
			    (setf side (name-one 'side (get-random-side shape)))
			    (get-random-side-pair side))))
		    ((setf hd-lit
			   (list 'has-device machine 
				 (name-one
				  'vise
				  (get-random-number no-vises 'vise))))
		     ;;make sure that device is not being held in
		     ;;other machine
		     (setf state
			   (remove-if
			    #'(lambda (lit)
				(and (eq (car lit) 'has-device)
				     (eq (third lit) (third hd-lit))))
			    state))
		     (list hd-lit
			   (list
			    'holding machine
			    (third hd-lit) 
			    part-name
			    (setf side (name-one 'side (get-random-side shape)))
			    (get-random-side-pair side))))))		  
		 (:on-table
		  (setf machines (remove machine machines))
		  (list (list 'on-table machine part-name)))
		 (t nil)))))
	(setf state (append state new-lits))))))

(defun dim-size (dim)
  (case dim (LENGTH 5)(WIDTH 3)(HEIGHT 3)
	(t (break "Dont know about ~A yet." dim))))

(defun goal-dim-and-size ()
  (get-random-from-list
   '((LENGTH 4)(LENGTH 0.5)
     (WIDTH 3)(WIDTH 2)
     (HEIGHT 0.5)(HEIGHT 2.5)(HEIGHT 2))))

;;;***************************************************************

(defun add-dynamic-part-of
    (goals no-spot-drills no-twist-drills no-counterbores
	   no-countersinks no-taps no-reamers
	   no-plain-mills no-vises no-drills no-milling-machines)
  (declare (special *impossible-prob-p*))
  ;;return a list of literals (lists)
  (let* ((all-drills (build-instance-list 'drill no-drills))
	 (all-milling-machines
	  (build-instance-list 'mm no-milling-machines))
	 (machines (append all-drills all-milling-machines))
	 (needed-tools (needed-tools goals (make-problem-tools)))
	 machine tool-spec rem-milling-machines res)

    ;;check first if number of tools available is enough for number of
    ;;sizes required. If not, discard the problem
    (cond
      ((enough-tools-p
	no-spot-drills no-twist-drills no-counterbores no-countersinks
	no-taps no-reamers no-plain-mills needed-tools) 

       ;;when deciding (flip-coin) whether tool is on machine or not,
       ;;I am skewing it towards having the spot-drill, twist-drill
       ;;already in the tool-holder with more frequency than the other
       ;;tools 
       (dotimes (sd no-spot-drills)
	 (setf machine
	       (if (flip-coin) (get-random-from-list machines)))
	 (when machine
	   (push (list 'holding-tool machine (name-one 'spot-drill sd))
		 res)
	   (setf machines (remove machine machines))))
       (dotimes (td no-twist-drills)
	 (setf tool-spec
	       (get-random-from-list
		(or (problem-tools-twist-drill needed-tools) *diameters*)))
	 (push
	  (list 'diameter-of-drill-bit (name-one 'twist-drill td)
		tool-spec)
	  res)
	 (setf (problem-tools-twist-drill needed-tools)
	       (remove tool-spec
		       (problem-tools-twist-drill needed-tools)))
	 (setf machine
	       (if (flip-coin) (get-random-from-list machines)))
	 (when machine
	   (push (list 'holding-tool machine (name-one 'twist-drill td))
		 res) 
	   (setf machines (remove machine machines))))

       (setf rem-milling-machines
	     (set-difference machines all-drills))
       (setf machines
	     (set-difference machines all-milling-machines))

       (dotimes (cb no-counterbores)
	 (setf tool-spec
	       (get-random-from-list
		(or (problem-tools-counterbore-size needed-tools)
		    *counterbore-sizes*)))
	 (push
	  (list 'size-of-drill-bit (name-one 'counterbore cb)
		tool-spec)
	  res)
	 (setf (problem-tools-counterbore-size needed-tools)
	       (remove tool-spec
		       (problem-tools-counterbore-size needed-tools)))
	 (setf machine
	       (if (flip-coin) (get-random-from-list machines)))
	 (when machine
	   (push (list 'holding-tool machine (name-one 'counterbore cb))
		 res) 
	   (setf machines (remove machine machines))))

       (dotimes (cs no-countersinks)
	 (setf tool-spec
	       (get-random-from-list
		(or (problem-tools-countersink-angle needed-tools)
		    *angles*)))
	 (push
	  (list 'angle-of-drill-bit (name-one 'countersink cs)
		tool-spec)
	  res)
	 (setf (problem-tools-countersink-angle needed-tools)
	       (remove tool-spec
		       (problem-tools-countersink-angle needed-tools)))
	 (setf machine
	       (if (flip-coin) (get-random-from-list machines)))
	 (when machine
	   (push (list 'holding-tool machine (name-one 'countersink cs))
		 res) 
	   (setf machines (remove machine machines))))

       (dotimes (tap no-taps)
	 (setf tool-spec
	       (get-random-from-list
		(or (problem-tools-tap-diameter needed-tools) *diameters*)))
	 (push
	  (list 'diameter-of-drill-bit (name-one 'tap tap)
		tool-spec)
	  res)
	 (setf (problem-tools-tap-diameter needed-tools)
	       (remove tool-spec
		       (problem-tools-tap-diameter needed-tools)))
	 (setf machine
	       (if (flip-coin) (get-random-from-list machines)))
	 (when machine
	   (push (list 'holding-tool machine (name-one 'tap tap))
		 res) 
	   (setf machines (remove machine machines))))

       (dotimes (ream no-reamers)
	 (setf tool-spec
	       (get-random-from-list
		(or (problem-tools-reamer-diameter needed-tools)
		    *diameters*)))
	 (push
	  (list 'diameter-of-drill-bit (name-one 'reamer ream)
		tool-spec)
	  res)
	 (setf (problem-tools-reamer-diameter needed-tools)
	       (remove tool-spec
		       (problem-tools-reamer-diameter needed-tools)))
	 (setf machine
	       (if (flip-coin) (get-random-from-list machines)))
	 (when machine
	   (push (list 'holding-tool machine (name-one 'reamer ream))
		 res) 
	   (setf machines (remove machine machines))))

       (setf machines rem-milling-machines)
       
       (dotimes (pm no-plain-mills)
	 (setf machine
	       (if (flip-coin) (get-random-from-list machines)))
	 (when machine
	   (push (list 'holding-tool machine (name-one 'plain-mill pm))
		 res)
	   (setf machines (remove machine machines)))
	 )
       (setf machines (append all-drills all-milling-machines))
       (dotimes (v no-vises)
	 (setf machine (if (flip-coin)(get-random-from-list machines)))
	 (when machine
	   (push (list 'has-device machine (name-one 'vise v))
		 res)
	   (setf machines (remove machine machines))))
       (reverse res))
      (t;;not enough tools: discard the problem
       (setf *impossible-prob-p* t) nil))))

(defun needed-tools (goals needed-tools)
  (declare (type problem-tools needed-tools))
  ;;use goals to get diameter of tools. Eg: at least one of the 
  ;;twist-drill should have the proper diameter if a goal is
  ;;has-hole. Same for other tools. Also if goal is has-hole we should
  ;;have a spot-drill as well
  (dolist (g goals needed-tools)
    (case (car g)
      (size-of
       (setf (problem-tools-plain-mill needed-tools) t))
      (has-spot
       (setf (problem-tools-spot-drill needed-tools) t))
      (has-hole
       (setf (problem-tools-spot-drill needed-tools) t)
       (push (sixth g) (problem-tools-twist-drill needed-tools)))
      (is-counterbored
       (setf (problem-tools-spot-drill needed-tools) t)
       (pushnew (sixth g) (problem-tools-twist-drill needed-tools))
       (pushnew (ninth g)
	     (problem-tools-counterbore-size needed-tools)))
      (is-countersinked
       (setf (problem-tools-spot-drill needed-tools) t)
       (pushnew (sixth g) (problem-tools-twist-drill needed-tools))       
       (pushnew (ninth g)
	     (problem-tools-countersink-angle needed-tools)))
      (is-tapped
       (setf (problem-tools-spot-drill needed-tools) t)
       (pushnew (sixth g) (problem-tools-twist-drill needed-tools))       
       (pushnew (sixth g) (problem-tools-tap-diameter needed-tools)))
      (is-reamed
       (setf (problem-tools-spot-drill needed-tools) t)
       (pushnew (sixth g) (problem-tools-twist-drill needed-tools))       
       (pushnew (sixth g) (problem-tools-reamer-diameter needed-tools)))
      (t (break "I don't know about this goal yet.")))))


(defun enough-tools-p
    (no-spot-drills no-twist-drills no-counterbores no-countersinks
		    no-taps no-reamers no-plain-mills needed-tools)
  (and (or (not (problem-tools-spot-drill needed-tools))
	   (> no-spot-drills 0))
       (or (not (problem-tools-plain-mill needed-tools))
	   (> no-plain-mills 0))
       (>= no-twist-drills
	   (length (problem-tools-twist-drill needed-tools)))
       (>= no-countersinks
	   (length (problem-tools-countersink-angle needed-tools)))
       (>= no-counterbores
	   (length (problem-tools-counterbore-size needed-tools)))
       (>= no-taps
	   (length (problem-tools-tap-diameter needed-tools)))
       (>= no-reamers
	   (length (problem-tools-reamer-diameter needed-tools)))))


(defun build-instance-list (prefix no)
  (let (list)
    (dotimes (i no (reverse list))
      (push (name-one prefix i) list))))

(defun flip-coin nil
  (get-random-from-list '(t nil)))
