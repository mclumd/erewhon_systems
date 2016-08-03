;;; Intelligent GUI domain by Boris Kerkez
;;;

;;; This domain explores the problem of aleviating window clutter using a
;;; simple world composed of a screen and an arbitrary number of windows. The
;;; screen is divided into four area quadrants . When not iconified, a window
;;; is contained in exactly one quadrant and fills the entire area. When
;;; iconified, the window is placed on the icon bar. Operations on windows are
;;; a subset of normal window operations. Move a window, minimize a window, and
;;; restore a window. A window cannot be resized.

;;; Several states exist for windows.  First a window can be part of the set of
;;; windows being used by the user for the current task. All windows in this
;;; set will be considered "active." All windows not active are considered to
;;; belong to a suspended user task. Second a window can ba an icon
;;; (minimized), or not an icon. By definition an iconified window is never
;;; part of the active set. Third a window can be on top of another window
;;; (i.e., one window can entirely cover another window in the same
;;; area). Therefore a window can be on top (visible on the screen), or not be
;;; on top (there is some other window on top of it). Whether a window is on
;;; top or not is inferred.
;;;

;;; There are no direct manipulations of the quadrants, since the states of the
;;; areas are infered from the states that the windows occupying the areas are
;;; in. Consequently, an area can only be "clear" or not.  A clear quadrant
;;; indicates that there are no active windows currently in the area. 
;;;

