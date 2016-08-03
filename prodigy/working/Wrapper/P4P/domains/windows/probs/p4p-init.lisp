;;;;  THIS FILE is the initialize file for P4P. No window relationships are yet
;;;; established. The file only defines the objects and the functional
;;;; information.
;;;; 


(setf (current-problem)
      (create-problem
       (name p4pinit)
       (objects
	(emacs User_Interface_for_Prodigy Load_Window
	       Email View_Window PortDialogBox 
	       Alert A_Simple_Frame Load View_Domain 
	       Alert A_Simple_Frame Load View_Domain Close
	       Cancel OK Load_Domain Run Load_Problem View_Problem
	    WINDOW)
	(A1 A2 A3 A4 AREA)
	(SCR SCREEN)
	(runPRODIGY input2PRODIGY input2user control-display FUNCTION-VAL)
	)
       (state
	(and 
;	     (in User_Interface_for_Prodigy A2) 
;	     (in Load_Window A3)
;	     (in View_Window A4)
;	     (on User_Interface_for_Prodigy SCR) 
;	     (on Load_Window SCR) 
;	     (on View_Window SCR) 
	     (has-function emacs runPRODIGY)
	     (has-function Load_Window input2PRODIGY)
	     (has-function View_Window input2user)
	     (has-function User_Interface_for_Prodigy control-display)
;	     (is-empty View_Window)
;	     (on-top User_Interface_for_Prodigy) 
;	     (on-top View_Window) 
	     (on-top Load_Window) 
	     ))	
       (goal (and 
	      (clutterless SCR)
	      ))))


