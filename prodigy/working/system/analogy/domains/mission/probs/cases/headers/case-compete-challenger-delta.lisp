
(setf result '(
   (time 0.117)
   (nodes 12)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 2)
   (solution ((drop-off alienbody roswell) (drop-off jfksbrain roswell)))))

(setf problem-solved 
   "/afs/cs.cmu.edu/user/centaur/Research/Prodigy/analogy/domains/mission/probs/compete-challenger-delta")
(setf goal '((dropped alienbody roswell) (dropped jfksbrain roswell)))

(setf case-objects '((area51 place) (roswell place) (alienbody secret)
                     (jfksbrain secret)))

(setf insts-to-vars '(
   (area51 . <place1>) 
   (roswell . <place9>) 
   (alienbody . <secret86>) 
   (jfksbrain . <secret29>) 
))

(setf footprint-by-goal '(
   ((dropped jfksbrain roswell) (at roswell) (holding jfksbrain))
   ((dropped alienbody roswell) (holding alienbody) (at roswell))))
