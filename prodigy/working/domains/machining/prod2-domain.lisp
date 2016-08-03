;;;**********************************************************************
;;;**********************************************************************
;; MACHINING DOMAIN
;;
;; Yolanda Gil
;;
;; October 1990
;;
;; (Converted to Prodigy 4.0 by Jim Blythe, August 1991)
;;
;;;**********************************************************************
;;;**********************************************************************
;;
;;
;; OPERATORS: total of 57
;;            29 machining operations
;;            28 operators for setups
;;
;; INFERENCE RULES: total of 27
;;;**********************************************************************

;;;**********************************************************************
;;; Types and permanent instances
;;;**********************************************************************

(ptype-of Machine :Top-Type)
(ptype-of Milling-Machine Machine)
(ptype-of Milling-Cutter  :Top-Type)
(ptype-of Dimension-Type :Top-Type)
(ptype-op Surface-Finish :Top-Type)
(ptype-of Holding-Device :Top-Type)
(pinstance-of ROUGH-MILL Surface-Finish)
(ptype-of Part :Top-Type)

(infinite-type Dimension #'numberp)
(pinstance-of WIDTH LENGTH HEIGHT Dimension)

;;;**********************************************************************
; MACHINE: MILLING MACHINE

(Operator
 SIDE-MILL
 (params <machine> <part> <milling-cutter> <holding-device> <side-a> <dim>
	 <value>)
 (preconds
  ((<machine> Milling-Machine)
   (<milling-cutter> Milling-Cutter)
   (<dim> Dimension-Type)
   (<part> Part)
   (<value-old> Dimension))
  (and
   (or (same <dim> WIDTH)
       (same <dim> LENGTH))
   (size-of <part> <dim> <value-old>)
   (smaller <value> <value-old>)
   (dimension-opposite-sides <dim> <side-a> <side-b>)
   (holding-tool <machine> <milling-cutter>)
   (holding <machine> <holding-device> <part> <side-a>)))
 (effects
  ((<s-q> Surface-Finish))
  ((del (is-clean <part>))
   (add (has-burrs <part>))
   (del (surface-finish <part> <side-a> <s-q>))
   (add (surface-finish <part> <side-a> ROUGH-MILL))
   (add (size-of <part> <dim> <value>))
   (del (size-of <part> <dim> <value-old>)))))

(FACE-MILL
 (params <machine> <part> <milling-cutter> <holding-device> <side-a> <dim>
	 <value>)
 (preconds
  ((<machine> Milling-Machine)
   (<milling-cutter> Milling-Cutter)
   )
  (and
   (size-of <part> HEIGHT <value-old>)
   (smaller <value> <value-old>)
   (dimension-opposite-sides HEIGHT <side-a> <side-b>)
   (holding-tool <machine> <milling-cutter>)
   (holding <machine> <holding-device> <part> <side-a>)))
 (effects
  ()
  ((if (is-clean <part>) (del (is-clean <part>)))
   (if (~ (has-burrs <part>)) (add (has-burrs <part>)))
   (if (surface-finish <part> <side-a> <s-q>)
       (del (surface-finish <part> <side-a> <s-q>)))
   (add (surface-finish <part> <side-a> ROUGH-MILL))
   (add (size-of <part> HEIGHT <value>))
   (del (size-of <part> HEIGHT <value-old>)))))

;;;**********************************************************************
; MACHINE: DRILL

; operators for making holes

(DRILL-WITH-SPOT-DRILL
 (params (<machine> <drill-bit> <holding-device>
	  <part> <hole> <side> <hole-depth> <hole-diameter>))
 (preconds
   (and (is-a <machine> DRILL)
	(is-a <drill-bit> SPOT-DRILL)
	(holding-tool <machine> <drill-bit>)
	(holding <machine> <holding-device> <part> <side>)
	))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
	(add (has-spot <part> <hole> <side> <loc-x> <loc-y>)))))

(DRILL-WITH-TWIST-DRILL
 (params (<machine> <drill-bit> <holding-device>
	  <part> <hole> <side> <hole-depth> <hole-diameter>))
 (preconds
   (and (is-a <machine> DRILL)
        (same <drill-bit-diameter> <hole-diameter>)
	(diameter-of-drill-bit <drill-bit> <drill-bit-diameter>)
	(is-a <drill-bit> TWIST-DRILL)
	(has-spot <part> <hole> <side> <loc-x> <loc-y>)
	(holding-tool <machine> <drill-bit>)
	(holding <machine> <holding-device> <part> <side>)
	))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
	(del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
	(add (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)))))

(DRILL-WITH-HIGH-HELIX-DRILL
 (params (<machine> <drill-bit> <holding-device>
	  <part> <hole> <side> <hole-depth> <hole-diameter>))
 (preconds
   (and (is-a <machine> DRILL)
        (same <drill-bit-diameter> <hole-diameter>)
	(diameter-of-drill-bit <drill-bit> <drill-bit-diameter>)
	(is-a <drill-bit> HIGH-HELIX-DRILL)
	(has-fluid <machine> <fluid> <part>)
	(has-spot <part> <hole> <side> <loc-x> <loc-y>)
	(holding-tool <machine> <drill-bit>)
	(holding <machine> <holding-device> <part> <side>)))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
	(del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
	(add (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)))))

(DRILL-WITH-STRAIGHT-FLUTED-DRILL
 (params (<machine> <drill-bit> <holding-device>
	  <part> <hole> <side> <hole-depth> <hole-diameter>))
 (preconds
   (and (is-a <machine> DRILL)
        (same <drill-bit-diameter> <hole-diameter>)
	(diameter-of-drill-bit <drill-bit> <drill-bit-diameter>)
	(is-a <drill-bit> STRAIGHT-FLUTED-DRILL)
	(smaller <hole-depth> 2)
	(material-of <part> BRASS)
	(has-spot <part> <hole> <side> <loc-x> <loc-y>)
	(holding-tool <machine> <drill-bit>)
	(holding <machine> <holding-device> <part> <side>)
	))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
	(del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
	(add (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)))))

