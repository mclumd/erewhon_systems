 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 25th-id-division-ready-brigade bosnia-and-herzegovina))
              (p4::instantiate-consed-literal '(is-suppressed terrorism1 bosnia-and-herzegovina))
              (p4::instantiate-consed-literal '(is-deployed a10a-c-squadron korea-south))
              (p4::instantiate-consed-literal '(is-deployed f117-squadron korea-south))
              (p4::instantiate-consed-literal '(is-deployed f16-b-squadron korea-south))
              (p4::instantiate-consed-literal '(air-blockaded korea-south carrier-air-wing-9))
              (p4::instantiate-consed-literal '(air-defended korea-south 18th-wing))
              (p4::instantiate-consed-literal '(is-sovereign korea-south 11-meu-soc))
              (p4::instantiate-consed-literal '(airport-secure-at sri-lanka airport1))
              (p4::instantiate-consed-literal '(is-medically-assisted sri-lanka 45th-support-group)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator p4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 25th-id-division-ready-brigade bosnia-and-herzegovina))
              (p4::instantiate-consed-literal '(is-suppressed terrorism1 bosnia-and-herzegovina))
              (p4::instantiate-consed-literal '(is-deployed a10a-c-squadron korea-south))
              (p4::instantiate-consed-literal '(is-deployed f117-squadron korea-south))
              (p4::instantiate-consed-literal '(is-deployed f16-b-squadron korea-south))
              (p4::instantiate-consed-literal '(air-blockaded korea-south carrier-air-wing-9))
              (p4::instantiate-consed-literal '(air-defended korea-south 18th-wing))
              (p4::instantiate-consed-literal '(is-sovereign korea-south 11-meu-soc))
              (p4::instantiate-consed-literal '(airport-secure-at sri-lanka airport1))
              (p4::instantiate-consed-literal '(is-medically-assisted sri-lanka 45th-support-group)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed 25th-id-division-ready-brigade bosnia-and-herzegovina)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 25th-id-division-ready-brigade))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 bosnia-and-herzegovina))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'bosnia-and-herzegovina *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '25th-id-division-ready-brigade *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 25th-id-division-ready-brigade))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 bosnia-and-herzegovina))))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-applied-op-node 
        :name 8 
        :parent (find-node 7)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 8))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'bosnia-and-herzegovina *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '25th-id-division-ready-brigade *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 25th-id-division-ready-brigade))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 bosnia-and-herzegovina))))))

(setf (p4::a-or-b-node-applied (find-node 8))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 8))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed 25th-id-division-ready-brigade bosnia-and-herzegovina))))))
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-goal-node 
        :name 9 
        :parent (find-node 8) 
        :goal 
            (p4::instantiate-consed-literal '(is-suppressed terrorism1 bosnia-and-herzegovina)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-operator-node 
        :name 10 
        :parent (find-node 9) 
        :operator (p4::get-operator suppress))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-binding-node 
        :name 11 
        :parent (find-node 10)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 25th-id-division-ready-brigade bosnia-and-herzegovina))
              (p4::instantiate-consed-literal '(is-deployed 11-meu-soc bosnia-and-herzegovina))
              (p4::instantiate-consed-literal '(is-deployed security-police-a bosnia-and-herzegovina))
              (p4::instantiate-consed-literal '(threat-at terrorism1 bosnia-and-herzegovina)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 11))
      (p4::make-instantiated-op
          :op (p4::get-operator suppress)
          :binding-node-back-pointer (find-node 11)
          :values (list 
                    (p4::object-name-to-object 'bosnia-and-herzegovina *current-problem-space*)
                    (p4::object-name-to-object '25th-id-division-ready-brigade *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*)
                    (p4::object-name-to-object 'terrorism1 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 25th-id-division-ready-brigade bosnia-and-herzegovina))
              (p4::instantiate-consed-literal '(is-deployed 11-meu-soc bosnia-and-herzegovina))
              (p4::instantiate-consed-literal '(is-deployed security-police-a bosnia-and-herzegovina))
              (p4::instantiate-consed-literal '(threat-at terrorism1 bosnia-and-herzegovina)))))
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-goal-node 
        :name 12 
        :parent (find-node 11) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed 11-meu-soc bosnia-and-herzegovina)) 
        :introducing-operators (list (find-node 11) )))) 
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-operator-node 
        :name 13 
        :parent (find-node 12) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-binding-node 
        :name 14 
        :parent (find-node 13)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 11-meu-soc))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 bosnia-and-herzegovina))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 14))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 14)
          :values (list 
                    (p4::object-name-to-object 'bosnia-and-herzegovina *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 11-meu-soc))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 bosnia-and-herzegovina))))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-applied-op-node 
        :name 15 
        :parent (find-node 14)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 15))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 14)
          :values (list 
                    (p4::object-name-to-object 'bosnia-and-herzegovina *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 11-meu-soc))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 bosnia-and-herzegovina))))))

(setf (p4::a-or-b-node-applied (find-node 15))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 15))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed 11-meu-soc bosnia-and-herzegovina))))))
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-goal-node 
        :name 16 
        :parent (find-node 15) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed security-police-a bosnia-and-herzegovina)) 
        :introducing-operators (list (find-node 11) )))) 
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-operator-node 
        :name 17 
        :parent (find-node 16) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-binding-node 
        :name 18 
        :parent (find-node 17)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 bosnia-and-herzegovina))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 18))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 18)
          :values (list 
                    (p4::object-name-to-object 'bosnia-and-herzegovina *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 bosnia-and-herzegovina))))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-applied-op-node 
        :name 19 
        :parent (find-node 18)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 19))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 18)
          :values (list 
                    (p4::object-name-to-object 'bosnia-and-herzegovina *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 bosnia-and-herzegovina))))))

(setf (p4::a-or-b-node-applied (find-node 19))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 19))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed security-police-a bosnia-and-herzegovina))))))
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-applied-op-node 
        :name 20 
        :parent (find-node 19)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 20))
      (p4::make-instantiated-op
          :op (p4::get-operator suppress)
          :binding-node-back-pointer (find-node 11)
          :values (list 
                    (p4::object-name-to-object 'bosnia-and-herzegovina *current-problem-space*)
                    (p4::object-name-to-object '25th-id-division-ready-brigade *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*)
                    (p4::object-name-to-object 'terrorism1 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 25th-id-division-ready-brigade bosnia-and-herzegovina))
              (p4::instantiate-consed-literal '(is-deployed 11-meu-soc bosnia-and-herzegovina))
              (p4::instantiate-consed-literal '(is-deployed security-police-a bosnia-and-herzegovina))
              (p4::instantiate-consed-literal '(threat-at terrorism1 bosnia-and-herzegovina)))))

(setf (p4::a-or-b-node-applied (find-node 20))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 20))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-suppressed terrorism1 bosnia-and-herzegovina))))))
 
(setf (p4::nexus-children (find-node 20))
  (list
    (p4::make-goal-node 
        :name 21 
        :parent (find-node 20) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed a10a-c-squadron korea-south)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 21))
  (list
    (p4::make-operator-node 
        :name 22 
        :parent (find-node 21) 
        :operator (p4::get-operator deploy))))
 
