(in-package :user)

;;;; This file simulates the action of P4P as it passes change of env info to
;;;; the transducer. The code will run in a different Lisp environment than
;;;; does the wrapper.
;;;;
;;;; Before running this code, see comments in ProdigyP4P.lisp this dir.
;;;;
;;;; TO RUN THIS CODE, start Lisp, load PRODIGY, and load the Wrapper.
;;;; (load "/usr/local/users/mcox/Research/PRODIGY/Wrapper/loader.lisp")
;;;; Then load this file.
;;;; (load "/usr/local/users/mcox/Research/PRODIGY/Wrapper/P4P/fake-P4P.lisp")
;;;; Now run the program by calling (fake-P4P '(t  a (nothing) q))
;;;; {or (fake-P4P '(a (in View A4) a (on-top-of View Email) a (on-top View) d (on-top Email) t q))}
;;;; Create the file "/tmp/ready2.txt"
;;;; 


;;;The following three vars are in file file-fns.lisp

;(defvar *ready1-file-name* "/tmp/ready1.txt")
;(defvar *ready2-file-name* "/tmp/ready2.txt")
;(defvar *data-file-name* "/tmp/data.txt")


;;; Example sequemce of state changes. 
;;;
;;; The t's mean no change.
;;; The t's mean terminators now. Otherwise how to tell when one change series
;;; ends an a subsequent change series.
;;;
(defvar *p4p-sequence*
    #|
      '(
	((a (in User_Interface_for_Prodigy A1))
	 (a (on-top User_Interface_for_Prodigy))
	 (a (in PortDialogBox A4))
	 (a (on-top PortDialogBox))
	 (d (on-top User_Interface_for_Prodigy))
	 (a (on-top User_Interface_for_Prodigy))
	 (d (on-top PortDialogBox))
	 (d (in PortDialogBox A4))
	 (d (on-top User_Interface_for_Prodigy)))
	 )
	 |#
  ;;The Scenario of p4p-x2.lisp 
  '(
    ((a (on-top View_Window) )
     (a (in View_Window A4) )
     (a (on View_Window SCR) )
     )
    )
  #|
  ;;The Scenario of p4p-x1.lisp 
  '(
    ((a (on-top View_Window) )
     (a (in View_Window A4) )
     (a (on View_Window SCR) )
     (a (is-empty View_Window) )
     )
     )
     |#
  #|
  ;;The Scenario of p4p-2.lisp using p4p-3.lisp and env perception
  '(
    ((d (on-top Load_Window))
     (a (on-top-of View_Window Load_Window) )
     (a (on-top View_Window) )
     (a (in View_Window A4) )
     (a (is-empty View_Window) )
     )
    )
  |#
    "The first P4P scenario"
;    '(T T T T T T T T T T T T T T T T T T
;      T T T T T T T T T
;      A (ENABLES-MOVEMENT-OVER FORD1 YALU)
;      q)
;    '(t  a (nothing)
					;(ENABLES-MOVEMENT-OVER FORD1 YALU)
;      q)
  )


(defun fake-P4P (&optional
		 (sequence 
		  *p4p-sequence*))
  (format t "~%Fake P4P WAITING~%")
  (do ((delta (first sequence) 
	      (first sequence)))
      ((null sequence)
       nil)
    (ready *ready2-file-name*)		;Wait until PRODIGY is ready.
    (delete-file *ready2-file-name*)
    (pop sequence)			;cannot perform the pop in the var list
					;of the do funct because the last 
					;element of the list will not be used.
    (create-data-file
     (list delta))
    (create-ready-file 
     *ready1-file-name*)
    )
  )
      