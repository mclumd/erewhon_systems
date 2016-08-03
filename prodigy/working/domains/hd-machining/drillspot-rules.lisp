;;for eval-fn/cost-diff-ops.lisp

;;works
(control-rule test-drillspot0
  (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
	   ;;milling-machine has spot-drill
	   (known (holding-tool <machine> <drill-bit>))
	   (type-of-object <drill-bit> spot-drill)
	   (type-of-object <machine> milling-machine)
	   ;;drill-press has twist-drill
	   (known (holding-tool <mach> <other-bit>))
	   (type-of-object <mach> DRILL)
	   (~ (type-of-object <other-bit> SPOT-DRILL))))
  (then prefer operator drill-with-spot-drill-in-milling-machine
	drill-with-spot-drill))

(control-rule prefer-bnds-drill-with-spot-drill-in-milling-machine34
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (current-operator drill-with-spot-drill-in-milling-machine)
		       (pending-goal (holding <machine-4> <holding-device-5> <part> <side>
					      <side-pair-6>))
		       (or (diff <machine-4> <machine-1>)
			   (diff <holding-device-5> <holding-device-2>)
			   (diff <side-pair-6> <side-pair-3>))
		       ))
	      (then prefer bindings
		    ((<machine> . <machine-4>) (<holding-device> . <holding-device-5>)
		     (<side-pair> . <side-pair-6>))
		    ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>)
		     (<side-pair> . <side-pair-3>))))

(control-rule prefer-bnds-drill-with-spot-drill35
	      (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
		       (current-operator drill-with-spot-drill)
		       (pending-goal (holding <machine-4> <holding-device-5> <part> <side>
					      <side-pair-6>))
		       (or (diff <machine-4> <machine-1>)
			   (diff <holding-device-5> <holding-device-2>)
			   (diff <side-pair-6> <side-pair-3>))
			      ))
                     (then prefer bindings
                      ((<machine> . <machine-4>) (<holding-device> . <holding-device-5>)
                       (<side-pair> . <side-pair-6>))
                      ((<machine> . <machine-1>) (<holding-device> . <holding-device-2>)
                       (<side-pair> . <side-pair-3>))))


;;learned for drillhole4

(CONTROL-RULE PREFER-BNDS-DRILL-WITH-TWIST-DRILL11
              (IF (AND (CURRENT-GOAL (HAS-HOLE <PART> <HOLE> <SIDE> <HOLE-DEPTH> <HOLE-DIAMETER>
                                      <LOC-X> <LOC-Y>))
                       (CURRENT-OPERATOR DRILL-WITH-TWIST-DRILL)
                       (KNOWN (HAS-DEVICE <MACHINE-3> <HOLDING-DEVICE-4>))
                       (OR (DIFF <MACHINE-3> <MACHINE-1>)
                           (DIFF <HOLDING-DEVICE-4> <HOLDING-DEVICE-2>))))
              (THEN PREFER BINDINGS
               ((<MACHINE> . <MACHINE-3>) (<HOLDING-DEVICE> . <HOLDING-DEVICE-4>))
               ((<MACHINE> . <MACHINE-1>) (<HOLDING-DEVICE> . <HOLDING-DEVICE-2>))))


;;milling-machine has vise, drill-press doesn't have a hd
;;don't need ~(on-table <drill> ) because equiv (on-table <MM>)

(control-rule test-drillhole1
  (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
				   <hole-diameter> <loc-x> <loc-y>))
	   (known  (has-device <machine> <holding-device-4>))
	   (type-of-object <machine> milling-machine)
	   (known (on-table <machine> <part>))
	   (false-in-state-forall-values
	    (has-device <drill> <holding-device>)
	    (<holding-device> HOLDING-DEVICE) ;;possible types would come of op
	    (<drill> DRILL))))
  (then prefer operator drill-with-twist-drill-in-milling-machine
	drill-with-twist-drill))

(control-rule test-drillhole3
  (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
				   <hole-diameter> <loc-x> <loc-y>))
	   (known  (has-device <machine> <holding-device-4>))
	   (type-of-object <machine> milling-machine)
	   (known (on-table <machine> <part>))
	   (~ (has-spot  <part> <hole> <side> <loc-x> <loc-y>))
	   (false-in-state-forall-values
	    (has-device <drill> <holding-device>)
	    (<holding-device> HOLDING-DEVICE) ;;possible types would come of op
	    (<drill> DRILL))))
  (then prefer operator drill-with-twist-drill drill-with-twist-drill-in-milling-machine))

