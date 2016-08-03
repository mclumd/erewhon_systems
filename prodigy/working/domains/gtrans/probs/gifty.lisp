(SETF (CURRENT-PROBLEM)
      (CREATE-PROBLEM (NAME PROD-FORMAT.0)
                      (OBJECTS (OBJECT-IS TOWN1 TOWN) (OBJECT-IS AIRPORT1 AIRPORT) (OBJECT-IS AIRPORT2 AIRPORT)
                       (OBJECT-IS BRIDGE1 BRIDGE) (OBJECT-IS BRIDGE2 BRIDGE) (OBJECT-IS RIVER1 RIVER)
                       (OBJECT-IS POLICE1 POLICE) 
                       (OBJECTS-ARE F151 F152 F15)
                       
                       (OBJECT-IS INFANTRY1 INFANTRY))
                      (STATE (AND  (IS-READY F151) 
                              (ENABLES-MOVEMENT-OVER BRIDGE1 RIVER1) 
                             (ENABLES-MOVEMENT-OVER BRIDGE2 RIVER1)
                                  (NEAR AIRPORT2 RIVER1) (NEAR AIRPORT1 RIVER1) (LESS-BY-1 2 1) (LESS-BY-1 1 0)
                                  (MORE-THAN DECISIVE-VICTORY MARGINAL-VICTORY)
                                  (MORE-THAN MARGINAL-VICTORY STALEMATE) (MORE-THAN STALEMATE MARGINAL-DEFEAT)
                                  (MORE-THAN MARGINAL-DEFEAT DECISIVE-DEFEAT) (IS-USABLE AIRPORT2)
                                  (IS-USABLE AIRPORT1) (IS-READY POLICE1) 
                                
                                  (IS-READY F152)
                                  (IS-READY INFANTRY1)))
                      (GOAL (AND (OUTCOME-IMPASSABLE RIVER1)))))