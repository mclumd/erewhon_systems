;;;
;;; kqml.lisp : Parser I/O using KQML messages
;;;
;;; George Ferguson, ferguson@cs.rochester.edu, 13 Dec 1995
;;; Time-stamp: <96/11/14 20:21:34 stent>
;;;
;;; History:
;;;   95 Dec 13  ferguson - Created.
;;;   96 May 29  ringger  - Added parse-tree request handling.
;;;

(in-package "PARSER")

(defvar *log-stream* nil
  "Stream for logging i/o to/from parser. This is nil when running within
Lisp (meaning logging is effectively disabled), or is opened by the
restart function when running from a dumped Lisp.")

(defvar *robust-stream* nil
  "Stream for logging i/o to/from robust parser. This is nil when 
running within
Lisp (meaning logging is effectively disabled), or is opened by the
restart function when running from a dumped Lisp.")

(let ((*robust* t))
  (defun set-robust-parsing (&optional (flag t))
    "Enable or disable robust parsing based on value of FLAG."
    (setf *robust* flag)
    (format *log-stream* "~%;; robust=~S~%" *robust*)
    (finish-output *log-stream*)
    (load-newgrammar :robust *robust* :printsmart nil))

  (defun post-parser (parser-output)
    (cond (*robust* (let ((temp (car (check (list parser-output)))))
		      (when (not (sem-equal (parse-input temp) (parse-input parser-output)))
			    (format *robust-stream* "~S~%" (list 'tell ':content parser-output ':re (+ (getUttNum) 1)))
			    (finish-output *robust-stream*))
		      temp))
	  ((not *robust*) parser-output)))
)

(defun kqml-parser ()
  "Main loop for the parser. Reads a KQML message from standard input and
calls the approriate function to handle it. Lisp exits on EOF."
  ;; Make sure we're in the PARSER package during i/o (blech)
  (let ((*package* (find-package "PARSER")))
    ;; Then request to hear broadcasts from the input modules
    ;;(kqml-output 'request :receiver 'im :content '(listen speech-in))
    ;;(kqml-output 'request :receiver 'im :content '(listen speech-pp))
    ;;(kqml-output 'request :receiver 'im :content '(listen display))
    ;; gf: 15 Aug 1996: Use IM classes instead
    (kqml-output 'request :receiver 'im :content '(listen user-input))
    ;; Also monitor speech-pp status so we don't get stuck if it dies
    (kqml-output 'monitor :receiver 'im :content '(status speech-pp))
    ;; And tell the PM we're ready
    (kqml-output 'tell :receiver 'im :content '(ready))
    (loop
      ;; (excl:gc)  see kqml-parse-tell
      (let ((performative (read *standard-input* nil nil)))
	;; Log receipt
	(prin1 performative *log-stream*)
	(format *log-stream* "~%")
	(finish-output *log-stream*)
	;; Now decide what to do with the performative
       (cond
	((eq performative nil)			; end-of-file, we should exit
	 (excl:exit 0 :quiet t))
	((not (consp performative))		; not a list -> error
	 (format *error-output*
		 "kqml-parser: invalid input: \"~A\"~%" performative))
	(t					; otherwise check verb...
	 (case (car performative)
	  (tell					; TELL
	   (apply #'kqml-parse-tell (cdr performative)))
	  (request				; REQUEST
	   (apply #'kqml-parse-request (cdr performative)))
	  (reply				; REPLY
	   (apply #'kqml-parse-reply (cdr performative)))
	  (otherwise				; Unknown performative!
	   (let ((sender (kqml-sender-of-performative performative)))
	     (kqml-output 'error :receiver sender :code 520
			  :comment (format nil "bad performative: ~S"
					   performative))))
)))))))

(defun kqml-parse-tell (&key sender content &allow-other-keys)
  "Handles TELL messages received by the parser. The content is passed to
the function `parse'. If it returns something other than t or nil, that
something is sent as an output message of the parser."
  (if (consp content)
      (case (car content)
	    ;; A few TELL's are control messages (which can be ignored)
	    ((start-conversation end-conversation)
	     (format *log-stream* "~%;; ~S~%" (car content))
	     (finish-output *log-stream*)
	     (format *robust-stream* "~%;; ~S~%" (car content))
	     (finish-output *robust-stream*))
	    ;; But most of them get passed to the PARSE function
	    (otherwise
	     (let* ((mode (if sender sender 'display))
		    ;; may want to map sender to different mode values
		    (output (parse :user mode content)))
	       (cond ((and (consp output) 
			   (or (sa-p (parse-input output)) 
			       (cca-p (parse-input output))))
		     (let* ((temp (post-parser output))
			    (question (trap-questions (parse-input temp))))
		       (dolist (element (car question))
			      (kqml-output 'request :receiver 'ps :content (list 'handle-question (cdr element)))
			      (excl:gc))
		       (when (second question)
			      (kqml-output 'tell :content (second question) :re (genUttnum))
			      (excl:gc))))
		     ((consp output) 
		      (kqml-output 'tell :content output :re (genUttnum))
		      (excl:gc))))))
    (format *error-output*
	    "kqml-request: invalid content: ~S~%" content)))

(defun kqml-parse-request (&key content &allow-other-keys)
  "Handles REQUEST messages received by the parser."
  (case (car content)
    (restart					; RESTART
     (set-msg-started 'none))
    (exit					; EXIT
     (excl:exit 0 :quiet t))
    (chdir					; CHDIR
     (let* ((dir (cadr content))
	    (logfile (format nil "~A/parser.log" dir))
	    (robustfile (format nil "~A/robust.log" dir)))
       (when *log-stream* (close *log-stream*))
       (when *robust-stream* (close *robust-stream*))
       (setq *log-stream* (open logfile :direction :output
				:if-exists :supersede
				:if-does-not-exist :create))
       (setq *robust-stream* (open robustfile :direction :output
				:if-exists :supersede
				:if-does-not-exist :create))))
    (parse-tree				        ; PARSE-TREE
     (kqml-output 'reply :receiver 'pview
		  :content (get-pview-tree) ))
    (eval				        ; EVAL (watch out!)
     (apply #'eval (cdr content)))
    (otherwise
     (format *error-output*
	     "kqml-request: invalid content: ~S~%" content))
    ))

(defun kqml-parse-reply (&key content &allow-other-keys)
  "Handles REPLY messages received by the parser."
  (case (car content)
    (status					; STATUS
     ;; Status report should only be for speech-pp
     (when (and (eq (second content) 'speech-pp)
		(eq (third content) 'eof))
	   ;; If speech-pp just died, pretend we got an END instead
	   (let ((output (parse :user 'speech-pp '(end))))
	     (if (consp output)
		 (kqml-output 'tell :content output :re (genUttnum))))))
    (otherwise
     (format *error-output*
	     "kqml-reply: invalid content: ~S~%" content))
))

(defun kqml-output (verb &rest parms)
  "Format KQML message with performative VERB. Other keyword arguments
used as parameters of the messages. This results in a message being printed
to standard output."
  (format *standard-output* "~S~%" (cons verb parms))
  (finish-output *standard-output*)
  (format *log-stream* "~S~%" (cons verb parms))
  (finish-output *log-stream*))

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
    
;;(let ((dialognum 0))
;;  (defun toggle-robust-parsing ()
;;    (cond ((eq usernum 0)
;;	   (incf dialognum)
;;	   (cond ((or (oddp dialognum) (eq (mod dialognum 6) 0))
;;		  (load "robust.lisp"))
;;		 ((and (evenp dialognum) (not (eq (mod dialognum 6) 0)))
;;		  (load "nonrobust.lisp"))))
;;	  ((eq usernum 1)
;;	   (incf dialognum)
;;	   (cond ((or (evenp dialognum) (eq dialognum 1))
;;		  (load "robust.lisp"))
;;		 ((and (oddp dialognum) (not (eq dialognum 1)))
;;		  (load "nonrobust.lisp")))))))
 
(let ((counter 0))
  (defun genUttNum nil
    (incf counter))
  (defun getUttNum nil
    counter)
)
    
