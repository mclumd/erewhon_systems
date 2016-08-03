
(setf result '(
   (time 0.367)
   (nodes 26)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 5)
   (solution ((break-in area51) (steal jfksbrain area51)
              (steal alienbody area51) (escape area51) (go area51 roswell)))))

(setf problem-solved 
   "/afs/cs.cmu.edu/user/centaur/Research/Prodigy/analogy/domains/mission/probs/compete-challenger")
(setf goal '((holding alienbody) (holding jfksbrain) (at roswell)))

(setf case-objects '((area51 place) (roswell place) (alienbody secret)
                     (jfksbrain secret)))

(setf insts-to-vars '(
   (area51 . <place77>) 
   (roswell . <place70>) 
   (alienbody . <secret10>) 
   (jfksbrain . <secret41>) 
))

(setf footprint-by-goal '(
   ((at roswell) (pass area51 roswell) (insecure area51) (at area51))
   ((holding jfksbrain) (stored jfksbrain area51) (insecure area51)
    (at area51))
   ((holding alienbody) (stored alienbody area51) (insecure area51)
    (at area51))))
