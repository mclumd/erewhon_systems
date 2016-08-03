(in-package "FRONT-END")

;;;
;;; New stuff for JADE demo. [cox apr98]
;;;
;;; This code mainly addresses the issue of calculating the forces that are a
;;; part of a given force module and whether or not they are available. At the
;;; current time, the functions only determine aircraft-type forces. Ground and
;;; naval forces are not included. 
;;;
;;; In addition the file contains code to translate ForMAT-translated
;;; existential goals into ground literals and also contains routines to
;;; filter a plan created by Prodigy into its deployment components.
;;;




(defparameter *test-data* 
  '(
;    (   10     20   50.0   USER::Aircraft-Type  USER::Tactical-Fighter)
;    (   10     20   50.0   USER::Aircraft-Type  USER::None)
;    (    6     20   30.0   USER::Aircraft-Type  USER::A10a)
    (   16     32   50.0   USER::Aircraft-Type  USER::Tactical-Fighter)
    (   15     32   50.0   USER::Aircraft-Type  USER::None)
    (    6     32   30.0   USER::Aircraft-Type  USER::A10a)
    (    4     32   30.0   USER::Aircraft-Type  USER::F117)
    (    2     32   30.0   USER::Aircraft-Type  USER::F16 )
    (    1     32   30.0   USER::Aircraft-Type  USER::ELECTRONICS)
    )
  )


(defun init-aircraft-tree (total-fm-records)
  "Initialize the tree that calculates the forces in an FM."
  (list 
   (cons 'user::aircraft 
	 total-fm-records))
  )


;;; To perform the task of which forces are in an FM, function
;;; build-aircraft-tree creates an abstraction tree for the aircraft-type
;;; attribute as indicated by a ratios report.
;;;

#|
Given the attributes in *test-data* above, build-aircraft-tree creates the
following tree:

                AIRCRAFT
                /      \
    ELECTRONICS         TACTICAL FIGHTER
                         /     |      \
                     A10A     F117     F16

The leaves of the tree represent the forces in the Force-Module. Note that
because it is not guaranteed that a more general value will always precede a
more specific value in the ratios report, the code may result in faulty
trees. That is, if B52 precedes Bombardment, bombardment will not be inserted
into the tree as a parent of B52. I need to fix this.

However, it is guaranteed that a ratios report will never include two entries
that have the same value. That is, the report will not contain the following:

    (    2     32   30.0   USER::Aircraft-Type  USER::F16 )
    (    6     32   90.0   USER::Aircraft-Type  USER::F16 )

Because of this property, the code always adds a node to the tree for each
aircraft-type entry in the report.
|#
(defun build-aircraft-tree (ratios-report-records
			    &optional 
			    (ac-tree
			     (init-aircraft-tree 
			      (second 
			       (first 
				ratios-report-records))))
			    &aux 
			    (next-record 
			     (first ratios-report-records)))
  (if (null next-record)
	 ac-tree
    (let ((ac-type (fifth next-record ))
	  (ac-number (first next-record)))
      (cond ((eq ac-type 'user::none)
	     (build-aircraft-tree 
	      (rest ratios-report-records)
	      ac-tree))
	    (t
	     (build-aircraft-tree 
	      (rest ratios-report-records)
	      (insert-ac-record 
	       ac-type 
	       ac-number
	       ac-tree)
	     ))))
    )
  )


(defun insert-ac-record (ac-type 
			 ac-number
			 ac-tree
			 &aux
			 (root-node (first ac-tree))
			 tail)
  (cond ((setf tail 
	       (member ac-type (rest ac-tree) 
		       :test #'(lambda (x y)
				 (isa-p (first (first y))
					x))))
	 (append (my-delete ac-tree (first tail))
		 (cons (insert-ac-record
			ac-type ac-number 
			(first tail))
		       (rest tail))))
	;; Could also be same as a node, but Alice says never will happen in
	;; ratios report.
	(t ;otherwise add leaf.
	 (cons (cons (first root-node)
		     (- (rest root-node)
			ac-number))
	       (if (null (rest ac-tree))
		   (list (list (cons ac-type ac-number)))
		 (cons (list (cons ac-type ac-number))
		       (rest ac-tree))))
	 ))
  )


