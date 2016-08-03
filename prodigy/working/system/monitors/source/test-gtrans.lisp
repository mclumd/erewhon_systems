(in-package user)

;;;
;;; File test-gtrans.lisp contains the code to run the evaluation for goal
;;; transformations. Unlike the evaluation of monitors that used an artificial
;;; domain (plan-exec dir) and varied the domain definition file (domain.lisp),
;;; this code varies the problem file (bridge-eval.lisp) in a realistic air
;;; campaign planning domain (goals2 dir).
;;;
;;; Actually, rather than changing the problem file on disk, I used the
;;; set-problem function from the ForMAT-PRODIGY Front End. I simply modify the
;;; global parameters used in function init-lists and call set-problem to
;;; generate a suitable planning problem directly. See setup-experiment
;;; function below.
;;;

(defparameter *gresults-directory* 
  (concatenate 
   'string
   *prodigy-root-directory* 
   "domains/goals2/")
  "Where results are written to disk for goal transformations.")

(defvar *max-g-num* 10
  "The maximun number of goals to achieve in experiment.")

(defconstant *crossing-num* 3
  "The number of river crossings per river.")

(defvar *max-r-num* (* *max-g-num* *crossing-num*)
  "The maximun number of resources (i.e., F15s) available in the domain of the experiment.")


