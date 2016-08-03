
(setf result '(
   (time 1.317)
   (nodes 61)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 14)
   (solution ((go researcher georgiatech hartsfield atlanta) (can-fly-domestic researcher usa hartsfield atlanta dulles washington)
              (fly researcher hartsfield atlanta dulles washington) (go researcher dulles convention washington)
              (go researcher convention dulles washington) (can-fly-domestic researcher usa dulles washington hartsfield atlanta)
              (fly researcher dulles washington hartsfield atlanta) (go researcher hartsfield kingstavern atlanta)
              (go researcher kingstavern kinkos atlanta) (pick-up researcher akr kinkos) (go researcher kinkos hartsfield atlanta)
              (can-fly-domestic researcher usa hartsfield atlanta dulles washington) (fly researcher hartsfield atlanta dulles washington)
              (go researcher dulles convention washington)))))

(setf problem-solved 
   "/afs/cs.cmu.edu/user/centaur/Research/Prodigy/analogy/domains/stinger/probs/domestic-conference")
(setf goal '((at-loc-p researcher convention) (holding researcher akr)))

(setf case-objects '((usa country) (atlanta city) (hartsfield airport) (georgiatech location) (kinkos location) (postoffice location) (kingstavern location)
                     (washington city) (dulles airport) (convention location) (researcher person) (passport1 passport) (akr presentation) (luggage1 luggage)
                     (stinger1 stinger)))

(setf insts-to-vars '(
   (usa . <country39>) 
   (atlanta . <city89>) 
   (hartsfield . <airport19>) 
   (georgiatech . <location39>) 
   (kinkos . <location29>) 
   (postoffice . <location2>) 
   (kingstavern . <location81>) 
   (washington . <city62>) 
   (dulles . <airport39>) 
   (convention . <location14>) 
   (researcher . <person16>) 
   (passport1 . <passport89>) 
   (akr . <presentation97>) 
   (luggage1 . <luggage57>) 
   (stinger1 . <stinger17>) 
))

(setf footprint-by-goal '(
   ((holding researcher akr) (nationality researcher usa) (in-city-l convention washington) (in-city-l kinkos atlanta) (~ (immobile akr))
    (at-loc-o akr kinkos) (in-city-l kingstavern atlanta) (~ (air-security usa high)) (in-country washington usa) (in-city-l dulles washington)
    (in-country atlanta usa) (at-loc-p researcher georgiatech) (in-city-p researcher atlanta) (in-city-l georgiatech atlanta) (in-city-l hartsfield atlanta))
   ((at-loc-p researcher convention) (nationality researcher usa) (in-city-l convention washington) (in-city-l kinkos atlanta)
    (in-city-l kingstavern atlanta) (~ (air-security usa high)) (in-country washington usa) (in-city-l dulles washington) (in-country atlanta usa)
    (at-loc-p researcher georgiatech) (in-city-p researcher atlanta) (in-city-l georgiatech atlanta) (in-city-l hartsfield atlanta))))
