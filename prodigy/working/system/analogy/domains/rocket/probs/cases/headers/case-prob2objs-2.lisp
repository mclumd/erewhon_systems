
(setf result '(
   (time 0.267)
   (nodes 24)
   (exhaustedp NIL)
   (solutionp T)
   (solution-length 5)
   (solution ((LOAD-ROCKET OBJ2 LOCA R1) (LOAD-ROCKET OBJ1 LOCA R1) (MOVE-ROCKET R1)
              (UNLOAD-ROCKET OBJ2 LOCB R1) (UNLOAD-ROCKET OBJ1 LOCB R1)))))

(setf problem-solved 
   "/usr/mmv/prodigy4.0/domains/rocket/probs/prob2objs-2")
(setf goal '((AT OBJ1 LOCB) (AT OBJ2 LOCB)))

(setf case-objects '((LOCA LOCB LOCC LOCD LOCE LOCF LOCG LOCH LOCI LOCJ LOCATION)
                     (OBJ1 OBJ2 OBJECT) (R1 ROCKET)))

(setf insts-to-vars '(
   (LOCA . <L81>) (LOCB . <L50>) (LOCC . <L37>) (LOCD . <L64>) (LOCE . <L1>) (LOCF . <L9>) (LOCG
                                                                                            . <L86>) (LOCH
                                                                                                      . <L29>) (LOCI
                                                                                                                . <L66>) (LOCJ
                                                                                                                          . <L22>) 
   (OBJ1 . <O65>) (OBJ2 . <O72>) 
   (R1 . <R20>) 
))

(setf footprint-by-goal '(
   ((AT OBJ2 LOCB) (AT OBJ2 LOCA) (AT R1 LOCA))
   ((AT OBJ1 LOCB) (AT R1 LOCA) (AT OBJ1 LOCA))))
