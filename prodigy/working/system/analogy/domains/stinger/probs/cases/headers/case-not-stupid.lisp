
(setf result '(
   (time 0.233)
   (nodes 11)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 2)
   (solution ((launch researcher stinger1 georgiatech kingstavern atlanta) (explode-conventional stinger1 kingstavern)))))

(setf problem-solved 
   "/afs/cs.cmu.edu/user/centaur/Research/Prodigy/domains/stinger/probs/not-stupid")
(setf goal '((destroyed luggage1)))

(setf case-objects '((usa country) (atlanta city) (hartsfield airport) (georgiatech location) (kinkos location) (postoffice location) (kingstavern location)
                     (boston city) (bostonport airport) (copyservice location) (washington city) (dulles airport) (statedept location) (mall location)
                     (whitesands city) (airbase airport) (uk country) (london city) (gatwick airport) (bigben location) (inverness city) (lochness location)
                     (greece country) (iraklion city) (tinyport airport) (forth location) (researcher person) (passport1 passport) (akr presentation)
                     (luggage1 luggage) (stinger1 stinger) (monument object)))

(setf insts-to-vars '(
   (usa . <country39>) 
   (atlanta . <city25>) 
   (hartsfield . <airport32>) 
   (georgiatech . <location79>) 
   (kinkos . <location37>) 
   (postoffice . <location9>) 
   (kingstavern . <location73>) 
   (boston . <city91>) 
   (bostonport . <airport93>) 
   (copyservice . <location64>) 
   (washington . <city64>) 
   (dulles . <airport64>) 
   (statedept . <location2>) 
   (mall . <location53>) 
   (whitesands . <city26>) 
   (airbase . <airport22>) 
   (uk . <country37>) 
   (london . <city3>) 
   (gatwick . <airport99>) 
   (bigben . <location2>) 
   (inverness . <city37>) 
   (lochness . <location58>) 
   (greece . <country40>) 
   (iraklion . <city36>) 
   (tinyport . <airport98>) 
   (forth . <location16>) 
   (researcher . <person19>) 
   (passport1 . <passport92>) 
   (akr . <presentation85>) 
   (luggage1 . <luggage1>) 
   (stinger1 . <stinger60>) 
   (monument . <object76>) 
))

(setf footprint-by-goal '(
   ((destroyed luggage1) (at-loc-o luggage1 kingstavern) (in-city-l kingstavern atlanta) (in-city-l georgiatech atlanta) (holding researcher stinger1)
    (at-loc-p researcher georgiatech))))
