(load "/afs/cs/project/prodigy-aperez/codep4/my-meta-predicates")
(load "/afs/cs/project/prodigy-aperez/codep4/more-my-meta-predicates")
(load "/afs/cs/project/prodigy-aperez/codep4/pref-rule-meta-predicates")

;;I think the following rules could be learned by Dynamic

;;; ***************************************************************


;;Vises hold cylindrical parts weakly only. Then we need another
;;device (toe clamp) to hold them so the machining op can be done.
;;Therefore if the goal is holding we can't use a vise when the part
;;is cylindrical.

(control-rule AVOID-VISE-FOR-CYLINDRICAL-PARTS
  (if (and (current-goal-first-arg <part>)
	   ;;check if the part is cylindrical
	   (known (size-of <part> DIAMETER <d>))
	   ;;all ops that may use vises
	   (current-ops (DRILL-WITH-SPOT-DRILL
			 DRILL-WITH-TWIST-DRILL
                         DRILL-WITH-HIGH-HELIX-DRILL
;                         DRILL-WITH-STRAIGHT-FLUTED-DRILL
;                         DRILL-WITH-OIL-HOLE-DRILL
;                         DRILL-WITH-GUN-DRILL
;                         DRILL-WITH-CENTER-DRILL
                          TAP COUNTERSINK COUNTERBORE REAM
;                         ROUGH-SHAPE FINISH-SHAPE
			 SIDE-MILL FACE-MILL
			 DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE
			 DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE
;                         ROUGH-GRIND-WITH-HARD-WHEEL
;                         ROUGH-GRIND-WITH-SOFT-WHEEL
;                         FINISH-GRIND-WITH-HARD-WHEEL
;                         FINISH-GRIND-WITH-SOFT-WHEEL
;                         CUT-WITH-CIRCULAR-COLD-SAW                      
;                         CUT-WITH-CIRCULAR-FRICTION-SAW
			 ))
	   (type-of-object-gen <vise> VISE)))
  (then reject bindings ((<holding-device> . <vise>))))
#| no collet-chuck in this version of domain
(control-rule AVOID-COLLET-CHUCK-FOR-RECTANGULAR-PARTS
  (if (and (current-goal-first-arg <part>)
	   ;;check if the part is rectangular
	   (known (size-of <part> HEIGHT <h>))
	   ;;all ops that may use collet-chucks on rectangular parts
	   (current-ops (SIDE-MILL FACE-MILL
			 DRILL-WITH-SPOT-DRILL-IN-MILLING-MACHINE
			 DRILL-WITH-TWIST-DRILL-IN-MILLING-MACHINE
;			 METAL-SPRAY-PREPARE METAL-SPRAY-COATING
			 ))
	   (type-of-object-gen <collet-chuck> COLLET-CHUCK)))
  (then reject bindings ((<holding-device> . <collet-chuck>))))
|#

;;;***************************************************************


;;if the part is ~holding == is-available we don't use 
;;RELEASE-FROM-HOLDING-DEVICE but PUT-ON-MACHINE-TABLE
;;We have to test here either ~(holding ) or is-available. The latter
;;is only added when the corresponding inference rule fires.

;;I tested adding the next two rules instead of the third one on April
;;15 1993 with inference rule part-available marked as eager. But that
;;is more  expensive (as the forall in the inference rule
;;precondition is tested at each state change if we mark the rule as
;;eager)

#|
;;(this was the first reason for having the more expensive rule:
;;I think it is cheaper to mark the rule as eager and test here for
;;is-available, but the inference rule gives an error
;;)
(control-rule PUT-ON-MACHINE-TABLE-IF-NOT-HOLDING
  (if (and (current-goal (on-table <machine> <part>))
	   (known (is-available-part <part>))))
  (then select operator PUT-ON-MACHINE-TABLE))

(control-rule PUT-ON-SHAPER-TABLE-IF-NOT-HOLDING
  (if (and (current-goal (on-table <machine> <part>))
	   (type-of-object <machine> SHAPER)
	   (known (is-available-part <part>))))
  (then select operator PUT-ON-SHAPER-TABLE))
|#