#| replace by test-drillhole5-specific
(control-rule test-drillhole5
  (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
				   <hole-diameter> <loc-x> <loc-y>))
	   (known (holding <machine> <holding-device> <part> <side>
			   <side-pair>))
	   (type-of-object <machine> Milling-machine)))
  (then prefer operator drill-with-twist-drill-in-milling-machine
	drill-with-twist-drill))
|#

(control-rule test-drillhole5-sd
  (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
	   (known (holding <machine> <holding-device> <part> <side>
			   <side-pair>))
	   (type-of-object <machine> Milling-machine)))
  (then prefer operator drill-with-spot-drill-in-milling-machine
	drill-with-spot-drill))

;;both  test-drillhole5 and test-drillhole7 fire for drillhole7, and
;;cycle is broken correctly (for drill)

#| replace by test-drillhole5-specific
(control-rule test-drillhole7
  (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
				   <hole-diameter> <loc-x> <loc-y>))
	   (known (has-device <machine> <holding-device>))
	   (type-of-object <machine> DRILL)
	   (known (is-clean <part>))
	   (false-in-state-forall-values
	    (holding <m> <holding-device> <p> <s> <sp>)
	    (<m> machine)(<p> part)(<s> side)(<sp> Side-Pair))))
  (then prefer operator drill-with-twist-drill
	drill-with-twist-drill-in-milling-machine)) 
|#
(control-rule test-drillhole7-sd
  (if (and (current-goal (has-spot <part> <hole> <side> <loc-x> <loc-y>))
	   (known (has-device <machine> <holding-device>))
	   (type-of-object <machine> DRILL)
	   (known (is-clean <part>))
	   (false-in-state-forall-values
	    (holding <m> <holding-device> <p> <s> <sp>)
	    (<m> machine)(<p> part)(<s> side)(<sp> Side-Pair))))
  (then prefer operator drill-with-spot-drill
	drill-with-spot-drill-in-milling-machine)) 



#| rules learned for tst-drillhole-7
Loading rule PREFER-BNDS-DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE4.

(CONTROL-RULE PREFER-BNDS-DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE4
              (IF (AND (CURRENT-GOAL (HAS-SPOT <PART> <HOLE> <SIDE> <LOC-X> <LOC-Y>))
                       (CURRENT-OPERATOR DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE)
                       (KNOWN (HAS-DEVICE <MACHINE-3> <HOLDING-DEVICE-4>))
                       (PENDING-GOAL (HOLDING <MACHINE-1> <HOLDING-DEVICE-2> <PART> <SIDE-3>
                                      <SIDE-PAIR-4>))
                       (OR (DIFF <MACHINE-3> <MACHINE-1>)
                           (DIFF <HOLDING-DEVICE-4> <HOLDING-DEVICE-2>))))
              (THEN PREFER BINDINGS
               ((<MACHINE> . <MACHINE-3>) (<HOLDING-DEVICE> . <HOLDING-DEVICE-4>))
               ((<MACHINE> . <MACHINE-1>) (<HOLDING-DEVICE> . <HOLDING-DEVICE-2>))))


Loading rule PREFER-DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE3.

(CONTROL-RULE PREFER-DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE3
              (IF (AND (CURRENT-GOAL (HAS-SPOT <PART> <HOLE> <SIDE> <LOC-X> <LOC-Y>))
                       (KNOWN (HAS-DEVICE <MACHINE> <HOLDING-DEVICE>))
                       (PENDING-GOAL (HOLDING <MACHINE-1> <HOLDING-DEVICE-2> <PART> <SIDE-3>
                                      <SIDE-PAIR-4>))
                       (TYPE-OF-OBJECT <MACHINE> MILLING-MACHINE)))
              (THEN PREFER OPERATOR DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE DRILL-WITH-SPOT-DRILL))


Loading rule PREFER-BNDS-DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE2.

