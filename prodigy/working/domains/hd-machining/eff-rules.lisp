;prefer to do all operations in same part consecutively

(control-rule Q1
  (if (and (goal-first-arg <goal> <part>)
	   (type-of-object <part> PART)
	   ;;part it was working on
	   (last-achieved-goal <prev-goal>)
	   (goal-first-arg <prev-goal> <prev-part>)
	   (type-of-object <prev-part> PART)
	   (diff <part> <prev-part>)
	   ;;other alternative, on previous goal
	   (candidate-goal <other-goal>)
	   (goal-first-arg <other-goal> <prev-part>)))
  (then prefer goal <other-goal> <goal>))


;;; ***************************************************************
;;; Expand the machining goals first. By this I mean the goals not
;;; related to set-ups. Ex Size-of, surface-finish, etc.

;;; set-up goals (from machining op preconds) are:
;;;   holding, holding-weakly, holding-tool,
;;;   has-fluid, hardness-of, (~(has-burrs)), is-clean, on-table.
;;;
;;; set-up goals (from set-up op preconds) are:
;;;   for holding-tool: is-available-tool, is-available-tool-holder
;;;   for has-device: is-available-table, is-available-holding-device
;;;   for on-table: is-available-machine, is-available-part
;;;   for has-center-holes: has-center-hole, is-countersinked

;;; what about: shape-of

;;Warning! This rule does not include surface-finish-side because
;;then, if surface-finish-side is a candidate goal, and size-of has
;;been expanded, SURFACE-SIDE-EFFECT would fire. IF that happens after
;;EXPAND-MAIN-GOALS-FIRST fires, all the goals would be rejected
;;(I don't want to depend on the order the control rules are given)

(control-rule EXPAND-MAIN-GOALS-FIRST
  (if (and (candidate-goal <goal>)
	   (goal-instance-of <goal>
             size-of shape-of has-hole has-spot is-tapped is-countersinked
	     is-counterbored is-reamed
	     ;surface-finish-side
	     surface-finish-quality-side
	     surface-coating-side surface-coating)	     
	   (candidate-goal <other-goal>)
	   (~ (goal-instance-of <other-goal>
             size-of shape-of has-hole has-spot is-tapped is-countersinked
	     is-counterbored is-reamed
	     ;surface-finish-side
	     surface-finish-quality-side
	     surface-coating-side surface-coating))))
  (then reject goal <other-goal>))



;;this complements rule SIZE-BEFORE-SURFACE

(control-rule SURFACE-SIDE-EFFECT
  (if (and (candidate-goal (surface-finish-side <part> <side> <sf>))
	   (expanded-goal (size-of <part> <dim> <value>))
	   ;;this links <side> and <dim>
	   (known (side-up-for-machining <dim> <side>))))
  (then reject goal (surface-finish-side <part> <side> <sf>)))

;;; *****************************************************************

(load "/afs/cs/project/prodigy-aperez/domains4.0/hd-machining/switch-goal-rules-prefer.lisp")


;;; ***************************************************************
;;; prefer milling-machine for drilling

;; april 30
;;note that if we use (pending-goal (holding ...)) the rule is over specific
;;as it won't fire when has-spot is the first goal that we expand, and
;;size-of is a pending goal not expanded yet. But if we learn it from
;;an example, such as simple3, where holding is pending already, we
;;may learn the over specific rule

;;What if there are more than milling-machine ops to reduce the part
;;size? Testing size-of may not be enough (if milling-machine ops may
;;fail), and also milling-mach ops should be selected for size-of goal
;;in addition to what this rule does

(control-rule PREFER-MILL-FOR-HOLE
  (if (and (current-goal
	    (has-hole <part> <hole> <side> <depth> <diam> <x> <y>))
	   ;;april 30 replace this by (pending-goal (holding...))
	   (pending-goal (size-of <part> <dim> <value>))
;	   (pending-goal (holding <m> <hd> <part> <side> <sp>))
;	   (type-of-object <m> MILLING-MACHINE)
	   ))
  (then prefer operator DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE
	                <other-op>))

(control-rule PREFER-MILL-FOR-SPOT-HOLE
  (if (and (current-goal (has-spot <part> <hole> <side> <x> <y>))
	   ;;april 30 replace this by (pending-goal (holding...))
	   (pending-goal (size-of <part> <dim> <value>))
;	   (pending-goal (holding <m> <hd> <part> <side> <sp>))
;	   (type-of-object <m> MILLING-MACHINE)
	   ))
  (then prefer operator DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE
	                <other-op>))

;;; ***************************************************************
;;; But if hole has to be counterbored, countersinked, tapped, or
;;; reamed as well, those can only be done in drill. Use drill to make
;;; hole as well 

;;This should be extended as it doesn't really matter if it is the
;;same hole and size, but just the fact that there is some op that has
;;to be performed in the drill. Then the drill op can be done in the
;;drill (and may take advantage of the tool set-up) or in the milling
;;machine). Should we prefer one or the other?