(defun my-delete (alist element)
  (cond ((null alist)
	 nil)
	((equal element 
		(first alist))
	 nil)
	(t
	 (cons (first alist)
	       (my-delete
		(rest alist)
		element))))
  )


(defun return-leaves (ac-tree)
  (cond ((or (null ac-tree)
	     (isa-leaf-p ac-tree))
	 nil)
	(t
	 (ret-leaves ac-tree)))
  )


(defun ret-leaves (ac-tree
		   &aux
		   result)
 (cond ((null ac-tree)
	 nil)
	((isa-leaf-p ac-tree)
	 (list (first (first ac-tree))))
	(t
	 (dolist (each-subtree (rest ac-tree))
		 (setf result
		       (append (ret-leaves
				each-subtree)
			       result)))
	 result)
	)
  )


(defun isa-leaf-p (node)
  (and (consp node)
       (eql (length node) 1)
       (atom (first (first node)))
       (atom (rest (first node))))
  )



;;; E.g., (part-of f15 18th-wing)
;;;
(defun force-available (force)
  "If force is component of some command, return the command."
  (or (if (member force *force-list*)
	  force)
      (some 
       #'(lambda (each-command)
	   (if (user::true-in-state 
		`(USER::part-of ,force ,each-command))
	       each-command))
       *force-list*))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; The following functions are jade-related routines to translate
;;; ForMAT-translated (i.e., already translated by code from translations.lisp)
;;; existential goals into ground literals to be acheived by case replay.
;;;



;;;
;;; Function make-literal is a filter that translates existential goals into
;;; ground literals. 
;;;
;;; For example, 
;;;
;;; (make-literal 
;;;   '(EXISTS ((<location.29> LOCATION) 
;;;             (<ground-force-module.28> GROUND-FORCE-MODULE))
;;;            (IS-DEPLOYED
;;;              <ground-force-module.28> <location.29>))
;;;  --> (IS-DEPLOYED 11-MEU-SOC PHILIPPINES)
;;;
;;; when *geographic-location* is equal to the philippines (this global is set
;;; by :save-default-features commands early in the demo by ForMAT) and when
;;; the 11-meu-soc is in the force list as determined by the is-active
;;; predicate.
;;; 
;;; A somewhat more complex example call:
;;;
;;;(mapcar
;;; #'make-literal
;;; (rest (translate-goals fgoal-action)))
;;;
;;; where fgoal action is of the form
;;; (<"time-string"> :SAVE-GOALS 
;;;    GOAL-FILE-NAME (ID PLAN-NAME 
;;;                     (:DESCRIPTION "description-string") 
;;;                     (:GOALS GOAL1 GOAL2 ... GOALn) 
;;;                     (:GUIDANCE-FILE "filename-string")))
;;; 
;;;
(defun make-literal (translated-goal
		     &aux
		     (list-form-of-goal
		      (get-preconditions 
		       nil
		       translated-goal)))
  (cons (first list-form-of-goal) ;The predicate
	(mapcar 
	 #'(lambda (each-arg)
	     (if (is-type-p each-arg 
			    *current-problem-space*)
		 (ret-available-instance-of each-arg)
	       each-arg))
	 (rest list-form-of-goal)))
  )


(defun ret-available-instance-of (type-id
				  &aux
				  (prodigy-type
				   (is-type-p 
				    type-id
				    *current-problem-space*)))
  (cond ((and (eq type-id 
		  'user::government)
	      (not 
	       (eq *current-destination*
		   *unknown-destination*)))
	 (let ((gov
		(rest 
		 (assoc 
		  '<gov> 
		  (first 
		   (user::true-in-state
		    `(user::legitimate-gov 
		      <gov>
		      ,*current-destination*)
		    ))))))
	   (if gov
	       (p4::prodigy-object-name gov)
	     type-id)
	   ))
	((and 
	  (eq type-id 
	      'user::carrier-battle-group)
	  ;;True if returning a currently active carrier-battle-group with at
	  ;;least one component that is a carrier-air-wing.
	  (some 
	   #'(lambda (each-cvg)
	       (if (some
		    #'(lambda (each-b-list)
			(let ((component
			       (rest 
				(assoc 
				 '<component>
				 each-b-list))))
			  (user::type-of-object
			   component
			   'user::carrier-air-wing)))
		    (user::true-in-state
		     `(user::part-of
		       <component> 
		       ,each-cvg)
		     ))
		   each-cvg))
	   (gen-active-naval-units)))
	 )
	((eq type-id 'user::airport)    ; Must handle airport 1st because it
					; isa location.
	 (or				; Return either
	  (and 
	   (not 
	    (eq *current-destination*
		*unknown-destination*))
	   (some			; some airport in the geo-loc
	    #'(lambda (each-airport)
		(if (user::true-in-state
		     `(user::loc-at 
		       ,(p4::prodigy-object-name
			 each-airport)
		       ,*current-destination*))
		    (p4::prodigy-object-name
		     each-airport)))
	    (p4::type-instances 
	     prodigy-type)))
	  (p4::prodigy-object-name	; or the name of the 
	   (first			; first known airport.
	    (p4::type-instances 
	     prodigy-type))))
	 )
	((isa-p 'user::location 
		type-id)
	 (if  (eq *current-destination*
		  *unknown-destination*)
	     type-id
	   *current-destination*)
	 )
	((eq type-id 'user::population)
	 (or
	  (next-avail-pop)
	  type-id)
	 )
	((some 
	  #'(lambda (each-token)
	      (if (user::true-in-state
		   `(user::is-active 
		     ,(p4::prodigy-object-name
		       each-token)))
		  (if (not (and (eq type-id 'user::fighter-aircraft)
				(isa-p 'user::carrier-air-wing
				       each-token)))		      
		      (p4::prodigy-object-name
		       each-token))))
	  (p4::type-instances 
	   prodigy-type))
	 )
	(t
	 type-id)
	)
  )

(defun gen-active-naval-units (&optional
			       (candidates
				(p4::type-instances 
				 (is-type-p 
				  'user::carrier-battle-group
				  *current-problem-space*)))
			       (today
				(p4::prodigy-object-name
				 (rest 
				  (assoc 
				   '<day> 
				   (first 
				    (user::true-in-state
				     `(user::today-is <day>)
				     ))))))
			       )
  (cond ((null candidates)
	 nil)
	((and 
	  (user::true-in-state
	   `(user::is-active 
	     ,(p4::prodigy-object-name
	       (first candidates))))
	  (user::true-in-state
	   `(user::is-available 
	     ,(p4::prodigy-object-name
	       (first candidates))
	     ,today)))
	 (cons (p4::prodigy-object-name
		(first candidates))
	       (gen-active-naval-units 
		(rest candidates))))
	(t
	 (gen-active-naval-units 
	  (rest candidates)))
	)
  )