(setf (p4::nexus-children (find-node 22))
  (list
    (p4::make-binding-node 
        :name 23 
        :parent (find-node 22)
        :instantiated-preconds 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 a10a-c-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active a10a-c-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 23))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 23)
          :values (list 
                    (p4::object-name-to-object 'a10a-c-squadron *current-problem-space*)
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'airport2 *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 a10a-c-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active a10a-c-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))
 
(setf (p4::nexus-children (find-node 23))
  (list
    (p4::make-goal-node 
        :name 24 
        :parent (find-node 23) 
        :goal 
            (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2)) 
        :introducing-operators (list (find-node 23) )))) 
 
(setf (p4::nexus-children (find-node 24))
  (list
    (p4::make-operator-node 
        :name 25 
        :parent (find-node 24) 
        :operator (p4::get-operator secure))))
 
(setf (p4::nexus-children (find-node 25))
  (list
    (p4::make-binding-node 
        :name 26 
        :parent (find-node 25)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-deployed security-police-a korea-south))
              (p4::instantiate-consed-literal '(is-deployed hawka korea-south))
              (p4::instantiate-consed-literal '(is-deployed 25th-id korea-south)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 26))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 26)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'airport2 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object '25th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-deployed security-police-a korea-south))
              (p4::instantiate-consed-literal '(is-deployed hawka korea-south))
              (p4::instantiate-consed-literal '(is-deployed 25th-id korea-south)))))
 
(setf (p4::nexus-children (find-node 26))
  (list
    (p4::make-goal-node 
        :name 27 
        :parent (find-node 26) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed security-police-a korea-south)) 
        :introducing-operators (list (find-node 26) )))) 
 
(setf (p4::nexus-children (find-node 27))
  (list
    (p4::make-operator-node 
        :name 28 
        :parent (find-node 27) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 28))
  (list
    (p4::make-binding-node 
        :name 29 
        :parent (find-node 28)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 29)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))
 
(setf (p4::nexus-children (find-node 29))
  (list
    (p4::make-applied-op-node 
        :name 30 
        :parent (find-node 29)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 30))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 29)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))

(setf (p4::a-or-b-node-applied (find-node 30))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 30))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed security-police-a korea-south))))))
 
