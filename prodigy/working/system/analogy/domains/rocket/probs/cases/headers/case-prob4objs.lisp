
(setf result '(
   (time 0.583)
   (nodes 40)
   (exhaustedp NIL)
   (solutionp T)
   (solution-length 9)
   (solution ((LOAD-ROCKET BLANCMANGE LOCA APOLLO)
              (LOAD-ROCKET BOOK LOCA APOLLO)
              (LOAD-ROCKET ROBOT LOCA APOLLO)
              (LOAD-ROCKET HAMMER LOCA APOLLO) (MOVE-ROCKET APOLLO)
              (UNLOAD-ROCKET BLANCMANGE LOCB APOLLO)
              (UNLOAD-ROCKET BOOK LOCB APOLLO)
              (UNLOAD-ROCKET ROBOT LOCB APOLLO)
              (UNLOAD-ROCKET HAMMER LOCB APOLLO)))))

(setf problem-solved 
   "/usr/mmv/prodigy4.0/domains/rocket/probs/prob4objs")
(setf goal '((AT HAMMER LOCB) (AT ROBOT LOCB) (AT BOOK LOCB)
             (AT BLANCMANGE LOCB)))

(setf case-objects '((LOCA LOCB LOCATION)
                     (HAMMER ROBOT BLANCMANGE BOOK OBJECT)
                     (APOLLO ROCKET)))

(setf insts-to-vars '(
   (LOCA . <L81>) (LOCB . <L50>) 
   (HAMMER . <O37>) (ROBOT . <O64>) (BLANCMANGE . <O1>) (BOOK . <O9>) 
   (APOLLO . <R86>) 
))

(setf footprint-by-goal '(
   ((AT BLANCMANGE LOCB) (AT BLANCMANGE LOCA) (AT APOLLO LOCA))
   ((AT BOOK LOCB) (AT APOLLO LOCA) (AT BOOK LOCA))
   ((AT ROBOT LOCB) (AT ROBOT LOCA) (AT APOLLO LOCA))
   ((AT HAMMER LOCB) (AT APOLLO LOCA) (AT HAMMER LOCA))))