(defvar *current-population* nil)

(defun init-current-pop ()
  (declare (special *current-population*))
  (declare (special *current-problem-space*))
  (setf *current-population* nil)
  (dolist (each-country (p4::type-instances 
			 (is-type-p 
			  'user::country
			  *current-problem-space*)))
	  (if (or
	       (user::true-in-state
		`(user::member-of
		  ,(p4::prodigy-object-name
		    each-country)
		  user::designated-foreign-national-countries))
	       (eq 'user::US
		   (p4::prodigy-object-name
		    each-country)))
	      (dolist (each-pop 
		       (p4::type-instances 
			(is-type-p 
			 'user::population
			 *current-problem-space*)))
		      (if (user::true-in-state
			   `(user::citizen-of
			     ,(p4::prodigy-object-name
			       each-country)
			     ,(p4::prodigy-object-name
			       each-pop)))
			  (pushnew
			   (p4::prodigy-object-name
			    each-pop)
			   *current-population*)))))
  )


;;; Need to make sure that this get initialized upon subsequent runs.
;;; by calling init fn.


(defun next-avail-pop ()
  (pop *current-population*)
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; The following functions and parameters are jade-related code to extract and
;;; print the deployment plan within a mixed employment and deployment plan
;;; produced by Prodigy.
;;;

;;;
;;; NOTE that I used to define this parameter in the domain.lisp file; that is,
;;; the value was domain dependent. See for example goals2/domain.lisp.
;;;
(defparameter 
  *deployment-operators* 
  '(user::send user::deploy user::transit user::deploy-ships 
    user::deploy-air-group user::deploy-tfs user::send-police-with-dog user::send-dog-with-police)
  "A list of operators that represent deployment rather than employment actions.")


