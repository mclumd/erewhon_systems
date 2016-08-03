;;; Intelligent GUI domain by Boris Kerkez
;;; Last edited: 14.11.1999
;;;
;;; This domain aleviates human users from the window clutter.
;;; The objects to operate on are WINDOWS; each window is in an AREA, 
;;; which is also an object.
;;; Operations on windows are exactly those that a human user can
;;; perform on the windows.

;;; There are several states windows can be in. 
;;; First of all, 
;;; each window is in a single area at all times, no matter if a 
;;; window is an icon or not.
;;;
;;; A window can be active (it is relevant for viewing in the 
;;; current state of the world), or not active (a window exists, 
;;; but there is no need to keep it visible on the screen).
;;;
;;; A window can ba an icon (minimized), or not an icon.
;;;
;;; One window can be on top of another window, i.e. one window can
;;; cover another window in the same area. Therefore, a window can 
;;; be on top (visible on the screen), or not be on top (there is 
;;; some other window on top of it). Whether a window is on top or
;;; not is infered.
;;;
;;; There are no direct manipulations of the areas, since the
;;; states of the areas are infered from the states that the
;;; windows occupying the areas are in. Consequently, an area can 
;;; be:
;;;    Clear - There are no active windows currently in the area.
;;;    Not clear - There is an active window in the area.
;;;
;;;
;;; Currently, there can be only one window in only one area. 