(setf (p4::nexus-children (find-node 30))
  (list
    (p4::make-goal-node 
        :name 31 
        :parent (find-node 30) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed hawka korea-south)) 
        :introducing-operators (list (find-node 26) )))) 
 
(setf (p4::nexus-children (find-node 31))
  (list
    (p4::make-operator-node 
        :name 32 
        :parent (find-node 31) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 32))
  (list
    (p4::make-binding-node 
        :name 33 
        :parent (find-node 32)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 33))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 33)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))
 
(setf (p4::nexus-children (find-node 33))
  (list
    (p4::make-applied-op-node 
        :name 34 
        :parent (find-node 33)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 34))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 33)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))

(setf (p4::a-or-b-node-applied (find-node 34))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 34))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed hawka korea-south))))))
 
(setf (p4::nexus-children (find-node 34))
  (list
    (p4::make-goal-node 
        :name 35 
        :parent (find-node 34) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed 25th-id korea-south)) 
        :introducing-operators (list (find-node 26) )))) 
 
(setf (p4::nexus-children (find-node 35))
  (list
    (p4::make-operator-node 
        :name 36 
        :parent (find-node 35) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 36))
  (list
    (p4::make-binding-node 
        :name 37 
        :parent (find-node 36)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 25th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 37))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 37)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '25th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 25th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))
 
(setf (p4::nexus-children (find-node 37))
  (list
    (p4::make-applied-op-node 
        :name 38 
        :parent (find-node 37)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 38))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 37)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '25th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 25th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))

(setf (p4::a-or-b-node-applied (find-node 38))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 38))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed 25th-id korea-south))))))
 
(setf (p4::nexus-children (find-node 38))
  (list
    (p4::make-applied-op-node 
        :name 39 
        :parent (find-node 38)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 39))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 26)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'airport2 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object '25th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-deployed security-police-a korea-south))
              (p4::instantiate-consed-literal '(is-deployed hawka korea-south))
              (p4::instantiate-consed-literal '(is-deployed 25th-id korea-south)))))

(setf (p4::a-or-b-node-applied (find-node 39))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 39))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))))))
 
(setf (p4::nexus-children (find-node 39))
  (list
    (p4::make-applied-op-node 
        :name 40 
        :parent (find-node 39)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 40))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 23)
          :values (list 
                    (p4::object-name-to-object 'a10a-c-squadron *current-problem-space*)
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'airport2 *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 a10a-c-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active a10a-c-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))

(setf (p4::a-or-b-node-applied (find-node 40))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 40))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed a10a-c-squadron korea-south))))))
 
(setf (p4::nexus-children (find-node 40))
  (list
    (p4::make-goal-node 
        :name 41 
        :parent (find-node 40) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed f117-squadron korea-south)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 41))
  (list
    (p4::make-operator-node 
        :name 42 
        :parent (find-node 41) 
        :operator (p4::get-operator deploy))))
 
(setf (p4::nexus-children (find-node 42))
  (list
    (p4::make-binding-node 
        :name 43 
        :parent (find-node 42)
        :instantiated-preconds 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 f117-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active f117-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 43))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 43)
          :values (list 
                    (p4::object-name-to-object 'f117-squadron *current-problem-space*)
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'airport2 *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 f117-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active f117-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))
 
(setf (p4::nexus-children (find-node 43))
  (list
    (p4::make-applied-op-node 
        :name 44 
        :parent (find-node 43)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 44))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 43)
          :values (list 
                    (p4::object-name-to-object 'f117-squadron *current-problem-space*)
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'airport2 *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 f117-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active f117-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))

(setf (p4::a-or-b-node-applied (find-node 44))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 44))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed f117-squadron korea-south))))))
 
(setf (p4::nexus-children (find-node 44))
  (list
    (p4::make-goal-node 
        :name 45 
        :parent (find-node 44) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed f16-b-squadron korea-south)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 45))
  (list
    (p4::make-operator-node 
        :name 46 
        :parent (find-node 45) 
        :operator (p4::get-operator deploy))))
 
