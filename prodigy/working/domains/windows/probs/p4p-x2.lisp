;;; 
;;; p4p-x2.lisp is the simple problem of non-empty view window
;;; 
;;; with NO INPUT FROM THE ENVIRONMENT 
;;; 
;;; The solution: Load_Window must be minimized instead of View_Window killed.
;;; 
;;; This version uses the threshhold and (on <w> SCR) predicate for determining
;;; clutter.
;;; 
;;; Difference between this and p4p-x1.lisp is that (is-empty View_Window) is
;;; commented out.
;;; 

(setf (current-problem)
      (create-problem
       (name p4px2)
       (objects
	(emacs User_Interface_for_Prodigy Load_Window
	       Email View_Window PortDialogBox 
	       Alert A_Simple_Frame Load View_Domain Close
	    WINDOW)
	(A1 A2 A3 A4 AREA)
	(SCR SCREEN)
	(runPRODIGY input2PRODIGY input2user control-display FUNCTION-VAL)
	)
       (state
	(and 
	     (in User_Interface_for_Prodigy A2) 
	     (in Load_Window A3)
	     (in View_Window A4)
	     (on User_Interface_for_Prodigy SCR) 
	     (on Load_Window SCR) 
	     (on View_Window SCR) 
	     (has-function emacs runPRODIGY)
	     (has-function Load_Window input2PRODIGY)
	     (has-function View_Window input2user)
	     (has-function User_Interface_for_Prodigy control-display)
;	     (is-empty View_Window)
	     (on-top User_Interface_for_Prodigy) 
	     (on-top View_Window) 
	     (on-top Load_Window) 
	     ))	
       (goal (and 
	      (clutterless SCR)
	      ))))