(create-problem-space 'GUIworld :current t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                   ;;;;
;;;                               OBJECTS                             ;;;;
;;;                                                                   ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(ptype-of WINDOW :top-type)
(ptype-of AREA :top-type)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                   ;;;;
;;;                             OPERATORS                             ;;;;
;;;                                                                   ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           ;
;          RESTORE          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Restore an inactive window into its area and make it active. 
;;; A window can be restored only if it an icon, i.e. RESTORE is the
;;; opposite of MINIMIZE
(OPERATOR RESTORE
	  (params <w>)
	  
;;; Window being restored must not be active, must be icon, and the area to
;;; restore window to must be clear.
	  (preconds
	   ((<w> WINDOW) 
	    (<w1> (and WINDOW (diff <w1> <w>)))
	    (<a> AREA))
	   (and
	    (icon <w>)
	    (~(active <w>))
	    (clear <a>)
	    (in <w> <a>)))
;;; A window will become active, and the area will not be clear anymore.
;;; A window was an icon, it won't be any longer.
;;; If there was any other window on top of the area a window is being 
;;; restored to, it will not be on top anymore, and it will be below 
;;; restored window and inactive, if it was active.
;;; The restored window is active, so it is on the top.
	  (effects
	   (
	   ) 
	   (
	    (add (active <w>))
	    (del (clear <a>))
	    (del (icon <w>))
	    (if (and (on-top <w1>) (in <w1> <a>))
		((del (on-top <w1>))
		 (add (on-top-of <w> <w1>))))
	    (add (on-top <w>)))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           ;
;          MAKE-ACTIVE          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Activate inactive window into its area. 
;;; A window can be activated only if it is not an icon, and area window is 
;;; currently clear.
(OPERATOR MAKE-ACTIVE
	  (params <w>)
	  
	  (preconds
	   ((<w> WINDOW) 
	    (<w1> (and WINDOW (diff <w1> <w>)))
	    (<a> AREA))
	   (and
	    (~(icon <w>))
	    (~(active <w>))
	    (clear <a>)
	    (in <w> <a>)))

;;; The restored window is active, so it is on the top.
	  (effects
	   (
	   ) 
	   (
	    (add (active <w>))
	    (del (clear <a>))
	    (del (icon <w>))
	    (if (and (on-top <w1>) (in <w1> <a>))
		((del (on-top <w1>))
		 (add (on-top-of <w> <w1>))))
	    (add (on-top <w>)))))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           ;
;         MINIMIZE          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Minimize window
(OPERATOR MINIMIZE
	  (params <w>)
;;; Any window can be minimized, active or inactive. Better that human, since
;;; here we have access to hidden windows
	  (preconds
	   ((<w> WINDOW)
	    (<w1> (and WINDOW (diff <w> <w1>)))
	    (<w2> (and WINDOW (diff <w2> <w1>) (diff <w2> <w>))) 
	    (<a> AREA))
	   (and
	    (~(icon <w>))
	    (in <w> <a>)))
;;; After being minimized, a window will become an icon and it will not
;;; be active or on top anymore. 
;;; If an active window is removed from an area, area a window was
;;; in will become clear.
;;; If there was another window below a window being minimized, it is 
;;; on top now, and it is not below minimized window anymore.	  
	  (effects 
           (
	   )
	   ((add (icon <w>))
	    (if (active <w>)
		((del (active <w>))
		 (add (clear <a>))))
	   
	    (if (and (on-top <w>) (on-top-of <w> <w1>))
	        ((add (on-top <w1>))
		 (del (on-top-of <w> <w1>))
	         (del (on-top <w>))))
	    (if (on-top <w>)
	        ((del (on-top <w>)))) 
	    ;;; Window w is sandwiched between two other windows, 
	    ;;; Update state of the world.
	    (if (and (on-top-of <w> <w1>) (on-top-of <w2> <w>))
		((del (on-top-of <w> <w1>))
		 (del (on-top-of <w2> <w>))
		 (add (on-top-of <w2> <w1>)))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           ;
;           MOVE            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Move a window into an area. A window need not be active to be moved.
(OPERATOR MOVE
	  (params <w> <a>)
	  (preconds
;;; A window must not be in the desired area already, and the area has to
;;; be clear. A window doesn't have to be active to be moved 	   
	   ((<w> WINDOW) 
	    (<a> AREA) 
	    (<w1> (and WINDOW (diff <w1> <w>))) 
	    (<w2> (and WINDOW (diff <w1> <w2>) (diff <w> <w2>)))  
	    (<a1> (and AREA (diff <a> <a1>))))
	   (and
	    (clear <a>)
	    (~(in <w> <a>))
	    ;;; Get the area the window being moved is currently in
	    (in <w> <a1>)))

	  ;;; A window will not be in old area anymore, it will be in the new
	  ;;; area. 	   
	  (effects
	   (
	    
	   )
	   (
	    ;;; If a window being moved was on top of other window, it is not
	    ;;; any longer, and the other window is on top now (rule!).	    

	    ;; "Sandwiched" :
	    (if (and (in <w1> <a1>) (in <w2> <a1>) (on-top-of <w> <w1>) (on-top-of <w2> <w>))
		((del (on-top-of <w2> <w>))	
		 (del (on-top-of <w> <w1>))
		 (add (on-top-of <w2> <w1>))))

	    ;; On top and on another window
	    (if (and (on-top <w>) (on-top-of <w> <w1>))
		((del (on-top-of <w> <w1>))
		 (add (on-top <w1>))))
	    ;; If w is just on top, it will stay on top, since move will put it on top in the clear area

	    (del (in <w> <a1>))
	    (add (in <w> <a>))
	    

	    ;;; If a window being moved is active, the area a window has moved to
	    ;;; will not be clear anymore.	    
	    (if (active <w>)
		((del (clear <a>))
		 (add (clear <a1>))))
	    
	    ;;; Now, update state of the world in the area where the window
	    ;;; was moved to.
	    
	    (if (and (in <w1> <a>) (on-top <w1>))
		((del (on-top <w1>))
		 (add (on-top-of <w> <w1>))))
	    ;;; Make sure moved window is on top now
	    (if (~(on-top <w>))
		((add (on-top <w>))))
	    
	    
	   )))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                   ;;;;
;;;                       INFERENCE RULES                             ;;;;
;;;                                                                   ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           ;
;      WINDOW-ON-TOP        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Infer that a window is on top, i.e. there are no other windows on top
;;; of it.
(INFERENCE-RULE INFER-WINDOW-ON-TOP
		(params <w1>)
;;; If there is not a different window on top of the current window,
;;; then the window is on top.		
		(preconds
		 ((<w1> WINDOW)
		  (<a> AREA)
;;;		  (<w2> (and WINDOW (diff <w2> <w1>)))
		  )
		(and

		 ;;; Ideally, here it should state:
		 ;;; if doesn't exist a window, s.t. this window is on top of
		 ;;; <w1>, then <w1> is on top. Had problems implementing this.
		 ;;; Help, please !
		 (in <w1> <a>)
		 (forall (
			  (<w2> (and WINDOW 
				     (diff <w1> <w2>) 
				     (gen-from-pred (in <w2> <A>))
				     )))
			 (~ (on-top-of <w2> <w1>)))
;;;		 (in <w2> <a>)
;;;		 (~(on-top-of <w2> <w1>))
		 ))
		(effects
		 ()
		 ((add (on-top <w1>)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           ;
;       NO-CLUTTER          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Infer no clutter, i.e. all the windows in GUI world that are active, 
;;; don't overlap.
(INFERENCE-RULE INFER-NO-CLUTTER
		(params)
		(preconds
		 (
;		  (<w1> WINDOW) 
;		  (<w2> (and WINDOW (diff <w1> <w2>)))
		  )
		 (and
		  (forall ((<w1> (and WINDOW
				      (gen-from-pred (active <w1>))))
			   (<w2> (and WINDOW 
				      (diff <w1> <w2>) 
				      (gen-from-pred (active <w2>)  ))))
			  (~ (overlaps <w1> <w2>)))
		  ;;; IS this OK?
;;;		  (~(and (active <w1>) 
;;;			 (active <w2>) 
;;;			 (overlaps <w1> <w2>)))
		  ))
		(effects
		 ()
		 ((add (no-clutter)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           ;
;          OVERLAP          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Infer whether two windows overlap.
(INFERENCE-RULE INFER-OVERLAP
		(params <w1> <w2>)
	
;;; Two windows overlap if they are in same area, and both are active.		
		(preconds
		 ((<w1> WINDOW) 
		  (<w2> (and WINDOW (diff <w1> <w2>)))
		  (<a1> (and AREA (in <w1> <a1>)))
		  (<a2> (and AREA (in <w2> <a2>))))
		 (and
		  (diff <w1> <w2>)
		  (~(diff <a1> <a2>))))
		(effects
		 ()
		 ((add (overlaps <w1> <w2>)))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                   ;;;;
;;;                         CONTROL RULES                             ;;;;
;;;                                                                   ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Choose appropriate bindings for MOVE operator, only clear areas
;;; cane be taken in consideration
(control-rule SELECT-AREAS-FOR-MOVE
	      (if (and (current-operator MOVE)
		       (type-of-object <ar> AREA)
		       (true-in-state (clear <ar>))
		  )
	      )    
	      (then select bindings ((<a> . <ar>)) ))







;(control-rule PREFER-MAKE-ACTIVE-TO-RESTORE
;	      (if (and (type-of-object <wi> WINDOW)
;		       (current-goal (active <w1>)




;(control-rule DONT-RESTORE-IF-NOT-AN-ICON
;	      (IF (and 
;		       (type-of-object <wi> WINDOW)
;		       (type-of-object <a> AREA)
;		       (current-goal (active <wi>))
;		       (true-in-state (in <wi> <a>))
;		       (true-in-state (clear <a>))))
;		   (candidate-operator (MAKE-ACTIVE <x>))
;		   (candidate-operator (RESTORE <x>))))
;	(THEN prefer operator MAKE-ACTIVE RESTORE))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;(INFERENCE-RULE INFER-AREA-CLEAR
;		(params <a>)
;		(preconds
;		 ((<a> AREA) (<w> WINDOW))
;		  (~(and (active <w>)
;			 (in <w> <a>))))
;		  (~(exists ((<w> WINDOW))
;			    (and
;			     (active <w>)
;			     (in <w> <a>))))))
;		  (~(exists ((<w> (and WINDOW (gen-from-pred (active <w>)))))

		
;		(effects
;		 ()
;       	         ((add (clear <a>)))))



;(CONTROL-RULE BDS
;	      (IF (oldest-candidate-node <node>))
;	      (THEN select node <node>))




;(INFERENCE-RULE INFER-WINDOW-OCCUPIES-AREA
;		(params <w> <a>)
;		(preconds
;		 ((<w> WINDOW)
;		  (<a> AREA)
;		  (<a1> (and AREA (in <w> <a1>))))
;		 (and
;		  (intersects <a> <a1>)))
;		(effects
;		 ()
;		 ((add (occupies <w> <a>)))))


;(INFERENCE-RULE INFER-AREAS-INTERSECT
;		(params <a1> <a2>)
;		(preconds
;		 ((<a1> AREA) 
;		  (<a2> AREA)
;		  (<x1> (and NUM (xCo <a1> <x1>))) (<x2> (and NUM (xCo <a2> <x2>))) 
;		  (<y1> (and NUM (yCo <a1> <y1>))) (<y2> (and NUM (yCo <a1> <y2>)))
;		  (<x1Size> (and NUM (xSize <a1> <x1Size>)))
;		  (<x2Size> (and NUM (xSize <a2> <x2Size>)))
;		  (<y1Size> (and NUM (ySize <a1> <y1Size>))) 
;		  (<y2Size> (and NUM (ySize <a2> <y2Size>))))
;		 (and 
;		   (or (intersect <x1> <x1Size> <x2> <x2Size>)
;		       (intersect <y1> <y1Size> <y2> <y2Size>))))
;		(effects
;		 ()
;       	         ((add (intersect <a1> <a2>)))))




;(OPERATOR RESIZE
;	  (params <w> <a>)
;	  (preconds
;	   ((<w> WINDOW) (<a> AREA)
;			 (<a1> AREA))
;	   (and 
;	    (in <w> <a1>)
;	    (clear <a>)))
;	  (effects
;	   ()
;	   ((add (in <w> <a>))
;	    (add (active <w>))
;	    (del (in <w> <a1>))
;	    (add (visible <w>)))))