(setf (p4::nexus-children (find-node 46))
  (list
    (p4::make-binding-node 
        :name 47 
        :parent (find-node 46)
        :instantiated-preconds 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 f16-b-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active f16-b-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 47))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 47)
          :values (list 
                    (p4::object-name-to-object 'f16-b-squadron *current-problem-space*)
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'airport2 *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 f16-b-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active f16-b-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))
 
(setf (p4::nexus-children (find-node 47))
  (list
    (p4::make-applied-op-node 
        :name 48 
        :parent (find-node 47)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 48))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 47)
          :values (list 
                    (p4::object-name-to-object 'f16-b-squadron *current-problem-space*)
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'airport2 *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 f16-b-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active f16-b-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))

(setf (p4::a-or-b-node-applied (find-node 48))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 48))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed f16-b-squadron korea-south))))))
 
(setf (p4::nexus-children (find-node 48))
  (list
    (p4::make-goal-node 
        :name 49 
        :parent (find-node 48) 
        :goal 
            (p4::instantiate-consed-literal '(air-blockaded korea-south carrier-air-wing-9)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 49))
  (list
    (p4::make-operator-node 
        :name 50 
        :parent (find-node 49) 
        :operator (p4::get-operator air-blockade))))
 
(setf (p4::nexus-children (find-node 50))
  (list
    (p4::make-binding-node 
        :name 51 
        :parent (find-node 50)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(part-of carrier-air-wing-9 uss-nimitz-cvg)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 51))
      (p4::make-instantiated-op
          :op (p4::get-operator air-blockade)
          :binding-node-back-pointer (find-node 51)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'carrier-air-wing-9 *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(part-of carrier-air-wing-9 uss-nimitz-cvg)))))
 
(setf (p4::nexus-children (find-node 51))
  (list
    (p4::make-applied-op-node 
        :name 52 
        :parent (find-node 51)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 52))
      (p4::make-instantiated-op
          :op (p4::get-operator air-blockade)
          :binding-node-back-pointer (find-node 51)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'carrier-air-wing-9 *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(part-of carrier-air-wing-9 uss-nimitz-cvg)))))

(setf (p4::a-or-b-node-applied (find-node 52))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 52))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(air-blockaded korea-south carrier-air-wing-9))))))
 
(setf (p4::nexus-children (find-node 52))
  (list
    (p4::make-goal-node 
        :name 53 
        :parent (find-node 52) 
        :goal 
            (p4::instantiate-consed-literal '(air-defended korea-south 18th-wing)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 53))
  (list
    (p4::make-operator-node 
        :name 54 
        :parent (find-node 53) 
        :operator (p4::get-operator air-defense))))
 
(setf (p4::nexus-children (find-node 54))
  (list
    (p4::make-binding-node 
        :name 55 
        :parent (find-node 54)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available 18th-wing day-19))
              (p4::instantiate-consed-literal '(is-deployed 18th-wing korea-south)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 55))
      (p4::make-instantiated-op
          :op (p4::get-operator air-defense)
          :binding-node-back-pointer (find-node 55)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object '18th-wing *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available 18th-wing day-19))
              (p4::instantiate-consed-literal '(is-deployed 18th-wing korea-south)))))
 
(setf (p4::nexus-children (find-node 55))
  (list
    (p4::make-goal-node 
        :name 56 
        :parent (find-node 55) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed 18th-wing korea-south)) 
        :introducing-operators (list (find-node 55) )))) 
 
(setf (p4::nexus-children (find-node 56))
  (list
    (p4::make-operator-node 
        :name 57 
        :parent (find-node 56) 
        :operator (p4::get-operator deploy))))
 
(setf (p4::nexus-children (find-node 57))
  (list
    (p4::make-binding-node 
        :name 58 
        :parent (find-node 57)
        :instantiated-preconds 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 18th-wing)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active 18th-wing))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 58))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 58)
          :values (list 
                    (p4::object-name-to-object '18th-wing *current-problem-space*)
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'airport2 *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 18th-wing)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active 18th-wing))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))
 
(setf (p4::nexus-children (find-node 58))
  (list
    (p4::make-applied-op-node 
        :name 59 
        :parent (find-node 58)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 59))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 58)
          :values (list 
                    (p4::object-name-to-object '18th-wing *current-problem-space*)
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'airport2 *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 18th-wing)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active 18th-wing))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))

(setf (p4::a-or-b-node-applied (find-node 59))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 59))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed 18th-wing korea-south))))))
 
(setf (p4::nexus-children (find-node 59))
  (list
    (p4::make-applied-op-node 
        :name 60 
        :parent (find-node 59)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 60))
      (p4::make-instantiated-op
          :op (p4::get-operator air-defense)
          :binding-node-back-pointer (find-node 55)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object '18th-wing *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available 18th-wing day-19))
              (p4::instantiate-consed-literal '(is-deployed 18th-wing korea-south)))))

(setf (p4::a-or-b-node-applied (find-node 60))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 60))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(air-defended korea-south 18th-wing))))))
 
