(setf (current-problem)
      (create-problem
       (name drill2)
       (objects
        (object-is lathe1 LATHE)
	(object-is finish-toolbit1 FINISH-TOOLBIT)
        (object-is 4-jaw-chuck1 4-JAW-CHUCK)
	(object-is brush1 BRUSH)
	(object-is soluble-oil SOLUBLE-OIL)
	(object-is mineral-oil MINERAL-OIL)
	(object-is part10 PART))
       (state
	(and
	 (always-true)
	 (material-of part10 BRASS)
	 (size-of part10 LENGTH 5)
	 (size-of part10 DIAMETER 3.00001)))
       (goal
	((<part> PART))
	(size-of <part> DIAMETER 3))))