(control-rule DRILL-FOR-COUNTERBORED-OR-TAPPED-HOLE
 (if (and (current-goal
	   (has-hole <part> <hole> <side> <depth> <diam> <x> <y>))
	  (or-metapred
	   (pending-goal
	    (is-tapped <part> <hole> <side> <depth> <diam> <x> <y>))
	   (pending-goal
	    (is-counterbored
	     <part> <hole> <side> <depth> <diam> <x> <y> <cs>))
	   (pending-goal
	    (is-countersinked
	     <part> <hole> <side> <depth> <diam> <x> <y> <ang>))
	   (pending-goal
	    (is-reamed <part> <hole> <side> <depth> <diam> <x> <y>)))))
 (then reject operator DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE))

(control-rule DRILL-SPOT-FOR-COUNTERBORED-OR-TAPPED-HOLE
 (if (and (current-goal (has-spot <part> <hole> <side> <x> <y>))
	  (or-metapred
	   (pending-goal
	    (is-tapped <part> <hole> <side> <depth> <diam> <x> <y>))
	   (pending-goal
	    (is-counterbored
	     <part> <hole> <side> <depth> <diam> <x> <y> <cs>))
	   (pending-goal
	    (is-countersinked
	     <part> <hole> <side> <depth> <diam> <x> <y> <ang>))
	   (pending-goal
	    (is-reamed <part> <hole> <side> <depth> <diam> <x> <y>)))))
 (then reject operator DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE))

;;; ***************************************************************
#|
This is solved better with the prefer rule below
;;; If other ops (counterbore, etc) need to be done in hole, and
;;; has-hole has already been expanded, focus first on achieving
;;; has-hole, which corresponds to the first precond of those ops, and
;;; then on holding the tool for that op. This is to avoid setting the
;;; tool for counterbore, etc and then changing it to drill. 

;;; <op> is an instantiation of TAP, COUNTERBORE, COUNTERSINK, REAM.

(control-rule MAKE-HOLE-BEFORE-SET-UP-FOR-FINISH-HOLE
  (if (and (candidate-goal (holding-tool <mach> <tool>))
	   ;;the next is not needed but it reduces the number of times
	   ;;the rest of the metapreds are matched
           (or (type-of-object <tool> COUNTERSINK)
               (type-of-object <tool> COUNTERBORE)
               (type-of-object <tool> TAP)
               (type-of-object <tool> REAMER))
	   (pending-goal
	    (has-hole <part> <hole> <side> <depth> <diam> <x> <y>))
	   (is-subgoal-of-p
	    (has-hole <part> <hole> <side> <depth> <diam> <x> <y>)
	    <op>)
	   (is-subgoal-of-p (holding-tool <mach> <tool>) <op>)))
  (then reject goal (holding-tool <mach> <tool>)))