;;;; 
;;;; Major change in this domain representation:
;;;; 
;;;; 1. Removed all references to overlaps, including the inference rule that
;;;; would deduce the state, control rules that needed it, and operators that
;;;; added, deleted it, or used it in the test for conditional effects.
;;;; 
;;;; 2. Inferring no-clutter changed from dependence upon on-top-of predicate
;;;; to the window threshhold amount (see variable in functions.lisp).
;;;; 
;;;; 3. Added function-value (see Kerkez, Srinivas & Cox (2000).
;;;; 
;;;; 4. Uses SCR instead of only the four quadrants. SCR now an permanent
;;;; instance (declared with p-instance-of).
;;;; 
;;;; 


(create-problem-space 'P4Pworld :current t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                   ;;;;
;;;                               OBJECTS                             ;;;;
;;;                                                                   ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(ptype-of WINDOW :top-type)
(ptype-of AREA :top-type)
(ptype-of SCREEN :top-type)

;;; Added [16jun00 cox]
(ptype-of FUNCTION-VAL :top-type)
(pinstance-of SCR SCREEN)

;;;(ptype-of QUADRANT :top-type)
;;;(infinite-type NUM #'numberp)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                   ;;;;
;;;                             OPERATORS                             ;;;;
;;;                                                                   ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           ;
;          RESTORE          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; OPERATOR RESTORE an inactive window into its area and make it active. 
;;; 
;;; PRECONDITIONS:
;;; Window being restored must be iconified. 
;;; 
;;; EFFECTS:
;;; The window will become active, and the area will not be clear anymore.
;;; The window will no longer be an icon.
;;; If there was any other window on top of the area a window is being 
;;; restored to, it will not be on top anymore, and it will be below 
;;; restored window and inactive, if it was active.
;;; The restored window is active, so it is on the top.
;;; 
;;; Simplified [17jun00 cox]
;;; 
(OPERATOR RESTORE
	  (params <w> <a>)
	  (preconds
	   ((<w> WINDOW) 
	    (<w1> (and WINDOW (diff <w> <w1>))) 
	    (<a> AREA))
	   (and
	    (iconified <w>)
	    ))
	  (effects
	   (
	    ) 
	   (
	    (add (active <w>))
	    (add (on-top <w>))
	    (del (clear <a>))
	    (del (iconified <w>))
	    ;; The top window in the area will no longer be on top.
	    (if (and (on-top <w1>) (in <w1> <a>))
		((del (on-top <w1>))
		 (add (on-top-of <w> <w1>))))
	    )))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           ;
;         MINIMIZE          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Minimize active window
(OPERATOR MINIMIZE
	  (params <w> <a> <w1>)
	  (preconds
	   ((<w> WINDOW)
	    (<a> AREA)
	    (<w1> (and WINDOW (diff <w> <w1>))))
	   (and
;	    (~ (is-empty <w>))
;;;	    (on-top <w>)
	    (on <w> SCR)
	    (in <w> <a>)))
;;; After being minimized, a window will become an icon and it will not
;;; be active or on top anymore. 
;;; Since an active window is removed from an area, area a windoww was
;;; in will become clear.
;;; If there was another window below a window being minimized, it is 
;;; on top now, and it is not below minimized window anymore.	  
	  (effects 
	   ()
	   ((add (iconified <w>))
	    (del (on-top <w>))
	    (del (on <w> SCR)) ;Added [16jun00 cox]
	    (if (active <w>)
		((del (active <w>))
		 ))
	    (if (on-top-of <w> <w1>)
		((del (on-top-of <w> <w1>))
		 ))

	    )))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           ;
;           MOVE            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Move a window into an area.  Window is only window in beginning area.
(OPERATOR MOVE
	  (params <w> <a>)
	  (preconds
	   ;; A window must not be in the desired area already, and the area
	   ;; must be clear. A window doesn't have to be active to be moved
	   ((<w> WINDOW) 
	    (<a> AREA) 
	    (<a1> (and AREA (diff <a> <a1>))))
	   (and
	    (on-top <w>)
	    (~(in <w> <a>))
	    ;; Get the area the window being moved is currently in
	    (in <w> <a1>)))
	  (effects
	   ;; A window will not be in old area anymore, it will be in the new
	   ;; area.
	   ((<w1> WINDOW)) ;Moved to here from preconds
	   (
	    (add (in <w> <a>))
	    (add (on-top <w>))
	    (add (clear <a1>))
	    (del (in <w> <a1>))
	    (del (clear <a>))
	    ;; If there was a window on top of the area to move a window into,
	    ;; it won't be on top anymore, and new window will be on top of it.
            (if (and (in <w1> <a>) 
		     (on-top <w1>)
		     (diff <W> <W1>))
		((del (on-top <w1>))
		 (add (on-top-of <w> <w1>))
		 ))
	    ))
	  )

(OPERATOR MOVEOFFOF
	  (params <w> <a> <w-below> )
	  (preconds
	   ;; A window must not be in the desired area already, and the area
	   ;; must be clear. A window doesn't have to be active to be moved
	   ((<w> (and WINDOW (gen-from-pred '(on-top <w>))) )
	    (<w-below> WINDOW)
	    (<a> AREA)
	    (<a1> (and AREA (diff <a> <a1>))))
	   (and
	    (on-top <w>)
	    (clear <a>)
	    (on-top-of <w> <w-below>)
	    (~(in <w> <a>))
	    ;; Get the area the window being moved is currently in
	    (in <w> <a1>)
					;	    (in <w1> <a>) ; To bind W1 to the window where W is going.
	    )
	   )
	  (effects
	   ;; A window will not be in old area anymore, it will be in the new
	   ;; area.
	   ((<w1> WINDOW ))
					;		       (gen-from-pred '(on-top <w1>))))) ;Moved to here from preconds
	   (
	    (add (on-top <w-below>))
	    (add (in <w> <a>))
	    (del (on-top-of <w> <w-below>))
	    (del (in <w> <a1>))
	    (del (clear <a>))
	    ;; If there was a window on top of the area to move a window into,
	    ;; it won't be on top anymore, and new window will be on top of it.
            (if (and (in <w1> <a>)
		     (on-top <w1>)
		     (diff <W> <W1>))
		((del (on-top <w1>))
		 (add (on-top-of <w> <w1>))
		 ))
	    )))



;;[12may00 cox]
;;; 
;;; After being minimized, a window will become an icon and it will not
;;; be active or on top anymore. 
;;; Since an active window is removed from an area, area a windoww was
;;; in will become clear.
;;; If there was another window below a window being minimized, it is 
;;; on top now, and it is not below minimized window anymore.	  
;;; 
(OPERATOR KILL
	  (params <w> <a> <w1>)
	  (preconds
	   ((<w> WINDOW)
	    (<a> AREA)
	    (<w1> (and WINDOW (diff <w> <w1>)))
	    )
	   (and
	    (on-top <w>)
	    (in <w> <a>)))
	  (effects 
	   (
	    )
	   ((del (on-top <w>))
	    (del (in <w> <a>))
	    (del (on <w> SCR))		;Added [16jun00 cox]
	    (if (on-top-of <w> <w1>)
		((add (on-top <w1>))
		 (del (on-top-of <w> <w1>))
		 ))
	    (if (active <w>)
		((del (active <w>))
		 ))
	    )))






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                   ;;;;
;;;                        CONTROL RULES                              ;;;;
;;;                                                                   ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(control-rule  SELECT-TOP-WINDOW-BINDING-FOR-MOVE
	       (if (and (current-operator  MOVE)
			(type-of-object-gen <Windo> WINDOW)
			(true-in-state (on-top  <Windo>))
			)
		   )	   
	       (then select bindings ((<W> . <Windo>)) ))



(control-rule  SELECT-TOP-WINDOW-BINDING-FOR-MOVEOFFOF
	       (if (and (current-operator  MOVEOFFOF)
			(type-of-object-gen <Windo> WINDOW)
			(true-in-state (on-top  <Windo>))
					;			(type-of-object <QTo> AREA)
			(true-in-state (clear <QTo>))
			)
		   )	   
	       (then select bindings ((<W> . <Windo>)) 
		     (<A> . <QTo>)
		     )
	       )




(control-rule  SELECT-OP-MOVEOFFOF-WHEN-OTHER-WIN
	       (if (and (candidate-operator  MOVE)
			(candidate-operator  MOVEOFFOF)
			(current-goal (~ (on-top-of <w1> <w2>)))
			(true-in-state (on-top  <W1>))
			)
		   )
	       (then select operator MOVEOFFOF ))


(control-rule  PREFER-OP-MOVE-TO-RESTORE
	       (if (and (candidate-operator  MOVE)
			(candidate-operator  RESTORE)
			)
		   )
	       (then prefer operator MOVE RESTORE ))

(control-rule  PREFER-OP-MOVEOFFOF-TO-RESTORE
	       (if (and (candidate-operator  MOVEOFFOF)
			(candidate-operator  RESTORE)
			)
		   )
	       (then prefer operator MOVEOFFOF RESTORE ))



;;; New [1may00 cox]
(control-rule  PREFER-OP-MINIMIZE-TO-MOVEOFFOF
	       (if (and (candidate-operator  MOVEOFFOF)
			(candidate-operator  MINIMIZE)
			(current-goal(~ (on-top-of <w1> <w2>)))
			(false-in-state-forall-values
			 '(clear <A>))
			)
	   )
	       (then prefer operator MINIMIZE MOVEOFFOF))

;;; New [12may00 cox]
(control-rule  PREFER-OP-KILL-TO-MOVEOFFOF
	       (if (and (candidate-operator  MOVEOFFOF)
			(candidate-operator  KILL)
			(current-goal(~ (on-top-of <w1> <w2>)))
			(false-in-state-forall-values
			 '(clear <A>))
			)
	   )
	       (then prefer operator KILL MOVEOFFOF))





;;; New [17jun00 cox]
;;; 
;;; This control rule differentiates the KILL and MINIMIZE OP whewn a goal is
;;; to remove a window from the screen. See Kerkez, Srinivas, & Cox (2000).
;;; 
(control-rule  PREFER-OP-KILL-TO-MINIMIZE
	       (if (and (candidate-operator  MINIMIZE)
			(candidate-operator  KILL)
			(current-goal(~ (on <windo> SCR)))
;			(type-of-object-gen <Windo> WINDOW)
			(true-in-state (is-empty <windo>))
			)
	   )
	       (then prefer operator KILL MINIMIZE))





;;[1may00 cox]
(control-rule  SELECT-AREA-BINDING-FOR-MINIMIZE
	       (if (and (current-operator  MINIMIZE)
			(current-goal (~ (on-top-of <w1> <w2>)))
			(type-of-object-gen <area> AREA)
			(true-in-state (in  <w1> <Area>))
			)
	   )	   
  (then select bindings ((<A> . <Area>)) ))


;;[12may00 cox]
(control-rule  SELECT-AREA-BINDING-FOR-KILL
	       (if (and (current-operator  KILL)
			(current-goal (~ (on-top-of <w1> <w2>)))
			(type-of-object-gen <area> AREA)
			(true-in-state (in  <w1> <Area>))
			)
	   )	   
  (then select bindings ((<A> . <Area>)) ))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                   ;;;;
;;;                       INFERENCE RULES                             ;;;;
;;;                                                                   ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           ;
;       NO-CLUTTER          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Second Major Change [16jun00 cox]
(INFERENCE-RULE INFER-NO-CLUTTER 
		(params <scr>)
		(mode lazy)
		(preconds
					;		 ((<a> AREA))
		 ((<scr> SCREEN)
		  (<w> 
		   (and WINDOW 
			(test-candidate-window <w>) ;(gen-from-pred (has-function <w> INPUT2PRODIGY))
			))
		  )
		 (and
		  (~ (on <w> <scr>)))
		 )
		(effects
		 ()
		 ((add (clutterless <scr>)))
		 )
		)


#|

;;; Earlier Major Change [1may00 cox]
;;; Old approach using on-top-of relationship
;;;
(INFERENCE-RULE INFER-NO-CLUTTER 
		(params <scr>)
		(mode lazy)
		(preconds
					;		 ((<a> AREA))
		 ((<scr> SCREEN))
		 (and
		  (forall ((<A> AREA)
			   (<w1> (and WINDOW
				      (gen-from-pred (in <w1> <A>) <w1> )))
			   (<w2> (and WINDOW 
				      (diff <w1> <w2>) 
				      (gen-from-pred (in <w2> <A> <w2>)) )))
			  (~ (on-top-of <w1> <w2>))))
		 )
		(effects
		 ()
		 ((add (clutterless <scr>)))
		 )
		)

|#