(DRILL-WITH-OIL-HOLE-DRILL
 (params (<machine> <drill-bit> <holding-device>
	  <part> <hole> <side> <hole-depth> <hole-diameter>))
 (preconds
   (and (is-a <machine> DRILL)
        (same <drill-bit-diameter> <hole-diameter>)
	(diameter-of-drill-bit <drill-bit> <drill-bit-diameter>)
	(is-a <drill-bit> OIL-HOLE-DRILL)
	(smaller <hole-depth> 20)
	(has-fluid <machine> <fluid> <part>)
	(has-spot <part> <hole> <side> <loc-x> <loc-y>)
 	(holding-tool <machine> <drill-bit>)
	(holding <machine> <holding-device> <part> <side>)))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
	(del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
	(add (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)))))

(DRILL-WITH-GUN-DRILL 
 (params (<machine> <drill-bit> <holding-device>
	  <part> <hole> <side> <hole-depth> <hole-diameter>))
 (preconds
   (and (is-a <machine> DRILL)
        (same <drill-bit-diameter> <hole-diameter>)
	(diameter-of-drill-bit <drill-bit> <drill-bit-diameter>)
	(is-a <drill-bit> GUN-DRILL)
	(has-fluid <machine> <fluid> <part>)
	(has-spot <part> <hole> <side> <loc-x> <loc-y>)
 	(holding-tool <machine> <drill-bit>)
	(holding <machine> <holding-device> <part> <side>)))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
	(del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
	(add (has-hole <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)))))


(DRILL-WITH-CENTER-DRILL
 (params (<machine> <drill-bit> <holding-device>
	  <part> <hole> <side> <drill-bit-diameter> <loc-x> <loc-y>))
 (preconds
   (and (is-a <machine> DRILL)
	(diameter-of-drill-bit <drill-bit> <drill-bit-diameter>)
	(is-a <drill-bit> CENTER-DRILL)
	(has-spot <part> <hole> <side> <loc-x> <loc-y>)
	(holding-tool <machine> <drill-bit>)
	(holding <machine> <holding-device> <part> <side>)
	))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
	(del (has-spot <part> <hole> <side> <loc-x> <loc-y>))
	(add (has-hole <part> <hole> <side> <hole-depth> <drill-bit-diameter> <loc-x> <loc-y>))
	(add (has-center-hole <part> <hole> <side> <loc-x> <loc-y>)))))

;; operators for finishing holes

(TAP 
 (params (<machine> <drill-bit> <holding-device> <part> <hole>))
  (preconds
     (and
	(is-a <machine> DRILL)
 	(same <drill-bit-diameter> <hole-diameter>)
	(diameter-of-drill-bit <drill-bit> <drill-bit-diameter>)
	(is-a <drill-bit> TAP)
	(has-hole <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)
	(holding-tool <machine> <drill-bit>)
	(holding <machine> <holding-device> <part> <side>)
	))
  (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (is-reamed <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)
	    (del (is-reamed <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)))
	(add (is-tapped <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)))))

(COUNTERSINK 
 (params (<machine> <drill-bit> <holding-device> <part> <hole>))
  (preconds
     (and
	(is-a <machine> DRILL)
	(angle-of-drill-bit <drill-bit> <angle>)
	(is-a <drill-bit> COUNTERSINK)
	(has-hole <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)
	(holding-tool <machine> <drill-bit>)
	(holding <machine> <holding-device> <part> <side>)
	))
  (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
	(add (is-countersinked <part> <hole> <side> <hole-depth> 
			    <hole-diameter> <loc-x> <loc-y> <angle>)))))

(COUNTERBORE 
 (params (<machine> <drill-bit> <holding-device> <part> <hole>))
  (preconds
     (and
	(is-a <machine> DRILL)
	(size-of-drill-bit <drill-bit> <counterbore-size>)
	(is-a <drill-bit> COUNTERBORE)
	(has-hole <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)
	(holding-tool <machine> <drill-bit>)
	(holding <machine> <holding-device> <part> <side>)
	))
  (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
	(add (is-counterbored <part> <hole> <side> <hole-depth> 
			   <hole-diameter>  <loc-x> <loc-y> <counterbore-size>)))))

(REAM 
 (params (<machine> <drill-bit> <holding-device> <part> <hole> 
	<side> <hole-depth> <hole-diameter>))
 (preconds
   (and (is-a <machine> DRILL)
	(same <drill-bit-diameter> <hole-diameter>)
	(diameter-of-drill-bit <drill-bit> <drill-bit-diameter>)
	(is-a <drill-bit> REAMER)
   	(smaller <hole-depth> 2)
	(has-fluid <machine> <fluid> <part>)
	(has-hole <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)
	(holding-tool <machine> <drill-bit>)
	(holding <machine> <holding-device> <part> <side>)
	))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (is-tapped <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)
	    (del (is-tapped <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)))
        (add (is-reamed <part> <hole> <side> <hole-depth> <hole-diameter> <loc-x> <loc-y>)))))

;;;**********************************************************************
; MACHINE: LATHE

(ROUGH-TURN
  (params (<machine> <part> <toolbit> <holding-device> <diameter-new>))
  (preconds
     (and
        (is-a <machine> LATHE)
	(is-a <toolbit> ROUGH-TOOLBIT)
	(or (and 
		 (shape-of <part> RECTANGULAR)
		 (holding <machine> <holding-device> <part> SIDE1))
	    (and
		 (shape-of <part> CYLINDRICAL)
		 (holding <machine> <holding-device> <part> SIDE0)))
	(or (and 
		 (shape-of <part> RECTANGULAR)
		 (size-of <part> HEIGHT <h>)
		 (size-of <part> WIDTH <w>)
		 (smaller <diameter-new> <h>)
		 (smaller <diameter-new> <w>))
	    (and
		 (shape-of <part> CYLINDRICAL)
		 (size-of <part> DIAMETER <diameter>)
		 (smaller <diameter-new> <diameter>)))
	(holding-tool <machine> <toolbit>)))
  (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
	(if (shape-of <part> RECTANGULAR) 
	    (del (size-of <part> HEIGHT <h>)))
	(if (shape-of <part> RECTANGULAR) 
	    (del (size-of <part> WIDTH <w>)))
	(if (shape-of <part> CYLINDRICAL) 
	    (del (size-of <part> DIAMETER <diameter>)))
	(if (surface-finish <part> SIDE1 <sf1>)
	    (del (surface-finish <part> SIDE1 <sf1>)))
	(if (surface-finish <part> SIDE2 <sf2>)
	    (del (surface-finish <part> SIDE2 <sf2>)))
	(if (surface-finish <part> SIDE4 <sf4>)
	    (del (surface-finish <part> SIDE4 <sf4>)))
	(if (surface-finish <part> SIDE5 <sf5>)
	    (del (surface-finish <part> SIDE5 <sf5>)))
	(add (size-of <part> DIAMETER <diameter-new>))
	(if (surface-finish <part> SIDE0 <sf>)
            (del (surface-finish <part> SIDE0 <sf>)))
        (add (surface-finish <part> SIDE0 ROUGH-TURN)))))