(defun init-lists ()
  "Initialize *state-list* and *object-list* to invariant values of bridges-eval.lisp."
  (setf *state-list*
	'(
	  (nothing)
	  (GROUP-TYPE TFS2 F15) (SIZE TFS2 2)
	  (PART-OF F16-A-SQUADRON TFS3)
	  (PART-OF F16-B-SQUADRON TFS3)
	  (PART-OF F16-C-SQUADRON TFS3)
	  (GROUP-TYPE TFS2 F16) (SIZE TFS3 3)
	  (LESS-BY-1 2 1) (LESS-BY-1 1 0)
	  (THREAT-AT TERRORISM1 BOSNIA-AND-HERZEGOVINA)
	  (THREAT-AT TERRORISM3 KOREA-SOUTH)
	  (THREAT-AT TERRORISM2 SRI-LANKA)
	  (THREAT-AT WEAPONS-SMUGGLING1 SAUDI-ARABIA)
	  (LOC-AT AIRPORT1 SRI-LANKA)
	  (LOC-AT AIRPORT2 KOREA-SOUTH)
	  (LOC-AT AIRPORT6 KOREA-SOUTH)
	  (LOC-AT AIRPORT3 SAUDI-ARABIA)
	  (LOC-AT AIRPORT4 BOSNIA-AND-HERZEGOVINA)
	  (LOC-AT TOWN-CENTER1 BOSNIA-AND-HERZEGOVINA) 
	  (IS-ENEMY ENEMY1)
	  (IS-ENEMY ENEMY2)
	  (IS-DEPLOYED ENEMY1 TOWN-CENTER1)
	  (IS-DEPLOYED ENEMY2 TOWN-CENTER1)
	  (NEAR AIRPORT4 TOWN-CENTER1)
	  (more-than decisive-victory marginal-victory)
	  (more-than marginal-victory stalemate)
	  (more-than stalemate marginal-defeat)
	  (more-than marginal-defeat decisive-defeat)
	  (LOC-AT AIRPORT5 KUWAIT)
	  (LOC-AT TOWN-CENTER2 KOREA-SOUTH)
	  (IS-USABLE AIRPORT1) (IS-USABLE AIRPORT2)
	  (IS-USABLE AIRPORT3) (IS-USABLE AIRPORT4)
	  (IS-USABLE AIRPORT5) 
	  (airport-secure-at korea-south airport6)
	  (IS-READY POLICE-A)
	  (IS-READY SECURITY-POLICE-A)
	  (IS-READY SECURITY-POLICE-B)
	  (IS-READY SPECIAL-FORCES-A)
	  (IS-READY SPECIAL-OPERATION-FORCE)
	  (IS-READY MAGTF-MEU-GCE) (IS-READY DOG-TEAM1)
	  (IS-READY DOG-TEAM2) (IS-READY HAWKA)
	  (IS-READY BD1) (IS-READY BD2)
	  (IS-READY MILITARY-POLICE-A)
	  (IS-READY A10A-A-SQUADRON)
	  (IS-READY A10A-B-SQUADRON)
	  (IS-READY A10A-C-SQUADRON)
	  (MISSION-OF A10A-A-SQUADRON CLOSE-AIR-SUPPORT)
	  (MISSION-OF A10A-B-SQUADRON CLOSE-AIR-SUPPORT)
	  (MISSION-OF A10A-C-SQUADRON CLOSE-AIR-SUPPORT)
	  (IS-READY F16-A-SQUADRON)
	  (IS-READY F16-B-SQUADRON)
	  (IS-READY F16-C-SQUADRON)
	  (IS-READY 25TH-INFANTRY-DIVISION-LIGHT)
	  (IS-READY INFANTRY-BATTALION-A)
	  (IS-READY BRIGADE-TASK-FORCE)
	  (IS-READY ENGINEERING-BRIGADE)
	  (IS-READY DIVISION-READY-BRIGADE)))

  (setf *object-list*
	'(
	  (OBJECTS-ARE TFS2 TFS3 TFS)
	  (OBJECTS-ARE AIR-INTERDICTION AIR-SUPERIORITY
		       CLOSE-AIR-SUPPORT COUNTER-AIR MISSION-NAME)
	  (OBJECTS-ARE WEAPONS-SMUGGLING TERRORISM THREAT)
	  (OBJECTS-ARE TERRORISM1 TERRORISM2 TERRORISM3 TERRORISM)
	  (OBJECT-IS WEAPONS-SMUGGLING1 WEAPONS-SMUGGLING)
	  (OBJECT-IS TOWN-CENTER BUILDING)
	  (OBJECTS-ARE ENEMY1 ENEMY2 INFANTRY)
	  (OBJECT-IS AIR-FORCE-MODULE FORCE-MODULE)
	  (OBJECTS-ARE F16-A-SQUADRON F16-B-SQUADRON F16-C-SQUADRON
		       F16)
	  (OBJECTS-ARE A10A-A-SQUADRON A10A-B-SQUADRON
		       A10A-C-SQUADRON A10A)
	  (OBJECT-IS DOG-TEAM1 DOG-TEAM)
	  (OBJECT-IS DOG-TEAM2 DOG-TEAM)
	  (OBJECT-IS SECURITY-POLICE-A SECURITY-POLICE)
	  (OBJECT-IS SECURITY-POLICE-B SECURITY-POLICE)
	  (OBJECTS-ARE SPECIAL-FORCES-A MAGTF-MEU-GCE
		       SPECIAL-OPERATION-FORCE
		       SPECIAL-FORCE-MODULE)
	  (OBJECTS-ARE AIRPORT1 AIRPORT6 AIRPORT3 AIRPORT4 AIRPORT5 AIRPORT2
		       AIRPORT)
	  (OBJECTS-ARE TOWN-CENTER1 TOWN-CENTER2 TOWN-CENTER)
	  (OBJECTS-ARE BOSNIA-AND-HERZEGOVINA SAUDI-ARABIA KOREA-SOUTH SRI-LANKA KUWAIT
		       COUNTRY)
	  (OBJECTS-ARE BD1 BD2 BRIGADE-TASK-FORCE
		       ENGINEERING-BRIGADE DIVISION-READY-BRIGADE
		       BRIGADE)
	  (OBJECT-IS MILITARY-POLICE-A MILITARY-POLICE)
	  (OBJECT-IS HAWKA HAWK-BATTALION)
	  (OBJECT-IS 25TH-INFANTRY-DIVISION-LIGHT INFANTRY)
	  (OBJECT-IS INFANTRY-BATTALION-A INFANTRY-BATTALION)
	  (OBJECT-IS POLICE-A POLICE-FORCE-MODULE)
	  (OBJECTS-ARE F15 F16 TACTICAL-FIGHTER)
	  (Object-is Local-Residents NONCOMBATANTS)
	  ))
  )


