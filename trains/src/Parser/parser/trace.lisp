(in-package parser)

;;
;; trace.lisp
;;
;; Time-stamp: <96/10/16 15:23:55 james>
;;
;; History:
;;   ?????? james   - written as part of Chart.lisp.
;;   941215 ringger - moved to own file trace.lisp.
;;

;;;======================================================================
;;; NLP code for use with Natural Language Understanding, 2nd ed.
;;; Copyright (C) 1994 James F. Allen
;;;
;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 2, or (at your option)
;;; any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program; if not, write to the Free Software
;;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
;;;======================================================================

;;=============================================================================
;;  TRACING
;;
;; There are two levels of tracing:
;; 1.  Basic tracing: each entry is traced as it is entered,
;;     and the complete chart is printed at the end (the default on)
;; 2.  Verbose tracing: each non-lexical active arc is traced as well
;;     as it is constructed 
;; TRACEON enables simple tracing, TRACEOFF turns it off
;; VERBOSEON enables verbose tracing, if simple tracing is on.

;;   trace: 0 - no tracing, 1 - for basic tracing, 2 - verbose tracing
(let ((trace 1)
      (rules-traced nil)
      (trace-feats t))

  (defun traceon nil
    (setq trace 1))
  
  (defun traceoff nil
    (setq trace 0)
    (setq rules-traced nil))
  
  (defun verboseon nil
    (setq trace 2))
  
  (defun trace-rule (&rest rule-ids)
    (let ((ids (get-rule-ids)))
      (when rule-ids
	(mapcar #'(lambda (x) 
		    (if (not (member x ids))
			(format t "~%Warning: no rule with id ~S:" x)))
		  rule-ids)
	   
	(setq rules-traced (append rule-ids rules-traced)))))

  (defun verboseoff nil
    (setq trace 1)
    (setq rules-traced nil))
  
  (defun rules-to-trace ()
    rules-traced)
  
  (defun tracelevel nil
    trace)

  (defun set-trace-features (feats)
    (setq trace-feats feats))

  (defun get-trace-features nil
    trace-feats)

  ;; General trace function for use elsewhere
  
  (defun trace-msg0 (string)
    (if (> trace 0)
      (format t string)))

  (defun trace-msg (string arg)
    (if (> trace 0)
      (format t string arg)))

   (defun trace-msg2 (string arg1 arg2)
    (if (> trace 0)
      (format t string arg1 arg2)))

  (defun verbose-msg (string arg)
    (if (> trace 1)
	(format t string arg)))
  
   (defun verbose-msg2 (string arg1 arg2)
    (if (> trace 1)
      (format t string arg1 arg2)))

)   ;;   end of scope for variable TRACE and RULES-TRACED

(defun get-printable-constit (c feats)
  (if (eq feats t)
      (if (constit-p c)
	  (cons (constit-cat c) (constit-feats c))
	(list 'Warning-ill-formed-subconstituent c))
    (reduce-constit feats c)))

;;  BREAK POINTS 

(let ((stopping-condition nil))

  (defun break-on (c)
    (if (null c)
	(setq stopping-condition nil)
      (let ((constit (read-embedded-constit c nil)))
	(if (constit-p constit)
	    (setq stopping-condition constit)
	  ))))
  
  (defun get-stopping-condition ()
    STOPPING-CONDITION)
  
  ) ;; end scope of STOPPING-CONDITION
