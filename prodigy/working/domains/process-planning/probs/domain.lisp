
(create-problem-space 'ai-sched :current t)

(ptype-of Part :Top-Type)

(ptype-of Machine :Top-Type)
(ptype-of Polisher Machine)
(ptype-of Spray-Painter Machine)
(ptype-of Drill-Press Machine)
(ptype-of Bolting-Machine Machine)

(ptype-of Time :Top-Type)

(ptype-of Surface-Condition :Top-Type)
(pinstance-of polished painted unknown Surface-Condition)

(OPERATOR POLISH
 (params <part> <prev-time-p> <machine> <time-p>)
 (preconds 
  ((<part> PART)
   (<machine> POLISHER)
   (<prev-time-p> TIME)
   (<time-p> (and TIME (later <time-p> <prev-time-p>))))
  (and (~ (busy <machine> <time-p>))
       (last-scheduled <part> <prev-time-p>)))
 (effects
  ((<surface> Surface-Condition))
  ((del (surface-condition <part> <surface>))
   (add (surface-condition <part> polished))
   (del (last-scheduled <part> <prev-time-p>))
   (add (last-scheduled <part> <time-p>))
   (add (busy <machine> <time-p>)))))

(OPERATOR PAINT
 (params <part> <prev-time-p> <machine> <time-p>)
 (preconds 
  ((<part> PART)
   (<machine> SPRAY-PAINTER)
   (<prev-time-p> TIME)
   (<time-p> (and TIME (later <time-p> <prev-time-p>))))
  (and (~ (busy <machine> <time-p>))
       (last-scheduled <part> <prev-time-p>)))
 (effects
  ()
  ((add (surface-condition <part> painted))
   (del (last-scheduled <part> <prev-time-p>))
   (add (last-scheduled <part> <time-p>))
   (add (busy <machine> <time-p>)))))

(OPERATOR DRILL
 (params <part> <prev-time-p> <machine> <time-p>)
 (preconds 
  ((<part> PART)
   (<machine> DRILL-PRESS)
   (<prev-time-p> TIME)
   (<time-p> (and TIME (later <time-p> <prev-time-p>))))
  (and (~ (busy <machine> <time-p>))
       (last-scheduled <part> <prev-time-p>)))
 (effects
  ((<surface> Surface-Condition))
  ((del (surface-condition <part> <surface>))
   (add (has-hole <part>))
   (del (last-scheduled <part> <prev-time-p>))
   (add (last-scheduled <part> <time-p>))
   (add (busy <machine> <time-p>)))))

(OPERATOR BOLT
 (params <part1> <prev-time1-p> <part2> <prev-time2-p>
	 <machine> <time-p>)
 (preconds 
  ((<part1> PART)
   (<part2> PART)
   (<machine> BOLTING-MACHINE)
   (<prev-time1-p> TIME)
   (<prev-time2-p> TIME)
   (<time-p> (and TIME
		  (later <time-p> <prev-time1-p>)
		  (later <time-p> <prev-time2-p>))))
  (and (has-hole <part1>)
       (has-hole <part2>)
       (~ (busy <machine> <time-p>))
       (last-scheduled <part1> <prev-time1-p>)
       (last-scheduled <part2> <prev-time2-p>)))
 (effects
  ()
  ((add (joined <part1> <part2>))
   (del (last-scheduled <part1> <prev-time1-p>))
   (add (last-scheduled <part1> <time-p>))
   (del (last-scheduled <part2> <prev-time2-p>))
   (add (last-scheduled <part2> <time-p>))
   (add (busy <machine> <time-p>)))))

(defun later (time1 time2)
  (> (read-from-string (subseq (string (p4::prodigy-object-name time1)) 1))
     (read-from-string (subseq (string (p4::prodigy-object-name time2)) 1))))