(setf (p4::nexus-children (find-node 60))
  (list
    (p4::make-goal-node 
        :name 61 
        :parent (find-node 60) 
        :goal 
            (p4::instantiate-consed-literal '(is-sovereign korea-south 11-meu-soc)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 61))
  (list
    (p4::make-operator-node 
        :name 62 
        :parent (find-node 61) 
        :operator (p4::get-operator isolate-battlefield))))
 
(setf (p4::nexus-children (find-node 62))
  (list
    (p4::make-binding-node 
        :name 63 
        :parent (find-node 62)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-blockaded korea-south uss-nimitz-cvg carrier-air-wing-9))
              (p4::instantiate-consed-literal '(made-ineffective-by nkorean-brigade 11-meu-soc)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 63))
      (p4::make-instantiated-op
          :op (p4::get-operator isolate-battlefield)
          :binding-node-back-pointer (find-node 63)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*)
                    (p4::object-name-to-object 'carrier-air-wing-9 *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'nkorean-brigade *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-blockaded korea-south uss-nimitz-cvg carrier-air-wing-9))
              (p4::instantiate-consed-literal '(made-ineffective-by nkorean-brigade 11-meu-soc)))))
 
(setf (p4::nexus-children (find-node 63))
  (list
    (p4::make-goal-node 
        :name 64 
        :parent (find-node 63) 
        :goal 
            (p4::instantiate-consed-literal '(is-blockaded korea-south uss-nimitz-cvg carrier-air-wing-9)) 
        :introducing-operators (list (find-node 63) )))) 
 
(setf (p4::nexus-children (find-node 64))
  (list
    (p4::make-operator-node 
        :name 65 
        :parent (find-node 64) 
        :operator (p4::get-operator do-blockade))))
 
(setf (p4::nexus-children (find-node 65))
  (list
    (p4::make-binding-node 
        :name 66 
        :parent (find-node 65)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(part-of carrier-air-wing-9 uss-nimitz-cvg))
              (p4::instantiate-consed-literal '(naval-blockaded korea-south uss-nimitz-cvg))
              (p4::instantiate-consed-literal '(air-blockaded korea-south carrier-air-wing-9)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 66))
      (p4::make-instantiated-op
          :op (p4::get-operator do-blockade)
          :binding-node-back-pointer (find-node 66)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'carrier-air-wing-9 *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(part-of carrier-air-wing-9 uss-nimitz-cvg))
              (p4::instantiate-consed-literal '(naval-blockaded korea-south uss-nimitz-cvg))
              (p4::instantiate-consed-literal '(air-blockaded korea-south carrier-air-wing-9)))))
 
(setf (p4::nexus-children (find-node 66))
  (list
    (p4::make-goal-node 
        :name 67 
        :parent (find-node 66) 
        :goal 
            (p4::instantiate-consed-literal '(naval-blockaded korea-south uss-nimitz-cvg)) 
        :introducing-operators (list (find-node 66) )))) 
 
(setf (p4::nexus-children (find-node 67))
  (list
    (p4::make-operator-node 
        :name 68 
        :parent (find-node 67) 
        :operator (p4::get-operator naval-blockade))))
 
(setf (p4::nexus-children (find-node 68))
  (list
    (p4::make-binding-node 
        :name 69 
        :parent (find-node 68)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(is-deployed uss-nimitz-cvg korea-south)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 69))
      (p4::make-instantiated-op
          :op (p4::get-operator naval-blockade)
          :binding-node-back-pointer (find-node 69)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(is-deployed uss-nimitz-cvg korea-south)))))
 
(setf (p4::nexus-children (find-node 69))
  (list
    (p4::make-goal-node 
        :name 70 
        :parent (find-node 69) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed uss-nimitz-cvg korea-south)) 
        :introducing-operators (list (find-node 69) )))) 
 
(setf (p4::nexus-children (find-node 70))
  (list
    (p4::make-operator-node 
        :name 71 
        :parent (find-node 70) 
        :operator (p4::get-operator deploy-ships))))
 
(setf (p4::nexus-children (find-node 71))
  (list
    (p4::make-binding-node 
        :name 72 
        :parent (find-node 71)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active uss-nimitz-cvg)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 72))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy-ships)
          :binding-node-back-pointer (find-node 72)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active uss-nimitz-cvg)))))
 
(setf (p4::nexus-children (find-node 72))
  (list
    (p4::make-applied-op-node 
        :name 73 
        :parent (find-node 72)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 73))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy-ships)
          :binding-node-back-pointer (find-node 72)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active uss-nimitz-cvg)))))