(control-rule PUT-ON-MACHINE-TABLE-IF-NOT-HOLDING
  (if (and (current-goal (on-table <machine> <part>))
	   (~ (type-of-object <machine> SHAPER))
;	   (known (~ (holding <machine> <holding-device> <part> <s> <s1> <s2>)))
	   ;;the meaning of this is "forall". I don't want to generate
	   ;;bindings 
	   (false-in-state-forall-values
	    (holding <machine> <holding-device> <part> <s> <sp>)
	    (<holding-device> HOLDING-DEVICE)
	    (<s> SIDE) (<sp> SIDE-PAIR))
;	   (~(known (holding-weakly <machine> <holding-device> <part> <side>)))
	   (false-in-state-forall-values
	    (holding-weakly <machine> <holding-device> <part> <s> <sp>)
	    (<holding-device> HOLDING-DEVICE)
	    (<s> SIDE) (<sp> SIDE-PAIR))))
  (then select operator PUT-ON-MACHINE-TABLE))

#|this could be faster than previous rule. Check it
(control-rule PUT-ON-MACHINE-TABLE-IF-NOT-HOLDING
  (if (and (current-goal (on-table <machine> <part>))
	   (~ (type-of-object <machine> SHAPER))
	   ;;the meaning of this is "forall". I don't want to generate
	   ;;bindings
	   (number-of-matches 0
	     (known '(holding <machine> <holding-device> <part> <s> <sp>)))
	   ;(number-of-matches 0
           ;  (known (holding-weakly <machine> <holding-device> <part> <s> <s1> <s2>)))
	   ))
  (then select operator PUT-ON-MACHINE-TABLE))
|#

(control-rule PUT-ON-MACHINE-TABLE-IF-HOLDING
  (if (and (current-goal (on-table <machine> <part>))
	   (or-metapred
	    (known
	     (holding
	      <machine> <holding-device> <part> <s> <s1> <s2>))
	    (known
	     (holding-weakly
	      <machine> <holding-device> <part> <s> <s1> <s2>))))) 
  (then reject operator PUT-ON-MACHINE-TABLE))


(control-rule REMOVE-FROM-TABLE
  (if (and (current-goal (~ (on-table <machine> <part>)))
	   (not-candidate-goal (on-table <other-machine> <part>))))
  (then select operator REMOVE-FROM-MACHINE-TABLE))

;;;***************************************************************
#| no toe-clamps in this version of domain
;don't make the shape of the part rectangular in order to hold it with
;vise or toe-clamp
(control-rule DONT-MAKE-RECTANGULAR-TO-HOLD-WITH-TOE-CLAP
  (if (and (current-goal
	    (holding <machine> <holding-device> <part> <s> <s1> <s2>))
	  ;;this is to ask if the part is cylindrical 
	  (known (size-of <part> DIAMETER <diameter>))))
  (then reject operator HOLD-WITH-TOE-CLAMP2))
|#
;this may replace the first rule of this file
(control-rule DONT-MAKE-RECTANGULAR-TO-HOLD-WITH-VISE
  (if (and (current-goal
	    (holding <machine> <holding-device> <part> <s> <sp>))
	  ;;this is to ask if the part is cylindrical 
	  (known (size-of <part> DIAMETER <diameter>))))
  (then reject operator HOLD-WITH-VISE))

;;;***************************************************************
;;; rules for choosing the fluids. I think this kind of rules could be
;;; derived from the domain specification (by looking at the preconds
;;; of the add-fluid operators)

#| Changed these rules into reject rules
;;; Note that only one bindings select can fire at a particular choice
;;; point. Therefore I cannot put other select bindings rules for this
;;; ops. 
(control-rule USE-MINERAL-OIL
  (if (and (current-goal-first-arg <part>)
           (current-ops (;DRILL-WITH-OIL-HOLE-DRILL
                         DRILL-WITH-HIGH-HELIX-DRILL
                         ;DRILL-WITH-GUN-DRILL
			 REAM
                         ;ROUGH-GRIND-WITH-HARD-WHEEL
                         ;ROUGH-GRIND-WITH-SOFT-WHEEL
                         ;FINISH-GRIND-WITH-HARD-WHEEL
                         ;FINISH-GRIND-WITH-SOFT-WHEEL
                         ;CUT-WITH-CIRCULAR-FRICTION-SAW
			 ))
	   (known (material-of <part> IRON))
	   (type-of-object-gen <fluid> mineral-oil)))
  (then select bindings ((<fluid> . <fluid>))))

(control-rule USE-SOLUBLE-OIL
  (if (and (current-goal-first-arg <part>)
           (current-ops (;DRILL-WITH-OIL-HOLE-DRILL
                         DRILL-WITH-HIGH-HELIX-DRILL
                         ;DRILL-WITH-GUN-DRILL
			 REAM
                         ;ROUGH-GRIND-WITH-HARD-WHEEL
                         ;ROUGH-GRIND-WITH-SOFT-WHEEL
                         ;FINISH-GRIND-WITH-HARD-WHEEL
                         ;FINISH-GRIND-WITH-SOFT-WHEEL
                         ;CUT-WITH-CIRCULAR-FRICTION-SAW
			 ))
	   (or (known (material-of <part> STEEL))
	       (known (material-of <part> ALUMINUM)))
	   (type-of-object-gen <f> soluble-oil)))
  (then select bindings ((<fluid> . <f>))))

;;I think this rule is useless (all fluids are cutting fluids)
(control-rule USE-ANY-OIL
  (if (and (current-goal-first-arg <part>)
           (current-ops (;DRILL-WITH-OIL-HOLE-DRILL
                         DRILL-WITH-HIGH-HELIX-DRILL
                         ;DRILL-WITH-GUN-DRILL
			 REAM
                         ;ROUGH-GRIND-WITH-HARD-WHEEL
                         ;ROUGH-GRIND-WITH-SOFT-WHEEL
                         ;FINISH-GRIND-WITH-HARD-WHEEL
                         ;FINISH-GRIND-WITH-SOFT-WHEEL
                         ;CUT-WITH-CIRCULAR-FRICTION-SAW
			 ))
	   (or (known (material-of <part> BRASS))
	       (known (material-of <part> BRONZE))
	       (known (material-of <part> COPPER)))
	   (type-of-object-gen <fluid> cutting-fluid)))
  (then select bindings ((<fluid> . <fluid>))))
|#

(control-rule USE-MINERAL-OIL
  (if (and (current-goal-first-arg <part>)
           (current-ops (;DRILL-WITH-OIL-HOLE-DRILL
                         DRILL-WITH-HIGH-HELIX-DRILL
                         ;DRILL-WITH-GUN-DRILL
			 REAM
                         ;ROUGH-GRIND-WITH-HARD-WHEEL
                         ;ROUGH-GRIND-WITH-SOFT-WHEEL
                         ;FINISH-GRIND-WITH-HARD-WHEEL
                         ;FINISH-GRIND-WITH-SOFT-WHEEL
                         ;CUT-WITH-CIRCULAR-FRICTION-SAW
			 ))
	   (known (material-of <part> IRON))
	   (type-of-object-gen <fluid> soluble-oil)))
  (then reject bindings ((<fluid> . <fluid>))))

(control-rule USE-SOLUBLE-OIL
  (if (and (current-goal-first-arg <part>)
           (current-ops (;DRILL-WITH-OIL-HOLE-DRILL
                         DRILL-WITH-HIGH-HELIX-DRILL
                         ;DRILL-WITH-GUN-DRILL
			 REAM
                         ;ROUGH-GRIND-WITH-HARD-WHEEL
                         ;ROUGH-GRIND-WITH-SOFT-WHEEL
                         ;FINISH-GRIND-WITH-HARD-WHEEL
                         ;FINISH-GRIND-WITH-SOFT-WHEEL
                         ;CUT-WITH-CIRCULAR-FRICTION-SAW
			 ))
	   (or (known (material-of <part> STEEL))
	       (known (material-of <part> ALUMINUM)))
	   (type-of-object-gen <f> mineral-oil)))
  (then reject bindings ((<fluid> . <f>))))


;;;***************************************************************
;;; Rules for choosing operators to add the fluids

(control-rule ADD-OIL-ANY
  (if (and (current-goal (has-fluid <mach> <fluid> <part>))
	   (known (material-of <part> <mat>))
	   (one-of-metapred <mat> (BRASS BRONZE COPPER))))
  (then select operator ADD-ANY-CUTTING-FLUID))
			 
;;;***************************************************************
#|no grinding in this version of the domain
;;soft wheel for hard materials
(control-rule SOFT-WHEEL-FOR-FINISH-GRIND
  (if (and (or-metapred
	    (current-goal (surface-finish-side <part> <side> FINISH-GRIND))
	    (current-goal (size-of <part> <dim> <size>)))
	   (or (known (material-of <part> STEEL))
	       (known (material-of <part> IRON)))))
  (then reject operator FINISH-GRIND-WITH-HARD-WHEEL))

;;hard wheel for soft materials
(control-rule HARD-WHEEL-FOR-FINISH-GRIND
  (if (and (or-metapred
	    (current-goal (surface-finish-side <part> <side> FINISH-GRIND))
	    (current-goal (size-of <part> <dim> <size>)))
	   (or (known (material-of <part> BRASS))
	       (known (material-of <part> COPPER))
	       (known (material-of <part> BRONZE))
	       (known (material-of <part> ALUMINUM)))))
  (then reject operator FINISH-GRIND-WITH-SOFT-WHEEL))

;;soft wheel for hard materials
(control-rule SOFT-WHEEL-FOR-ROUGH-GRIND
  (if (and (or-metapred
	    (current-goal (surface-finish-side <part> <side> ROUGH-GRIND))
	    (current-goal (size-of <part> <dim> <size>)))
	   (or (known (material-of <part> STEEL))
	       (known (material-of <part> IRON)))))
  (then reject operator ROUGH-GRIND-WITH-HARD-WHEEL))

;;hard wheel for soft materials
(control-rule HARD-WHEEL-FOR-ROUGH-GRIND
  (if (and (or-metapred
	    (current-goal (surface-finish-side <part> <side> ROUGH-GRIND))
	    (current-goal (size-of <part> <dim> <size>)))
	   (or (known (material-of <part> BRASS))
	       (known (material-of <part> COPPER))
	       (known (material-of <part> BRONZE))
	       (known (material-of <part> ALUMINUM)))))
  (then reject operator ROUGH-GRIND-WITH-SOFT-WHEEL))
|#
;;;***************************************************************

(control-rule SURFACE-FINISH-CYLINDRICAL
  (if (and (current-goal (surface-finish-side <part> <side> <surface-finish>))
	   (candidate-operator HAVE-SURFACE-FINISH-CYLINDRICAL-PART-SIDES)))
  (then reject operator HAVE-SURFACE-FINISH-CYLINDRICAL-PART-SIDES))

(control-rule SURFACE-FINISH-RECTANGULAR
  (if (and (current-goal (surface-finish-side <part> <side> <surface-finish>))
	   (candidate-operator HAVE-SURFACE-FINISH-RECTANGULAR-PART-SIDES)))
  (then reject operator HAVE-SURFACE-FINISH-RECTANGULAR-PART-SIDES))

#|
(control-rule SURFACE-FINISH-RECTANGULAR
  (if (and (current-goal (surface-finish-side <part> <side> <surface-finish>))
	   (candidate-operator HAVE-SURFACE-FINISH-RECTANGULAR-PART-SIDES)
	   (candidate-operator <op>)))
  (then prefer operator <op> HAVE-SURFACE-FINISH-RECTANGULAR-PART-SIDES))
|#

(control-rule SURFACE-COATING-SIDE-CYLINDRICAL
  (if (and (current-goal (surface-coating-side <part> <side> <surface-coating>))
	   (candidate-operator HAVE-SURFACE-COATING-CYLINDRICAL-PART-SIDES)))
  (then reject operator HAVE-SURFACE-COATING-CYLINDRICAL-PART-SIDES))

(control-rule SURFACE-COATING-SIDE-RECTANGULAR
  (if (and (current-goal (surface-coating-side <part> <side> <surface-coating>))
	   (candidate-operator HAVE-SURFACE-COATING-RECTANGULAR-PART-SIDES)))
  (then reject operator HAVE-SURFACE-COATING-RECTANGULAR-PART-SIDES))

(control-rule SURFACE-COATING-CYLINDRICAL
  (if (and (current-goal (surface-coating <part> <surface-coating>))
	   ;;check if the part is cylindrical
	   (known (size-of <part> DIAMETER <diameter>))))
;	   (candidate-operator HAS-SURFACE-COATING-CYLINDRICAL-PART)
  (then select operator HAS-SURFACE-COATING-CYLINDRICAL-PART))

(control-rule SURFACE-COATING-RECTANGULAR
  (if (and (current-goal (surface-coating <part> <surface-coating>))
	   ;;check if the part is rectangular
	   (known (size-of <part> HEIGHT <h>))))
;	   (candidate-operator HAS-SURFACE-COATING-RECTANGULAR-PART)
  (then select operator HAS-SURFACE-COATING-RECTANGULAR-PART))

;;;***************************************************************

(control-rule CANNOT-ENLARGE-PART
 (if (and (candidate-goal (size-of <part> <dim> <new-size>))
	  (known (size <part> <dim> <curr-size>))
	  (smaller <curr-size> <new-size>)))
 (then reject goal (size <part> <dim> <new-size>)))
 
;;; ***************************************************************
;;; This is to avoid trying the opposite order of holding-tool and
;;; holding when one of them fails: do always holding before
;;; holding-tool. (Good to reduce the search space).

#|When we expand all the main goals (size-of) there are several
holding and holding-tool goals pending, and this rule causes a switch
of attention to other part 
(control-rule HOLDING-BEFORE-HOLDING-TOOL
  (if (and (candidate-goal (holding <machine> <hd> <part> <side>))
	   (candidate-goal (holding-tool <machine> <tool>))))
  (then reject goal (holding-tool <machine> <tool>)))
|#

;;;***************************************************************
;;; Rules to handle positive interactions between size-of and
;;; surface-finish goals.
;;;
;;; When the goal is to reduce the size of a part and change its surface,
;;;         (and (size-of part1 LENGTH 5)
;;;              (size-of part1 DIAMETER 2.999)
;;;              (surface-finish-quality-side part1 side1 GROUND)
;;; note that the operators that change the surface reduce also the size
;;; of the part. For example, if the size reduction to do is small, we
;;; shouldn't use rough-grind-with-hard-wheel to achieve the desired
;;; surface, and then work on size-of, because it will grind
;;; too much and will ruin the part! Then the problem becomes unsolvable.
;;; 
;;; We have two alternatives:
;;; - pick the right sizes for each of the operators, noticing that the
;;; goal size has to be smaller than the size actually picked for the
;;; cutting operator. Then the finishing operator will get the desired
;;; size. 
;;; 
;;; - find an operator that both reduces the size and gets the desired
;;; finishing: the op variables have to be bound to satisfy both goals. 


;;; Expand first the goals that are achieved by inference rules, so we
;;; can take advantage of goal concord when choosing operators.

(control-rule EXPAND-INF-RULE-SURFACE-GOALS-FIRST
  (if (and
       (candidate-goal <goal>)
       (goal-instance-of <goal>
	 surface-finish-quality-side surface-finish surface-coating)
       (candidate-goal <other-goal>)
       (~ (goal-instance-of <other-goal>
            surface-finish-quality-side surface-finish surface-coating))))
  (then reject goal <other-goal>))

(control-rule SIZE-BEFORE-SURFACE
  (if (and (candidate-goal (size-of <part> <dim> <value>))
	   ;;this links <side> and <dim>
	   (known (side-up-for-machining <dim> <side>))))
  (then prefer goal (size-of <part> <dim> <value>)
	(surface-finish-side <part> <side> <sf>)))

;;; ***************************************************************
;;; If the top level goals are:
;;; (has-hole p0 h0 ...) and
;;; (is-reamed p0 h0...) i.e same hole and other params in both
;;; goals, avoid working on setting the tool for second goal before
;;; the hole (first goal) is achieved, as the reamer will be held and
;;; then released to put the drilling-tool leading to state loops in
;;; some cases (tst5-8)

(control-rule reject-hole-goal
  (if (and (candidate-goal (has-hole <p> <h> <s> <d> <di> <x> <y>))
	   (or-metapred
	    (candidate-goal
	     (is-tapped <p> <h> <s> <d> <di> <x> <y>))
	    (candidate-goal
	     (is-counterbored <p> <h> <s> <d> <di> <x> <y> <s>))
	    (candidate-goal
	     (is-countersinked <p> <h> <s> <d> <di> <x> <y> <a>))
	    (candidate-goal
	     (is-reamed <p> <h> <s> <d> <di> <x> <y>)))))
   (then reject goal (has-hole <p> <h> <s> <d> <di> <x> <y>)))