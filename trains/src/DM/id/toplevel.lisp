;;;
;;; toplevel.lisp : Formerly in defsystem.lisp, called when restarting a dump
;;;
;;; George Ferguson, ferguson@cs.rochester.edu, 13 Jan 1997
;;; Time-stamp: <Mon Jan 20 14:56:17 EST 1997 ferguson>
;;;
(in-package cl-user)

(defconstant *TRAINS-BASE-DEFAULT* "/u/trains/96/2.2") ; does putenv if needed, see also sys:hosts.cl
(defvar *TRAINS-BASE* (or (sys:getenv "TRAINS_BASE") *TRAINS-BASE-DEFAULT*))

(defvar *crash-log-stream* nil)

(declaim (special *dumping-tt*))

(defparameter *dump-name* 'hack::dm)          ; my name when talking

(defvar *debug* :ps "Debug level. See *debug-levels* for values")

(defvar *debug-interactive* nil "If non-nil many problems will enter a break loop")

(defparameter *debug-levels* '( :hard   ; internal hard errors, pretty much always want this unless we're ignoring errors.
                            #||   :performance ||# ; fiddles lights on G's display for internal messages
                               :ref     ; debug reference
                               :reference ; because sometimse I spelled it out.
                               :discourse-manager ; the general guy who calls everyone else.
                               :self-model-kb
                               :actualization ; debug actualization
                               :user-model-kb
                               :prince  ; debug prince (the man in the moon)
                               :ps      ; debug the problem solver  (interface, see ps.log for the ps's own logs)
                               :context-manager ; Extremely verbose, but shows each update to the context tree
                               :display-manager ; interactions with the display and kb
                               :kb-messages ; turn on debugging for all messages to/from a kb. Very Verbose
                               :kqml    ; turn on debugging of all kqml, and handlers. You probably don't want to do this.
                               t        ; debug everything (should be last, both in this list and in terms of "resort")
                               ) 
  "so we can debug some things and not others, hierarchically (if not in this list, only
   debug specific items) Setting *debug* to an item in this list will enable statements
   with that label, and all prior labels.")
;; not included, :io (force lisp io), :display (force display of logged messages to stdout)
;; note SOME debug messages are output if *debug* in non-nil, others only if debug is the
;; right level. FOr instance, (debug-log :ps :ps "foo") would print "foo" to the PS log if *debug* is
;; :kqml, or :ps, but not :ref. See transcripts.lisp for the description of logging messages, 
;; and the streams (files) they may be written to.

;; this is now done in the dumper.
;(eval-when (compile load eval)
;  (load "tt-master:id;autozoom"))

(defvar *hack-package* (find-package 'hack))

;;;
;;; George's toplevel (no signal catching; auto-zoom handled in dump-dm.lisp)
;;;
(defun toytrains-toplevel ()
  (declare (special hack::*im-stream*))
  (setq *trains-base* (or (sys:getenv "TRAINS_BASE")
                          *trains-base-default*)
        *print-circle* t)               ; force it, once and for all!
  
  (tpl:setq-default *print-circle* t)   ; there too (for inside break loops)
  (let ((*print-length* 80)
        (*print-level* 15))
     (funcall (intern "DO-TOPLEVEL" *hack-package*) "DM" '(display parser ps) t)))
