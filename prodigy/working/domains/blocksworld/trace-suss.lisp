(run)
Creating objects (BLOCKA BLOCKB BLOCKC) of type OBJECT

  2 n2 (done)
  4 n4 <*finish*>
  5   n5 (on blocka blockb) [1]
  7   n7 <stack blocka blockb>
  8     n8 (holding blocka) [1]
 10     n10 <pick-up blocka>
 11       n11 (clear blocka) [1]
 13       n13 <unstack blockc blocka>
 14       n14 <UNSTACK BLOCKC BLOCKA> [1]
 15       n15 (arm-empty) [1]
 17       n17 <put-down blockc>
 18       n18 <PUT-DOWN BLOCKC> [1]
 19     n19 <PICK-UP BLOCKA> [1]
 20   n20 <STACK BLOCKA BLOCKB> [1]
 21   n21 (on blockb blockc)
 23   n23 <stack blockb blockc>
 24     n24 (holding blockb)
 26     n26 <pick-up blockb>
 27       n27 (clear blockb)
 29       n29 <unstack blocka blockb> ...applying leads to state loop.

 19     n19 <PICK-UP BLOCKA> [1]
 20   n31 (on blockb blockc)
 22   n33 <stack blockb blockc>
 23     n34 (holding blockb)
 25     n36 <pick-up blockb>
 26       n37 (arm-empty)
 28       n39 <put-down blocka> ...applying leads to state loop.
 28       n42 <stack blocka blockc> [1]
 29       n43 <STACK BLOCKA BLOCKC>
 30     n44 <PICK-UP BLOCKB> [2]
 31     n45 (clear blockc) [2] ...hit depth bound (30)

 30     n44 <PICK-UP BLOCKB> [2]
 31     n46 (clear blockb) [1] ...hit depth bound (30)

 30     n44 <PICK-UP BLOCKB> [2]
 31     n47 (holding blocka) ...hit depth bound (30)

 29       n43 <STACK BLOCKA BLOCKC>
 30     n48 (clear blockc) [1] ...hit depth bound (30)

 29       n43 <STACK BLOCKA BLOCKC>
 30     n49 (holding blocka) ...hit depth bound (30)

 27       n41 stack
 28       n50 <stack blocka blockb>
 29       n51 <STACK BLOCKA BLOCKB>
 30       n52 (clear blockb) [1] ...hit depth bound (30)

 29       n51 <STACK BLOCKA BLOCKB>
 30     n53 (holding blocka) ...hit depth bound (30)

 18       n18 <PUT-DOWN BLOCKC> [1]
 19   n54 (on blockb blockc)
 21   n56 <stack blockb blockc>
 22     n57 (holding blockb)
 24     n59 <pick-up blockb>
 25     n60 <PICK-UP BLOCKB>
 26   n61 <STACK BLOCKB BLOCKC> [2]
 27     n62 <PICK-UP BLOCKA>
 27   n63 <STACK BLOCKA BLOCKB>
Achieved top-level goals.

Solution:
	<unstack blockc blocka>
	<put-down blockc>
	<pick-up blockb>
	<stack blockb blockc>
	<pick-up blocka>
	<stack blocka blockb>


(((:STOP . :ACHIEVE) .
  #<APPLIED-OP-NODE 63 #<STACK [<OB> BLOCKA] [<UNDEROB> BLOCKB]>>)
 #<UNSTACK [<OB> BLOCKC] [<UNDEROB> BLOCKA]> #<PUT-DOWN [<OB> BLOCKC]>
 #<PICK-UP [<OB1> BLOCKB]> #<STACK [<OB> BLOCKB] [<UNDEROB> BLOCKC]>
 #<PICK-UP [<OB1> BLOCKA]> #<STACK [<OB> BLOCKA] [<UNDEROB> BLOCKB]>) 

 Node: 36 has prerequisite violation on goal #<ARM-EMPTY>
 the subgoal chain is: ((#<OP: *FINISH*> #<ON BLOCKB BLOCKC> #<OP: STACK>
                         #<HOLDING BLOCKB>))
 Node: 26 has prerequisite violation on goal #<CLEAR BLOCKB>
 the subgoal chain is: ((#<OP: *FINISH*> #<ON BLOCKB BLOCKC> #<OP: STACK>
                         #<HOLDING BLOCKB>))
 Node: 30 has protection violation on goal (ON BLOCKA BLOCKB)
 the subgoal chain is: (NIL)
(CONTROL-RULE PREFER-ON4
	      (IF
	       (AND
		(CANDIDATE-GOAL (ON BLOCKB BLOCKC))
		(CANDIDATE-GOAL (ON BLOCKA BLOCKB))))
	      (THEN PREFER GOAL (ON BLOCKB BLOCKC) (ON BLOCKA BLOCKB)))

No rule learned from prerequisite violation (#<CLEAR BLOCKB> #<BINDING-NODE 26 #<PICK-UP [<OB1> BLOCKB]>>).
No rule learned from prerequisite violation (#<ARM-EMPTY> #<BINDING-NODE 36 #<PICK-UP [<OB1> BLOCKB]>>).
