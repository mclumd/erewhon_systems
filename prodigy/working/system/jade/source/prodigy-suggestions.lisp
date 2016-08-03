(in-package "FRONT-END")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; 
;;;;			File: prodigy-suggestions.lisp
;;;
;;;
;;; These functions comprise  the  part of the PRODIGY-Analogy/ForMAT front-end
;;; responsible for providing suggestion  to the ForMAT user.  The get-prodigy-
;;; response  function was removed  from  the original file (fake-prodigy.lisp)
;;; written  by  S. Christey of  Mitre. The calling  convention of the function
;;; was changed to pass the entire action received from ForMAT instead  of just
;;; the operator and arguments. Also, the code called in each of the function's
;;; case clauses was removed and rewritten to  form individual functions (e.g.,
;;; destination-suggestions).
;;;
;;; The most important of these functions  is called case-and-query-suggestions
;;; and is  invoked upon detection  of  a :save-goals command  by ForMAT.  This
;;; function   first     parses   the   format  action   that    was passed  to
;;; get-prodigy-response. The call of set-problem  represents  the parse and is
;;; the object of the entire  file called front-end2.lisp.  Once the action  is
;;; parsed  and the     goals  extracted  and  converted   to  PRODIGY-specific
;;; representations, case-and-query-suggestions invokes PRODIGY to come up with
;;; a plan to guide the suggestions.
;;;
;;;;
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; HISTORY
;;;
;;; 17jun98 Implemented code to handle :set-task-status commands from format. [cox]
;;;



;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; GLOBAL VARIABLES
;;;; AND PARAMETERS
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;


(defconstant *unknown-destination* 'WORLD
  "The starting value of *current-destination* before planning is begun."
)


(defvar *current-oplan* nil
  "The name of the current tpfdd or operational plan.")

;;;
;;; Variable *current-destination* takes the place of *geographic-location*
;;; from file front-end.lisp. It represents the destination from the goals
;;; PRODIGY has built.
;;;
(defvar *current-destination* *unknown-destination*
  "The geographic destination for the deployment plan as determined by PRODIGY.")


(defvar *latest-ForMAT-goals* nil
  "The last goal set saved by the ForMAT user.")


(defvar *dependency-list* nil)


;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; UTILITIES
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;


;;;
;;; Function collapse-tree takes a tree in the form of nested sublists, e.g., 
;;; the list (a (b c) (d (e f) g) h), and returns a list with all of the 
;;; elements of the tree in a singles list, e.g., (a c b d g e f h). Note that
;;; the order of the elements within the returned list may not retain 
;;; correspondence with the original tree.
;;;
(defun collapse-tree (tree)
  (assert (listp tree) (tree) 
	  "Tree arg ~S must be a list." tree)
  (collapse tree)
  )

;;;
;;; Function collapse is the actual recursive function that performs the work
;;; for function collapse-tree after the top-level function checks for argument
;;; type consistency.
;;;
(defun collapse (tree)
  (cond ((null tree)
	 nil)
	((atom (first tree))
	 (cons (first tree)
	       (collapse (rest tree))))
	(t
	 (append (collapse (first tree))
		 (collapse (rest tree)))))
  )