(setf (p4::a-or-b-node-applied (find-node 73))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 73))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed uss-nimitz-cvg korea-south))))))
 
(setf (p4::nexus-children (find-node 73))
  (list
    (p4::make-applied-op-node 
        :name 74 
        :parent (find-node 73)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 74))
      (p4::make-instantiated-op
          :op (p4::get-operator naval-blockade)
          :binding-node-back-pointer (find-node 69)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(is-deployed uss-nimitz-cvg korea-south)))))

(setf (p4::a-or-b-node-applied (find-node 74))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 74))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(naval-blockaded korea-south uss-nimitz-cvg))))))
 
(setf (p4::nexus-children (find-node 74))
  (list
    (p4::make-applied-op-node 
        :name 75 
        :parent (find-node 74)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 75))
      (p4::make-instantiated-op
          :op (p4::get-operator do-blockade)
          :binding-node-back-pointer (find-node 66)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'carrier-air-wing-9 *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(part-of carrier-air-wing-9 uss-nimitz-cvg))
              (p4::instantiate-consed-literal '(naval-blockaded korea-south uss-nimitz-cvg))
              (p4::instantiate-consed-literal '(air-blockaded korea-south carrier-air-wing-9)))))

(setf (p4::a-or-b-node-applied (find-node 75))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 75))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-blockaded korea-south uss-nimitz-cvg carrier-air-wing-9))))))
 
