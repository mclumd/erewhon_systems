
(setf result '(
   (time 1.016)
   (nodes 49)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 11)
   (solution ((immovable-object monument) (go researcher georgiatech hartsfield atlanta)
              (can-fly-domestic researcher usa hartsfield atlanta dulles washington) (fly researcher hartsfield atlanta dulles washington)
              (can-fly-domestic researcher usa dulles washington hartsfield atlanta) (fly researcher dulles washington hartsfield atlanta)
              (go researcher hartsfield kingstavern atlanta) (go researcher kingstavern kinkos atlanta) (pick-up researcher akr kinkos)
              (go researcher kinkos hartsfield atlanta) (can-fly-domestic researcher usa hartsfield atlanta dulles washington)
              (fly researcher hartsfield atlanta dulles washington)))))

(setf problem-solved 
   "/afs/cs.cmu.edu/user/centaur/Research/Prodigy/analogy/domains/stinger/probs/compete-wc2")
(setf goal '((in-city-p researcher washington) (holding researcher akr)))

(setf case-objects '((usa country) (atlanta city) (hartsfield airport) (georgiatech location) (kinkos location) (postoffice location) (kingstavern location)
                     (washington city) (dulles airport) (statedept location) (mall location) (researcher person) (passport1 passport) (akr presentation)
                     (luggage1 luggage) (monument fixed)))

(setf insts-to-vars '(
   (usa . <country78>) 
   (atlanta . <city13>) 
   (hartsfield . <airport22>) 
   (georgiatech . <location4>) 
   (kinkos . <location80>) 
   (postoffice . <location83>) 
   (kingstavern . <location90>) 
   (washington . <city14>) 
   (dulles . <airport44>) 
   (statedept . <location52>) 
   (mall . <location64>) 
   (researcher . <person61>) 
   (passport1 . <passport71>) 
   (akr . <presentation14>) 
   (luggage1 . <luggage43>) 
   (monument . <fixed71>) 
))

(setf footprint-by-goal '(