(defun setup-experiment (&optional
			 (goal-num *max-g-num*)
			 (resource-num *max-r-num*)
			 (crossing-num *crossing-num*)
			 &aux
			 (bridge-list	;Only one bridge per river here
			  (mapcar 
			   #'(lambda (x) 
			       (make-sym
				'BRIDGE x))
			   (gen-lte goal-num)))
			 (river-list
			  (mapcar 
			   #'(lambda (x) 
			       (make-sym
				'RIVER x))
			   (gen-lte goal-num)))
			 (resource-list
			  (mapcar 
			   #'(lambda (x) 
			       (make-sym
				'F15-SQUADRON x))
			   (gen-lte resource-num))))
  (init-lists)
  (setf *goal-list* 
	`(and ,@(mapcar 
		 #'(lambda (x) 
		     `(outcome impassable ,(make-sym
					    'RIVER x))) 
		 (gen-lte goal-num))))
  (setf *object-list* 
	(append 
	 *object-list* 
	 `((objects-are
	    ,@river-list
	    RIVER)
	   (objects-are
	    ,@resource-list
	    F15)
	   (objects-are
	    ,@(let ((tmp nil))
		(dolist (x bridge-list)
			(setf tmp 
			      (append tmp
				      (mapcar
				       #'(lambda (y)
					   (make-sym x y))
				       (gen-lte crossing-num)))))
		tmp)
	    BRIDGE)
	   )))
  (setf *state-list* 
	(append 
	 *state-list* 
	 `(,@(mapcar 
	      #'(lambda (x) 
		  `(near airport2 ,x))
	      river-list)
	     ,@(mapcar 
		#'(lambda (x) 
		    `(is-ready ,x))
		resource-list)
	     ,@(mapcar 
		#'(lambda (x) 
		    `(mission-of ,x air-interdiction))
		resource-list)
	     
	     ,@(let ((tmp nil))
		 (dolist 
		  (z (mapcar 
		      #'(lambda (x y) 
			  ;; Make this be from 1 to crossing-num instead
			  `((enables-movement-over ,(make-sym y 1) ,x)
			    (enables-movement-over ,(make-sym y 2) ,x)
			    (enables-movement-over ,(make-sym y 3) ,x)))
		      river-list
		      bridge-list))
		  (setf tmp (append z tmp)))
		 tmp))
	 ))
  (set-problem *goal-list*) ;See /afs/cs/project/prodigy-1/format/set-problem.lisp
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; The following 2 functions were from domain.lisp in plan-exec

;; Integers i such that  1<=i<=x
(defun gen-lte (x)
  (if (<= x 0) 
      nil
    (if (= x 1) (list x) (cons x (gen-lte (- x 1))))))

