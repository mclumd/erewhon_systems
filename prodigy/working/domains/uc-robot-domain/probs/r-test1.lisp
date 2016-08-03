(setf (current-problem)
      (create-problem
       (name r-test1)
       (objects
	(rm1 rm2 location)
	(box1 box2 object))
       (state
	(and (connected rm1 rm2) (connected rm2 rm1)
	     (at box1 rm2) (at box2 rm2) (at robot rm1)
	     (empty-handed)))
       (goal (at box1 rm1))))



