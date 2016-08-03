(in-package "PSM")

(defun handle-psm-request (content)
  (if (content-OK content)
      (let ((sa (car content))
            (args (cdr content)))
	(case sa
	  (:CLEAR
	   (let ((ps-state (caar (init-psm))))
	     (clear-tables)
	     (list 'ANSWER :RESULT '(:CLEARED) :PLAN-ID *ROOT-NODE-NAME* :PS-STATE ps-state)))
	      ;; Starting a new scenario, e.g., (:NEW-SCENARIO (:AND (:AT-LOC eng1 atlanta) 
	      ;;                                                (:TYPE eng2 :ENGINE)))
	  (:NEW-SCENARIO
	   (setq *initialized* t)
	   (let ((ps-state (caar (init-psm))))
	     (init-KB)
	     (reset-map)
	     (clear-tables)
	     (handle-psm-assert (find-arg args :CONTENT))
	     (list 'ANSWER :RESULT '(:CLEARED) :PLAN-ID *ROOT-NODE-NAME* :PS-STATE ps-state))
	   )
	  
	  (:NEW-PROBLEM
	   (setq *initialized* t)
	   (let ((ps-state (caar (init-psm))))
	     (init-KB)
	     (clear-tables)
	     (handle-psm-assert (find-arg args :CONTENT))
	     (list 'ANSWER :RESULT '(:CLEARED) :PLAN-ID *ROOT-NODE-NAME* :PS-STATE ps-state))
	   )
	  
	  (:UNDO ;; Note this is a crude UNDO as it can't be later undone itself
	   (when *initialized*
	     (let ((ps-state-to-revert-to (find-arg args :PS-STATE)))
	     (let ((changes (UNDO-PSM ps-state-to-revert-to)))
	       (if (eq (car changes) 'error)
		   (prep-reply-message (build-impossible-answer :cant-undo-initial-state))
		 (let*
		     ((st (task-tree-symbol-table (current-pss)))
		      (changed-plans (remove-if-not #'(lambda (x) (get-node-by-name x st)) changes))
		      (deleted-plans (remove-if  #'(lambda (x) (get-node-by-name x st)) changes)))
		   (list 'ANSWER :RESULT `(:UNDONE :changed-plans ,changed-plans :deleted-plans ,deleted-plans) 
			 :PS-STATE (current-pss-id))))))))
	 
	  (:find-solution
	   (when *initialized*
	     (let ((ans (solve (find-arg args :CONTENT))))
	       (if ans (cons 'answer ans)))))

	  (otherwise ;; a plan/domain action
	   (when *initialized*
	     (let*
	       ((focus-pss (current-pss))
		(ST (task-tree-symbol-table focus-pss))
		(new-content (prep-message-for-processing content))
		(plan (get-node-by-name (find-arg args :PLAN-ID) ST)))
	     (if (and (consp new-content) (not (eq (car new-content) 'error)))
		 (prep-reply-message
		  (interpret-sa new-content focus-pss 
				(if plan plan (task-tree-focus focus-pss))))
	       new-content ;; return error message
	       ))))

	  
	  )				; END CASE
	)				; end LET
    (make-error-msg (format nil "Ill-formed content: ~S" content))
    ))

(defun clear-tables nil
  (clear-message-symbol-table)
  (clear-symbol-tables))
  
(defun content-OK (content)
  "Content must be of form (<atom> (<keyword> <value>)*)"
  (when (consp content)
    (and (symbolp (car content))
	 (check-keyword-values (cdr content)))))

(defun check-keyword-values (pairs)
  (if (null pairs) T
    (and (keywordp (car pairs))
	 (consp (cdr pairs))
	 (listp (cddr pairs))
	 (check-keyword-values (cddr pairs)))))

;; ======================
;;
;;  ENCODING MESSAGES
;;
;; In order to cut down on message traffic, we store here information that is not
;;  used by other modules except to pass back to the PSM (essentially update information)


;; the MESSAGE-SYMBOL-TABLE stores information for later retrieval

(let ((MESSAGE-SYMBOL-TABLE))

  (defun encode-update (answer)
    (let ((id (gensymbol 'PSS))
	  (psm-update (answer-psm-update answer))
	  (parent (answer-node-name answer)))
      (setq MESSAGE-SYMBOL-TABLE 
            (cons (cons id (cons parent psm-update))
                  MESSAGE-SYMBOL-TABLE))
      id))

  (defun find-update (id)
    (cdr (assoc id MESSAGE-SYMBOL-TABLE)))

  (defun get-message-symbol-table nil
    MESSAGE-SYMBOL-TABLE)

  (defun clear-message-symbol-table nil
    (setq MESSAGE-SYMBOL-TABLE nil))

)  ; end scope of MESSAGE-SYMBOL-TABLE

(defun prep-reply-message (answer)
  "This prepares and ANSWER structure for passing out. It makes everything into
      a list, and condenses the message by encoding information other modules 
      don't need"
  (cond
   ((answer-p answer)
    (let*
      ((update-id (encode-update answer)))
      (list :ANSWER
            :recognition-score (answer-recognition-score answer)
            :Answer-score   (answer-answer-score answer)
            :ps-state     update-id
            :Result         (answer-result answer)
            :Reason         (listify-answer (answer-reason answer)))))
   ((listp answer) answer)
   (t
    (PSM-Warn "~%PSM did not return and answer structure: ~S" answer)
    answer)))
    
(defun prep-message-for-processing (msg)
  "This converts a list into structures, and expands encoded information"
  (let* ((pss-id (find-arg (cdr msg) :PS-STATE))
	 (update (find-update pss-id)))
	(case (car msg)
	  (:UPDATE-PSS
	   (if (consp update)
	       (list :UPDATE-PSS
		     :PLAN-ID (find-arg (cdr msg) :PLAN-ID)
		     :parent (car update)
		     :ps-state pss-id
		     :CONTENT (cdr update))
	    (make-error-msg (format nil "Unknown PS STATE ID: ~A" pss-id))))
	  (otherwise
	   msg))
     )
  )
    
(defun listify-answer (answer)
  (cond
   ((answer-p answer)
    (list :ANSWER :Recognition-score (answer-recognition-score answer)
          :Answer-score   (answer-answer-score answer)
          :ps-state     (listify-answer (answer-psm-update answer))
          :Result         (answer-result answer)
          :Reason         (listify-answer (answer-reason answer))
          :node-name (answer-node-name answer)))
   ((reason-p answer)
    (if (eq (reason-type answer) :and)
	(list :REASON :type :AND
	      :info (mapcar #'listify-answer (reason-info answer))
	      :msg (reason-msg answer))
      (list :REASON 
	    :type (reason-type answer)
	    :info (reason-info answer)
	    :msg (reason-msg answer))))
   ((solution-set-p answer)
    (list :SOLUTION-SET
	  :name (solution-set-name answer)
          :action-type (solution-set-action-type answer)
          :filters (solution-set-filters answer)
	  :preference-function (solution-set-preference-function answer)
	  :decomposition (solution-set-decomposition answer)
          :domain-info (listify-answer (solution-set-domain-info answer))))
   ((route-soln-p answer)
    (list :current (route-soln-current answer)
	  :alternates (route-soln-alternates answer)
	  :rejects (route-soln-rejects answer)))
   ((consp answer)
    (mapcar #'listify-answer answer))
   (t answer)))

(defun de-listify-answer (answer)
  (if (consp answer)
    (let ((args (cdr answer)))
      (if (symbolp (car answer))
        (case (car answer)
          (:ANSWER
           (make-answer
            :Recognition-score (find-arg answer :recognition-score)
            :Answer-score   (find-arg answer :answer-score)
            :ps-state     (de-listify-answer (find-arg answer :ps-state))
            :Result         (find-arg answer :result)
            :Reason         (de-listify-answer (find-arg answer :reason))
            :node-name      (find-arg answer :node-name)))
          (:REASON 
           (make-reason
            :type (find-arg answer :type)
            :info (find-arg answer :info)
            :msg (find-arg answer :msg)))
          (:SOLUTION-SET
           (make-solution-set
	    :name (find-arg answer :name)
	    :agents (find-arg answer :agents)
            :action-type (find-arg answer :action-type)
            :filters (find-arg answer :filters)
            :preference-function (de-listify-answer (find-arg answer :preference-function))
	    :decomposition (de-listify-answer (find-arg answer :decomposition))
            :domain-info (de-listify-answer (find-arg answer :domain-info))))
	  (otherwise
           (mapcar #'de-listify-answer answer)))
        (mapcar #'de-listify-answer answer)))
    answer))


