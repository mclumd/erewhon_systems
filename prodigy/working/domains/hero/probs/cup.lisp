;;;
;;; Similar to the domain of the hero robot.
;;;

(setf (current-problem)
      (create-problem
       (name 'cup)
       (objects
	(RobotHome CupSpot BinLocation Location)
	(Hero2000 Robot)
	(BigChiller Big-Chiller)
	(PaperBox Bin))
       (state
	(and (at Hero2000 RobotHome)
	     (at BigChiller CupSpot)
	     (at PaperBox BinLocation)
	     (arm-empty Hero2000)))
       (igoal (in-bin BigChiller PaperBox))))