(defun access-goal-name (goal)
  (if (eq (first goal) 'user::exists)
      (first (third goal))
    (first goal))
  )

(defun access-last-arg (goal)
  (if (eq (first goal) 'user::exists)
      (first (last (third goal)))
    (first (last goal)))
  )


(defun extract-destination (&optional (goal-list (get-current-goals)))
  (cond ((null goal-list)
	 nil)
	((let ((first-goal (first goal-list)))
	   (if (eq 'user::is-deployed 
		   (access-goal-name 
		    first-goal))
	       (access-last-arg 
		first-goal))))
	(t 
	 (extract-destination 
	  (rest goal-list))))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; SUGGESTION FUNCTION 
;;;; FOR GET-PRODIGY-RESPONSE
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;


;;;
;;; Function destination-suggestions is in response to the ForMAT command
;;; :save-default-features. 
;;;
(defun destination-suggestions (arguments 
				&aux 
				responses 
				(features (first arguments)))
  (dolist 
   (f features)
   (when (eq (first f) 'user::GEOGRAPHIC-LOCATION)
	 ;; Should be eq to what PRODIGY has already built.
	 (when (not (eq *current-destination* 
			(second f)))
;	       (break 
;		"ForMAT user saved default features before defining goals")
	       (setf *current-destination* (second f)))
	 (if (not *JADE-demo-p*) ;;Added to prevent message in Jade demo [cox
				 ;;28apr98]
;;;	     (not-same-dest-as-old-case-p)
	     (push
	      (coerce-to-message
	       (format 
		nil 
		"Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A"
		*current-destination*))
	      responses))
	 ))
  responses
  )


;;;
;;; Function dog-suggestions is in response to the ForMAT command :save-tpfdd.
;;; This is no longer used because the advice is not realistic, given PRODIGY's
;;; knowledge (or lack thereof) of the ForMAT system.
;;;
(defun dog-suggestions ()
  (list
   (coerce-to-message "Find some dog teams. Do the following:
         Make a FM query for  FUNCTION = Supply-units
         AND
           Make TPFDD Query for	Desc = \"%DOG%\
        Select General")
   )
  )

(defvar *best-matches* nil)

;;;
;;; Function case-and-query-suggestions is called when the ForMAT user saves a 
;;; set of planning goals built or changed in the goal editor (ForMAT command 
;;; :save-goals).
;;;
;;; If the programmer calls this function manually to test anything, set
;;; *current-destination* beforehand.
;;;
(defun case-and-query-suggestions (ForMAT-action
				   &optional 
				   called-from-ui
				   (run-prodigy t)
				   &aux responses 
				   )
  (user::set-problem
   ForMAT-action)			; Parse the ForMAT action and
					; create a PRODIGY problem.
  (let ((geo-loc (extract-destination)))
    (if geo-loc
	(setf *current-destination*	; Extract the destination from the
					; PRODIGY goals.
	      geo-loc)))
;  (setf *dependency-list* (change-goals))
  (setf responses 
	(append
	 (mapcar
	  #'(lambda (each-wing)
	      (coerce-to-message
	       (format
		nil 
		"CMDR ~s alerted (F-15, F-16, A-10a) for deployment." 
		each-wing
		))

	      )
	  *early-wings*)
	 (list 
	  (coerce-to-message
	   (format
	    nil 
	    "USS Nimitz Carrier-Battle-Group proceed to Mindanao." 
	    ))))	  
	)
  ;; Allow real case retrieval if *Use-Case-Replay*. [cox 20may98]
  (cond (*Use-Case-Replay*
	 (load-analogy-if-needed called-from-ui)
	 (setf user::*case-headers* nil)
	 (user::replay 
	  :match-threshold 0.7
	  :do-not-replay t 
					;	  :verbose  nil
	  )
;	 (break)
	 (dolist (each-case user::*replay-cases*)
		 (setf 
		  *best-matches*
		  (cons (list (intern 
			       (string-upcase 
				(first each-case)))
			      (cons 'and
				    (third each-case)))
			*best-matches*))
;		 (push (list (intern 
;			      (string-upcase 
;			       (first each-case)))
;			     (cons 'and
;				   (third each-case)))
;		       *best-matches*)
		 )
	 )
	(t
	 (setf *best-matches*
	       (retrieve-best-matches
		(get-goals nil (get-current-goals))))
	 (let ((another-match
		(retrieve-best-matches 
		 (goal-set-difference
		  (get-goals nil 
			     (get-current-goals))
		  (get-goals nil 
			     (cdadar *best-matches*))))))
	   (when another-match
		 (setf *best-matches*
		       (append *best-matches* another-match))))))
  (setf responses 
	(append
	 responses
	 (list 
	  (coerce-to-message
	   (format
	    nil 
	    "The goals of ~s are most similar to this plan." 
	    (get-case-id
	     (first 
	      *best-matches*))))
	  )))
  (format t "~%BEST MATCHES:  ~s~%"
	  *best-matches*)
;;;  (break)
  (when run-prodigy
	(when called-from-ui
	      (user::add-drawing-handler)
					;	(setf user::*user-guidance* t)
	      )
	(cond (*Use-Case-Replay*	;Alow actual case replay [cox 20may98]
	       (user::output-level 3)
	       (if called-from-ui
		   (user::send-to-tcl "DisplayCases"))
	       (user::replay-body 
		:depth-bound 1000
		:merge-mode 'user::saba-cr
		;;	     :verbose  nil
		)
	       )
	      (t
	       (run :output-level 3 
		    :depth-bound 1000))	; Run PRODIGY to create a case.
	      )
	(when called-from-ui
	      (user::remove-drawing-handler)
	      (user::opt-send-final)))

					;  (if (format-action-taken? :create-tpfdd)
					;      (cons (coerce-to-message 
					;	     "Make Query for GOAL = SEND-SECURITY-POLICE")
					;	    responses)
					;)
  (if (> (length *best-matches*) 1)
      (setf responses 
	    (append 
	     responses
	     (list 
	      (coerce-to-message
	       (format
		nil 
		"The following plans are also relevant: ~s." 
		(mapcar
		 #'get-case-id
		 (rest *best-matches*))))))))
  (if *Use-Case-Replay*
      (let ((temp (return-fm-home 
		   (extract-forces))))
	(if temp
	    (setf responses
		  (append 
		   responses
		   (mapcar
		    #'(lambda (each-element)
			(coerce-to-message
			 (format
			  nil 
			  "Copy FM ~S from plan ~S into new plan when created." 
			  (third each-element)
			  (fourth each-element)))
			)
		    temp)
		   )))))
  responses)




;;; [cox 6jun98]
(defun load-analogy-if-needed (&optional
			       called-from-ui)
  (when *Use-Case-Replay*
	(if (not (and (boundp 
		       'user::*analogy-loaded*) 
		      user::*analogy-loaded*))
	    (load 
	     (concatenate
	      'string
	      user::*system-directory*
	      "analogy/loader")))
	(if called-from-ui
	    (user::set-for-replay-ui))
	(setf user::*analogical-replay* t)
	)
  )




;;;
;;; Function tree-diff takes old-tree and "subtracts" the current-tree, 
;;; returning those nodes in the first but not the latter. The rationale for
;;; using this function is as follows.
;;;
;;; To properly suggest that a given Force Module needs to be removed from an
;;; old case when solving for a new situation, we need to be able to compare 
;;; goal trees. Any nodes in the old-case's tree that are missing from the 
;;; current situation needs to be pruned. 
;;;
(defun tree-diff (old-tree current-tree)
  (remove-duplicates
   (set-difference (collapse old-tree )
		  (collapse current-tree)))
  )


(defun not-geo-locs-p (symbol1 symbol2)
  (not 
   (or (isa-p 'user::location symbol1)
       (isa-p 'user::location symbol2)))
  )

(defun siblings-p (obj1 obj2)
  (or (sibling-instances-p obj1 obj2)
      (sibling-types-p obj1 obj2))
  )

(defun sibling-types-p (type1 type2)
  (and (not (is-token-p type1))
       (not (is-token-p type2))
       (eq (P4::super-type type1 *current-problem-space*)
	   (P4::super-type type2 *current-problem-space*)))
  )


(defun sibling-instances-p (obj1 obj2)
  (and (is-token-p obj1)
       (is-token-p obj2)
       (eq (parent-of-instance obj1)
	   (parent-of-instance obj2)))
  )


(defun allign-with-first (list1 list2)
  (cond ((null list1)
	 nil)
	((member (first list1) list2 :test #'(lambda (x y)
					       (and (eq (first x)(first y))
						    (eq (second x)(second y)))))
	 (allign-with-first (rest list1)
			    (remove (find (first list1)
					  list2
					  :test #'(lambda (x y)
					       (and (eq (first x)(first y))
						    (eq (second x)(second y)))))
				    list2)))
	(t
	 (let ((match (find (first list1) list2 :test #'(lambda (x y) (is-similar-p x y)))))
	 (cons match
	       (allign-with-first
		(rest list1)
		(remove match list2))))))
  )


(defun allign-with-itself (list1 list2)
  (cond ((null list1)
	 nil)
	((member (first list1) list2 :test #'(lambda (x y)
					       (and (eq (first x)(first y))
						    (eq (second x)(second y)))))
	 (allign-with-itself (rest list1)
			    (remove (find (first list1)
					  list2
					  :test #'(lambda (x y)
					       (and (eq (first x)(first y))
						    (eq (second x)(second y)))))
				    list2)))
	(t
	 (let ((match (find (first list1) list2 :test #'(lambda (x y) (is-similar-p x y)))))
	 (cons (first list1)
	       (allign-with-itself
		(rest list1)
		(remove match list2))))))
  )


;(defun allign-with-second (list1 list2)
;  (cond ((null list1)
;	 nil)
;	((member (first list1) list2 :test #'equal)
;	 (allign-with-second (rest list1)
;			    (remove (first list1) list2)))
;	(t
;	 (cons (first list1)
;	       (allign-with-second
;		(rest list1)
;		(goal-set-difference list2 (list (first list1)))))))
;  )


;;;
;;; Should really be checking more than just the first arguments of each goal 
;;; pair.
;;;
(defun create-consistency-messages (&aux
				    (common-goals-old
				     (goal-intersection
				      (get-goals (first *best-matches*))
				      (get-goals nil (get-current-goals))))
				    (common-goals-new
				     (goal-intersection
				      (get-goals nil (get-current-goals))
				      (get-goals (first *best-matches*))))
				    )
  (mapcan #'(lambda (old new)
	      (if (and (eq (first old) (first new))
		       (not-geo-locs-p (second old) (second new)))
		  (if (siblings-p (second old) (second new)) 
		      (list 
		       (coerce-to-message 
			(format 
			 nil 
			 "Change ~s to ~s."
			 (second old) 
			 (second new)))))))
	  (allign-with-itself common-goals-old 
			      common-goals-new)
	  (allign-with-first common-goals-old 
			      common-goals-new))
  )


;(defun create-prune-messages (&optional
;			      (extraneous-goals
;			       (goal-set-difference
;				(if *JADE-demo-p*
;				    (union;;Added for JADE demo [9mar98]
;				     (get-goals (first *best-matches*))
;				     (get-goals (second *best-matches*))
;				     :test #'is-similar-p)
;				  (get-goals (first *best-matches*)))
;				(get-goals nil (get-current-goals)))))
;  ;; Should use mapcar like function create-add-messages.
;  (if (not (null extraneous-goals))
;      (cons (coerce-to-message 
;	     (format nil 
;		     "Remove ~s Force Module from Plan."
;		     (second (first extraneous-goals))))
;	    (create-prune-messages (rest extraneous-goals))))
;  )

;;; Changed at DARPA demo [cox 16mar98]
(defun create-prune-messages (&optional
			      (extraneous-goals
			       (goal-set-difference
				(if *JADE-demo-p*
				    (union;;Added for JADE demo [9mar98]
				     (get-goals (first *best-matches*))
				     (get-goals (second *best-matches*))
				     :test #'is-similar-p)
				  (get-goals (first *best-matches*)))
				(get-goals nil (get-current-goals)))))
  ;; Should use mapcar like function create-add-messages.
  (cond ((null extraneous-goals)
	 nil
	 )
	((eq (second (first extraneous-goals))
	     'USER::F117)
	 (cons (coerce-to-message 
		(format nil 
			"Remove ~s Force Module from Plan."
			(second (first extraneous-goals))))
	       (create-prune-messages (rest extraneous-goals)))
	 )
	(t
	 (create-prune-messages (rest extraneous-goals))
	 ))
  )


(defun PRODIGY-2-ForMAT-goal (p-goal
			      &aux
			      (result
			       (PRODIGY-2-ForMAT-goal1 
				(first (get-goals nil (list p-goal))))))
  (if result
      `(,(second result)
	,@(seventh result)))
  )

(defun PRODIGY-2-ForMAT-goal1 (p-goal
			      &optional
			      (fgoals *latest-ForMAT-goals*))
  (cond ((null fgoals)
	 nil)
	((equal p-goal 
		(let ((first-pass (ForMAT-2-PRODIGY-goal 
				   (first fgoals))))
		   (specialize-bindings
		    (first first-pass)
		    (rest first-pass))))
	 (first fgoals))
	(t
	 (PRODIGY-2-ForMAT-goal1 p-goal
				(rest fgoals))))
  )



(defun create-add-messages (&optional
			    (unaddressed-goals
			     (goal-set-difference 
			      (get-goals nil (get-current-goals)) 
			      (if *JADE-demo-p*
				  (union ;;Added for JADE demo [9mar98]
				   (get-goals (first *best-matches*))
				   (get-goals (second *best-matches*))
				   :test #'is-similar-p)
				(get-goals (first *best-matches*))))))
  (mapcar
   #'(lambda (each-goal)
       (coerce-to-message 
	(format 
	 nil 
	 "Copy, Create, or Modify an FM to address goal: ~s."
	 (first each-goal))
	`(:add-goal ,(first each-goal))))
   (mapcar 
    #'PRODIGY-2-ForMAT-goal
    unaddressed-goals))
  )



(defun find-goal-similar-to (old-goal current-goals)
  (find old-goal 
	current-goals 
	:test #'is-similar-p)
  )

;;;
;;; Function consistency-suggestions is in response to the ForMAT command 
;;; :check-goal-consistency. 
;;; 
;;; Note that the PRODIGY plan (solution) can be obtained by the following 
;;; call: (user::prodigy-result-solution *prodigy-result*)
;;;
(defun consistency-suggestions ()
  (append (create-consistency-messages)
;;;	  (create-prune-messages) ;Comment [cox 12apr 98]
	  (create-add-messages))
  )

(defun not-same-dest-as-old-case-p ()
  (not 
   (member *current-destination* 
	   (get-goals (first *best-matches*))
	   :test #'(lambda (x y)
		     (and (eq 'user::is-deployed
			      (first y))
			  (member x y)))))
  )


;;;
;;; Function more-destination-suggestions is in response to the ForMAT command
;;; :add-child.
;;;
(defun more-destination-suggestions (arguments)
  (if (and (not (eq *current-destination*
		    *unknown-destination*))
	   (not-same-dest-as-old-case-p))
      (list
       (coerce-to-message 
	(format 
	 nil 
	 "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A in FM ~A"
	 *current-destination* 
	 (second (first arguments)) ;fmid
	 ))))
  )

;;;
;;; The fmid-mappings is of the form ((<FM-ID> "string")+)
;;;
;;; The recursive function for multiple-destination-suggestions.
(defun m-d-s (fmid-mappings ratio-reports)
  (cond 
   ((null fmid-mappings)
    nil)
   ((dest-cc-not-already-changed-p
     *current-destination* 
     (second (first fmid-mappings))
     *current-oplan*
     ratio-reports)
    (cons
     (coerce-to-message 
      (format 
       nil 
       "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A in FM ~A" 
       *current-destination* 
       (second (first fmid-mappings))))
     (m-d-s (rest fmid-mappings)
	    ratio-reports)))
   (t
    (m-d-s (rest fmid-mappings)
	    ratio-reports)))
  )



;;;
;;; When Prodigy sees the :copy-fm, both the ForMAT action and the arguments
;;; are saved on *old-args* and *old-action*. A request is made for a ratio
;;; report to check the suggestion before they are sent. Then Prodigy returns
;;; control and handles subsequent input. When the ratio report comes in,
;;; function handle-ratio-rep makes the check, and if passing, forms an
;;; appropriate suggestion message for the ForMAT user, sets *alt-available* to
;;; t and reset *old-args* to nil, then returns the message. Function
;;; process-input will then notice that *alt-available* is set, and will as a
;;; result, splice the *old-action* into the :ON-ACTION clause of the output
;;; sent to ForMAT. It then resets both *old-action* and *alt-available*.
;;;

(defvar *old-args* nil)
(defvar *old-action* nil)
(defvar *alt-available* nil)

;;; 23feb cox
(defvar *bad-FM-children* nil 
  "The illegitimate children copied during a copy-fm command")

;;;
;;; Assume that this information comes from an external source.
;;;
(defparameter *early-wings* '(user::18th-wing user::354-wing) "Fighter wings allerted early.")


;;; Added first three FMs so not to generate erroneous message until worked out
;;; inference from basic-fm report. [cox 9mar98]
;;;
;;; Remove the first in the list soon.
;;;
(defparameter 
  *force-list* 
  '(user::25th-id  user::USS-Essex-CVG  user::USS-Nimitz-CVG  
		   user::354-wing user::18th-wing  user::374-aw  
		   user::33-ars  user::3-wing  user::354-wing  
		   user::432-fighter-wing  user::49-fighter-wing  
		   user::388-fighter-wing  user::355-wing  user::6th-id)
;  '(user::AIRCRAFT user::K5B user::TFS user::CV2 user::NTG user::A10 user::A10A user::F16 user::ELECTRONICS user::25th-id  user::25th-id-division-ready-brigade  user::USS-Essex-CVG  user::USS-Nimitz-CVG  user::354-wing user::18th-wing  user::374-aw  user::33-ars  user::3-wing  user::354-wing  user::432-fighter-wing  user::49-fighter-wing  user::388-fighter-wing  user::355-wing  user::6th-id)
  "The list of available forces for the JADE demo.")

(defparameter *JADE-demo-p* t 
  "If t, then this is the JADE demo.")


;;;
;;; So really need to send off the requests (unless we already know that all
;;; changes have been made previously), squirel away the current arguments,
;;; record that there is an outstanding request to be serviced, and then allow
;;; the code in handle-ratio-rep to call m-d-s. What to do if the ForMAT user
;;; performs another copy-fm command before the request is serviced?
;;;
(defun multiple-destination-suggestions (arguments ForMAT-action)
  (if (not (null *old-args*))
      (cerror "Continue"
	      "Second :copy-fm command before receiving ratio-report."))
  (when *current-oplan*
	(request-reports
	 *current-oplan* 
	 ;; If I tack back on the :copy-fm symbol, the arguments list is really
	 ;; a disembodied property list. [cox 10apr98]
	 (getf (cons :copy-fm arguments) :FMID-MAPPING)
	 ;;(seventh arguments)
	 ':ratio-rep
	 )
	(request-reports
	 *current-oplan* 
	 (getf (cons :copy-fm arguments) :FMID-MAPPING)
	 ':basic-fm-rep
	 ))
  (setf *old-args* arguments)
  (setf *old-action* ForMAT-action)
  ;; The following needs to go into handle-ratio-rep
;  (if (eq :COPY-CHILDREN (second arguments))
;      (setf *bad-FM-children* 
;	    (bad-fm-messages
;	     (mapcar 
;	      #'(lambda (x)
;		  (list (first x)))
;	      (getf (cons :copy-fm arguments) :FMID-MAPPING)
;	      ;; (seventh arguments)
;	      ))))
  (or (and *JADE-demo-p* *bad-FM-children*)
      (list (dummy-msg)))
  ;; (if (not-same-dest-as-old-case-p)
  ;;     (reverse (m-d-s (seventh arguments))))
  )

;;;(:MESSAGE 2 "Remove F-117s from Force Module XXX" 
;;; (:REMOVE-ULN :FM TFS :FEATURE AIRCRAFT-TYPE :VALUE "3FA%"))


;;; 23feb cox
(defun bad-fm-messages (forces-copied 
			&optional 
			fm
			user-goals
			)
  (cond ((null forces-copied)
	 NIL)
	((equal forces-copied '(aircraft))
	 nil)
	((and (consp (first forces-copied))
	      (force-available
	       (first 
		(first forces-copied))))
	 (bad-fm-messages (rest forces-copied)
			  fm
			  user-goals))
	((and (atom (first forces-copied))
	      (force-available
	       (first forces-copied)))
	 (bad-fm-messages (rest forces-copied)
			  fm
			  user-goals))
	(t 
;	 (watchdog::watchdog-send-message 
;	  (format 
;	   nil 
;	   "(:ON-ACTION () (:MESSAGE ~s \"Remove ~s from Force Module ~s.\" (:REMOVE-ULN :FM ~s :FEATURE AIRCRAFT-TYPE :VALUE ~s)))~%" 
;	   (incf *message-counter*)
;	   (first forces-copied)
;	   fm
;	   fm
;	   (first forces-copied)
;	   )
;	  :convert nil)
	 (cons 
	  (if (has-goal-2-send-anyhow-p
	       (first forces-copied) user-goals)
	      (coerce-to-message 
	       (format 
		nil 
		"Request additional force of type ~s from CINC."
		(first forces-copied)
		))
	    ;;Changed syntax [cox 10apr98]
	    (coerce-to-message 
	     (format 
	      nil 
	      "Remove ~s ULNs from Force Module ~a."
	      (first forces-copied)
	      fm
	      )
	     `(:REMOVE-ULN :FM ,fm 
			   :FEATURE user::AIRCRAFT-TYPE 
			   :VALUE ,(first forces-copied))
	     ;;	   (format 
	     ;;	    nil 
	     ;;	    "Force module ~s not on force list from CINC. "
	     ;;	    (first forces-copied)
	     ;;	    )
	     ))
	  (bad-fm-messages (rest forces-copied)
			   fm
			   user-goals))
	 )
	)
  )



(defun has-goal-2-send-anyhow-p
  (force-copied user-goals)
  (if (member force-copied
	      user-goals
	      :test
	      #'(lambda (force-copied 
			 user-goal)
		  (member force-copied
			  (seventh user-goal) ; Attribute list.
			  :test
			  #'(lambda (force-copied attribute)
			      (or (and (eq (first attribute)
					   'user::FORCE)
				       (eq (second attribute)
					   force-copied))
				  (and (eq (first attribute)
					   'user::AIRCRAFT-TYPE)
				       (eq (second attribute)
					   force-copied))
				  )))))
      t)
  )


;;;
;;; Function yet-another-destination-suggestion is in response to the ForMAT 
;;; command :add-parent.
;;;
(defun yet-another-destination-suggestion (arguments ForMAT-action)
  (if (not (null *old-args*))
      (cerror "Continue"
	      "Second :add-parent command before receiving ratio-report."))
  (if (not-same-dest-as-old-case-p)
      (list
       (coerce-to-message 
	(format 
	 nil 
	 "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A in FM ~A"
	 *current-destination* 
	 (second (first (rest arguments))) ;fmid
	 ))))
  )


;; SMC 3/25/1996.  
;;;
;;; Function final-destination-suggestion is in response to the ForMAT command 
;;; :add-fm-feature.
;;;
(defun final-destination-suggestion (arguments)
  (if (and (eq 'user::GEOGRAPHIC-LOCATION (first (first arguments)))
	   (not-same-dest-as-old-case-p))
      (list
       (coerce-to-message 
	(format 
	 nil 
	 "Change POD, POD-CC, DEST, and DEST-CC to places in or near ~A in FM ~A"
	 *current-destination* 
	 (second arguments)))
	 ))
  )


(defun trigger-deployment-alert (arguments)
  (list
   (if (and (eq (first arguments) :goal)
	    (eq (second arguments) :air-defense))
       (coerce-to-message 
	(format 
	 nil 
	 "25th-ID-READY-BRIGADE is alerted to begin deployment."))
     (dummy-msg))
   )
  )

;;;
;;; Return dummy message because there will be no return message to ForMAT as a
;;; result of this input. Only the side-effect of saving the OPlan name is
;;; necessary.
;;;
(defun note-new-oplan (arguments)
  "Save the OPlan name for later use."
  (cond ((null *current-oplan*)
	 (setf *current-oplan* (first arguments))
	 (format t 
		 "~%Current OPLAN is ~S~%"
		 *current-oplan*))
	(t
	 (format t 
		 "~%Changing OPLAN from ~s to ~S~%"
		 *current-oplan*
		 (first arguments))
	 (setf *current-oplan* (first arguments))))
  (list (dummy-msg))
  )


;;;
;;; If *old-args* (= arguments) exist, then there was an earlier :copy-fm
;;; command performed and a ratio-report request outstanding for handling that
;;; command. If not, ForMAT user performed the report on his own, so process
;;; ratio reports normally. If m-d-s returns nil, then reset *old-actions*
;;; otherwise set *alt-available*.
;;;
;;; Used to return the following for testing:
;    (list
;     (coerce-to-message 
;      (format 
;       nil 
;       "Parsed ratio report is ~S"
;       parsed-reps)))
;;;
;;; To see what get-records is doing, try the following: 
;;; (get-records 'aircraft-type 
;;;             (second (third (first 
;;;                              (parse-ratio-reports (third *sample-input*))))))
;;;
(defun handle-ratio-rep (parsed-reps
			 &optional
			 (arguments *old-args*)
			 &aux
			 result
			 copied-forces
			 temp
			 )
  (push parsed-reps *ratio-reports*)
  ;; Reset the :copy-fm arguments and action saved earlier
  (when arguments
	(setf *old-args* nil)
	
	(if (setf result
		  (dolist 
		   (each-element 
		    (mapcar 
		     #'(lambda (each-rep)
			 (bad-fm-messages
			  (return-leaves 
			   (build-aircraft-tree
			    (get-records 'user::aircraft-type 
					 ;;The ratio report body
					 (second (third
						  each-rep)))))
			  ;; The name of the copied fm.
			  (second (first
				   each-rep))
			  ;; The ForMAT user's goals
			  *latest-ForMAT-goals*
			  ))
		     parsed-reps)
		    temp)
		   (setf temp
			 (append temp each-element)))
		  ;; [cox 10apr98]
		  ;;Commented out below form and replaced by above form 
		  ;;[cox 22apr98]
		  ;;	  (bad-fm-messages
		  ;;	   (return-leaves 
		  ;;	    (build-aircraft-tree
		  ;;	     (get-records 'user::aircraft-type 
		  ;;			  (second 
		  ;;			   (third
		  ;;			    (first parsed-reps))))))
		  ;;	   ;; The copied fm.
		  ;;	   (second (first arguments))
		  ;;	   ;; The ForMAT user's goals
		  ;;	   *latest-ForMAT-goals*
		  ;;	   )
		  ;; To do the following, I need to know which case they came
		  ;; from, and there can be more than one. [cox 16apr98]
		  ;;(if (not-same-dest-as-old-case-p)
		  ;;		      (reverse (m-d-s (seventh arguments)
		  ;;				      parsed-reps))
		  ;;		    )
		  )
	    (setf *alt-available* t)
	  (setf *old-action* nil))
	)
  (or result
      (list (dummy-msg)))
  )



(defun handle-fm-rep (parsed-reps
		      &optional
		      (arguments *old-args*)
		      &aux
		      result
		      copied-forces)
  (format t
	  "~%Parsed Basic FM  Reports: ~s~%"
	  parsed-reps)
  (or result
      (list (dummy-msg)))
  )


;;;
;;; Remove any arguments with dummy features. E.g., (ac-type ???)
;;;
(defun strip-dummy-args (ForMAT-action)
  (cond ((null ForMAT-action)
	 nil)
	((atom ForMAT-action)
	  ForMAT-action)
	((and
	  ;;Current dest has been set
	  (not (eq *current-destination*
		   *unknown-destination*))
	  (consp (first ForMAT-action))
	  (eq (length (first ForMAT-action)) 2)
	  (atom (first (first ForMAT-action)))
	  (eq 'user::GEOGRAPHIC-LOCATION (first (first ForMAT-action)))
	  (eq 'USER::??? (second (first ForMAT-action))))
	 ;;Use default geographic location
	 (cons (list (first (first ForMAT-action)) 
		     *current-destination*)
	       (strip-dummy-args (rest ForMAT-action)))
	 )
	((and
	  (consp (first ForMAT-action))
	  (eq (length (first ForMAT-action)) 2)
	  (atom (first (first ForMAT-action)))
	  (eq 'USER::??? (second (first ForMAT-action))))
	 (strip-dummy-args (rest ForMAT-action)))
	(t 
	 (cons (strip-dummy-args (first ForMAT-action))
	       (strip-dummy-args (rest ForMAT-action)))))
  )

#| 
Example ForMAT input. The last two (49 and 50) are the accepts the function
needs to register.

("7/17/1996: 16:13:33" :SET-TASK-STATUS 
 ((61
   "Add or create a Force Module to address goal (:SECURE-TOWN-CENTER-HALL
                                              (GEOGRAPHIC-LOCATION BOSNIA))."
   NIL)
  (60 "Remove BRIGADE Force Module from Plan." :ACCEPT)
  (59 "Remove HAWK-BATTALION Force Module from Plan." :ACCEPT)
  (57 "Change F15 to A10A." NIL)
  (51
   "Change POD, POD-CC, DEST, and DEST-CC to places in or near BOSNIA in FM T9P"
   NIL)
  (50
   "Change POD, POD-CC, DEST, and DEST-CC to places in or near BOSNIA"
   NIL)
  (49 "The following cases are also relevant: (PLANE)." :ACCEPT)
  (48 "The goals of PLANC are most similar to this plan." :ACCEPT)))

|#
;;;
;;; Function accepted-past-cases takes as input the arguments of a ForMAT
;;; command such as the one above (the arguments being the caddr of it), and
;;; outputs lists of accepted, rejected, and ignored suggestions (each of these
;;; three being a list of message numbers). So given the input above, the
;;; functions returns (48 49 59 60) nil and nil as its three results. 
;;;
;;; NOTE that the last sentence above is no longer true. Instead, the function
;;; returns lists of string that represent the corresponding message string
;;; accepted, rejected, and ignored.
;;;
(defun accepted-past-cases (arguments
			    &aux
			    accepts
			    rejects
			    ignores)
  (dolist (each-arg arguments)
	  (case (third each-arg)
		(:ACCEPT 
		 (push (second each-arg) accepts))
		(:REJECT
		 (push (second each-arg) rejects))
		(:IGNORE
		 (push (second each-arg) ignores))
		))
  (values accepts rejects ignores)
  )


(defvar *case-candidates* nil)

;;;
;;; For now, the function process-ForMAT-user-feedback uses only the primary
;;; return value from accepted-past-cases. It returns a dummy message (and thus
;;; will not use the return value for further suggestions to the ForMAT
;;; user. Instead, the function has the side-effect of setting the value of the
;;; global *case-candidates* to any case offered by a past suggestion as
;;; similar and accepted by the user. 
;;;
(defun process-ForMAT-user-feedback (arguments
				     &aux
				     candidate)
  (dolist (each-accepted
	   (accepted-past-cases arguments))
	  (if (setf candidate
		    (or (read-from-string
			 (user::matches-initial-substr 
			  "The goals of " 
			  each-accepted))
			(read-from-string
			 (user::matches-initial-substr 
			  "The following cases are also relevant: " 
			  each-accepted))))
	      (setf *case-candidates*
		    (if (listp candidate)
			(append candidate
			  *case-candidates*)
		      (cons candidate
			  *case-candidates*)))))
  (list (dummy-msg))
  )


;;;
;;; This function used to be contained within file fake-prodigy.lisp
;;; 
;;; Parameter op is the ForMAT operator (i.e., command). It is the second in
;;; the list that comprises the ForMAT-action. Note that the first in the list
;;; is a time stamp. The rest of the list is the arguments and vary depending
;;; on the ForMAT op.
;;;
(defun get-prodigy-response (ForMAT-action
			     &optional 
			     called-from-ui
			     (run-prodigy t)
			     )
  (setf ForMAT-action
	(strip-dummy-args 
	 ForMAT-action))
  (let ((op (second ForMAT-action))
	(arguments 
	 (rest 
	  (rest 
	   ForMAT-action))))
    ;; SMC 3/25/1996.  Only return messages that are active.
    (remove-if-not 
     #'status 
     (case op
	   ;; SMC 3/21/1996.  Special case: enable/disable Prodigy tasks.
	   (:completed-prodigy-tasks
	    (mark-tasks-completed (first arguments))
	    )
	   ;;	 (:build-tpfdd
	   ;;	  nil
	   ;;	  )
	   (:save-default-features
	    (destination-suggestions arguments)
	    )
					;	 (:save-tpfdd
					;	  (dog-suggestions)
					;	  )
	   (:save-goals
	    (case-and-query-suggestions ForMAT-action called-from-ui run-prodigy)
	    )
	   (:check-goal-consistency
	    (consistency-suggestions)
	    )
	   (:add-child ;; Used to include :create-fm
	    (more-destination-suggestions arguments)
	    )
	   (:copy-fm
	    (multiple-destination-suggestions arguments ForMAT-action)
	    )
	   (:add-parent
	    (yet-another-destination-suggestion arguments ForMAT-action)
	    )
	   ((:add-fm-feature :change-feature-value)
	    (final-destination-suggestion arguments)
	    )
	   (:copy-goals-to-features
	    (trigger-deployment-alert arguments)
	    )
	   (:create-tpfdd 
	    (note-new-oplan arguments))
	   (:report-p4-ratios-report ;report-uln-ratios-report is not
				       ;included because it is requested by
				       ;ForMAT user, not Prodigy
	    (handle-ratio-rep 
	     (parse-ratio-reports (mapcar #'append
					  (first arguments)
					  (second arguments)))))
	   (:report-p4-basic-report
	    (handle-fm-rep 
	     (parse-fm-reports (mapcar #'append
					  (first arguments)
					  (second arguments)))))
	   (:set-task-status
	    (process-ForMAT-user-feedback arguments))
	   )))
  )