;;; Copied from ~mcox/prodigy/Interleave/execute.lisp.
(defun deployment-op-p (node)
  (case (type-of node)
	    ((p4::applied-op-node)
	     (if (member (p4::operator-name 
			  (p4::instantiated-op-op 
			   (p4::applied-op-node-instantiated-op node)))
			 *deployment-operators*)
		 t))
	    ((p4::instantiated-op)
	     (if (member (p4::operator-name 
			  (p4::instantiated-op-op 
			   node))
			 *deployment-operators*)
		 t)))
  )




(defun extract-deployment-plan (&optional
				(print-plan t)
				(plan
				 (user::prodigy-result-solution 
				  user::*prodigy-result*))
				&aux
				(d-plan
				 (deployment-plan 
				  plan)))
  (when print-plan
	(format t "~%Deployment")
	(p4::announce-plan d-plan))
  d-plan
  )


;;; Plan is a list of applied-operators.
;;;
(defun deployment-plan (plan)
  (cond ((null plan)
	 nil)
	((deployment-op-p 
	  (first plan))
	 (cons (first plan)
	       (deployment-plan (rest plan))))
	(t
	 (deployment-plan (rest plan))))
  )


;;; d-plan is a list of instantiated deployment operators.
(defun extract-forces (&optional
		       (d-plan (extract-deployment-plan
				nil)))
  (cond ((null d-plan)
	 nil)
	(t 
	 ;; NOTE that if some step in the plan does not have either a ground,
	 ;; air, or naval unit variable, then nil will be inserted into the
	 ;; list. This is preferable to just leaving it out since it will be
	 ;;easier to debug.
	 (cons 
	  (get-force 
	   (first d-plan))
	  (extract-forces 
	   (rest d-plan)))))
  )



(defun get-force (op)
  (some 
   #'(lambda (each-var 
	      each-val)
       (if (case each-var
		 ((user::<ground-unit>
		   user::<air-unit>
		   user::<naval-unit>)
		  t))
	   (p4::prodigy-object-name 
	    each-val))
       )
   (p4::operator-vars 
    (p4::instantiated-op-op op))
   (p4::instantiated-op-values op))
  )



(defvar *Force-2-FM-map*
  '(user::planm nil user::jack3 nil)
  "Map from a force to the Force Module it belongs in each case.")


(defun assign-mapping (parsed-fm-rep
		       &aux
		       (plan (second 
			      (second parsed-fm-rep)))
		       (FM (second 
			    (first parsed-fm-rep)))
		       )
  (dolist (each-element 
	   (extract-relevant-recs
	    (second (third parsed-fm-rep))))
	  (setf (getf 
		 (getf *Force-2-FM-map* 
		       (if (stringp plan)
			   (intern plan :USER)
			 plan))
		 (if (stringp each-element)
		     (intern each-element :USER)
		   each-element))
		(if (stringp FM)
		    (intern FM :USER)
		  FM)))
  )