(FINISH-TURN
  (params (<machine> <part> <toolbit> <holding-device> <diameter-new>))
  (preconds
     (and
        (is-a <machine> LATHE)
	(is-a <toolbit> FINISH-TOOLBIT)
	(shape-of <part> CYLINDRICAL)
	(size-of <part> DIAMETER <diameter>)
	(finishing-size <diameter> <diameter-new>)
	(holding-tool <machine> <toolbit>)
	(holding <machine> <holding-device> <part> SIDE0)
	))
  (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
	(del (size-of <part> DIAMETER <diameter>))
	(add (size-of <part> DIAMETER <diameter-new>))
        (if (surface-finish <part> SIDE0 <sf>)
            (del (surface-finish <part> SIDE0 <sf>)))
        (add (surface-finish <part> SIDE0 FINISH-TURN)))))

(MAKE-THREAD-WITH-LATHE
  (params (<machine> <part> <holding-device> <side>))
  (preconds
     (and
        (is-a <machine> LATHE)
	(is-a <toolbit> V-THREAD)
	(shape-of <part> CYLINDRICAL)
	(size-of <part> DIAMETER <diameter>)
	(holding <machine> <holding-device> <part> SIDE0)
	))
  (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (surface-finish <part> SIDE0 <sf>)
            (del (surface-finish <part> SIDE0 <sf>)))
        (add (surface-finish <part> SIDE0 TAPPED)))))

(MAKE-KNURL-WITH-LATHE
  (params (<machine> <part> <holding-device> <side>))
  (preconds
     (and
        (is-a <machine> LATHE)
	(is-a <toolbit> KNURL)
	(shape-of <part> CYLINDRICAL)
	(size-of <part> DIAMETER <diameter>)
	(holding <machine> <holding-device> <part> SIDE0)))
  (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (surface-finish <part> SIDE0 <sf>)
            (del (surface-finish <part> SIDE0 <sf>)))
        (add (surface-finish <part> SIDE0 KNURLED)))))

(FILE-WITH-LATHE
  (params (<machine> <part> <holding-device> <lathe-file> <diameter-new>))
  (preconds
     (and
        (is-a <machine> LATHE)
	(is-a <lathe-file> LATHE-FILE)
	(shape-of <part> CYLINDRICAL)
	(size-of <part> DIAMETER <diameter>)
	(finishing-size <diameter> <diameter-new>)
	(holding <machine> <holding-device> <part> SIDE0)))
  (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
	(del (size-of <part> DIAMETER <diameter>))
	(add (size-of <part> DIAMETER <diameter-new>))
        (if (surface-finish <part> SIDE0 <sf>)
            (del (surface-finish <part> SIDE0 <sf>)))
        (add (surface-finish <part> SIDE0 ROUGH-GRIND)))))

(POLISH-WITH-LATHE
  (params (<machine> <part> <holding-device> <cloth> <diameter-new>))
  (preconds
     (and
        (is-a <machine> LATHE)
	(is-a <cloth> ABRASIVE-CLOTH)
	(material-of-abrasive-cloth <cloth> EMERY)
	(shape-of <part> CYLINDRICAL)
	(holding <machine> <holding-device> <part> SIDE0)))
  (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (surface-finish <part> SIDE0 <s-q>)
            (del (surface-finish <part> SIDE0 <s-q>)))
        (add (surface-finish <part> SIDE0 POLISHED)))))

;;;**********************************************************************
; MACHINE: SHAPER

(ROUGH-SHAPE
  (params (<machine> <part> <cutting-tool> <holding-device> <side-a> <dim> <value>))
  (preconds 
     (and
        (is-a <machine> SHAPER)
	(is-a <cutting-tool> ROUGHING-CUTTING-TOOL)
	(size-of <part> <dim> <value-old>)
	(smaller <value> <value-old>)
	(~ (same <dim> DIAMETER)) ; this is necessary, ow 
	    ;  the op is used to make parts cylindrical
	(dimension-opposite-sides <dim> <side-a> <side-b>)
	(holding-tool <machine> <cutting-tool>)
	(holding <machine> <holding-device> <part> <side-a>)))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (surface-finish <part> <side-a> <s-q>)
            (del (surface-finish <part> <side-a> <s-q>)))
        (add (surface-finish <part> <side-a> ROUGH-SHAPED))
	(add (size-of <part> <dim> <value>))
	(del (size-of <part> <dim> <value-old>)))))
    
(FINISH-SHAPE
  (params (<machine> <part> <cutting-tool> <holding-device> <side-a> <dim> <value>))
   (preconds
     (and
        (is-a <machine> SHAPER)
	(is-a <cutting-tool> FINISHING-CUTTING-TOOL)
	(size-of <part> <dim> <value-old>)
	(finishing-size <value-old> <value>)
 	(~ (same <dim> DIAMETER)) ; this is necessary, ow 
	    ;  the op is used to make parts cylindrical
	(dimension-opposite-sides <dim> <side-a> <side-b>)
	(holding-tool <machine> <cutting-tool>)
	(holding <machine> <holding-device> <part> <side-a>)))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (surface-finish <part> <side-a> <s-q>)
            (del (surface-finish <part> <side-a> <s-q>)))
        (add (surface-finish <part> <side-a> FINISH-SHAPED))
	(add (size-of <part> <dim> <value>))
	(del (size-of <part> <dim> <value-old>)))))

;;;**********************************************************************
; MACHINE: PLANER