|#

(control-rule EXPAND-FINISH-HOLE-FIRST
  (if (and (candidate-goal
	    (has-hole <part> <hole> <side> <depth> <diam> <x> <y>))
	   (candidate-goal <g>)
	   (goal-instance-of <g>
            is-tapped is-countersinked is-counterbored is-reamed)))
  (then prefer goal
	<g> (has-hole <part> <hole> <side> <depth> <diam> <x> <y>)))


;;; ***************************************************************
;;; rules to take advantage of the set-ups by doing a face-mill and
;;; side-mill with the same setup

;;; holes have only one possible setup: side where hole has to be made
;;;prefer that side up
;;Note that this only fires if has-hole is a pending goal (but not if
;;it is for ex is-tapped and we have not expanded it yet into has-hole)

(control-rule PREFER-SIDE-FOR-FACE-MILL
 (if (and (current-goal (size-of <p> <d> <val>))
	  (current-operator FACE-MILL)
	  (pending-goal
	   (has-hole <p> <hole> <sd> <depth> <diam> <x> <y>))
	  (side-up-for-machining <d> <sd>)))
 (then prefer bindings
       ((<machine> . <m>)(<milling-cutter> . <mc>)(<part> . <p>)
	(<dim> . <d>)(<side> . <sd>)(<value-old> . <vo>)
	(<value> . <val>))
       ((<machine> . <m>)(<milling-cutter> . <mc>)(<part> . <p>)
	(<dim> . <d>)(<side> . <other-sd>)(<value-old> . <vo>)
	(<value> . <val>))))


;;Are the last two preconditions useless?: what they capture is in the
;;static part of side-mill. If I don't put them here, it will prefer
;;side-mill which then may fail. If I put them here, I make sure that
;;there are bindings for side-mill, but is this only for ps efficiency?

;;The difference is that if I put them, side-mill is preferred over
;;face-mill whenever face-mill has already been expanded, even if the
;;bindings require a different setup. If they are in the rule, when
;;the setup is different face-mill is used (the default because of the
;;op ordering)

(control-rule PREFER-SIDE-MILL-OTHER-DIM
  (if (and (current-goal (size-of <p> <d> <val>))
	   ;;april 29 replace this by (pending-goal (holding...))
;	   (expanded-operator
;	    (face-mill <m> <mc> <hd> <p> <dim> <sd> <sp> <vo> <v> <sc> <sf>))
	   (pending-goal (holding <m> <hd> <p> <sd> <sp>))
	   (type-of-object <m> MILLING-MACHINE)
	   ;;next two capture conditions for the allowed bindings of side-mill
	   (known (side-for-side-mill <d> <sd> <mach-s>))
	   (not-in-side-pair <mach-s> <sp>)
	   ))
  (then prefer operator SIDE-MILL <op>))


;;this rule may not work if we have already chosen for face-mill a
;;<sd-up> <side-pair> combination incompatible with the <mach-side>
;;needed to side-mill the part in <this-dim>

;;add also drilling ops in milling machine
(control-rule PREFER-SIDE-FOR-SIDE-MILL
  (if (and (current-goal (size-of <p> <this-dim> <val>))
	   (current-operator SIDE-MILL)
	   ;;april 29 replace this by (pending-goal (holding...))
;	   (expanded-operator
;	    (face-mill <m> <mc> <hd> <p> <face-dim> <sd-up> <sp>
;		       <fvo> <fv> <sc> <sf>))
	   (pending-goal (holding <m> <hd> <p> <sd-up> <sp>))
	   ;;removed april 29. As these are in the operator,
	   ;;if they are false, the bindings are not candidate.
;	   (known (side-for-side-mill <this-dim> <sd-up> <mach-s>))
;	   (not-in-side-pair <mach-s> <sp>)
	   ))
  (then prefer bindings 
	((<machine> . <m>)(<milling-cutter> . <mc>)(<part> . <p>)
	 (<dim> . <this-dim>)(<side> . <sd-up>)(<mach-sd> . <mach-s>)
	 (<side-pair> . <sp>)(<value-old> . <vo>)(<value> . <val>))
	((<machine> . <m>)(<milling-cutter> . <mc>)(<part> . <p>)
	 (<dim> . <this-dim>)(<side> . <other-side>)(<mach-sd> . <other-m-sd>)
	 (<side-pair> . <other-sp>)(<value-old> . <vo>)(<value> . <val>))))


