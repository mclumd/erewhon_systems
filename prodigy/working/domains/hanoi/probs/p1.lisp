
(setf (current-problem)
      (create-problem
       (name p1)
       (objects
;	(object-is disk1 Disk)
	(objects-are peg1 peg2 Peg))
       (state
	(and (on disk1 peg1)))
       (igoal (on disk1 peg2))))