(ROUGH-SHAPE-WITH-PLANER
  (params (<machine> <part> <cutting-tool> <holding-device> <side-a> <dim> <value>))
   (preconds
     (and
        (is-a <machine> PLANER)
	(is-a <cutting-tool> ROUGHING-CUTTING-TOOL)
	(size-of <part> <dim> <value-old>)
	(smaller <value> <value-old>)
	(~ (same <dim> DIAMETER)) ; this is necessary, ow 
	    ;  the op is used to make parts cylindrical
	(dimension-opposite-sides <dim> <side-a> <side-b>)
	(holding-tool <machine> <cutting-tool>)
	(holding <machine> <holding-device> <part> <side-a>)))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (surface-finish <part> <side-a> <s-q>)
            (del (surface-finish <part> <side-a> <s-q>)))
        (add (surface-finish <part> <side-a> ROUGH-PLANED))
	(add (size-of <part> <dim> <value>))
	(del (size-of <part> <dim> <value-old>)))))

(FINISH-SHAPE-WITH-PLANER
  (params (<machine> <part> <cutting-tool> <holding-device> <side-a> <dim> <value>))
   (preconds
     (and
        (is-a <machine> PLANER)
	(is-a <cutting-tool> FINISHING-CUTTING-TOOL)
	(size-of <part> <dim> <value-old>)
	(finishing-size <value-old> <value>)
	(~ (same <dim> DIAMETER)) ; this is necessary, ow 
	    ;  the op is used to make parts cylindrical
	(dimension-opposite-sides <dim> <side-a> <side-b>)
	(holding-tool <machine> <cutting-tool>)
	(holding <machine> <holding-device> <part> <side-a>)))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (surface-finish <part> <side-a> <s-q>)
            (del (surface-finish <part> <side-a> <s-q>)))
        (add (surface-finish <part> <side-a> FINISH-PLANED))
	(add (size-of <part> <dim> <value>))
	(del (size-of <part> <dim> <value-old>)))))

;;;**********************************************************************
; MACHINE: GRINDER

(ROUGH-GRIND
  (params (<machine> <part> <wheel> <holding-device> <side-a> <dim> <value>))
 (preconds
   (and
        (is-a <machine> GRINDER)
	(is-a <wheel> GRINDING-WHEEL)
	(has-fluid <machine> <fluid> <part>)
	(or (and (hardness-of <part> SOFT)
		 (hardness-of-wheel <wheel> HARD))
	    (and (hardness-of <part> HARD)
		 (hardness-of-wheel <wheel> SOFT)))
	(grit-of-wheel <wheel> COARSE-GRIT)
	(size-of <part> <dim> <value-old>)
	(smaller <value> <value-old>)
	(~ (same <dim> DIAMETER)) ; this is necessary, ow 
	    ;  the op is used to make parts cylindrical
	(dimension-opposite-sides <dim> <side-a> <side-b>)
	(holding-tool <machine> <wheel>)
	(holding <machine> <holding-device> <part> <side-a>)))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (surface-finish <part> <side-a> <s-q>)
            (del (surface-finish <part> <side-a> <s-q>)))
        (add (surface-finish <part> <side-a> ROUGH-GRIND))
	(add (size-of <part> <dim> <value>))
	(del (size-of <part> <dim> <value-old>)))))

(FINISH-GRIND
  (params (<machine> <part> <wheel> <holding-device> <side-a> <dim> <value>))
 (preconds
   (and
        (is-a <machine> GRINDER)
	(is-a <wheel> GRINDING-WHEEL)
	(has-fluid <machine> <fluid> <part>)
	(or (and (hardness-of <part> SOFT)
		 (hardness-of-wheel <wheel> HARD))
	    (and (hardness-of <part> HARD)
		 (hardness-of-wheel <wheel> SOFT)))
	(grit-of-wheel <wheel> FINE-GRIT)
	(size-of <part> <dim> <value-old>)
	(smaller <value> <value-old>)
	(~ (same <dim> DIAMETER)) ; this is necessary, ow 
	    ;  the op is used to make parts cylindrical
	(dimension-opposite-sides <dim> <side-a> <side-b>)
	(holding-tool <machine> <wheel>)
	(holding <machine> <holding-device> <part> <side-a>)))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (surface-finish <part> <side-a> <s-q>)
            (del (surface-finish <part> <side-a> <s-q>)))
        (add (surface-finish <part> <side-a> FINISH-GRIND))
	(add (size-of <part> <dim> <value>))
	(del (size-of <part> <dim> <value-old>)))))

;;;**********************************************************************
; MACHINE: CIRCULAR-SAW

(CUT-WITH-CIRCULAR-COLD-SAW
  (params (<machine> <part> <attachment> <holding-device> <dim> <value>))
  (preconds
    (and 
         (is-a <machine> CIRCULAR-SAW)
	 (is-a <attachment> COLD-SAW)
	 (size-of <part> <dim> <value-old>)
	 (smaller <value> <value-old>)
	 (~ (same <dim> DIAMETER)) ; this is necessary, ow 
	    ;  the op is used to make parts cylindrical
	 (dimension-opposite-sides <dim> <side-a> <side-b>)
	 (holding-tool <machine> <attachment>)
	 (holding <machine> <holding-device> <part> <side-a>)))
  (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (surface-finish <part> <side-a> <s-q>)
            (del (surface-finish <part> <side-a> <s-q>)))
        (add (surface-finish <part> <side-a> SAWCUT))
	(del (size-of <part> <dim> <value-old>))
	(add (size-of <part> <dim> <value>)))))

(CUT-WITH-CIRCULAR-FRICTION-SAW
  (params (<machine> <part> <attachment> <holding-device> <dim> <value>))
  (preconds
    (and 
         (is-a <machine> CIRCULAR-SAW)
	 (is-a <attachment> FRICTION-SAW)
	 (has-fluid <machine> <fluid> <part>)
	 (size-of <part> <dim> <value-old>)
	 (smaller <value> <value-old>)
	 (~ (same <dim> DIAMETER)) ; this is necessary, ow 
	    ;  the op is used to make parts cylindrical
	 (dimension-opposite-sides <dim> <side-a> <side-b>)
	 (holding-tool <machine> <attachment>)
	 (holding <machine> <holding-device> <part> <side-a>)))
  (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (surface-finish <part> <side-a> <s-q>)
            (del (surface-finish <part> <side-a> <s-q>)))
        (add (surface-finish <part> <side-a> SAWCUT))
	(del (size-of <part> <dim> <value-old>))
	(add (size-of <part> <dim> <value>)))))

