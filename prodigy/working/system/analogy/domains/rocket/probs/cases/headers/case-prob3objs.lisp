
(setf result '(
   (time 0.45)
   (nodes 32)
   (exhaustedp NIL)
   (solutionp T)
   (solution-length 7)
   (solution (((LOAD-ROCKET BLANCMANGE LOCA APOLLO)) ((LOAD-ROCKET ROBOT LOCA APOLLO))
              ((LOAD-ROCKET HAMMER LOCA APOLLO)) ((MOVE-ROCKET APOLLO))
              ((UNLOAD-ROCKET BLANCMANGE LOCB APOLLO)) ((UNLOAD-ROCKET ROBOT LOCB APOLLO))
              ((UNLOAD-ROCKET HAMMER LOCB APOLLO))))))

(setf goal '((AT HAMMER LOCB) (AT ROBOT LOCB) (AT BLANCMANGE LOCB)))
(setf initial-state '((AT APOLLO LOCA) (AT HAMMER LOCA) (AT ROBOT LOCA) (AT BLANCMANGE LOCA)))

(setf case-objects '((LOCA LOCB LOCATION) (HAMMER ROBOT BLANCMANGE OBJECT) (APOLLO ROCKET)))
(setf insts-to-vars '(
   (LOCA . <L81>) (LOCB . <L50>) 
   (HAMMER . <O37>) (ROBOT . <O64>) (BLANCMANGE . <O1>) 
   (APOLLO . <R9>) 
))

(setf footprint-by-goal '(
   ((AT BLANCMANGE LOCB) (AT BLANCMANGE LOCA) (AT APOLLO LOCA))
   ((AT ROBOT LOCB) (AT APOLLO LOCA) (AT ROBOT LOCA))
   ((AT HAMMER LOCB) (AT HAMMER LOCA) (AT APOLLO LOCA))))
