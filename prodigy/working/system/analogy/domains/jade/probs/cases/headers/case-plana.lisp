
(setf result '(
   (time 0.433)
   (nodes 24)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 5)
   (solution ((send saudi-arabia weapons-smuggling2 security-police-b) (send saudi-arabia weapons-smuggling2 hawka)
              (send saudi-arabia weapons-smuggling2 infantry-battalion-a) (secure saudi-arabia airport3 security-police-b hawka infantry-battalion-a)
              (deploy f15-c-squadron saudi-arabia airport3)))))

(setf problem-solved 
   "/afs/cs/user/mcox/prodigy/domains/jade/probs/plana")
(setf goal '((is-deployed f15-c-squadron saudi-arabia) (airport-secure-at saudi-arabia airport3) (is-deployed infantry-battalion-a saudi-arabia)
             (is-deployed hawka saudi-arabia) (is-deployed security-police-b saudi-arabia)))

(setf case-objects '((object-is 25th-infantry-division-light infantry) (objects-are a10a-a-squadron a10a-b-squadron a10a-c-squadron a10a)
                     (object-is enemy enemy-ground-unit) (objects-are special-forces-a magtf-meu-gce special-operation-force special-force-module)
                     (objects-are tfs2 tfs3 group-unit) (objects-are air-interdiction air-superiority close-air-support counter-air mission-name)
                     (objects-are weapons-smuggling terrorism threat) (objects-are terrorism1 terrorism2 terrorism3 terrorism)
                     (objects-are weapons-smuggling1 weapons-smuggling2 weapons-smuggling) (object-is air-force-module force-module)
                     (objects-are f15-a-squadron f15-b-squadron f15-c-squadron f15) (objects-are f16-a-squadron f16-b-squadron f16-c-squadron f16)
                     (object-is dog-team1 dog-team) (object-is dog-team2 dog-team) (object-is security-police-a security-police)
                     (object-is security-police-b security-police) (objects-are airport1 airport2 airport3 airport4 airport5 airport6 airport)
                     (objects-are town-center1 town-center2 town-center) (objects-are bosnia-and-herzegovina saudi-arabia korea-south sri-lanka kuwait pacifica country)
                     (objects-are bd1 bd2 brigade-task-force engineering-brigade division-ready-brigade brigade) (object-is military-police-a military-police)
                     (object-is hawka hawk-battalion) (object-is infantry-battalion-a infantry-battalion) (object-is police-a police-force-module)
                     (objects-are f15 f16 a10a tactical-fighter)))

(setf insts-to-vars '(
   (25th-infantry-division-light . <infantry.35>) 
   (a10a-a-squadron . <a10a.32>) (a10a-b-squadron . <a10a.96>) (a10a-c-squadron . <a10a.19>) 
   (enemy . <enemy-ground-unit.26>) 
   (special-forces-a . <special-force-module.91>) (magtf-meu-gce . <special-force-module.42>) (special-operation-force . <special-force-module.35>) 
   (tfs2 . <group-unit.52>) (tfs3 . <group-unit.83>) 
   (air-interdiction . <mission-name.10>) (air-superiority . <mission-name.35>) (close-air-support . <mission-name.73>) (counter-air . <mission-name.93>) 
   (weapons-smuggling . <threat.24>) (terrorism . <threat.55>) 
   (terrorism1 . <terrorism.20>) (terrorism2 . <terrorism.23>) (terrorism3 . <terrorism.81>) 
   (weapons-smuggling1 . <weapons-smuggling.69>) (weapons-smuggling2 . <weapons-smuggling.37>) 
   (air-force-module . <force-module.36>) 
   (f15-a-squadron . <f15.72>) (f15-b-squadron . <f15.24>) (f15-c-squadron . <f15.74>) 
   (f16-a-squadron . <f16.1>) (f16-b-squadron . <f16.79>) (f16-c-squadron . <f16.7>) 
   (dog-team1 . <dog-team.69>) 
   (dog-team2 . <dog-team.89>) 
   (security-police-a . <security-police.14>) 
   (security-police-b . <security-police.49>) 
   (airport1 . <airport.16>) (airport2 . <airport.82>) (airport3 . <airport.51>) (airport4 . <airport.1>) (airport5 . <airport.45>) (airport6 . <airport.78>) 
   (town-center1 . <town-center.13>) (town-center2 . <town-center.22>) 
   (bosnia-and-herzegovina . <country.4>) (saudi-arabia . <country.80>) (korea-south . <country.83>) (sri-lanka . <country.90>) (kuwait . <country.14>) (pacifica
                                                                                                                                                         . <country.44>) 
   (bd1 . <brigade.52>) (bd2 . <brigade.64>) (brigade-task-force . <brigade.61>) (engineering-brigade . <brigade.71>) (division-ready-brigade . <brigade.14>) 
   (military-police-a . <military-police.43>) 
   (hawka . <hawk-battalion.71>) 
   (infantry-battalion-a . <infantry-battalion.39>) 
   (police-a . <police-force-module.89>) 
   (f15 . <tactical-fighter.19>) (f16 . <tactical-fighter.39>) (a10a . <tactical-fighter.29>) 
))

(setf footprint-by-goal '(
   ((is-deployed security-police-b saudi-arabia) (~ (threat-at weapons-smuggling2 saudi-arabia)) (is-active security-police-b))
   ((is-deployed hawka saudi-arabia) (is-active hawka) (~ (threat-at weapons-smuggling2 saudi-arabia)))
   ((is-deployed infantry-battalion-a saudi-arabia) (~ (threat-at weapons-smuggling2 saudi-arabia)) (is-active infantry-battalion-a))
   ((airport-secure-at saudi-arabia airport3) (is-active hawka) (is-active infantry-battalion-a) (loc-at airport3 saudi-arabia)
    (~ (threat-at weapons-smuggling2 saudi-arabia)) (is-active security-police-b))
   ((is-deployed f15-c-squadron saudi-arabia) (is-active hawka) (is-active infantry-battalion-a) (is-usable airport3) (is-active f15-c-squadron)
    (~ (isa-c141 f15-c-squadron)) (loc-at airport3 saudi-arabia) (~ (threat-at weapons-smuggling2 saudi-arabia)) (is-active security-police-b))))