;;;**********************************************************************
; MACHINE: BAND-SAW

(CUT-WITH-BAND-SAW
  (params (<machine> <part> <attachment> <dim> <value>))
  (preconds
    (and
         (is-a <machine> BAND-SAW)
	 (is-a <attachment> BAND-SAW-ATTACHMENT)
	 (size-of <part> <dim> <value-old>)
	 (smaller <value> <value-old>)
	 (~ (same <dim> DIAMETER)) ; this is necessary, ow 
	    ;  the op is used to make parts cylindrical
	(dimension-opposite-sides <dim> <side-a> <side-b>)
	(holding-tool <machine> <attachment>)
	(~ (has-burrs <part>))
	(is-clean <part>)
	(on-table <machine> <part>)))
  (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (surface-finish <part> <side-a> <s-q>)
            (del (surface-finish <part> <side-a> <s-q>)))
        (add (surface-finish <part> <side-a> SAWCUT))
	(del (size-of <part> <dim> <value-old>))
	(add (size-of <part> <dim> <value>)))))

(POLISH-WITH-BAND-SAW
  (params (<machine> <part> <attachment> <side>))
  (preconds
    (and
         (is-a <machine> BAND-SAW)
	 (is-a <attachment> BAND-SAW-ATTACHMENT)
	 (holding-tool <machine> <attachment>)
	 (~ (has-burrs <part>))
	 (is-clean <part>)
	 (on-table <machine> <part>)))
  (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(if (~ (has-burrs <part>)) (add (has-burrs <part>)))
        (if (surface-finish <part> <side> <old-sf-cond>)
            (del (surface-finish <part> <side> <old-sf-cond>)))
        (add (surface-finish <part> <side> POLISHED)))))

;;;**********************************************************************
; OTHER OPERATIONS

(CLEAN
   (params (<part>))
   (preconds
	(is-available-part <part>))
   (effects (
	 (add (is-clean <part>)))))

(REMOVE-BURRS
   (params (<part> <brush>))
   (preconds
      (and
	(is-a <brush> BRUSH)
	(is-available-part <part>)))
   (effects (
	(if (is-clean <part>) (del (is-clean <part>)))
	(del (has-burrs <part>)))))

;;;**********************************************************************
;;;**********************************************************************
; operators for preparing the machines

(PUT-MILLING-CUTTER-ON-MILLING-MACHINE
 (params (<machine> <attachment>))
   (preconds
     (and 
	  (is-a <machine> MILLING-MACHINE)
	  (is-of-type <attachment> MILLING-CUTTER)
	  (is-available-tool-holder <machine>)
	  (is-available-tool <attachment>)))
   (effects ( (add (holding-tool <machine> <attachment>)))))

(PUT-IN-DRILL-SPINDLE
 (params (<machine> <drill-bit>))
   (preconds
     (and
	  (is-a <machine> DRILL)
	  (is-of-type <drill-bit> DRILL-BIT)
	  (is-available-tool-holder <machine>)
	  (is-available-tool <drill-bit>)))
   (effects ( (add (holding-tool <machine> <drill-bit>)))))

(PUT-TOOLBIT-IN-LATHE
 (params (<machine> <toolbit>))
   (preconds
     (and 
	  (is-a <machine> LATHE)
	  (is-of-type <toolbit> LATHE-TOOLBIT)
	  (is-available-tool-holder <machine>)
	  (is-available-tool <toolbit>)))
   (effects ( (add (holding-tool <machine> <toolbit>)))))

(PUT-CUTTING-TOOL-IN-SHAPER-OR-PLANER
 (params (<machine> <cutting-tool>))
   (preconds
     (and (or (is-a <machine> SHAPER)
	      (is-a <machine> PLANER))
	  (is-of-type <cutting-tool> CUTTING-TOOL)
	  (is-available-tool-holder <machine>)
	  (is-available-tool <cutting-tool>)))
   (effects ( (add (holding-tool <machine> <cutting-tool>)))))

(PUT-WHEEL-IN-GRINDER
 (params (<machine> <wheel>))
   (preconds
     (and 
	  (is-a <machine> GRINDER)
	  (is-a <wheel> GRINDING-WHEEL)
	  (is-available-tool-holder <machine>)
	  (is-available-tool <wheel>)))
   (effects ( (add (holding-tool <machine> <wheel>)))))

(PUT-CIRCULAR-SAW-ATTACHMENT-IN-CIRCULAR-SAW
 (params (<machine> <attachment>))
   (preconds
     (and 
	  (is-a <machine> CIRCULAR-SAW)
	  (is-of-type <attachment> CIRCULAR-SAW-ATTACHMENT)
	  (is-available-tool-holder <machine>)
	  (is-available-tool <attachment>)))
   (effects ( (add (holding-tool <machine> <attachment>)))))

(PUT-BAND-SAW-ATTACHMENT-IN-BAND-SAW
 (params (<machine> <attachment>))
   (preconds
     (and 
	  (is-a <machine> BAND-SAW)
	  (is-a <attachment> BAND-SAW-ATTACHMENT)
	  (is-available-tool-holder <machine>)
	  (is-available-tool <attachment>)))
   (effects ( (add (holding-tool <machine> <attachment>)))))

(REMOVE-TOOL-FROM-MACHINE
    (params (<machine> <tool>))
    (preconds
	(holding-tool <machine> <tool>))
    (effects (
	(del (holding-tool <machine> <tool>)))))

(PUT-HOLDING-DEVICE-IN-MILLING-MACHINE
 (params (<machine> <holding-device>))
   (preconds
     (and
	  (is-a <machine> MILLING-MACHINE)
	  (or 
	      (is-a <holding-device> 4-JAW-CHUCK)
	      (is-a <holding-device> V-BLOCK)
	      (is-a <holding-device> VISE)
              (is-a <holding-device> COLLET-CHUCK)
              (is-a <holding-device> TOE-CLAMP))
	  (is-available-table <machine>)
	  (is-available-holding-device <holding-device>)))
   (effects ( (add (has-device <machine> <holding-device>)))))

