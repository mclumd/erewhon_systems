;;;
;;; kqml.lisp : Problem Solver I/O using KQML messages
;;;
;;; George Ferguson, ferguson@cs.rochester.edu, 13 Dec 1995
;;; Time-stamp: <96/11/16 15:33:18 james>
;;;

(in-package "PSM")

(defvar *log-stream* nil
  "Stream for logging i/o to/from PSM. This is nil when running within
Lisp (meaning logging is effectively disabled), or is opened by the
restart function when running from a dumped Lisp.")

(defun kqml-psm ()
  "Main loop for the PSM. Reads a KQML message from standard input and
calls the approriate function to handle it. Lisp exits on EOF."
  	;; Open stream for logging psm i/o
  (let ((*package* (find-package "PSM")))
	
    ;; Tell the PM we're ready
    (kqml-output 'tell :receiver 'im :content '(ready))
    (loop
     (let ((performative (read *standard-input* nil nil)))
       ;; Log receipt
       (when *log-stream*
	 (prin1 performative *log-stream*)
	 (format *log-stream* "~%")
	 (finish-output *log-stream*))
       ;; Now decide what to do with the performative
       (cond
	((eq performative nil)			; end-of-file, we should exit
	 (excl:exit 0 :quiet t))
	((not (consp performative))		; not a list -> error
	 (format *error-output*
		 "kqml-psm: invalid input: \"~A\"~%" performative))
	((oddp (length performative))				; otherwise check verb...
	 (case (car performative)
	   ((tell request)
	    (apply #'kqml-psm-request (cdr performative)))
	   (ask-if
	    (apply #'kqml-psm-ask-if (cdr performative)))
	   (ask-one
	     (apply #'kqml-psm-ask-one (cdr performative)))
	   (ask-all
	    (apply #'kqml-psm-ask-all (cdr performative)))
	   (assert
	       (apply #'kqml-psm-assert (cdr performative)))
	   (reply 
	    ;; igoring replies
	    )
	   (error
	    (when *log-stream*
	      (format *log-stream* "Igoring Error Message: ~S~%" performative)
	      (finish-output *log-stream*)))
	   (otherwise			; Unknown performative!
	    (let ((sender (kqml-sender-of-performative performative)))
	      (kqml-output 'error :receiver sender :code 520
			   :comment (format nil "bad performative: ~S"
					    performative))))))
	;;  Ill-formed message
	(t (list 'error :comment (Format nil "Wrong number of args in preformative: ~S" performative)))
			   
	))))) 

(defun kqml-psm-request (&key sender content reply-with re &allow-other-keys)
  "Handles REQUEST or TELL messages received by the PSM. The content is
passed to the function `handle-psm-request'. If it returns something other
than t or nil, that something is sent as an output message of the parser."
  (if (consp content)
      (case (car content)
	(exit					; EXIT
	 (excl:exit 0 :quiet t))
	(chdir					; CHDIR
	 (let* ((dir (cadr content))
		(logfile (format nil "~A/ps.log" dir)))
	   (when *log-stream* (close *log-stream*))
	   (setq *log-stream* (open logfile :direction :output
				    :if-exists :supersede
				    :if-does-not-exist :create))))
	((start-conversation end-conversation)	; START/END-CONVERSATION
	 (format *log-stream* "~%;; %S~%" (car content)))
	(handle-question
	 (if *initialized* (handle-question-msg content))) ;; ignore until a sceanrio has been defined
	(otherwise	 			; else process it
	 (make-kqml-response (handle-psm-request content) sender reply-with re)))
    (make-kqml-response (list 'error :comment (Format nil "Bad content: ~s" content)) sender reply-with re)))
  
(defun kqml-psm-ask-if (&key sender content aspect reply-with re &allow-other-keys)
 "If it returns something other than t or nil, that
something is sent as an output message of the parser."
  (make-kqml-response (handle-psm-query 'ask-if content aspect) sender reply-with re))

  
(defun kqml-psm-ask-one (&key sender content aspect reply-with re &allow-other-keys)
 "If it returns something other than t or nil, that
something is sent as an output message of the parser."
   (make-kqml-response (handle-psm-query 'ask-one content aspect) sender reply-with re))

  
(defun kqml-psm-ask-all (&key sender content aspect reply-with re &allow-other-keys)
 "If it returns something other than t or nil, that
something is sent as an output message of the parser."
   (make-kqml-response (handle-psm-query 'ask-all content aspect) sender reply-with re))

(defun kqml-psm-assert (&key sender content reply-with re &allow-other-keys)
  "If it returns something other than t or nil, that
something is sent as an output message of the parser."
    (make-kqml-response (handle-psm-assert content) sender reply-with re))

(defun make-kqml-response  (content receiver in-reply-to re)
  (if (consp content)
      (case (car content)
	((ANSWER :ANSWER)
	 (if in-reply-to
	     (apply #'kqml-output
		    (list 'reply :content content :receiver receiver 
			  :in-reply-to in-reply-to :re re))
	   (apply #'kqml-output (list 'reply :content content 
				      :receiver receiver :re re))))
	((error sorry)
	 (if in-reply-to
	     (apply #'kqml-output (append content (list :receiver receiver
							:in-reply-to in-reply-to :re re)))
	   (apply #'kqml-output (append content (list :receiver receiver :re re))))
	 )
	(otherwise
	 (apply #'kqml-output (list 'sorry :comment :unknown-error :receiver receiver :in-reply-to in-reply-to :re re))))))

;;(defun make-kqml-sorry (code comment)
;;   (if comment 
;;      (apply #'kqml-output (list 'sorry :code code :comment comment))
;;    (apply #'kqml-output (list 'sorry :code code))))

    
(defun kqml-output (verb &rest parms)
  "Format KQML message with performative VERB. Other keyword arguments
   used as parameters of the messages. This results in a message being printed
    to standard output."
  (format *standard-output* "~S~%" (cons verb parms))
  (finish-output *standard-output*)
  (when *log-stream*
    (format *log-stream* "~S~%" (cons verb parms))
    (finish-output *log-stream*)))

(defun kqml-sender-of-performative (perf)
  "Returns the value of :sender in PERF, or nil."
  (kqml-find-sender-in-args (cdr perf)))

(defun kqml-find-sender-in-args (args)
  (cond
   ((< (length args) 2)
    nil)
   ((eq (car args) :sender)
    (cadr args))
   (t
    (kqml-find-sender-in-args (cddr args)))))
    
;; GENERAL WARNING/ERROR FUNCTION
;;  set *PSM-INTERRUPTABLE* to NIL if you want to inhibit break points in
;;  demo system - in which case it logs the problem and returns an error message

(defun psm-warn (f a)
  (if  *PSM-interruptable*
      (let nil
	 (format t "~%~%PSM WARNING: ")
	 (format t f a)
	 (break))
       (let nil
	 (format *log-stream* "PSM WARNING:")
	 (format *log-stream*  f a)
	 (list 'sorry :comment (format nil f a)))))


(defun make-error-msg (msg)
  (list 'error :comment msg))

(defun make-sorry-msg (msg)
  (list 'sorry :comment msg))

;;;=============
;;
;;  Code to handle questions for '96 evaluation


(defun handle-question-msg (content)
  (let* ((args (cadr content))
	(query-type (car args))
	(route-descr (cadr args)))
    
    (if (and (or (and (consp route-descr) (eq (car route-descr) :path))
		 (null route-descr))
	     (consp query-type) (eq (car query-type) :how-much))
	(handle-question (cadr query-type) (cdr route-descr))
      (make-error-msg (format nil "Bad format for HANDLE-QUESTION:~S" content)))))
	
(defun handle-question (quantity route-constraints)
  (let ((ans (find-plan-id-for-route (fixup-constraints route-constraints) route-constraints)))
    (if ans
	(if (and (consp ans) (eq (car ans) 'error))
	    ;;  error found
	    (generate-hack (cadr ans))
	  ;; no error, ANS = the plan
	  (case quantity
	    (:TIME-DURATION
	     (let ((duration (quick-query 'ask-one `(:DURATION ?x ,ans) '?x)))
	       (if (numberp duration)
		   (generate-hack (format nil "~A will take ~A hours"
					  (describe-route ans)
					  (round duration)))
		 (generate-hack (format nil "Sorry I can not find the duration of ~A" (describe-route ans))))))
	    (:DISTANCE
	      (let ((distance (quick-query 'ask-one `(:DISTANCE ?x ,ans) '?x)))
	       (if (numberp distance)
		   (generate-hack (format nil "~A is ~A miles long" 
					  (describe-route ans)
					  (round distance)))
		 (generate-hack (format nil "Sorry, I can not find the distance of ~A" (describe-route ans))))))
	    (otherwise (generate-hack "I can not answer that question")))
	  )
      (if route-constraints (generate-hack "You have to define the route before I can answer that")
	(generate-hack "I don't know what route you are talking about")))))

(defun find-plan-id-for-route (route-constraints original-constraints)
  ;;  First identify the route, using the following preferences
  ;;  - focussed-plan, any plan
  (let* ((task-tree (current-pss))
	 (st (task-tree-symbol-table task-tree))
	 (focus-plan (task-tree-focus task-tree))
	 (constraints (if (equal route-constraints '(nil))
			  nil
			route-constraints))
	 ;; find all plans that satisfy the constraints
	 (possible-plans 
	  (remove-if-not #'(lambda (p)
			     (let ((soln (task-solution (task-node-content (get-node-by-name p st)))))
			       (and soln (all-constraints-redundant :go soln constraints))))
			 (task-tree-leaf-cache task-tree))))
    ;; If the route is described as "other", remove the focus plan from the candidates
    (when (some #'(lambda (x) (eq (car x) :OTHER)) original-constraints)
      (setq possible-plans (remove-if #'(lambda (x) (eq x focus-plan)) possible-plans)))
	
    (if possible-plans
	(if (> (length possible-plans) 1)
	    (if (member focus-plan possible-plans)
		focus-plan
	      '(error "I don't know which route you are talking about"))
	  (car possible-plans)))
    ))
	     

(defun generate-hack (x)
  (kqml-output 'request :receiver 'transcript :content (list 'log (format nil "SYS say ~A." x)))
  (kqml-output 'request :receiver 'speech-out :content (list 'say (concatenate 'string x ".")))
  )

(defun describe-route (plan-id)
  (let* ((st (task-tree-symbol-table (current-pss)))
	 (objective (task-objective (task-node-content (get-node-by-name plan-id st))))
	 (from (find-constraint-in-act objective :from))
	 (to (find-constraint-in-act objective :to))
	 (output "the current route"))
    (when from
      (setq output (concatenate 'string output " from " (string-downcase (format nil "~S" (car from))))))
    (when to
      (setq output (concatenate 'string output " to " (string-downcase (format nil "~S" (car to))))))
    ))


;; FIXUP CONSTRAINTS
;; This checks that each constraint is meaningful to the PS, 
;;  and dekeywordifies the values


(defun fixup-constraints (clist)
  (if (equal clist '(nil))
      clist
    (mapcan #'(lambda (x)
		(let ((name (check-constraint-name (car x))))
		  (if name 
		      (list (cons name (dekeywordify (cdr x)))))))
	    clist)))

(defun check-constraint-name (name)
  (cond ((member name '(:TO :FROM :VIA :USE :AVOID :AGENT :DIRECTLY))
	 name)
	((eq name :ASSOC-WITH)
	 :use)))

(defun dekeywordify (x)
  (cond ((consp x)
	 (mapcar #'dekeywordify x))
	((numberp x) x)
	((symbolp x)
	 (read-from-string (symbol-name x)))
	(t x)))
  