(setf (p4::nexus-children (find-node 75))
  (list
    (p4::make-goal-node 
        :name 76 
        :parent (find-node 75) 
        :goal 
            (p4::instantiate-consed-literal '(made-ineffective-by nkorean-brigade 11-meu-soc)) 
        :introducing-operators (list (find-node 63) )))) 
 
(setf (p4::nexus-children (find-node 76))
  (list
    (p4::make-operator-node 
        :name 77 
        :parent (find-node 76) 
        :operator (p4::get-operator specialize-inneffective-2-destroy))))
 
(setf (p4::nexus-children (find-node 77))
  (list
    (p4::make-binding-node 
        :name 78 
        :parent (find-node 77)
        :instantiated-preconds 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(near alice nkorean-brigade)))
              (p4::instantiate-consed-literal '(is-destroyed-by nkorean-brigade 11-meu-soc)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 78))
      (p4::make-instantiated-op
          :op (p4::get-operator specialize-inneffective-2-destroy)
          :binding-node-back-pointer (find-node 78)
          :values (list 
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*)
                    (p4::object-name-to-object 'alice *current-problem-space*)
                    (p4::object-name-to-object 'nkorean-brigade *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(near alice nkorean-brigade)))
              (p4::instantiate-consed-literal '(is-destroyed-by nkorean-brigade 11-meu-soc)))))
 
(setf (p4::nexus-children (find-node 78))
  (list
    (p4::make-goal-node 
        :name 79 
        :parent (find-node 78) 
        :goal 
            (p4::instantiate-consed-literal '(is-destroyed-by nkorean-brigade 11-meu-soc)) 
        :introducing-operators (list (find-node 78) )))) 
 
(setf (p4::nexus-children (find-node 79))
  (list
    (p4::make-operator-node 
        :name 80 
        :parent (find-node 79) 
        :operator (p4::get-operator attack))))
 
(setf (p4::nexus-children (find-node 80))
  (list
    (p4::make-binding-node 
        :name 81 
        :parent (find-node 80)
        :instantiated-preconds 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(impossible-precondition)))
              (p4::instantiate-consed-literal '(is-ready 11-meu-soc))
              (p4::instantiate-consed-literal '(is-deployed nkorean-brigade town-center1))
              (p4::instantiate-consed-literal '(loc-at town-center1 korea-south))
              (p4::instantiate-consed-literal '(is-deployed 11-meu-soc korea-south)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 81))
      (p4::make-instantiated-op
          :op (p4::get-operator attack)
          :binding-node-back-pointer (find-node 81)
          :values (list 
                    (p4::object-name-to-object 'nkorean-brigade *current-problem-space*)
                    (p4::object-name-to-object 'town-center1 *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*)
                    (p4::object-name-to-object 'korea-south *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(impossible-precondition)))
              (p4::instantiate-consed-literal '(is-ready 11-meu-soc))
              (p4::instantiate-consed-literal '(is-deployed nkorean-brigade town-center1))
              (p4::instantiate-consed-literal '(loc-at town-center1 korea-south))
              (p4::instantiate-consed-literal '(is-deployed 11-meu-soc korea-south)))))
 
(setf (p4::nexus-children (find-node 81))
  (list
    (p4::make-goal-node 
        :name 82 
        :parent (find-node 81) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed 11-meu-soc korea-south)) 
        :introducing-operators (list (find-node 81) )))) 
 
(setf (p4::nexus-children (find-node 82))
  (list
    (p4::make-operator-node 
        :name 83 
        :parent (find-node 82) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 83))
  (list
    (p4::make-binding-node 
        :name 84 
        :parent (find-node 83)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 11-meu-soc))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 84))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 84)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 11-meu-soc))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))
 
(setf (p4::nexus-children (find-node 84))
  (list
    (p4::make-applied-op-node 
        :name 85 
        :parent (find-node 84)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 85))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 84)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 11-meu-soc))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))

(setf (p4::a-or-b-node-applied (find-node 85))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 85))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed 11-meu-soc korea-south))))))
 
(setf (p4::nexus-children (find-node 85))
  (list
    (p4::make-applied-op-node 
        :name 86 
        :parent (find-node 85)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 86))
      (p4::make-instantiated-op
          :op (p4::get-operator attack)
          :binding-node-back-pointer (find-node 81)
          :values (list 
                    (p4::object-name-to-object 'nkorean-brigade *current-problem-space*)
                    (p4::object-name-to-object 'town-center1 *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*)
                    (p4::object-name-to-object 'korea-south *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(impossible-precondition)))
              (p4::instantiate-consed-literal '(is-ready 11-meu-soc))
              (p4::instantiate-consed-literal '(is-deployed nkorean-brigade town-center1))
              (p4::instantiate-consed-literal '(loc-at town-center1 korea-south))
              (p4::instantiate-consed-literal '(is-deployed 11-meu-soc korea-south)))))

(setf (p4::a-or-b-node-applied (find-node 86))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 86))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-destroyed-by nkorean-brigade 11-meu-soc)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(is-ready 11-meu-soc))))))
 
(setf (p4::nexus-children (find-node 86))
  (list
    (p4::make-applied-op-node 
        :name 87 
        :parent (find-node 86)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 87))
      (p4::make-instantiated-op
          :op (p4::get-operator specialize-inneffective-2-destroy)
          :binding-node-back-pointer (find-node 78)
          :values (list 
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*)
                    (p4::object-name-to-object 'alice *current-problem-space*)
                    (p4::object-name-to-object 'nkorean-brigade *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(near alice nkorean-brigade)))
              (p4::instantiate-consed-literal '(is-destroyed-by nkorean-brigade 11-meu-soc)))))

(setf (p4::a-or-b-node-applied (find-node 87))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 87))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(made-ineffective-by nkorean-brigade 11-meu-soc))))))
 
(setf (p4::nexus-children (find-node 87))
  (list
    (p4::make-applied-op-node 
        :name 88 
        :parent (find-node 87)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 88))
      (p4::make-instantiated-op
          :op (p4::get-operator isolate-battlefield)
          :binding-node-back-pointer (find-node 63)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*)
                    (p4::object-name-to-object 'carrier-air-wing-9 *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'nkorean-brigade *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-blockaded korea-south uss-nimitz-cvg carrier-air-wing-9))
              (p4::instantiate-consed-literal '(made-ineffective-by nkorean-brigade 11-meu-soc)))))

(setf (p4::a-or-b-node-applied (find-node 88))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 88))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-sovereign korea-south 11-meu-soc))))))
 
(setf (p4::nexus-children (find-node 88))
  (list
    (p4::make-goal-node 
        :name 89 
        :parent (find-node 88) 
        :goal 
            (p4::instantiate-consed-literal '(airport-secure-at sri-lanka airport1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 89))
  (list
    (p4::make-operator-node 
        :name 90 
        :parent (find-node 89) 
        :operator (p4::get-operator secure))))
 
(setf (p4::nexus-children (find-node 90))
  (list
    (p4::make-binding-node 
        :name 91 
        :parent (find-node 90)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed 25th-id sri-lanka)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 91))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 91)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object '25th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed 25th-id sri-lanka)))))
 
(setf (p4::nexus-children (find-node 91))
  (list
    (p4::make-goal-node 
        :name 92 
        :parent (find-node 91) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka)) 
        :introducing-operators (list (find-node 91) )))) 
 