(PUT-HOLDING-DEVICE-IN-DRILL
 (params (<machine> <holding-device>))
   (preconds
     (and
	  (is-a <machine> DRILL)
	  (or 
	      (is-a <holding-device> 4-JAW-CHUCK)
	      (is-a <holding-device> V-BLOCK)
	      (is-a <holding-device> VISE)
              (is-a <holding-device> TOE-CLAMP))
	  (is-available-table <machine>)
	  (is-available-holding-device <holding-device>)))
   (effects ( (add (has-device <machine> <holding-device>)))))

(PUT-HOLDING-DEVICE-IN-LATHE
 (params (<machine> <holding-device>))
   (preconds
     (and
	  (is-a <machine> LATHE)
	  (or (is-a <holding-device> CENTERS)
	      (is-a <holding-device> 4-JAW-CHUCK)
	      (is-a <holding-device> COLLET-CHUCK))
	  (is-available-table <machine>)
	  (is-available-holding-device <holding-device>)))
   (effects ( (add (has-device <machine> <holding-device>)))))

(PUT-HOLDING-DEVICE-IN-SHAPER
 (params (<machine> <holding-device>))
   (preconds
     (and (is-a <machine> SHAPER)
	  (is-a <holding-device> VISE)
	  (is-available-table <machine>)
	  (is-available-holding-device <holding-device>)))
   (effects ( (add (has-device <machine> <holding-device>)))))

(PUT-HOLDING-DEVICE-IN-PLANER
 (params (<machine> <holding-device>))
   (preconds
     (and (is-a <machine> PLANER)
	  (is-a <holding-device> TOE-CLAMP)
	  (is-available-table <machine>)
	  (is-available-holding-device <holding-device>)))
   (effects ( (add (has-device <machine> <holding-device>)))))

(PUT-HOLDING-DEVICE-IN-GRINDER
 (params (<machine> <holding-device>))
   (preconds
     (and
	  (is-a <machine> GRINDER)
	  (or (is-a <holding-device> MAGNETIC-CHUCK)
	      (is-a <holding-device> V-BLOCK)
	      (is-a <holding-device> VISE))
	  (is-available-table <machine>)
	  (is-available-holding-device <holding-device>)))
   (effects ( (add (has-device <machine> <holding-device>)))))

(PUT-HOLDING-DEVICE-IN-CIRCULAR-SAW
 (params (<machine> <holding-device>))
   (preconds
     (and
	  (is-a <machine> CIRCULAR-SAW)
	  (or
  	      (is-a <holding-device> VISE)
	      (is-a <holding-device> V-BLOCK))
	  (is-available-table <machine>)
	  (is-available-holding-device <holding-device>)))
   (effects ( (add (has-device <machine> <holding-device>)))))

(REMOVE-HOLDING-DEVICE-FROM-MACHINE
    (params (<machine> <holding-device>))
    (preconds
       (and
	(has-device <machine> <holding-device>)
	(is-empty-holding-device <holding-device> <machine>)))
    (effects (
	(del (has-device <machine> <holding-device>)))))

(ADD-CUTTING-FLUID
 (params (<machine> <fluid>))
  (preconds
	(or (and 
		 (or (material-of <part> STEEL)
		     (material-of <part> ALUMINUM))
		 (is-a <fluid> SOLUBLE-OIL))
	    (and
		 (material-of <part> IRON)
		 (is-a <fluid> MINERAL-OIL))
	    (and 
		 (or (material-of <part> BRASS)
		     (material-of <part> BRONZE)
		     (material-of <part> COPPER))
	         (is-of-type <fluid> CUTTING-FLUID))))
  (effects (
     (add (has-fluid <machine> <fluid> <part>)))))

;;;**********************************************************************
;;;**********************************************************************
; operators for holding parts with a device in a machine

(PUT-ON-MACHINE-TABLE
 (params (<machine> <part>))
   (preconds
       (and 
	    (or (~ (is-a <machine> SHAPER))
		(and (size-of-machine <machine> <shaper-size>)
		     (size-of <part> LENGTH <part-size>)
		     (smaller <part-size> <shaper-size>)))
	    (is-available-part <part>)
	    (is-available-machine <machine>)))
   (effects ( 
	(add (on-table <machine> <part>)))))

