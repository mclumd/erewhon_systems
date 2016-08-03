;;;
;;; File FRAME2ALTERNATE.LISP presents an example of data-driven programming
;;; (see Charniak, Riesbeck, McDermott, & Meehan. (1987). Artificial
;;; Intelligence Programming; Chapter 6). Data-driven programming is a
;;; technique used in AI that includes with the input to be processed the code
;;; that will perform the processing. Therefore, to change the processing, one
;;; need only change the input. The program itself is usually a simple shell.
;;;
;;; The program takes as input a set of styles and some data in normalized
;;; frame format, and it converts it to a format as defined by the style.

;;; The input protocol is as follows:
;;;
;;; (:style 
;;;   (STYLE-NAME
;;;     (start      LAMBDA-FN) ;arg = stream
;;;	(head-print LAMBDA-FN) ;args = head, stream
;;;	(role-print LAMBDA-FN) ;args = role, stream
;;;	(done       LAMBDA-FN) ;arg = stream
;;;    ) )
;;; (:data STYLE-NAME FRAME)
;;;
;;; An example that represents an identity function (i.e., converts the frame
;;; to an identical frame) is as follows:
;;;
;;; (
;;;  (:style 
;;; 	   (identity
;;;              (start      (lambda (stream)
;;;                            (terpri)
;;; 			       (format stream "(")
;;; 			      )
;;;              )
;;; 		 (head-print (lambda (head stream)
;;; 			       (format stream "~s " head)
;;; 			      )
;;; 		 )
;;; 		 (role-print (lambda (role stream)
;;; 			       (format stream "~s "  role)
;;;                           )
;;;              )
;;; 		 (done (lambda (stream)
;;; 		         (format stream ")")
;;;                     )
;;; 		 ) )
;;;  )
;;;  (:data identity (STACK (<OB> BLOCKA) (<UNDEROB> BLOCKB)))
;;; )
;;;
;;; NOTE that the input is a list of lists. Each inner list is either a style
;;; or data entry. For a style to be used in a data entry, the corresponding
;;; style entry must occur previously. 
;;;
;;; Normalized frame form
;;;
;;;(frame 
;;; (attribute1 val1)
;;; (attribute2 val2)
;;; (attribute3 val3)
;;; ... )
;;;
;;; For DEBUGGING
;;; (trace process-style process-frame process-input )
;;; Also uncomment the format statements within functions.

#|
(unless (find-package "Transducer")
  (make-package "Transducer" :nicknames '("Trans")))

(in-package "Transducer")

;;; Make available in USER package.
;(export '(exec gen-file))
|#

(defparameter
    *Plan-Out-stream*
    nil
  "Output string stream containing the formatted plan." )


(defun process-style (style-frame)
  (let* ((style-name (first style-frame))
	 (p-list (rest style-frame)))
;;;    (format t "STYLE-NALE: ~s ~%P-LIST: ~S" style-name p-list )
    (dolist (each-property p-list)
;;;      (format t "~%each-property: ~S" each-property)
      (setf (get style-name 
		 (first each-property))
	(second each-property))
    ))
  )

(defun process-frame (frame current-style stream &optional head-printed)
  (cond ((null frame)
	 (apply (get current-style 'done)
		(list stream))
	 )
	(head-printed 
	 (apply (get current-style 'role-print)
		(list (first frame) stream))
	 (process-frame (rest frame) current-style stream t))
	(t 
	 (apply (get current-style 'start)
		(list stream))
	 (apply (get current-style 'head-print)
		(list (first frame) stream))
	  (process-frame (rest frame) current-style stream t))
	)
  )



(defun process-input (alist stream &optional current-style)
  (let* ((first-item (first alist))
	 (identifier  (first first-item))
	 (remainder (rest first-item))
	 (done (null alist)))
;    (format t "~%list ~S first ~S id ~S rem ~S done ~s~%" alist first-item identifier remainder done)
    (cond ((null alist)
	   nil)
	  ((eq identifier :data)
	   (if (atom (first remainder))
	       (process-frame (second remainder) (first remainder) stream)
	     (process-frame (first remainder) current-style stream))
	   )
	  ((eq identifier :style)
	   (process-style (first remainder)))
	  )
    (if (not done)
	(process-input (rest alist) stream current-style))
	  )
    )



;;; 
;;; The save-file optional function-parameter is used by code in file
;;; plan2frames-and-state.lisp. This option was written to save state info
;;; after each Applied-Op applied. Boris uses it now.
;;; 
(defun exec (&optional save-file
		       (out *Plan-Out-stream*)
		       (in  *Normalized-plan-stream* ))
    (format out "(")
    (process-input
      (read-from-string
       (get-output-stream-string in))
       out)
    (format out "~%)")
    
  ;(delete-file in-file-name)
  ;(let ((return-val
       (read-from-string
	 (get-output-stream-string out))
	;))
   ; (format t "~s~%" return-val)
  ;)
)

;;; 
;;; Function gen-file is a top-level user callable routine that first saves a
;;; plan in normalized frame format and then second converts this output in a
;;; user-specified style (defined by *current-style*. When save-file is
;;; non-nil, the file that tempoarily holds the final output (/tmp/plan.txt) is
;;; not deleted.
;;; 

(defun gen-file (&optional 
		 save-file)
  (setf *Normalized-plan-stream* (make-string-output-stream))
  (setf *Plan-Out-stream* (make-string-output-stream))
  (ask-user-for-demo t)
  (exec save-file)
  )

