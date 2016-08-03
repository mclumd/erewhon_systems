;;; Here is the simple problem of empty view window 
;;; with THE INPUT COMING FROM THE ENVIRONMENT
;;; The solution is to kill "View_Window."

(setf (current-problem)
      (create-problem
       (name p4p2)
       (objects
	(emacs User_Interface_for_Prodigy 
	       Load_Window Email View_Window 
	       PortDialogBox
	    WINDOW)
	(A1 A2 A3 A4 AREA)
	(SCR SCREEN))
       (state
	(and (in emacs A1) 
	     (in User_Interface_for_Prodigy A2) 
	     (in Load_Window A3) 
	     (in Email A4) 
;	     (in View_Window A4) 
;	     (active View_window) 
;	     (is-empty View_Window)
	     (on-top emacs) 
	     (on-top User_Interface_for_Prodigy) 
	     (on-top Email) 
	     (on-top Load_Window) 
;	     (on-top View_Window) 
;	     (on-top-of View_Window Load_Window) 
	     ))	
       (goal (and 
	      (clutterless SCR)
	      ))))