(CONTROL-RULE PREFER-BNDS-DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE2
              (IF (AND (CURRENT-GOAL (HAS-HOLE <PART> <HOLE> <SIDE> <HOLE-DEPTH> <HOLE-DIAMETER>
                                      <LOC-X> <LOC-Y>))
                       (CURRENT-OPERATOR DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE)
                       (KNOWN (HAS-DEVICE <MACHINE-3> <HOLDING-DEVICE-4>))
                       (OR (DIFF <MACHINE-3> <MACHINE-1>)
                           (DIFF <HOLDING-DEVICE-4> <HOLDING-DEVICE-2>))))
              (THEN PREFER BINDINGS
               ((<MACHINE> . <MACHINE-3>) (<HOLDING-DEVICE> . <HOLDING-DEVICE-4>))
               ((<MACHINE> . <MACHINE-1>) (<HOLDING-DEVICE> . <HOLDING-DEVICE-2>))))


Loading rule PREFER-DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE1.

(CONTROL-RULE PREFER-DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE1
              (IF (AND (CURRENT-GOAL (HAS-HOLE <PART> <HOLE> <SIDE> <HOLE-DEPTH> <HOLE-DIAMETER>
                                      <LOC-X> <LOC-Y>))
                       (KNOWN (HAS-DEVICE <MACHINE> <HOLDING-DEVICE>))
                       (TYPE-OF-OBJECT <MACHINE> MILLING-MACHINE)))
              (THEN PREFER OPERATOR DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE
               DRILL-WITH-TWIST-DRILL))


|#


(control-rule test-drillhole5-specific
  (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
				   <hole-diameter> <loc-x> <loc-y>))
	   (known (holding <machine> <holding-device> <part> <side>
			   <side-pair>))
	   (type-of-object <machine> Milling-machine)
	   (forall-metapred
	    (and (type-of-object-gen <drill> DRILL)
		 (type-of-object-gen <hd> HOLDING-DEVICE))
	    (and (~ (has-device <drill> <hd>))
		 (has-device <other-mach> <hd>)
		 ;;next is implied by above holding
		 ;;(holding <other-mach> <hd> <p> <s> <sp>)
		 (~ (is-clean <part>))
		 (~ (on-table <drill> <part>))))))
  (then prefer operator drill-with-twist-drill-in-milling-machine
	drill-with-twist-drill))
#|
;;next is a test: rule as it would be learned. some precs not needed
(control-rule test-drillhole5-specific
  (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
				   <hole-diameter> <loc-x> <loc-y>))
	   (known (holding <machine> <holding-device> <part> <side>
			   <side-pair>))
	   (type-of-object <machine> Milling-machine)
	   ;;type for hd, Side-Pair (or else compare type from op spec
	   ;;and predicate signature)
	   (known (~ (has-hole <part> <hole> <side> <loc-x> <loc-y>)))
	   (forall-metapred
	    (and (type-of-object-gen <drill> DRILL)
		 (type-of-object-gen <hd> HOLDING-DEVICE)
		 (type-of-object-gen <spa> SIDE-PAIR))
	    (and (~ (holding <drill> <hd> <part> <side> <spa>))
		 ;;previous is implied by above holding		 
		 (~ (has-device <drill> <hd>))
		 (has-device <other-mach> <hd>)
		 ;;next is implied by first holding
		 (holding <other-mach> <hd> <p> <s> <sp>)
		 (~ (is-clean <part>))
		 (~ (on-table <drill> <part>))))))
  (then prefer operator drill-with-twist-drill-in-milling-machine
	drill-with-twist-drill))
|#


;;this rule has two preconds less than test-drillhole5-specific. Fires
;;correctly also for drillhole5
(control-rule test-drillhole6-specific
  (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
				   <hole-diameter> <loc-x> <loc-y>))
	   (known (holding <machine> <holding-device> <part> <side>
			   <side-pair>))
	   (type-of-object <machine> Milling-machine)
	   (forall-metapred
	    (type-of-object-gen <drill> DRILL)
	    (and (~ (is-clean <part>))
		 ;;next is implied by above holding
		 ;;(holding <other-mach> <other-hd> <part> <s> <sp>)		 
		 (~ (on-table <drill> <part>))))))
  (then prefer operator drill-with-twist-drill-in-milling-machine
	drill-with-twist-drill))


