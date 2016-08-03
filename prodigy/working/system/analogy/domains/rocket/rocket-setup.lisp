
(defun guide2 ()
  (setf *analogical-replay* t
	*ui* t
	*talk-case-p* t
	*replay-cases*
	'(("case-prob1-robot" "case-obj2" ((at obj2 locb))
	   ((<r31> . r1) (<o77> . obj2) (<l15> . locb) (<l20> . loca)))
	  ("case-prob1-hammer" "case-obj1" ((at obj1 locb))
	   ((<r1> . r1) (<o44> . obj1) (<l54> . locb) (<l1> . <l1>))))))

(defun guide1 ()
  (setf *analogical-replay* t
	*ui* t
	*talk-case-p* t)
  (setf *replay-cases*
	'(("case-prob2objs" "case-prob2objs" ((at obj1 locb) (at obj2 locb))
	  ((<r95> . r1) (<o21> . obj2) (<o74> . obj1) (<l86> . locb) (<l45> . loca))))))

(guide2)



