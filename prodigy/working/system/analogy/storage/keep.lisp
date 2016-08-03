;;; This function creates a case, and loads it back.
;;; If tmp is t the name of the case will be case-tmp.lisp
;;; A different case-name can be also specified, using case-name.
;;; The directory where the case is to be stored can also be specified.
;;; (see store.lisp for how to specify this input.)
;;; If add-to-case-cache is true then the case is added to the current *case-cache*

(defun create-and-keep
  (&key (tmp nil)
	(add-to-case-cache nil)
	(case-name (concatenate 'string 
				"case-"
				(string-downcase
				 (symbol-name
				  (p4::problem-name
				   (current-problem))))))
	(case-dir (concatenate 'string *problem-path* 
			       "probs/cases/")))
  (if tmp (setf case-name "case-tmp"))
  (store-case :case-name case-name :case-dir case-dir)
  (retrieve-all-same-case case-name case-dir)
  (load-cases :add-to-case-cache add-to-case-cache
	      :case-dir case-dir))

;;; This function, like all the retrieval functions,
;;; returns the list *replay-cases*: An example is 
;;; (("case-pgh1" "case-pgh1" ((at-obj package1 bos-po))
;;;  ((<city58> . boston) (<city37> . pittsburgh) (<locker2> . bos-locker)
;;;   (<airport99> . bos-airport) (<airport3> . pgh-airport) (<post-office37> . pgh-po)
;;;   (<post-office22> . bos-po) (<airplane26> . airplane2) (<airplane53> . airplane1)
;;;   (<taxi62> . bos-taxi) (<taxi64> . pgh-taxi) (<o93> . package1))))
;;; This function loads the case header and "reverses" all the information from the
;;; that case. What this means is that all the objects names are kept and that the
;;; case is going to be used exactly for the same goals.
;;; loads the case header.

(defun retrieve-all-same-case (case-name case-dir)
  (setf *path-to-case-header*
	(concatenate 'string case-dir "headers/" case-name ".lisp"))
  (load-case-header case-name)
  (let* ((case-header (car *case-headers*)))
    (setf *replay-cases*
	  (list 
	   (list case-name case-name
		 (case-header-goal case-header)
		 (reverse-var-to-insts (case-header-insts-to-vars case-header)))))))

(defun reverse-var-to-insts (insts-to-vars)
  (let ((result nil))
    (dolist (inst-to-var insts-to-vars)
      (push (cons (cdr inst-to-var) (car inst-to-var)) result))
    (reverse result)))


		 
    
	
  
  
