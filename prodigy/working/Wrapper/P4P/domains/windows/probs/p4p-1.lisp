;;; NOTE that View window not used. Since it is not (in View <someArea>), it
;;; does not "exist."

(setf (current-problem)
      (create-problem
       (name p4p1)
       (objects
	(emacs UIP Load Email View
	    WINDOW)
	(A1 A2 A3 A4 AREA))
       (state
	(and (in emacs A1) (in UIP A2) (in Load A3) (in Email A4) 
	     (active Email) 
	     (on-top emacs) (on-top UIP) (on-top Load) (on-top Email) 
	     ))	
       (goal (and 
	      (clutterless A1)
	      (clutterless A2)
	      (clutterless A3)
	      (clutterless A4)
	      ))))


