(in-package parser)
;; MOUSE HANDLING ROUTINES

;;  converts  mouse actions directly into a speech act

;;   GET-MOUSED-OBJECT
;;    in all formats below, 
;;      <obj-spec> is a list of form (<object>1...<object>n)
;;  current strategy is to pick the first object in the list
;;   of the indicated pref-type. If none, it returns the first

(defun get-moused-object (obj-spec pref-type)
  (if (consp obj-spec)
      (let ((object-in-type 
	     (remove-if-not #'(lambda (c)
				(has-entry-of-type c pref-type))
			    obj-spec)))
	(if object-in-type
	    ;;   if there are objects of the preferred type, select first
	    (car object-in-type)
	  ;;  otherwise, pick the first non-null
	  (or (car obj-spec) (cadr obj-spec))))
    obj-spec))

;;    returns T is the lex-item has a lexical entry of the pref-type
(defun has-entry-of-type (lex-item pref-type)
  (some #'(lambda (c) 
	    (let
		((sem (get-value  (lex-entry-constit c) 'SEM)))
	      (if sem (subtype 'sem sem pref-type))))
	(retrieve-from-lex (intern lex-item 'parser))))

;;  PROCESS-MOUSE-ACTION
;;  takes an atom indicating the action and an ARG whose format depends on the act, and converts the action into an NL input to parse

(defun process-mouse-action (content)
  "Process a mouse action CONTENT, which is of the form
    (select <obj-or-list>)
    (drag <obj-or-list> :from <obj-or-list> :to <obj-or-list>)
    (button restart|undo)."
  (case (car content)
    ((select :select)
     ;; even though we'll take the first thing in the list which
     ;; satisfies 'any-sem, (which you would think is the first thing in
     ;; the list), it might not be in the lexicon, so we pass the whole list
     ;; to 'get-moused-object'.
     (let ((object (get-moused-object (cdr content) 'any-sem)))
       ;;  process only when person not speaking or typing
       (when (eq (get-msg-started) 'none)
	 (startNewUtterance (append (tokenize object) '(end-of-utterance)))
	 (getAnalysis :mouse))))
    ((drag :drag)
     ;;  prefer CITYs as the obj-spec in both cases
     (let ((from-location
	    (tokenize (get-moused-object (fourth content) 'city)))
	   (to-location
	    (tokenize (get-moused-object (sixth content) 'city))))
       (when (eq (get-msg-started) 'none)
	     (startNewUtterance 
	      (append (cons 'from from-location)
		      (cons 'to to-location) '(end-of-utterance)))
	     (getAnalysis :mouse))))
    ((button :button)
     (case (cadr content)
       ((undo :undo)
	(startNewUtterance (list 'cancel 'end-of-utterance))
	(getAnalysis :mouse))
;       ((parse-tree :parse-tree)
;	(let ((output))
;	  (let ((*standard-output* (make-string-output-stream)))
;	    (show-speech-acts)
;	    (setq output (get-output-stream-string *standard-output*)))
;	  (send-to-display output))
;        nil)
       ))
    (otherwise
     (parser-warn "~%-Uninterpretable mouse action: ~s~%" content))))

(defun send-to-display (string1)
  (format t "~a" string1))

(defun find-sem-of-obj (obj)
  ;;  This eventually should call the reference module to find the
  ;;  appropriate semantic type of the object. Currently, we let it
  ;;  be anything
  (make-var :name 'type))

(defun process-confirm-action (content)
  "Process a confirm of CONTENT, which is of the form (ACT TAG), where
ACT is `restart' or `quit', and TAG is `t' or `nil'."
  (case (car content)
    ((restart :restart)
     (cond
      ((cadr content)
       (startNewUtterance (list 'restart 'end-of-utterance))
       (getAnalysis :mouse))
      (t
       (startNewUtterance (list 'no 'end-of-utterance))
       (getAnalysis :mouse))))
    ((quit :quit)
     (cond
      ((cadr content)
       (startNewUtterance (list 'done 'end-of-utterance))
       (getAnalysis :mouse))
      (t
       (startNewUtterance (list 'no 'end-of-utterance))
       (getAnalysis :mouse))))))
    
(defun process-menu-action (content)
  "Process a menu selection CONTENT, which can be:
    (restart)
    (quit)."
  (let ((utt (case (car content)
	       (restart (list 'restart 'end-of-utterance))
	       (quit (list 'quit 'end-of-utterance)))))
    (startNewUtterance utt)
    (set-msg-started 'none)
    (getAnalysis :menu)))