;;; ************************************************************
;;; From here on rules written for the hd-machining version.


;;it doesn't work because holding is not true when we choose the
;;bindings for drill-with-twist-drill
#|
(control-rule sides-to-hd
  (if (and (current-goal-first-arg <part>)
	   (current-ops (DRILL-WITH-TWIST-DRILL DRILL-WITH-SPOT-DRILL))
	   (known (holding <m> <p> <s-hd1> <s-hd2>))))
  (then prefer bindings
	((<side-hd1> . <s-hd1>)(<side-hd2> . <s-hd2>))
	((<side-hd1> . <other1>)(<side-hd2> . <other2>))	))
|#

;;could add here ream, countersink. And similar
;;rules for each of the machines (as the hd set-up is for a given
;;machine). For face-mill and side-mill it maybe a prefer rule, as
;;there are several ways to hold the part.

;;if the holes are on different sides it does not matter that the
;;side-pair is the same

;;april 29
;;replaced in next two rules (or-metapred (expanded-operator ...) with
;;(pending-goal (holding <m> ...)) 
;;I may need to specify in addition (type-of <m> DRILL) or
;;(type-of <m> DRILL) respectively but if that is not true, the
;;bindings selected would not work because of the current-ops 

;;We may have to specify bindings for hd as well (but in examples so
;;far there is only one)

(control-rule SIDES-TO-HD-FOR-DRILL
  (if (and ;(current-goal-first-arg <part>)
           (or-metapred
	    (current-goal
	     (has-hole <part> <gh> <su> <gd> <gdiam> <gx> <gy>))
	    (current-goal
	     (has-spot <part> <gh> <su> <gx> <gy>))
	    (current-goal
	     (is-tapped <part> <gh> <su> <gd> <gdiam> <gx> <gy>))
	    (current-goal
	     (is-counterbored <part> <gh> <su> <gd> <gdiam> <gx> <gy> <gc>)))
	   (current-ops (DRILL-WITH-TWIST-DRILL
			 DRILL-WITH-HIGH-HELIX-DRILL
			 DRILL-WITH-SPOT-DRILL
			 TAP COUNTERBORE COUNTERSINK REAM))
	   ;;april 29 replace this by (pending-goal (holding...))
;	   (or-metapred
;            (expanded-operator
;             (drill-with-spot-drill
;              <m> <sdb> <hd> <part> <su> <sp> <h> <x> <y>))
;            (expanded-operator
;             (drill-with-twist-drill
;              <m> <tdb> <hd> <h> <dbd> <hld> <su> <sp> <part> <x> <y>
;              <hdp>)) 
;            (expanded-operator
;             (drill-with-twist-drill
;              <m> <hdb> <hd> <f> <part> <su> <sp> <h> <x> <y> <hld> <hdp>)) 
;            (expanded-operator
;             (tap
;              <m> <t> <hd> <p> <h> <su> <sp> <hdp> <dbd> <hld>
;              <x> <y>))
;            (expanded-operator
;             (counterbore
;              <m> <t> <hd> <p> <h> <su> <sp> <cs> <hdp> <hld>
;              <x> <y>)))
	   (pending-goal (holding <m> <hd> <p> <su> <sp>))
	   ))
  (then select bindings
	((<machine> . <m>)(<side-pair> . <sp>))))

(control-rule SIDES-TO-HD-FOR-DRILL-IN-MILLING-MACHINE
  (if (and (or-metapred
	    (current-goal
	     (has-hole <part> <gh> <su> <gd> <gdiam> <gx> <gy>))
	    (current-goal
	     (has-spot <part> <gh> <su> <gx> <gy>)))
	   (current-ops (DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE
			 DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE))
	   ;;april 29 replace this by (pending-goal (holding...))
;           (or-metapred
;            (expanded-operator
;             (drill-with-spot-drill-in-milling-machine
;              <m> <sdb> <hd> <part> <su> <sp> <x> <y> <h>))
;            (expanded-operator
;             (drill-with-twist-drill-in-milling-machine
;              <m> <tdb> <hd> <part> <su> <sp> <h> <dbd> <hld> <part>
;              <x> <y> <hdp>))
;            (expanded-operator
;             (side-mill
;              <m> <p> <mc> <hd> <dim> <su> <sp> <ms> <vo> <v> <sc> <sf>))
;            (expanded-operator
;             (face-mill
;              <m> <mc> <hd> <p> <dim> <su> <sp> <vo> <v> <sc> <sf>)))
	   (pending-goal (holding <m> <hd> <p> <su> <sp>))
	   ))
  (then select bindings
	((<machine> . <m>)(<side-pair> . <sp>))))

#|replaced by PREFER-SIDE-FOR-SIDE-MILL
;;add also drilling ops in milling machine
(control-rule SIDES-TO-HD-FOR-MILLING-MACHINE
  (if (and (current-goal (size-of <p> <d> <v>))
	   (current-operator SIDE-MILL)
	   (expanded-operator
	    (face-mill <m> <mc> <hd> <p> <face-d> <s-up> <sd1> <sd2>
		       <vold> <vnew>))
	   (known (side-for-side-mill <d> <s-up> <mach-s>))))
  (then select bindings
	((<machine> . <m>)(<milling-cutter> . <mc>)
	 (<holding-device> . <hd>)(<side> . <s-up>)
	 (<side-hd1> . <sd1>)(<side-hd2> . <sd2>)
	 (<mach-side> . <mach-s>))))
|#


;;; ************************************************************
;;; Rules to prefer one of the available parts such that the cost of
;;; the plan is reduced (this makes sense when the goal is an
;;; existencial expression such as
;;;    (goal ((<part> PART))
;;;        (and  (material-of <part> ALUMINUM)
;;;              (size-of <part> LENGTH 4)
;;;              (size-of <part> WIDTH 3)
;;;              (size-of <part> HEIGHT 0.5)))
;;; The bindings for <part> are chosen when the operator *finish* is
;;; instantiated.

;;; generate-bindings computes the conspiracy-number and orders the
;;; bindings so the part matching more goals (the instantiations of
;;; finish with more matched preconds) is preferred, if no other
;;; control knowledge is available.

(load "/afs/cs/project/prodigy-aperez/domains4.0/hd-machining/sel-part-metapreds")

;;Can't use candidate-bindings with select/reject rules.
;;If I specify the var name in the rule, I have to make sure that the
;;goal uses that same var name. *finish* is funny because the var
;;names in the operator depend on the particular problem (from its
;;goal definition) instead of the domain definition.

(control-rule CHOOSE-PART
  (if (and (current-goal (p4::done))
	   (current-operator p4::*finish*)
	   (candidate-bindings ((<part> . <p1>)))
	   (diff <p1> <p2>)
	   ;;<p> is bound to a symbol (not to an object)
	   (est-binding-cost <p1> <c1>)
	   (est-binding-cost <p2> <c2>)
	   (< <c1> <c2>)))
  (then prefer bindings	((<part> . <p1>))((<part> . <p2>))))



;;; ************************************************************
;;; if there are holes to be made on one side, prefer size-of goal that
;;; puts that dimension up.

(control-rule PREFER-DIM
  (if (and (candidate-goal (size-of <part> <dim> <val>))
	   (or-metapred
	    (pending-goal
	     (has-hole <part> <hole> <sd> <depth> <diam> <x> <y>))
	    (pending-goal
	     (has-spot <part> <hole> <sd> <x> <y>))	    
	    (pending-goal
	     (is-tapped <part> <hole> <sd> <depth> <diam> <x> <y>))
	    (pending-goal
	     (is-counterbored
	      <part> <hole> <sd> <depth> <diam> <x> <y> <c>))
	    (pending-goal
	     (is-countersinked
	      <part> <hole> <sd> <depth> <diam> <x> <y> <angle>))
	    (pending-goal
	     (is-reamed <part> <hole> <sd> <depth> <diam> <x> <y>)))	    
	   (side-up-for-machining <dim> <sd>)))
  (then prefer goal (size-of <part> <dim> <val>)
	<other-goal>))


;; prefer a side-pair for face-mill that is compatible with further
;; side-mill ops.
;;this rule may interact with PREFER-SIDE-FOR-FACE-MILL. Also it may
;;give pref cycles when more than one pending size-of match.

(control-rule PREFER-SIDE-PAIR-FOR-FACE-MILL
  (if (and (current-goal (size-of <p> <d> <val>))
	   (current-operator FACE-MILL)
	   (pending-goal (size-of <p> <other-d> <other-val>))
	   (diff <d> <other-d>)
	   (side-up-for-machining <d> <side-up>)
	   (sides-for-holding-device <side-up> <sp>)
	   (diff <sp> <other-sp>)
	   (side-for-side-mill <other-d> <side-up> <machined-side>)
	   (not-in-side-pair <machined-side> <sp>)))
  (then prefer bindings
	((<side> . <side-up>)(<side-pair> . <sp>))
	((<side> . <side-up>)(<side-pair> . <other-sp>))))
	

;;; ******************************************************************
;;; To take advantage of the setup in the initial state.
;;; I don't add (known (holding ...)) because the conspiracy number
;;; takes care of that case.

;;candidate-bindings needs bindings for all the op vars

(control-rule USE-INITIAL-SETUP-FOR-SIZE
  (if (and (current-goal (size-of <p> <d> <v>))
	   (current-ops (FACE-MILL SIDE-MILL))
	   (or-metapred
	    (known (has-device <milling-machine> <hd>))
	    (known (on-table <milling-machine> <part>)))
           (diff <milling-machine> <other-mm>)	   
	   ))
  (then prefer bindings
	((<machine> . <milling-machine>)(<holding-device> . <hd>))
	((<machine> . <other-mm>)(<holding-device> . <some-hd>))))

(control-rule USE-INITIAL-SETUP-FOR-HOLES
  (if (and (or-metapred
	    (current-goal
	     (has-hole <part> <gh> <su> <gd> <gdiam> <gx> <gy>))
	    (current-goal
	     (has-spot <part> <gh> <su> <gx> <gy>))
	    (current-goal
	     (is-tapped <part> <gh> <su> <gd> <gdiam> <gx> <gy>))
	    (current-goal
	     (is-counterbored <part> <gh> <su> <gd> <gdiam> <gx> <gy> <gc>)))
	   (current-ops (DRILL-WITH-TWIST-DRILL
			 DRILL-WITH-HIGH-HELIX-DRILL
			 DRILL-WITH-SPOT-DRILL
			 DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE
			 DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE
			 TAP COUNTERBORE COUNTERSINK REAM))
	   (or-metapred
	    (known (has-device <mach> <hd>))
	    (known (on-table <mach> <part>)))
           (diff <mach> <other-mach>)	   
	   ))
  (then prefer bindings
	((<machine> . <mach>)(<holding-device> . <hd>))
	((<machine> . <other-mach>)(<holding-device> . <some-hd>))))

