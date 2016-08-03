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
;	   (preference-value-for-goal 5 <pref-goal>)
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
  (if (and (candidate-goal
	    (holding <new-mach> <hd> <part> <side> <s-pair>))
	   (known (has-device <machine> <curr-hd>))
	   (diff <machine> <new-mach>)
	   (or-metapred
	    (known (holding <machine> <curr-hd> <some-part> <some-s> <some-sp>))
	    (pending-goal (holding <machine> <curr-hd> <some-part> <some-s> <some-sp>)))
	   (is-subgoal-of-ops
	    (holding <machine> <curr-hd> <some-part> <some-s> <some-sp>)
	    <same-mach-ops>)
	   (first-pending-subgoal-in-subtree <sel-goal> <same-mach-ops>)
;	   (preference-value-for-goal 0 <sel-goal>)
	   ))
  (then prefer goals <sel-goal> <other-goal>))


;;keep same machine (for same part).
;;mmm: impossible (and (known (on-table <machine> <part>))
;;                     (known (holding <machine> <some-hd> <part> <some-s> <some-sp>)))
;;if I remove  (known (on-table <machine> <part>)) it gets subsumed in
;;switch-mach-operation-same-machine2

(control-rule SWITCH-MACH-OPERATION-SAME-MACHINE2-SAME-PART
  (if (and (candidate-goal
	    (holding <new-mach> <hd> <part> <side> <s-pair>))
	   (known (on-table <machine> <part>))
	   (diff <machine> <new-mach>)
	   (or-metapred
	    (known (holding <machine> <some-hd> <part> <some-s> <some-sp>))
	    (pending-goal (holding <machine> <some-hd> <part> <some-s> <some-sp>)))
	   (is-subgoal-of-ops
	    (holding <machine> <some-hd> <part> <some-s> <some-sp>) <ops>)
	   (first-pending-subgoal-in-subtree <sel-goal> <ops>)
;	   (preference-value-for-goal 1 <sel-goal>)
	   ))
  (then prefer goals <sel-goal> <other-goal>))

;;keep machine, hd, part and setup (holding ...)
(control-rule SWITCH-MACH-OPERATION-SAME-HD-SETUP
  (if (and (candidate-goal
	    (holding <machine> <hd> <part> <side> <s-pair>))
	   ;;current set-up
	   (known (holding <machine> <curr-hd> <curr-part> <curr-s> <curr-sp>))
	   ;;some open op needs current set-up
	   (is-subgoal-of-ops
	    (holding <machine> <curr-hd> <curr-part> <curr-s> <curr-sp>) <ops>) 
	   (first-pending-subgoal-in-subtree <sel-goal> <ops>)
;	   (preference-value-for-goal 0 <sel-goal>)
	   ))
  (then prefer goals <sel-goal> <other-goal>))


;;; ****************************************************************
;;;*rule-relative-weights* contains pairs of rules such that first
;;;rule should be preferred over the second.

(when (fboundp 'p4::sc-rule-name-to-rule)
  (setf p4::*rule-relative-weights*
	(list
	 (list (p4::sc-rule-name-to-rule 'switch-mach-operation-same-machine2)
	       (p4::sc-rule-name-to-rule 'switch-mach-operation-same-machine2-same-part))
	 (list (p4::sc-rule-name-to-rule 'switch-mach-operation-same-hd-setup)
	       (p4::sc-rule-name-to-rule 'switch-mach-operation-same-tool))))

  (format t "Defined *rule-relative-weights*.~%"))