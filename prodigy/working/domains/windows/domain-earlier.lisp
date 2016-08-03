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


(create-problem-space 'GUIworld :current t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                   ;;;;
;;;                               OBJECTS                             ;;;;
;;;                                                                   ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(ptype-of WINDOW :top-type)
(ptype-of AREA :top-type)
(ptype-of SCREEN :top-type)

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

;;; Restore an inactive window into its area and make it active. 
(OPERATOR RESTORE
  (params <w>)
  
;;; Window being restored must not be active, and the area to
;;; restore window to must be clear.
  (preconds
   ((<w> WINDOW) (<w1> (and WINDOW (diff <w> <w1>))) (<a> AREA))
   (and
    (iconified <w>)
    (in <w> <a>)
    (~(active <w>))
    (clear <a>)))
;;; A window will become active, and the area will not be clear anymore.
;;; If a window was an icon, it won't be any longer.
;;; If there was any other window on top of the area a window is being 
;;; restored to, it will not be on top anymore, and it will be below 
;;; restored window and inactive, if it was active.
;;; The restored window is active, so it is on the top.
  (effects
   () 
   (
    (add (active <w>))
    (del (clear <a>))
    (del (iconified <w>))
    (if (and (on-top <w1>) (in <w1> <a>)) ;; (diff <w1> <w>))
((del (on-top <w1>))
(add (on-top-of <w> <w1>))))
    (add (on-top <w>)))))









;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           ;
;           MOVE            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Move a window into an area.  Window is only window in beginning area.
(OPERATOR MOVE1
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
;     (in <w1> <a>) ; To bind W1 to the window where W is going.
    )
   )
  (effects
   ;; A window will not be in old area anymore, it will be in the new
   ;; area.
   ((<w1> WINDOW ))
;        (gen-from-pred '(on-top <w1>))))) ;Moved to here from preconds
   (
    (add (on-top <w-below>))
    (add (in <w> <a>))
    (del (on-top-of <w> <w-below>))
    (del (overlaps <w> <w-below>))
    (del (in <w> <a1>))
    (del (clear <a>))
    ;; If there was a window on top of the area to move a window into,
    ;; it won't be on top anymore, and new window will be on top of it.
            (if (and (in <w1> <a>)
     (on-top <w1>)
     (diff <W> <W1>))
((del (on-top <w1>))
(add (on-top-of <w> <w1>))
(add (overlaps <w> <w1>))
))
   )))





(control-rule  SELECT-TOP-WINDOW-BINDING-FOR-MOVE1
       (if (and (current-operator  MOVE1)
(type-of-object <Windo> WINDOW)
(true-in-state (on-top  <Windo>))
)
   )    
  (then select bindings ((<W> . <Windo>)) ))



(control-rule  SELECT-TOP-WINDOW-BINDING-FOR-MOVEOFFOF
       (if (and (current-operator  MOVEOFFOF)
(type-of-object <Windo> WINDOW)
(true-in-state (on-top  <Windo>))
; (type-of-object <QTo> AREA)
(true-in-state (clear <QTo>))
)
   )    
       (then select bindings ((<W> . <Windo>)) 
     (<A> . <QTo>)
     )
  )






(control-rule  SELECT-OP-MOVEOFFOF-WHEN-OTHER-WIN
       (if (and (candidate-operator  MOVE1)
(candidate-operator  MOVEOFFOF)
(current-goal (~ (overlaps <w1> <w2>)))
(true-in-state (on-top  <W1>))
(true-in-state (on-top-of <W1> <w2>))
)
   )
  (then select operator MOVEOFFOF ))

(control-rule  PREFER-OP-MOVE1-TO-RESTORE
       (if (and (candidate-operator  MOVE1)
(candidate-operator  RESTORE)
)
   )
       (then prefer operator MOVE1 RESTORE ))

(control-rule  PREFER-OP-MOVEOFFOF-TO-RESTORE
       (if (and (candidate-operator  MOVEOFFOF)
(candidate-operator  RESTORE)
)
   )
  (then prefer operator MOVEOFFOF RESTORE ))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           ;
;         MINIMIZE          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Minimize active window
(OPERATOR MINIMIZE
  (params <w>)
  (preconds
   ((<w> WINDOW)
    (<a> AREA)
    (<w1> (and WINDOW (diff <w> <w1>))))
   (and
    (on-top <w>)
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
    (if (active <w>)
((del (active <w>))
))
    (if (on-top-of <w> <w1>)
((del (on-top-of <w> <w1>))
(del (overlaps <w> <w1>))
))

    )))
;;; There is a rule to infer window is on top !!! (add (on-top <w1>)))))))









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
;;; 
;;; (INFERENCE-RULE INFER-WINDOW-ON-TOP
;;; (params <w1>)
;;; (mode eager)
;;; ;;; If there is not a different window on top of the current window,
;;; ;;; then the window is on top. 
;;; (preconds
;;; ((<w1> WINDOW) (<w2> (and WINDOW (diff <w2> <w1>))))
;;; (and
;;; (~(on-top-of <w2> <w1>))))
;;; (effects
;;; ()
;;; ((add (on-top <w1>)))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                           ;
;       NO-CLUTTER          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Infer no clogging, i.e. all the windows in GUI world that are active, 
;;; don't overlap.

(INFERENCE-RULE INFER-NO-CLUTTER 
(params <a>)
(mode eager)
(preconds
((<a> AREA))
(and
  (forall ((<w1> (and WINDOW
      (gen-from-pred (in <w1> <A>))))
   (<w2> (and WINDOW 
      (diff <w1> <w2>) 
      (gen-from-pred (in <w2> <A>))  )))
  (~ (overlaps <w1> <w2>))))
)
(effects
()
((add (clutterless <a>)))
)
)



;                           ;
;          OVERLAP          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Infer whether two windows overlap.
(INFERENCE-RULE INFER-IS-OVERLAPPED
(params <w1>)
(mode eager)

;;; Window is overlapped if another window is in the area and is on top of W1. 
(preconds
((<w1> WINDOW) 
  (<w2> (and WINDOW (diff <w2> <w1>)))
  (<a> AREA)
  )
(and
  (in <w1> <a>)
  (in <w2> <a>)
  (on-top-of <w2> <w1>)))
(effects
()
((add (overlaps <w2> <w1>)))))

