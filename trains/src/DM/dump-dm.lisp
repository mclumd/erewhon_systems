;;;
;;; dump-dm.lisp : Whatever is necessary to dump and restart an image
;;;
;;; George Ferguson, ferguson@cs.rochester.edu, 17 Dec 1995
;;; Time-stamp: <Wed Jan 15 15:16:41 EST 1997 ferguson>
;;;
;;; Note that many of the interesting "properties" of the dumped lisp
;;; image are beyond our control here since they are properties of whatever
;;; lisp image is running this code (if you follow me). Thus loading this
;;; code into a full-featured Lisp will result in a bigger executable
;;; than using some bare-bones lisp image (which itself must have been
;;; created by some external process). Also, depending on the complexity
;;; of the image, it may still depend on external files. For details,
;;; see the ACL User's Guide.
;;;

(if (not (find-package "DM"))
    (defpackage "DM"))
(in-package "DM")

;; Name of executable when lisp is dumped
(defvar *dm-image-name* "tdm")

;; Name of function to call when dumped lisp restarts
(defvar *dm-restart-function* 'cl-user::toytrains-toplevel)

;; Timestamp set in Makefile
(defvar *timestamp* "timestamp not set")

;;
;; Dump the image: This is basically a call to DUMPLISP with some fluff
;; added.
;;
(defun dump-dm (&optional (image-name "tdm"))
  "Dump a new Lisp image named IMAGE-NAME containing the dm. "
  ;; Redefine this function to avoid printing any startup banner at all.
  ;; For ACL4.3, they got this right, and it goes to stderr, so we'll be
  ;; nice and let them print it.
#-(version>= 4 3)
  (let ((excl:*enable-package-locked-errors* nil))
    (defun excl::copyright-banner () nil))
  ;; Always a good idea to gc so we restart nice and fresh
  (format t "~%; Garbage collecting prior to dumping...~%")
  (excl:gc nil)
  (excl:gc nil)
  (excl:gc t)
  ;; Dump the image, which will restart by calling *dm-restart-function*
  (format t "; Dumping image file ~A...~%" image-name)
#-(version>= 4 3)
  (excl:dumplisp :name image-name :checkpoint nil
		 :restart-function 'my-restart-function
		 :read-init-file nil)
#+(version>= 4 3)
  (progn
    (setq excl:*restart-app-function* 'my-restart-function)
    (setq excl:*read-init-files* nil)
    (setq excl:*print-startup-message* nil)
    (excl:dumplisp :name image-name :checkpoint nil))
)

(defun my-restart-function ()
  "This function is passed to `dumplisp' as the :restart-function parameter.
It simply calls the value of *dm-restart-function* inside a handler-bind
causes a stack trace on error."
  ;; Rebind most streams to use stderr for output
  (setq *terminal-io*
	  (make-instance 'stream:bidirectional-terminal-stream
			 :fn-in 0 :fn-out 2))
  (setq excl::*initial-terminal-io* *terminal-io*)
  (setq *error-output* *terminal-io*)
  ;; Print our timestamp (to stderr)
  (format *terminal-io* "~%~A: ~A~%" (sys:command-line-argument 0) *timestamp*)
  (finish-output *terminal-io*)
  ;; Here we go...
  (handler-bind
   ((error #'(lambda (e)
	       (zoom-and-exit e))))
   (apply *dm-restart-function* nil)))

(defun zoom-and-exit (e)
  "Called after error E has been trapped to cause a stack trace. It uses
LOGGING:*log-stream* if it is non-nil, otherwise writes to the file dm.zoom.
It then calls excl:exit to terminate execution (and so never returns)."
  (format *error-output* "DM Error: ~A (see Dm.log or dm.zoom)~%" e)
  (finish-output *error-output*)
  (setq tpl::*user-top-level*
    #'(lambda ()
	(setq tpl::*user-top-level* nil)
	(ignore-errors
	 (let ((*print-readably* nil)
	       (*print-miser-width* 40)
	       (*print-circle* t)
	       (*print-pretty* t)
	       (tpl:*zoom-print-level* nil)
	       (tpl:*zoom-print-length* nil)
	       (stream (or logging::*log-stream*
			   (open "dm.zoom" :direction :output
				 :if-does-not-exist :create
				 :if-exists :append)
			   *error-output*)))
	   (let ((*terminal-io* stream)
		 (*standard-output* stream))
	     (format stream "Error: ~A~%" e)
	     (tpl:do-command "zoom" :count t :all t)
	     (finish-output stream)))
	 (excl:exit 0 :quiet t :no-unwind t)))))