(setf (p4::nexus-children (find-node 92))
  (list
    (p4::make-operator-node 
        :name 93 
        :parent (find-node 92) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 93))
  (list
    (p4::make-binding-node 
        :name 94 
        :parent (find-node 93)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 94))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 94)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))
 
(setf (p4::nexus-children (find-node 94))
  (list
    (p4::make-applied-op-node 
        :name 95 
        :parent (find-node 94)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 95))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 94)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))

(setf (p4::a-or-b-node-applied (find-node 95))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 95))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka))))))
 
(setf (p4::nexus-children (find-node 95))
  (list
    (p4::make-goal-node 
        :name 96 
        :parent (find-node 95) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka)) 
        :introducing-operators (list (find-node 91) )))) 
 
(setf (p4::nexus-children (find-node 96))
  (list
    (p4::make-operator-node 
        :name 97 
        :parent (find-node 96) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 97))
  (list
    (p4::make-binding-node 
        :name 98 
        :parent (find-node 97)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 98))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 98)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))
 
(setf (p4::nexus-children (find-node 98))
  (list
    (p4::make-applied-op-node 
        :name 99 
        :parent (find-node 98)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 99))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 98)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))

(setf (p4::a-or-b-node-applied (find-node 99))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 99))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka))))))
 
(setf (p4::nexus-children (find-node 99))
  (list
    (p4::make-goal-node 
        :name 100 
        :parent (find-node 99) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed 25th-id sri-lanka)) 
        :introducing-operators (list (find-node 91) )))) 
 
(setf (p4::nexus-children (find-node 100))
  (list
    (p4::make-operator-node 
        :name 101 
        :parent (find-node 100) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 101))
  (list
    (p4::make-binding-node 
        :name 102 
        :parent (find-node 101)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 25th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 102))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 102)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '25th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 25th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))
 
(setf (p4::nexus-children (find-node 102))
  (list
    (p4::make-applied-op-node 
        :name 103 
        :parent (find-node 102)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 103))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 102)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '25th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 25th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))

(setf (p4::a-or-b-node-applied (find-node 103))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 103))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed 25th-id sri-lanka))))))
 
(setf (p4::nexus-children (find-node 103))
  (list
    (p4::make-applied-op-node 
        :name 104 
        :parent (find-node 103)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 104))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 91)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object '25th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed 25th-id sri-lanka)))))

(setf (p4::a-or-b-node-applied (find-node 104))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 104))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(airport-secure-at sri-lanka airport1))))))
 
(setf (p4::nexus-children (find-node 104))
  (list
    (p4::make-goal-node 
        :name 105 
        :parent (find-node 104) 
        :goal 
            (p4::instantiate-consed-literal '(is-medically-assisted sri-lanka 45th-support-group)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 105))
  (list
    (p4::make-operator-node 
        :name 106 
        :parent (find-node 105) 
        :operator (p4::get-operator provide-medical-assistance))))
 
(setf (p4::nexus-children (find-node 106))
  (list
    (p4::make-binding-node 
        :name 107 
        :parent (find-node 106)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 107))
      (p4::make-instantiated-op
          :op (p4::get-operator provide-medical-assistance)
          :binding-node-back-pointer (find-node 107)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object '45th-support-group *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka)))))
 
(setf (p4::nexus-children (find-node 107))
  (list
    (p4::make-goal-node 
        :name 108 
        :parent (find-node 107) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka)) 
        :introducing-operators (list (find-node 107) )))) 
 
(setf (p4::nexus-children (find-node 108))
  (list
    (p4::make-operator-node 
        :name 109 
        :parent (find-node 108) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 109))
  (list
    (p4::make-binding-node 
        :name 110 
        :parent (find-node 109)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 45th-support-group))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 110))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 110)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '45th-support-group *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 45th-support-group))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))
 
(setf (p4::nexus-children (find-node 110))
  (list
    (p4::make-applied-op-node 
        :name 111 
        :parent (find-node 110)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 111))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 110)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '45th-support-group *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 45th-support-group))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))

(setf (p4::a-or-b-node-applied (find-node 111))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 111))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka))))))
 
(setf (p4::nexus-children (find-node 111))
  (list
    (p4::make-applied-op-node 
        :name 112 
        :parent (find-node 111)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 112))
      (p4::make-instantiated-op
          :op (p4::get-operator provide-medical-assistance)
          :binding-node-back-pointer (find-node 107)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object '45th-support-group *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka)))))

(setf (p4::a-or-b-node-applied (find-node 112))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 112))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-medically-assisted sri-lanka 45th-support-group))))))
