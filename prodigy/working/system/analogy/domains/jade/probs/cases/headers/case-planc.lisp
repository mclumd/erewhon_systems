
(setf result '(
   (time 0.833)
   (nodes 32)
   (exhaustedp nil)
   (solutionp t)
   (solution-length 7)
   (solution ((send saudi-arabia weapons-smuggling2 security-police-b) (send saudi-arabia weapons-smuggling2 hawka)
              (send saudi-arabia weapons-smuggling2 infantry-battalion-a) (secure saudi-arabia airport3 security-police-b hawka infantry-battalion-a)
              (deploy f15-c-squadron saudi-arabia airport3) (send saudi-arabia weapons-smuggling2 division-ready-brigade)
              (send saudi-arabia weapons-smuggling2 dog-team2)))))

(setf problem-solved 
   "/afs/cs/user/mcox/prodigy/domains/jade/probs/planc")
(setf goal '((is-deployed f15-c-squadron saudi-arabia) (airport-secure-at saudi-arabia airport3)
             (exists ((|<brigade.587>| brigade)) (is-deployed |<brigade.587>| saudi-arabia)) (is-deployed hawka saudi-arabia) (is-deployed dog-team2 saudi-arabia)
             (is-deployed security-police-b saudi-arabia)))

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
   (25th-infantry-division-light . <infantry.53>) 
   (a10a-a-squadron . <a10a.97>) (a10a-b-squadron . <a10a.98>) (a10a-c-squadron . <a10a.24>) 
   (enemy . <enemy-ground-unit.95>) 
   (special-forces-a . <special-force-module.10>) (magtf-meu-gce . <special-force-module.99>) (special-operation-force . <special-force-module.88>) 
   (tfs2 . <group-unit.27>) (tfs3 . <group-unit.57>) 
   (air-interdiction . <mission-name.55>) (air-superiority . <mission-name.49>) (close-air-support . <mission-name.42>) (counter-air . <mission-name.27>) 
   (weapons-smuggling . <threat.22>) (terrorism . <threat.38>) 
   (terrorism1 . <terrorism.85>) (terrorism2 . <terrorism.54>) (terrorism3 . <terrorism.14>) 
   (weapons-smuggling1 . <weapons-smuggling.13>) (weapons-smuggling2 . <weapons-smuggling.38>) 
   (air-force-module . <force-module.30>) 
   (f15-a-squadron . <f15.45>) (f15-b-squadron . <f15.10>) (f15-c-squadron . <f15.48>) 
   (f16-a-squadron . <f16.65>) (f16-b-squadron . <f16.91>) (f16-c-squadron . <f16.37>) 
   (dog-team1 . <dog-team.56>) 
   (dog-team2 . <dog-team.98>) 
   (security-police-a . <security-police.38>) 
   (security-police-b . <security-police.28>) 
   (airport1 . <airport.67>) (airport2 . <airport.73>) (airport3 . <airport.65>) (airport4 . <airport.15>) (airport5 . <airport.54>) (airport6 . <airport.60>) 
   (town-center1 . <town-center.84>) (town-center2 . <town-center.3>) 
   (bosnia-and-herzegovina . <country.75>) (saudi-arabia . <country.71>) (korea-south . <country.41>) (sri-lanka . <country.89>) (kuwait . <country.83>) (pacifica
                                                                                                                                                          . <country.49>) 
   (bd1 . <brigade.17>) (bd2 . <brigade.88>) (brigade-task-force . <brigade.62>) (engineering-brigade . <brigade.46>) (division-ready-brigade . <brigade.80>) 
   (military-police-a . <military-police.1>) 
   (hawka . <hawk-battalion.86>) 
   (infantry-battalion-a . <infantry-battalion.86>) 
   (police-a . <police-force-module.38>) 
   (f15 . <tactical-fighter.15>) (f16 . <tactical-fighter.41>) (a10a . <tactical-fighter.33>) 
))

(setf footprint-by-goal '(
   ((is-deployed security-police-b saudi-arabia) (~ (threat-at weapons-smuggling2 saudi-arabia)) (is-active security-police-b))
   ((is-deployed dog-team2 saudi-arabia) (~ (threat-at weapons-smuggling2 saudi-arabia)) (is-active dog-team2))
   ((is-deployed hawka saudi-arabia) (is-active hawka) (~ (threat-at weapons-smuggling2 saudi-arabia)))
   ((exists ((|<brigade.587>| brigade)) (is-deployed |<brigade.587>| saudi-arabia)) (exists ((|<brigade.587>| brigade)) (is-deployed |<brigade.587>| saudi-arabia)))
   ((airport-secure-at saudi-arabia airport3) (is-active hawka) (is-active infantry-battalion-a) (loc-at airport3 saudi-arabia)
    (~ (threat-at weapons-smuggling2 saudi-arabia)) (is-active security-police-b))
   ((is-deployed f15-c-squadron saudi-arabia) (is-active hawka) (is-active infantry-battalion-a) (is-usable airport3) (is-active f15-c-squadron)
    (~ (isa-c141 f15-c-squadron)) (loc-at airport3 saudi-arabia) (~ (threat-at weapons-smuggling2 saudi-arabia)) (is-active security-police-b))))
