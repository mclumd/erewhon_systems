;;; see old-switch-rules.lisp for comments and older versions of the
;;; rules


;; As I assume that changing tools is cheaper than changing
;; fixtures and moving part to other machine, this rule is a prefer
;; rule (so it orders the alts left after the other rules fire)

(control-rule SWITCH-MACH-OPERATION-SAME-TOOL
  (if (and (candidate-goal (holding-tool <other-mach> <other-tool>))
	   ;;current set-up
	   (known (holding-tool <mach> <curr-tool>))
	   ;;some open ops need current set-up
	   ;;(make sure it is a pending op!! (not one we've applied))
	   (is-subgoal-of-ops (holding-tool <mach> <curr-tool>) <ops>)
	   (first-pending-subgoal-in-subtree <pref-goal> <ops>)
	   ))
  (then prefer goal <pref-goal> <other-goal>))


#|
(control-rule SWITCH-MACH-OPERATION-SAME-TOOL
  (if (and (last-expanded-goal <g>) ;a main goal
	   (goal-instance-of <g>
             size-of shape-of has-hole has-spot is-tapped is-countersinked
	     is-counterbored is-reamed
	     ;surface-finish-side
	     surface-finish-quality-side
	     surface-coating-side surface-coating)	     
	   ;;current set-up
	   (known (holding-tool <mach> <curr-tool>))
	   ;;some open ops need current set-up
	   ;;(make sure it is a pending op!! (not one we've applied))
	   (is-subgoal-of-ops (holding-tool <mach> <curr-tool>) <ops>)
	   (is-subgoal-of-ops <pref-goal> <ops>)
	   ;;this avoids preference cycles
	   (~(is-subgoal-of-ops <other-goal> <ops>))
	   ))
  (then prefer goal <pref-goal> <other-goal>))
|#
;;; *****************************************************************
;;; rules for diff machines


(control-rule SWITCH-MACH-OPERATION-SAME-MACHINE2
  (if (and (candidate-goal-to-sel
	    (holding <new-mach> <hd> <part> <side> <s-pair>))
	   (known (has-device <machine> <curr-hd>))
	   (diff <machine> <new-mach>)
	   (or-metapred
	    (known (holding <machine> <curr-hd> <some-part> <some-s> <some-sp>))
	    (pending-goal (holding <machine> <curr-hd> <some-part> <some-s> <some-sp>)))
	   (is-subgoal-of-ops
	    (holding <machine> <curr-hd> <some-part> <some-s> <some-sp>)
	    <same-mach-ops>)
	   (is-pending-subgoal-in-subtree <sel-goal> <same-mach-ops>)
	   ))
  (then select goals <sel-goal>))

;;keep same machine (for same part)
(control-rule SWITCH-MACH-OPERATION-SAME-MACHINE2-SAME-PART
  (if (and (candidate-goal-to-sel
	    (holding <new-mach> <hd> <part> <side> <s-pair>))
	   (known (on-table <machine> <part>))
	   (diff <machine> <new-mach>)
	   (or-metapred
	    (known (holding <machine> <some-hd> <part> <some-s> <some-sp>))
	    (pending-goal (holding <machine> <some-hd> <part> <some-s> <some-sp>)))
	   (is-subgoal-of-ops
	    (holding <machine> <some-hd> <part> <some-s> <some-sp>) <ops>)
	   (is-pending-subgoal-in-subtree <sel-goal> <ops>)
	   ))
  (then select goals <sel-goal>))


#| REJECT version (they work)
;;keep same machine and hd (may be for a different part)
(control-rule SWITCH-MACH-OPERATION-SAME-MACHINE2
  (if (and (candidate-goal
	    (holding <new-mach> <hd> <part> <side> <s-pair>))
	   (has-device <machine> <curr-hd>)
	   (diff <machine> <new-mach>)
	   (pending-goal (holding <machine> <curr-hd> <some-part> <some-s> <some-sp>))
	   (is-subgoal-of-ops
	    (holding <new-mach> <hd> <part> <side> <s-pair>) <ops>)
	   (is-pending-subgoal-only-below-ops <rej-goal> <ops>)
	   ))
  (then reject goals <rej-goal>))

;;keep same machine (for same part)
(control-rule SWITCH-MACH-OPERATION-SAME-MACHINE2-SAME-PART
  (if (and (candidate-goal
	    (holding <new-mach> <hd> <part> <side> <s-pair>))
	   (on-table <machine> <part>)
	   (diff <machine> <new-mach>)
	   (pending-goal (holding <machine> <some-hd> <part> <some-s> <some-sp>))
	   (is-subgoal-of-ops
	    (holding <new-mach> <hd> <part> <side> <s-pair>) <ops>)
	   (is-pending-subgoal-only-below-ops <rej-goal> <ops>)
	   ))
  (then reject goals <rej-goal>))
|#

#|this works, at least when there is only one part. Split in the two above.
;;keep same machine (and part)
(control-rule SWITCH-MACH-OPERATION-SAME-MACHINE2
  (if (and (candidate-goal
	    (holding <new-mach> <hd> <part> <side> <s-pair>))
	   ;;current set-up
	   ;;(known (holding <machine> <curr-hd> <part> <curr-s> <curr-sp>))
	   (or-metapred
	    (has-device <machine> <curr-hd>)
	    (on-table <machine> <part>))
	   (diff <machine> <new-mach>)
	   ;;I need this to get bindings for <some...> or else
	   ;;is-subgoal-of-ops gives an error 
	   (pending-goal (holding <machine> <some-hd> <part> <some-s> <some-sp>))
	   (is-subgoal-of-ops
	    (holding <new-mach> <hd> <part> <side> <s-pair>) <ops>)
	   (is-pending-subgoal-only-below-ops <rej-goal> <ops>)
	   ;;(~ (is-subgoal-of-ops <rej-goal> <same-mach-ops>))
	   ))
  (then reject goals <rej-goal>))
|#
#|
;; old version: works fine (but harder to explain why holding is
;; known. It fires less times though)
;;keep same machine (and part)
(control-rule SWITCH-MACH-OPERATION-SAME-MACHINE2
  (if (and (candidate-goal
	    (holding <new-mach> <hd> <part> <side> <s-pair>))
	   ;;current set-up
	   (known (holding <machine> <curr-hd> <part> <curr-s> <curr-sp>))
	   (diff <machine> <new-mach>)
	   ;;I need this to get bindings for <some...> or else
	   ;;is-subgoal-of-ops gives an error 
	   (candidate-goal (holding <machine> <some-hd> <part> <some-s> <some-sp>))
	   ;;some open op will machine the part in the same machine
	   (is-subgoal-of-ops
	    (holding <machine> <some-hd> <part> <some-s> <some-sp>) <same-mach-ops>)
	   (is-subgoal-of-ops
	    (holding <new-mach> <hd> <part> <side> <s-pair>) <ops>)
	   (is-subgoal-of-ops <rej-goal> <ops>)
	   (~ (is-subgoal-of-ops <rej-goal> <same-mach-ops>))))
  (then reject goals <rej-goal>))


;as switch-mach-operation-same-machine2 but for has-device (instead of
;for on-table). It is more specific (setup to keep is mach + hd, while
;for on-table is only mach). Works for simple7. 
(control-rule temp1
  (if (and (candidate-goal
	    (holding <new-mach> <hd> <part> <side> <s-pair>))
	   ;;current set-up
	   ;;(known (on-table <machine> <part>))
	   (known (holding <machine> <curr-hd> <part> <curr-s> <curr-sp>))
	   (diff <machine> <new-mach>)
	   ;;I need this to get bindings for <some...> or else
	   ;;is-subgoal-of-ops gives an error 
	   (candidate-goal (holding <machine> <curr-hd> <part> <some-s> <some-sp>))
	   ;;some open op will machine the part in the same machine
	   ;;with the same hd
	   (is-subgoal-of-ops
	    (holding <machine> <curr-hd> <part> <some-s> <some-sp>) <same-mach-ops>)
	   (is-subgoal-of-ops
	    (holding <new-mach> <hd> <part> <side> <s-pair>) <ops>)
	   (is-subgoal-of-ops <rej-goal> <ops>)
	   (~ (is-subgoal-of-ops <rej-goal> <same-mach-ops>))))
  (then reject goals <rej-goal>))



;;this is even more specific than the previous one as the setup that
;;it preserves includes same machine, hd, side and side-pair.
;;Therefore it doesn't work for simple7 (side and side-pair are
;;different). 

;;;If there are pending operations on a part in the same machine where
;;;the part is, don't move the part to other machine.
(control-rule SWITCH-MACH-OPERATION-SAME-MACHINE
  (if (and (candidate-goal
	    (holding <new-mach> <hd> <part> <side> <s-pair>))
	   (known (holding <machine> <some-hd> <part> <s> <sp>))
	   (diff <machine> <new-mach>)
	   ;;some open op will machine the part in the same machine,
	   ;;with the same hd and side and side-pair
	   (is-subgoal-of-ops
	    (holding <machine> <some-hd> <part> <s> <sp>) <same-mach-ops>)
	   (is-subgoal-of-ops
	    (holding <new-mach> <hd> <part> <side> <s-pair>) <ops>)
	   (is-subgoal-of-ops <rej-goal> <ops>)
	   (~ (is-subgoal-of-ops <rej-goal> <same-mach-ops>))))
  (then reject goals <rej-goal>))
|#

;;; ******************************************************************
;;; same machine but diff setups.

;;The next two rules are never used.
#|
;;keep machine and hd (but may be a different part) (has-device...)
(control-rule SWITCH-MACH-OPERATION-SAME-HD
  (if (and (candidate-goal
	    (holding <machine> <hd> <part> <side> <s-pair>))
	   ;;current set-up
	   (known (holding <machine> <curr-hd> <curr-part> <curr-s> <curr-sp>))
	   (diff <hd> <curr-hd>)
	   ;;some open op needs current set-up
	   (candidate-goal
	    (holding <machine> <curr-hd> <some-part> <s> <sp>))
	   (is-subgoal-of-ops
	    (holding <machine> <curr-hd> <some-part> <s> <sp>) <ops>) 
	   ;;reject candidate goal and the other goals for its same op
	   (is-subgoal-of-ops
	    (holding <machine> <hd> <part> <side> <s-pair>) <goal-ops>)
	   ;;<rej-goal> should include the cand-goal!!
	   (is-subgoal-of-ops <rej-goal> <goal-ops>)
	   (~(is-subgoal-of-ops <rej-goal> <ops>))))
  (then reject goals <rej-goal>))

;;keep mach and part   (on-table...)
(control-rule SWITCH-MACH-OPERATION-SAME-PART
  (if (and (candidate-goal
	    (holding <machine> <hd> <part> <side> <s-pair>))
	   ;;current set-up
	   (known (holding <machine> <curr-hd> <curr-part> <curr-s> <curr-sp>))
	   (diff <part> <curr-part>)
	   ;;some open op needs current set-up
	   (candidate-goal
	    (holding <machine> <some-hd> <curr-part> <s> <sp>))
	   (is-subgoal-of-ops
	    (holding <machine> <some-hd> <curr-part> <s> <sp>) <ops>) 
	   ;;reject candidate goal and the other goals for its same op
	   (is-subgoal-of-ops
	    (holding <machine> <hd> <part> <side> <s-pair>) <goal-ops>)
	   ;;<rej-goal> should include the cand-goal!!
	   (is-subgoal-of-ops <rej-goal> <goal-ops>)
	   (~(is-subgoal-of-ops <rej-goal> <ops>))))
  (then reject goals <rej-goal>))
|#

;;keep machine, hd, part and setup (holding ...)
(control-rule SWITCH-MACH-OPERATION-SAME-HD-SETUP
  (if (and (candidate-goal-to-sel
	    (holding <machine> <hd> <part> <side> <s-pair>))
	   ;;current set-up
	   (known (holding <machine> <curr-hd> <curr-part> <curr-s> <curr-sp>))
	   ;;some open op needs current set-up
	   (is-subgoal-of-ops
	    (holding <machine> <curr-hd> <curr-part> <curr-s> <curr-sp>) <ops>) 
	   (is-pending-subgoal-in-subtree <sel-goal> <ops>)
	   ))
  (then select goals <sel-goal>))

#| REJECT version
;;keep machine, hd, part and setup (holding ...)
(control-rule SWITCH-MACH-OPERATION-SAME-HD-SETUP
  (if (and (candidate-goal
	    (holding <machine> <hd> <part> <side> <s-pair>))
	   ;;current set-up
	   (known (holding <machine> <curr-hd> <curr-part> <curr-s> <curr-sp>))
	   ;;some open op needs current set-up
	   (is-subgoal-of-ops
	    (holding <machine> <curr-hd> <curr-part> <curr-s> <curr-sp>) <ops>) 
	   ;;reject candidate goal and the other goals for its same op
	   (is-subgoal-of-ops
	    (holding <machine> <hd> <part> <side> <s-pair>) <goal-ops>)
	   (is-subgoal-of-ops <rej-goal> <goal-ops>)
	   (~(is-subgoal-of-ops <rej-goal> <ops>))))
  (then reject goals <rej-goal>))
|#