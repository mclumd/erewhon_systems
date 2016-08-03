
(setf result '(
   (time 0.35)
   (nodes 95)
   (exhaustedp NIL)
   (solutionp T)
   (solution-length 6)
   (solution ((UNSTACK BLOCKC BLOCKA) (PUT-DOWN BLOCKC) (PICK-UP BLOCKB)
              (STACK BLOCKB BLOCKC) (PICK-UP BLOCKA) (STACK BLOCKA BLOCKB)))))

(setf problem-solved 
   "/usr/local/mcox/Research/ABMIC/Boris/domains/blocksworld/probs/sussman")
(setf goal '((ON BLOCKA BLOCKB) (ON BLOCKB BLOCKC)))

(setf case-objects '((BLOCKA BLOCKB BLOCKC OBJECT)))

(setf insts-to-vars '(
   (BLOCKA . <OBJECT.46>) (BLOCKB . <OBJECT.65>) (BLOCKC . <OBJECT.14>) 
))

(setf footprint-by-goal '(
   ((ON BLOCKB BLOCKC) (CLEAR BLOCKB) (ON-TABLE BLOCKB) (ARM-EMPTY)
    (CLEAR BLOCKC) (ON BLOCKC BLOCKA))
   ((ON BLOCKA BLOCKB) (ON-TABLE BLOCKB) (CLEAR BLOCKB) (ON-TABLE BLOCKA)
    (ARM-EMPTY) (CLEAR BLOCKC) (ON BLOCKC BLOCKA))))