(defun make-sym (letter num)
  (intern (string-upcase (format nil "~s~s" letter num)))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; The following is modified from test-battery.lisp

(defun do-gtest (&optional 
		(max-num-trials *max-g-num*) ;was *max-ops*
		with-gtrans-p
		write-results-p
		(o-level 0)
		&aux
		(resource-num (read-current-delay)) ;corresponds to resource-num
		(n-goals (read-current-n-ops)) ;corresponds to goal-num
		)
  (domain 'goals2)
  (setf *battery-results* nil)
;;;  (if (eq o-level 0)
;;;      (setf *monitor-trace* nil))

  ;; Test with or without goal transformations
  (dotimes (i 5)
	   (do-1-gtrial n-goals 
		       resource-num 
		       with-gtrans-p
		       o-level)
	   (setf resource-num (+ resource-num 1)))

  (if write-results-p
      (create-gres-file 
       with-gtrans-p))
  (let ((new-op-num-p (= (- resource-num 1) *max-r-num*))) ;was *max-delay*
    (write-current-status
     (if new-op-num-p 1 resource-num)
     (if new-op-num-p 
	 (if (= n-goals max-num-trials)
	     1
	   (+ 1 n-goals))
       n-goals)))     
  )

;;; For performing a single test trial at a given number of operators (n-ops)
;;; and sensing delay. 
;;;
(defun do-1-gtrial (n-goals
		    resource-num
		   &optional 
		   with-gtrans-p
		   (o-level 0))
;  (setf *n-ops* n-ops)
;  (if (eq  *test-condition* 'alternative-based-subgoal)
;      (problem 'p1)
;    (if (eq  *test-condition* 'alternative-based-usability)
;	(problem 'p2)))
  (setup-experiment n-goals resource-num)
  (output-level o-level)
  (testg-battery 
   n-goals
   (list "" "")
   resource-num)
  )

(defun testg-battery (n-goals
		      &optional 
		      (seq-list *sequence-list*)
		      (resource-num 1)
		      &aux
		      p-result)
  (declare (special *sequence-list*))
  (dotimes (x (/ (length seq-list) 2))
					;	   (unless (and (eq *test-condition* 'alternative-based-subgoal)
					;			(not with-gtrans-p))
					;		   (setf *sequence* (first seq-list))
					;		   (reset))
	   (setf seq-list (rest (rest seq-list)))
	   (setf p-result (cond ( (eq *test-condition* 'with-goal-transformations)
				  (run :depth-bound 1000))
				(t
				 (set-partial-satisfaction)
				 (run :depth-bound 1000 
				      :time-bound 
				      ;;Use the times of old run that used
				      ;;transformations + 10% (or 1 sec,
				      ;;whichever is higher)
				      (let ((old-time (pop-file)))
					(+ (max 1.0 (* 0.1 old-time)) old-time))
				      ))))
	   (setf *battery-results* 
		 (cons 
		  (list n-goals 
			resource-num 
			(prodigy-result-time p-result)
			(prodigy-result-nodes p-result)
			(calc-capacity-reduction
			 (or (prodigy-result-solution p-result)
			     (let ((old-result
				    (getf (prodigy-result-plist 
					  p-result)
					 :old-result)))
			       ;;fail is when no solution is found and
			       ;;time-bound not met
			       (and (not (eq (first old-result) :fail)) 
				    (eq :partial-achieve
				      (first 
				       (first 
					(first 
					 old-result))))
				    (rest old-result))))
			 n-goals))
		  *battery-results*))
	   (setf resource-num 
		 (+ 1 resource-num)))
  )



(defun calc-bridges-destroyed (soln
			       &aux
			       (op-name 
				(if (not (null soln))
				    (p4::operator-name 
				     (p4::instantiated-op-op 
				      (first soln)))))
			       )
  (cond ((null soln)
	 0.0)
	((eq op-name 'blow)
	 (+ 1.0 (calc-bridges-destroyed (rest soln))))
	((eq op-name 'damage)
	 (+ 0.5 (calc-bridges-destroyed (rest soln))))
	(t
	 (calc-bridges-destroyed (rest soln))))
  )
	
(defun calc-capacity-reduction (soln 
				n-goals
				&aux
				(num-bridges 
				 (* n-goals *crossing-num*))
				)
  (* (/ (calc-bridges-destroyed soln)
	num-bridges)
     100)
  )

(defun create-gres-file (&optional
			with-gtrans-p
			(results *battery-results*))
  "Write out partial results in format handled by Systat."
  (with-open-file
   (file-out 
    (concatenate 'string 
		 *gresults-directory*
		 (if with-gtrans-p
		     "results-gtrans.txt"
		   "results-no-gtrans.txt"))
    :direction :output
    :if-exists :append
    :if-does-not-exist :create)
   (mapc #'(lambda (tuple)
	     (write-results 
	      (first tuple)
	      (second tuple)
	      (fifth tuple)
	      file-out))
	 results))
  nil
  )


;;; The contents of file is a list at function invocation, the cdr of the list
;;; at conclusion. The function returns the value of the car of the list. Not
;;; efficient, but ...
;;;
(defun pop-file (&optional
		 (fname (concatenate 
			 'string 
			 *gresults-directory*
			 "results-gtrans.times"))
		 &aux
		 alist)
  (with-open-file
   (file-in fname
	    :direction :input)
   (setf alist (read file-in)))
  (with-open-file
   (file-out 
    fname
    :direction :output
    :if-exists :overwrite)
   (format file-out
	   "~S"
	   (rest alist)))
  (first alist)
  )
