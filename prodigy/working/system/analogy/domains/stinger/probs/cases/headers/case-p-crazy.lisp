
(setf result '(
   (time 0.383)
   (nodes 16)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 3)
   (solution ((immovable-object monument) (go researcher georgiatech hartsfield atlanta) (fly-domestic researcher usa hartsfield atlanta dulles washington)
              (launch researcher stinger1 dulles mall washington monument)))))

(setf problem-solved 
   "/afs/cs.cmu.edu/user/centaur/Research/Prodigy/domains/stinger/probs/p-crazy")
(setf goal '((destroyed monument)))

(setf case-objects '((usa country) (atlanta city) (hartsfield airport) (georgiatech location) (kingstavern location) (kinkos location) (postoffice location)
                     (washington city) (dulles airport) (mall location) (researcher person) (luggage1 luggage) (stinger1 stinger) (monument fixed)
                     (akr presentation) (passport1 passport)))

(setf insts-to-vars '(
   (usa . <country75>) 
   (atlanta . <city55>) 
   (hartsfield . <airport11>) 
   (georgiatech . <location93>) 
   (kingstavern . <location49>) 
   (kinkos . <location34>) 
   (postoffice . <location69>) 
   (washington . <city15>) 
   (dulles . <airport25>) 
   (mall . <location46>) 
   (researcher . <person87>) 
   (luggage1 . <luggage87>) 
   (stinger1 . <stinger41>) 
   (monument . <fixed54>) 
   (akr . <presentation48>) 
   (passport1 . <passport9>) 
))

(setf footprint-by-goal '(
   ((destroyed monument) (in-city-l hartsfield atlanta) (in-city-l georgiatech atlanta) (in-city-p researcher atlanta) (at-loc-p researcher georgiatech)
    (in-country atlanta usa) (in-city-l dulles washington) (in-country washington usa) (holding researcher stinger1) (in-city-l mall washington)
    (at-loc-o monument mall) (nationality researcher usa))))