(defun extract-relevant-recs (basic-fm-recs)
  (cond ((null basic-fm-recs)
	 nil)
	((member (first basic-fm-recs)
		 '(user::AIRCRAFT-TYPE
		   user::FORCE))
	 (cons (second basic-fm-recs)
	       (extract-relevant-recs
		(rest (rest basic-fm-recs)))))
	(t
	 (extract-relevant-recs
	  (rest (rest basic-fm-recs)))))
  )


(defun init-maps (&aux
		  (input-recs
		   (append
		    (with-open-file (jack 
				     (concatenate
				      'string
				      *format-directory* 
				      "jack3.fm-report")
				     :direction :input)
				    (read jack))
		    (with-open-file (planm
				     (concatenate
				      'string
				      *format-directory* 
				      "planm.fm-report.no-ulns")
				     :direction :input)
				    (read planm)))))
  (dolist (each-rep 
	   input-recs)
	  (let ((arguments 
		 (rest 
		  (rest each-rep))))
	    (assign-mapping
	     (first
	      (parse-fm-reports 
	       (mapcar #'append
		       (first arguments)
		       (second arguments)))))))
  )


;;;
;;; Assumes that there exists an even number of elements in alist.
;;;
(defun odd-elements (alist)
  (cond ((null alist)
	 nil)
	(t
	 (cons 
	  (first alist)
	  (odd-elements 
	   (rest
	    (rest alist))))))
  )

;;;
;;; Currently this function returns an FM only if the force named in the
;;; force-list exactly names something in the *Force-2-FM-map*. That is
;;; (return-fm-home '(meu-soc) '(planm jack3)) returns ((MEU-SOC NTG JACK3)).
;;; (return-fm-home '(11-meu-soc) '(planm jack3)) returns nil. Also need to
;;; returns the lowest-level FM in which a force resides and not a top-level FM
;;; such as T0P. 
;;;
;;; OK (return-fm-home '(11-meu-soc) '(planm jack3)) now returns ((11-MEU-SOC
;;; NTG JACK3)), but probably should return ((11-MEU-SOC MEU-SOC NTG JACK3)) or
;;; something to indicate that the exact match was not obtained.
;;;
(defun return-fm-home (force-list 
		       &optional
		       (candidate-plans
			(odd-elements
			 *Force-2-FM-map*)))
  (remove-duplicates 
   (ret-fm-home force-list 
		candidate-plans)
   :test #'equal)
   )



(defun ret-fm-home (force-list 
		    candidate-plans
		    &aux 
		    (first-force
		     (first force-list))
		    fm)
  (cond ((null force-list)
	 nil)
	((let ((return-val
		(some 
		 #'(lambda (each-plan)
		     (if (setf 
			  fm
			  (getf (getf 
				 *Force-2-FM-map* 
				 each-plan)
				first-force))
			 (list first-force
			       first-force
			       fm
			       each-plan)
		       (if (setf 
			    fm
			    (getf (getf 
				   *Force-2-FM-map* 
				   each-plan)
				  (ret-type
				   first-force)))
			   (list first-force
				 (ret-type
				  first-force)
				 fm 
				 each-plan))))
		 candidate-plans)))
	   (if return-val 
	       (cons 
		return-val 
		(ret-fm-home
		 (rest force-list)
		 candidate-plans)))))
	(t
	 (ret-fm-home
	  (rest force-list)
	  candidate-plans)))
  )


(defun ret-type (name
		 &aux
		 (named-object
		  (p4::object-name-to-object 
		   name
		   *current-problem-space*)))
  (if named-object
      (p4::type-name 
       (p4::prodigy-object-type 
	named-object)))
  )

