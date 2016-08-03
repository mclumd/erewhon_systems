;; Time-stamp: <Mon Jan 20 18:02:10 EST 1997 ferguson>

(when (not (find-package :logging))
  (load "logging-def"))
(in-package logging)

(defparameter *log-associations* '(( :user-model-kb . :context)
                                   ( :self-model-kb . :context)
                                   ( :context-manager . :context)
                                   ( :discourse-manager . :context)
                                   ( :reference . :reference)
                                   ( :score . :dm)
                                   ( :speech-out . :dm)
                                   ( :parser . :reference)
                                   ( :display-kb . :Actualization)
                                   ( :display-manager . :Actualization)
                                   ( :ps . :prince)
                                   ( :world-kb . :dm))
  "We can't have too many open files, so some modules are logged together.")

(excl:without-package-locks
 (defmethod open-stream-p ((x null))
   nil))

#||
(defpackage :logging
  (:use common-lisp cl-lib)
  (:export
   #:do-log #:transcribe #:transcribe-and-log #:open-transcript-stream #:open-log-stream #:close-logs
   #:*transcript-stream* #:*transcript-file* #:*log-file* #:*log-stream* #:*log-streams*))
||#

(defun check-for-lep ()
  "running under emacs?"
  (and (find-package 'lep)
       (funcall (intern "LEP-IS-RUNNING" (find-package 'lep)))))

(defvar *transcript-file* nil "Path to a transcript file")
(defvar *log-file* nil "Path to a log file")

(defvar *transcript-stream* nil)        ; global
(defvar *transcript-stream-stamp* '(1 2 3)) ; when we last printed to stream
(defvar *log-streams* nil)              ; global
(defvar *log-stream* nil)               ; global, for old code (gots to dm log)

(defun transcribe (who control &rest arguments)
  (declare (ignore who))
  (when (open-stream-p *transcript-stream*)
    (mlet (second minute hour) (get-decoded-time)
      (let ((stamp (list second minute hour)))
        (unless (equalp stamp *transcript-stream-stamp*)
          (format *transcript-stream* "~&<~2D:~2D:~2D>~%" hour minute second)
          (setq *transcript-stream-stamp* stamp)))
      (apply #'format *transcript-stream* control arguments)
      (fresh-line *transcript-stream*)
      (force-output *transcript-stream*))))

(defun transcribe-and-log (who control &rest arguments)
  (apply #'transcribe who control arguments)
  (apply #'do-log who control arguments))

(defun find-log-stream (who)
  (progfoo (assoc (make-keyword who) *log-associations*)
    (if foo (setq who (cdr foo))))
  (values-list (cdr (assoc (make-keyword (or who :dm)) *log-streams*))))

(defun update-stamp (who stamp)
  (progfoo (assoc (make-keyword who) *log-associations*)
    (if foo (setq who (cdr foo))))
  (setf (second (cdr (assoc (make-keyword (or who :dm)) *log-streams*))) stamp))

(defun do-log (who control &rest arguments)
  (let ((*print-circle* t)
        (*print-length* 400)
        (*print-level* 20)
        (*print-pretty* t)
        (*print-readably* nil))
    (apply #'do-log-direct who control arguments)))

(defun do-log-direct (who control &rest arguments)
  (mlet (log-stream stamp) (find-log-stream who)
    (unless log-stream
      (when *log-file*
        (open-log-stream-for-module who)
        (setq log-stream (find-log-stream who))))

    (mlet (second minute hour) (get-decoded-time)
      (let ((time-stamp (list second minute hour)))
        (cond
         ((open-stream-p log-stream)
          (unless (equalp time-stamp stamp)
            (format log-stream "~&<~2D:~2D:~2D>(~A)~%" hour minute second who)
            (update-stamp who time-stamp))
          (apply #'format log-stream control arguments)
          (fresh-line log-stream)
          (if user::*debug*
              (force-output log-stream))
          ))
        (cond
         ((or (and (eq cl-user::*debug* :display)
                   (not (eq *error-output* log-stream)))
              (and (null log-stream)
                   (check-for-lep)))
          (format *error-output* "<~2D:~2D:~2D> " hour minute second)
          (apply #'format *error-output* control arguments)
          (fresh-line)
          (if user::*debug*
              (force-output))))))))

(defun do-log-timestamp (who control &rest arguments)
  (let ((*print-circle* t)
        (*print-length* 400)
        (*print-level* 20)
        (*print-pretty* t)
        (*print-readably* nil))
    (apply #'do-log-direct-timestamp who control arguments)))

(let ((run-time 0)
      (real-time 0))
  (defun reset-timestamp ()
    (setq run-time (get-internal-run-time)
          real-time (get-internal-real-time)))
  
  (defun do-log-direct-timestamp (who control &rest arguments)
    (mlet (log-stream stamp) (find-log-stream who)
      (declare (ignore stamp))
      (unless log-stream
        (when *log-file*
          (open-log-stream-for-module who)
          (setq log-stream (find-log-stream who))))

      (let ((current-run-time (- (get-internal-run-time) run-time))
            (current-real-time (- (get-internal-real-time) real-time)))
        (cond
         ((open-stream-p log-stream)
          (format log-stream "~&< ~9D Run: ~9D Real>(~A) " current-run-time current-real-time who)
          (apply #'format log-stream control arguments)
          (fresh-line log-stream)
          (if user::*debug*
              (force-output log-stream))
          ))
        (cond
         ((or (and (eq cl-user::*debug* :display)
                   (not (eq *error-output* log-stream)))
              (and (null log-stream)
                   (check-for-lep)))
          (format *error-output* "~&< ~9D Run: ~9D Real>(~A) " current-run-time current-real-time who)
          (apply #'format *error-output* control arguments)
          (fresh-line)
          (if user::*debug*
              (force-output))))))))

(defun debug-p (debug-level)
  (and user::*debug*                    ; debugging on
       (or (eq debug-level t)           ; always if debug is on
           (eq user::*debug* debug-level) ; want to debug this
           (let ((statement-level (position debug-level user::*debug-levels*))
                 (user-level (position user::*debug* user::*debug-levels*)))
             (and statement-level user-level (<= statement-level user-level))))))

(defun debug-log (who debug-level control &rest arguments)
  (cond
   ((null user::*debug*))               ; not debugging, so just return
   ((consp who)
    ;; multiple logs
    (mapc #'(lambda (x) (apply #'debug-log x debug-level control arguments))
          (delete-duplicates who :key #'find-log-stream))) ; only if they have different log streams
      
   ((or (debug-p debug-level)
        (debug-p (make-keyword who)))
    (apply #'do-log who control arguments))))

(defun log-warning (who control &rest arguments)
  (cond
   ((consp who)
    ;; multiple logs
    (mapc #'(lambda (x) (apply #'do-log x control arguments))
          (delete-duplicates who :key #'find-log-stream))
    (apply #'do-log :warnings control arguments))
   (t
    (apply #'do-log who control arguments)
    (apply #'do-log :warnings control arguments))))

(defun close-logs ()
  (mlet (second minute hour) (get-decoded-time)
    (when (open-stream-p *transcript-stream*)
      (format *transcript-stream* "~&~%~%;; **** Log Closed: <~2D:~2D:~2D> ****~%" hour minute second)
      (close *transcript-stream*))
    (dolist (ls *log-streams*)
      (when (open-stream-p (cadr ls))
        (format (cadr ls) "~&~%~%;; **** Log Closed: <~2D:~2D:~2D> ****~%" hour minute second)
        (close (cadr ls))))
    (setq *log-streams* nil)))


(defun open-transcript-stream (file)
  (if *transcript-stream* (close *transcript-stream*))
  (setq *transcript-file* file)
  (if file
      (setq *transcript-stream* (open file
                                      :direction :output
                                      :if-exists :append
                                      :if-does-not-exist :create))))

(defun open-log-stream-for-module (who)
  (setq who (make-keyword who))
  (progfoo (assoc who *log-associations*)
    (if foo (setq who (cdr foo))))
  (unless (open-stream-p (find-log-stream who))
    (let ((new-stream (open (merge-pathnames (pathname (string-downcase (string who) :start 1)) (pathname *log-file*))
                            :direction :output
                            :if-exists :append
                            :if-does-not-exist :create)))
      (format new-stream ";; Log stream for ~(~A~)~%;; ***VL*** Crypto Fascist Format ENABLED!~%~%" who)
      (update-alist who (list new-stream '())
                    *log-streams*))))

(defun open-log-stream (file)
  (declare (special user::*crash-log-stream*))
  (if *log-streams* (close-logs))
  (setq *log-file* file)
  (when file
    (open-log-stream-for-module :DM)
    (setq user::*crash-log-stream* (find-log-stream :DM))
    (unless (check-for-lep)
      (setq *log-stream* (setq *error-output* user::*crash-log-stream*))))) ; put errors in log.

(defun do-log-all (control &rest arguments)
  (apply #'transcribe nil control arguments)
  (dolist (entry *log-streams*)
    (apply #'do-log (car entry) control arguments)))

(defun stamp-view-log-indicator (number message &optional info-only)
  (if info-only
      (do-log-all "~&;;; *** ~D ~W~%" number message)
    (do-log-all "~&;;; ***~%;;; ***~%;;; ***VL*** ~D ~W~%;;; ***~%;;; ***" number message)))


