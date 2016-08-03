
(setf result '(
   (time 1.283)
   (nodes 32)
   (exhaustedp NIL)
   (solutionp T)
   (solution-length 7)
   (solution ((LOAD-ROCKET OBJ3 LOCA R1) (LOAD-ROCKET OBJ2 LOCA R1)
              (LOAD-ROCKET OBJ1 LOCA R1) (MOVE-ROCKET R1)
              (UNLOAD-ROCKET OBJ3 LOCB R1) (UNLOAD-ROCKET OBJ2 LOCB R1)
              (UNLOAD-ROCKET OBJ1 LOCB R1)))))

(setf problem-solved 
   "/afs/cs/project/prodigy-1/analogy/domains/rocket/probs/prob3objs-3")
(setf goal '((AT OBJ1 LOCB) (AT OBJ2 LOCB) (AT OBJ3 LOCB)))

(setf case-objects '((LOCA LOCB LOCATION) (OBJ1 OBJ2 OBJ3 OBJECT) (R1 ROCKET)))

(setf insts-to-vars '(
   (LOCA . <L81>) (LOCB . <L50>) 
   (OBJ1 . <O37>) (OBJ2 . <O64>) (OBJ3 . <O1>) 
   (R1 . <R9>) 
))

(setf footprint-by-goal '(
   ((AT OBJ3 LOCB) (AT OBJ3 LOCA) (AT R1 LOCA))
   ((AT OBJ2 LOCB) (AT R1 LOCA) (AT OBJ2 LOCA))
   ((AT OBJ1 LOCB) (AT OBJ1 LOCA) (AT R1 LOCA))))