(HOLD-WITH-V-BLOCK	
 (params (<machine> <holding-device> <part> <side>))
 (preconds
   (and 
	(is-a <holding-device> V-BLOCK)
	(has-device <machine> <holding-device>)
	(~ (has-burrs <part>))
	(is-clean <part>)
	(on-table <machine> <part>)
	(shape-of <part> CYLINDRICAL)
	(is-empty-holding-device <holding-device> <machine>)
	(is-available-part <part>)))
 (effects (
   (del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))

(HOLD-WITH-VISE
 (params (<machine> <holding-device> <part> <side>))
 (preconds
   (and 
        (is-a <holding-device> VISE)
	(has-device <machine> <holding-device>)
	(~ (has-burrs <part>))
	(is-clean <part>)
	(on-table <machine> <part>)
	(is-empty-holding-device <holding-device> <machine>)
	(is-available-part <part>)))
 (effects (
   (del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))

(HOLD-WITH-TOE-CLAMP
 (params (<machine> <holding-device> <part> <side>))
 (preconds
   (and 
        (is-a <holding-device> TOE-CLAMP)
	(has-device <machine> <holding-device>)
	(~ (has-burrs <part>))
	(is-clean <part>)
	(on-table <machine> <part>)
	(is-empty-holding-device <holding-device> <machine>)
	(is-available-part <part>)
	))
 (effects (
   (del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))

(HOLD-WITH-CENTERS
 (params (<machine> <holding-device> <part> <side>))
 (preconds
   (and 
        (is-a <holding-device> CENTERS)
	(has-device <machine> <holding-device>)
	(has-center-holes <part>)
	(~ (has-burrs <part>))
	(is-clean <part>)
	(on-table <machine> <part>)
	(shape-of <part> CYLINDRICAL)
	(is-empty-holding-device <holding-device> <machine>)
	(is-available-part <part>)))
 (effects (
   (del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))

(HOLD-WITH-4-JAW-CHUCK
 (params (<machine> <holding-device> <part> <side>))
 (preconds
   (and 
        (is-a <holding-device> 4-JAW-CHUCK)
	(has-device <machine> <holding-device>)
	(~ (has-burrs <part>))
	(is-clean <part>)
	(on-table <machine> <part>)
	(is-empty-holding-device <holding-device> <machine>)
	(is-available-part <part>)))
 (effects (
   (del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))

(HOLD-WITH-COLLET-CHUCK
 (params (<machine> <holding-device> <part> <side>))
 (preconds
   (and 
        (is-a <holding-device> COLLET-CHUCK)
	(has-device <machine> <holding-device>)
	(~ (has-burrs <part>))
	(is-clean <part>)
	(on-table <machine> <part>)
	(shape-of <part> CYLINDRICAL)
	(is-empty-holding-device <holding-device> <machine>)
	(is-available-part <part>)))
 (effects (
   (del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))

(HOLD-WITH-MAGNETIC-CHUCK
 (params (<machine> <holding-device> <part> <side>))
 (preconds
   (and 
        (is-a <holding-device> MAGNETIC-CHUCK)
	(has-device <machine> <holding-device>)
	(~ (has-burrs <part>))
	(is-clean <part>)
	(on-table <machine> <part>)
	(is-empty-holding-device <holding-device> <machine>)
	(is-available-part <part>)))
 (effects (
   (del (on-table <machine> <part>))
   (add (holding <machine> <holding-device> <part> <side>)))))

(RELEASE-FROM-HOLDING-DEVICE
 (params (<machine> <holding-device> <part> <side>))
   (preconds
      (holding <machine> <holding-device> <part> <side>))
 (effects ( 
   (del (holding <machine> <holding-device> <part> <side>)))))

))

;;;**********************************************************************
;;;**********************************************************************
;;;**********************************************************************

(setq *INFERENCE-RULES* '(


(HAS-CENTER-HOLES
 (params (<part> <x2> <y2>))
  (preconds
    (and
	(or (and 
		 (shape-of <part> RECTANGULAR)
		 (size-of <part> WIDTH <x>)
		 (size-of <part> HEIGHT <y>))
	    (and
		 (shape-of <part> CYLINDRICAL)
		 (size-of <part> DIAMETER <x>)
		 (size-of <part> DIAMETER <y>)))
	(half-of <x> <x2>)
	(half-of <y> <y2>)
	(has-center-hole <part> CENTER-HOLE-SIDE3 SIDE3 <x2> <y2>)
	(is-countersinked <part> CENTER-HOLE-SIDE3 SIDE3 1/2 1/16 <x2> <y2> 60)
	(has-center-hole <part> CENTER-HOLE-SIDE6 SIDE6 <x2> <y2>)
	(is-countersinked <part> CENTER-HOLE-SIDE6 SIDE6 1/2 1/16 <x2> <y2> 60)))
  (effects (
	(add (has-center-holes <part>)))))

;;;**********************************************************************
; inference rules for availability

(MACHINE-AVAILABLE
 (params (<machine>))
  (preconds
     (~ (exists (<other-part>)
		       (on-table <machine> <other-part>))))
  (effects ( (add (is-available-machine <machine>)))))

(TOOL-HOLDER-AVAILABLE
 (params (<machine>))
  (preconds
     (~ (exists (<tool>)
		       (holding-tool <machine> <tool>))))
  (effects ( (add (is-available-tool-holder <machine>)))))

(TOOL-AVAILABLE
 (params (<tool>))
  (preconds
     (~ (exists (<machine>)
		       (holding-tool <machine> <tool>))))
  (effects ( (add (is-available-tool <tool>)))))

(TABLE-AVAILABLE
 (params (<machine>))
  (preconds
	(~ (exists (<holding-device>)
		(has-device <machine> <holding-device>))))
  (effects ( (add (is-available-table <machine>)))))

(HOLDING-DEVICE-AVAILABLE
 (params (<machine> <holding-device>))
  (preconds
        (~ (exists (<machine>)
		(has-device <machine> <holding-device>))))
  (effects ( (add (is-available-holding-device <holding-device>)))))

(PART-AVAILABLE
 (params (<part>))
  (preconds
	(~ (exists (<holding-device>)
		(holding <machine> <holding-device> <part> <side>))))
  (effects ( (add (is-available-part <part>)))))

(HOLDING-DEVICE-EMPTY
 (params (<machine> <holding-device>))
  (preconds
        (~ (exists (<part>)
		(holding <machine> <holding-device> <part> <side>))))
  (effects ( (add (is-empty-holding-device <holding-device> <machine>)))))

;;;**********************************************************************
; inference rules for shape

(IS-RECTANGULAR
 (params (<part>))
   (preconds
     (and
	(size-of <part> LENGTH <l>)
	(size-of <part> WIDTH <w>)
	(size-of <part> HEIGHT <h>)))
   (effects ( (add (shape-of <part> RECTANGULAR)))))

(IS-CYLINDRICAL
 (params (<part>))
   (preconds
     (and
	(size-of <part> LENGTH <l>)
	(size-of <part> DIAMETER <d>)))
   (effects ( (add (shape-of <part> CYLINDRICAL)))))

;;;**********************************************************************
; inference rules for surface finish

(IS-MACHINED-SURFACE-QUALITY
  (params (<part> <side>))
   (preconds
     (or 
	 (surface-finish <part> <side> ROUGH-MILL)
         (surface-finish <part> <side> ROUGH-TURN)
	 (surface-finish <part> <side> ROUGH-SHAPED)
	 (surface-finish <part> <side> ROUGH-PLANED)
	 (surface-finish <part> <side> FINISH-PLANED)
	 (surface-finish <part> <side> COLD-ROLLED)
         (surface-finish <part> <side> FINISH-MILL)
         (surface-finish <part> <side> FINISH-TURN)
         (surface-finish-quality <part> <side> GROUND)))
   (effects ( (add (surface-finish-quality <part> <side> MACHINED)))))

(IS-GROUND-SURFACE-QUALITY
 (params (<part> <side>))
   (preconds
     (or (surface-finish <part> <side> ROUGH-GRIND)
         (surface-finish <part> <side> FINISH-GRIND)))
   (effects ( (add (surface-finish-quality <part> <side> GROUND)))))

;;;**********************************************************************

(MATERIAL-FERROUS		
 (params (<part>))
 (preconds
    (or
	(material-of <part> STEEL)
	(material-of <part> IRON)))
 (effects (
	(add (alloy-of <part> FERROUS)))))

(MATERIAL-NON-FERROUS		
 (params (<part>))
 (preconds
    (or
	(material-of <part> BRASS)
	(material-of <part> COPPER)
	(material-of <part> BRONZE)
	(material-of <part> PLASTIC)))
 (effects (
	(add (alloy-of <part> NON-FERROUS)))))

(HARDNESS-OF-MATERIAL-SOFT
 (params (<part>))
 (preconds
	(or
	   (material-of <part> ALUMINUM)
	   (alloy-of <part> NON-FERROUS)))
 (effects (
	(add (hardness-of <part> SOFT)))))

(HARDNESS-OF-MATERIAL-HARD
 (params (<part>))
 (preconds
	(alloy-of <part> FERROUS))
 (effects (
	(add (hardness-of <part> HARD)))))

;;;**********************************************************************
; inference rules for types

(IS-MACHINE
 (params (<machine>))
  (preconds
    (or 
	(is-a <machine> DRILL)
        (is-a <machine> LATHE)
        (is-a <machine> SHAPER)
        (is-a <machine> PLANER)
        (is-a <machine> GRINDER)
        (is-a <machine> BAND-SAW)
        (is-a <machine> CIRCULAR-SAW)
        (is-a <machine> MILLING-MACHINE)))
  (effects (
       (add (is-of-type <machine> MACHINE)))))

(IS-HOLDING-DEVICE
 (params (<holding-device>))
  (preconds
    (or 
	(is-a <holding-device> V-BLOCK)
        (is-a <holding-device> VISE)
        (is-a <holding-device> TOE-CLAMP)
        (is-a <holding-device> CENTERS)
        (is-a <holding-device> 4-JAW-CHUCK)
        (is-a <holding-device> COLLET-CHUCK)
        (is-a <holding-device> MAGNETIC-CHUCK)))
  (effects (
       (add (is-of-type <holding-device> HOLDING-DEVICE)))))

(IS-TOOL
 (params (<tool>))
  (preconds
    (or 
	(is-of-type <tool> MACHINE-TOOL)
	(is-of-type <tool> OPERATOR-TOOL)))
  (effects (
       (add (is-of-type <tool> TOOL)))))

(IS-MACHINE-TOOL
 (params (<attachment>))
  (preconds
    (or 
	  (is-of-type <attachment> DRILL-BIT)
	  (is-of-type <attachment> LATHE-TOOLBIT)
	  (is-of-type <attachment> CUTTING-TOOL)
	  (is-a <attachment> GRINDING-WHEEL)
	  (is-of-type <attachment> BAND-SAW-ATTACHMENT)
	  (is-of-type <attachment> CIRCULAR-SAW-ATTACHMENT)
	  (is-of-type <attachment> MILLING-CUTTER)))
  (effects (
       (add (is-of-type <attachment> MACHINE-TOOL)))))

(IS-DRILL-BIT
 (params (<drill-bit>))
  (preconds
    (or 
	(is-a <drill-bit> SPOT-DRILL)
	(is-a <drill-bit> CENTER-DRILL)
	(is-a <drill-bit> TWIST-DRILL)
	(is-a <drill-bit> STRAIGHT-FLUTED-DRILL)
	(is-a <drill-bit> HIGH-HELIX-DRILL)
	(is-a <drill-bit> OIL-HOLE-DRILL)
	(is-a <drill-bit> GUN-DRILL)
	(is-a <drill-bit> CORE-DRILL)
	(is-a <drill-bit> TAP)
	(is-a <drill-bit> COUNTERSINK)
	(is-a <drill-bit> COUNTERBORE)
	(is-a <drill-bit> REAMER)))
  (effects (
       (add (is-of-type <drill-bit> DRILL-BIT)))))

(IS-LATHE-TOOLBIT
 (params (<toolbit>))
  (preconds
    (or 
	(is-a <toolbit> ROUGH-TOOLBIT)
	(is-a <toolbit> FINISH-TOOLBIT)
	(is-a <toolbit> V-THREAD)
	(is-a <toolbit> KNURL)))
  (effects (
       (add (is-of-type <toolbit> LATHE-TOOLBIT)))))

(IS-CUTTING-TOOL
 (params (<cutting-tool>))
  (preconds
    (or 
	(is-a <cutting-tool> ROUGHING-CUTTING-TOOL)
	(is-a <cutting-tool> FINISHING-CUTTING-TOOL)))
  (effects (
       (add (is-of-type <cutting-tool> CUTTING-TOOL)))))

(IS-CIRCULAR-SAW-ATTACHMENT
 (params (<attachment>))
  (preconds
    (or 
	(is-a <attachment> COLD-SAW)
	(is-a <attachment> FRICTION-SAW)))
  (effects (
       (add (is-of-type <attachment> CIRCULAR-SAW-ATTACHMENT)))))

(IS-MILLING-CUTTER
 (params (<milling-cutter>))
  (preconds
    (or
	(is-a <milling-cutter> PLAIN-MILL)
	(is-a <milling-cutter> END-MILL)))
  (effects (
       (add (is-of-type <milling-cutter> MILLING-CUTTER)))))

(IS-OPERATOR-TOOL
 (params (<tool>))
  (preconds
    (or 
	(is-a <tool> LATHE-FILE)
	(is-a <tool> ABRASIVE-CLOTH)
	(is-a <tool> BRUSH)))
  (effects (
       (add (is-of-type <tool> OPERATOR-TOOL)))))

(IS-CUTTING-FLUID
 (params (<cutting-fluid>))
  (preconds
    (or (is-a <cutting-fluid> SOLUBLE-OIL)
	(is-a <cutting-fluid> MINERAL-OIL)))
  (effects (
        (add (is-of-type <cutting-fluid> CUTTING-FLUID)))))

))