(control-rule test-drillhole8-specific
  (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
				   <hole-diameter> <loc-x> <loc-y>))
	   (known (holding <machine> <holding-device> <part> <side>
			   <side-pair>))
	   (type-of-object <machine> Milling-machine)
	   (forall-metapred
	    (type-of-object-gen <drill> DRILL)
	    (and ;;next is implied by above holding
		 ;;(holding <other-mach> <other-hd> <part> <s> <sp>)
                 ;;next doen't work (the rule hasn't fired and
	         ;;is-available-machine is false). It is ok for
	         ;;drillhole8, but makes the rule fire for drillhole7 as well.
;	         (~ (is-available-machine <drill>))
	         ;;logically equivalent to next lines
                 (holding <drill> <some-hd> <p> <s> <sp>)
		 (or (diff <p> <part>)
		     (diff <s> <side>)
		     (diff <sp> <side-pair>))))))
  (then prefer operator drill-with-twist-drill-in-milling-machine
	drill-with-twist-drill))

#|
;;next rule is not needed but I want to test preds inferred by inf rules
;;-not tested if default is drill-with-twist-drill
::-wouldn't fire because is-empty-holding-device has not been inferred
(although it would be true)
(control-rule test-drillhole7-specific
  (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
				   <hole-diameter> <loc-x> <loc-y>))
	   (known (holding-tool <drill> <spot-drill>))
	   (type-of-object <drill> DRILL)
	   (type-of-object <spot-drill> Spot-drill)
	   (known (has-device <drill> <hd>))
	   (is-clean <part>)
	   (is-available-machine <drill>)
	   (is-empty-holding-device <hd> <drill>)
	   
	   (forall-metapred
	    (type-of-object-gen <mm> MILLING-MACHINE)
	    (and (holding-tool <mm> <tool>)
		 (diff <tool> <spot-drill>)))))
  (then prefer operator drill-with-twist-drill
	drill-with-twist-drill-in-milling-machine))
|#

;;precs ordered as they appear in tree. Dumb order? (i.e. generate all
;;mms and then test them)

(control-rule tst-drillhole-7-specific
  (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
				   <hole-diameter> <loc-x> <loc-y>))
	   (type-of-object-gen <mm> MILLING-MACHINe)
	   (type-of-object-gen <spot-drill> SPOT-DRILL)
	   (forall-metapred
	    (type-of-object-gen <tool> MACHINE-TOOL)
	    (~ (holding-tool <mm> <tool>)))
	   (forall-metapred
	    (type-of-object-gen <any-machine> MACHINE)
	    (~ (holding-tool <any-machine> <spot-drill>)))
	   (has-device <mm> <hd>)
	   (forall-metapred
	    (and (type-of-object-gen <drill> DRILL)
		 (type-of-object-gen <hd> HOLDING-DEVICE))		 

	    (and (holding-tool <drill> <some-tool>)
		 (diff <some-tool> <spot-drill>)
		 (~ (has-device <drill> <hd>))
		 (has-device <other-mach> <hd>)
		 (holding <other-mach> <hd> <p> <s> <sp>)
		 (~ (is-clean <part>))
		 (~ (on-table <drill> <part>))))))
  (then prefer operator drill-with-twist-drill-in-milling-machine
	drill-with-twist-drill))

(control-rule simple5
  (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
				   <hole-diameter> <loc-x> <loc-y>))
	   (pending-goal (holding <mm> <holding-device> <part> <side>
			   <side-pair>))
	   (type-of-object <mm> MILLING-MACHINE)
	   (type-of-object-gen <plain-mill> PLAIN-MILL)
	   (forall-metapred
	    (type-of-object-gen <machine> Machine)
	    (~ (holding-tool <machine> <plain-mill>)))
	   (forall-metapred
	    (type-of-object-gen <tool> Machine-Tool)
	    (~ (holding-tool <mm> <tool>)))
	   ;;below again
;          (forall-metapred
;            (type-of-object-gen <hd> HOLDING-DEVICE)
;            (~ (has-device <mm> <hd>)))
	   (forall-metapred
	    (and (type-of-object-gen <p> PART)
		 (type-of-object-gen <hd2> HOLDING-DEVICE)
		 (type-of-object-gen <s> SIDE)
		 (type-of-object-gen <sp> Side-Pair))
	    (and (~ (on-table <mm> <p>))
		 (~ (holding <mm> <hd2> <p> <s> <sp>))))

	   (type-of-object-gen <drill> DRILL) ;should this be forall?
	   (~ (on-table <drill> <part>))
	   (forall-metapred
	    (type-of-object-gen <hd3> HOLDING-DEVICE)
	    (~ (has-device <drill> <hd3>)))
	   (forall-metapred
	    (type-of-object-gen <t> Machine-Tool)
	    (~ (holding-tool <drill> <t>)))))
  (then prefer operator drill-with-twist-drill-in-milling-machine
	drill-with-twist-drill))

