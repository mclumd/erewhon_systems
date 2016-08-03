(in-package "USER")

;;;=========================================================================
;;; Code for managing shells from lisp, including the shell from which tcl/tk
;;; runs.
;;;=========================================================================

;;; History 
;;;
;;; 15jun98 Modified the code that handles shell streams. [cox] 
;;;


(defvar *shell-stream* nil 
  "The bidirectional shell stream between which tcl/tk and lisp communicates.")


;;; Because *shell-stream* is used to run wish, it cannot be used for other
;;; purposes (e.g., run xbiff for the ForMAT icon). The program uses
;;; *alt-stream* instead. [cox 15jun98]
;;;
(defvar *alt-stream* nil "Alternative shell stream.")

(defvar *send-shell-verbose* nil)


;;; In function with both a stream and stream name as parameters, only the name
;;; is needed. THe function can call symbol-value to get the value assigned to
;;; the name symbol. Make hanges later.
;;;
(defun init-shell (&optional 
		   (stream *shell-stream*)
		   (stream-name '*shell-stream*))
  (declare (special *shell-stream*))
  (unless stream
	  (set stream-name
	       (excl:run-shell-command 
		"csh" :wait nil :input :stream)))
  )



(defun send-shell (string 
		   &optional 
		   (stream *shell-stream*))
  (declare (special *shell-stream*))
  (if *send-shell-verbose*
      (format t "Sending to shell: ~S~%" string))
  (format stream string)
  (terpri stream)
  (finish-output stream))



(defun quit-shell (&optional 
		   (stream *shell-stream*)
		   (stream-name '*shell-stream*))
  (declare (special *shell-stream*))
  (when stream
    (send-shell "exit" stream)
    (send-shell "exit" stream)
    (close stream)
    (set stream-name nil)))