;;fires also for simple5
(control-rule size-hole1
  (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
				   <hole-diameter> <loc-x> <loc-y>))
	   (pending-goal (holding <mm> <holding-device> <part> <side>
			   <side-pair>))
	   (type-of-object <mm> MILLING-MACHINE)

	   (type-of-object-gen <plain-mill> PLAIN-MILL)
	   ;;next two removed so rule fires in size-hole3. Not needed
	   ;;because they appear in both good sol and bad sol (in
	   ;;size-hole1) although hanging from diff trees.	   
;           (forall-metapred
;            (type-of-object-gen <machine> Machine)
;            (~ (holding-tool <machine> <plain-mill>)))
;           (forall-metapred
;            (type-of-object-gen <tool> Machine-Tool)
;            (~ (holding-tool <mm> <tool>)))
	   (forall-metapred
	    (and (type-of-object-gen <p> PART)
		 (type-of-object-gen <hd2> HOLDING-DEVICE)
		 (type-of-object-gen <s> SIDE)
		 (type-of-object-gen <sp> Side-Pair))
	    ;;next removed so rule fires in size-hole4. Not needed
	   ;;because it appears in both good sol and bad sol (in
	   ;;size-hole1) although hanging from diff trees.	   
;	    (~ (on-table <mm> <p>))
	    (~ (holding <mm> <hd2> <p> <s> <sp>)))
	   ;;without next, fires incorrectly for size-hole2
	   (forall-metapred
	    (and (type-of-object-gen <drill> DRILL)
		 (type-of-object-gen <hd2> HOLDING-DEVICE)
		 (type-of-object-gen <s> SIDE)
		 (type-of-object-gen <sp> Side-Pair))		 
	    (~ (holding <drill> <hd2> <part> <s> <sp>)))))
  (then prefer operator drill-with-twist-drill-in-milling-machine
	drill-with-twist-drill))

(control-rule size-hole5
  (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
				   <hole-diameter> <loc-x> <loc-y>))
	   (known (holding <machine> <holding-device> <part> <side>
			   <side-pair>))
	   (type-of-object <machine> Milling-machine)
	   (pending-goal (size-of <part> <dim> <val>))))
	   ;;here precs on relat between <dim> and <side>
  (then prefer operator drill-with-twist-drill-in-milling-machine
	drill-with-twist-drill))

;;for tap2
(CONTROL-RULE PREFER-BNDS-TAP23
              (IF (AND (CURRENT-GOAL (IS-TAPPED <PART> <HOLE> <SIDE> <HOLE-DEPTH> <HOLE-DIAMETER>
                                      <LOC-X> <LOC-Y>))
                       (CURRENT-OPERATOR TAP) (KNOWN (HAS-DEVICE <MACHINE-3> <HOLDING-DEVICE-4>))
                       (OR (DIFF <MACHINE-3> <MACHINE-1>)
                           (DIFF <HOLDING-DEVICE-4> <HOLDING-DEVICE-2>))))
              (THEN PREFER BINDINGS
               ((<MACHINE> . <MACHINE-3>) (<HOLDING-DEVICE> . <HOLDING-DEVICE-4>))
               ((<MACHINE> . <MACHINE-1>) (<HOLDING-DEVICE> . <HOLDING-DEVICE-2>))))

(control-rule tap4
  (if (and (current-goal (has-hole <part> <hole> <side> <hole-depth>
				   <hole-diameter> <loc-x> <loc-y>))
	   (holding-tool <drill> <spot-drill>)
	   (type-of-object <drill> DRILL)
	   (type-of-object <spot-drill> SPOT-DRILL)
	   (has-device <drill> <hd>)
	   (is-clean <part>)
	   (forall-metapred
	    (type-of-object-gen <mm> MILLING-MACHINE)
	    (holding-tool <mm> <some-tool>))
	   (forall-metapred
	    (type-of-object-gen <sd> SPOT-DRILL)
	    (holding-tool <some-machine> <sd>))
	   ;with is-tapped works but it is too specific
	   (pending-goal
;	    (is-tapped <part> <hole> <side> <h-depth> <h-diameter> <x> <y>)
	    (holding <drill> <some-hd> <part> <side> <sp>))))
  (then prefer operator drill-with-twist-drill
	drill-with-twist-drill-in-milling-machine)) 

   