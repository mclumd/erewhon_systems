 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed a10a-c-squadron korea-south))
              (p4::instantiate-consed-literal '(is-deployed f16-c-squadron korea-south))
              (p4::instantiate-consed-literal '(is-mission-supported sri-lanka 45th-support-group))
              (p4::instantiate-consed-literal '(is-medically-assisted sri-lanka 45th-support-group))
              (p4::instantiate-consed-literal '(is-evacuated iii-mef sri-lanka))
              (p4::instantiate-consed-literal '(is-neo-supported sri-lanka))
              (p4::instantiate-consed-literal '(is-sovereign sri-lanka 11-meu-soc))
              (p4::instantiate-consed-literal '(air-defended sri-lanka 18th-wing))
              (p4::instantiate-consed-literal '(air-blockaded sri-lanka carrier-air-wing-9))
              (p4::instantiate-consed-literal '(naval-blockaded sri-lanka uss-essex-cvg)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator p4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed a10a-c-squadron korea-south))
              (p4::instantiate-consed-literal '(is-deployed f16-c-squadron korea-south))
              (p4::instantiate-consed-literal '(is-mission-supported sri-lanka 45th-support-group))
              (p4::instantiate-consed-literal '(is-medically-assisted sri-lanka 45th-support-group))
              (p4::instantiate-consed-literal '(is-evacuated iii-mef sri-lanka))
              (p4::instantiate-consed-literal '(is-neo-supported sri-lanka))
              (p4::instantiate-consed-literal '(is-sovereign sri-lanka 11-meu-soc))
              (p4::instantiate-consed-literal '(air-defended sri-lanka 18th-wing))
              (p4::instantiate-consed-literal '(air-blockaded sri-lanka carrier-air-wing-9))
              (p4::instantiate-consed-literal '(naval-blockaded sri-lanka uss-essex-cvg)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed a10a-c-squadron korea-south)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator deploy))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 a10a-c-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active a10a-c-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 7)
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
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator secure))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-deployed security-police-a korea-south))
              (p4::instantiate-consed-literal '(is-deployed hawka korea-south))
              (p4::instantiate-consed-literal '(is-deployed 6th-id korea-south)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'airport2 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object '6th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-deployed security-police-a korea-south))
              (p4::instantiate-consed-literal '(is-deployed hawka korea-south))
              (p4::instantiate-consed-literal '(is-deployed 6th-id korea-south)))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 11 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed security-police-a korea-south)) 
        :introducing-operators (list (find-node 10) )))) 
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-operator-node 
        :name 12 
        :parent (find-node 11) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-binding-node 
        :name 13 
        :parent (find-node 12)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 13))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 13)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-applied-op-node 
        :name 14 
        :parent (find-node 13)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 14))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 13)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))

(setf (p4::a-or-b-node-applied (find-node 14))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 14))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed security-police-a korea-south))))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-goal-node 
        :name 15 
        :parent (find-node 14) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed hawka korea-south)) 
        :introducing-operators (list (find-node 10) )))) 
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-operator-node 
        :name 16 
        :parent (find-node 15) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-binding-node 
        :name 17 
        :parent (find-node 16)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 17))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 17)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-applied-op-node 
        :name 18 
        :parent (find-node 17)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 18))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 17)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))

(setf (p4::a-or-b-node-applied (find-node 18))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 18))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed hawka korea-south))))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-goal-node 
        :name 19 
        :parent (find-node 18) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed 6th-id korea-south)) 
        :introducing-operators (list (find-node 10) )))) 
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-operator-node 
        :name 20 
        :parent (find-node 19) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 20))
  (list
    (p4::make-binding-node 
        :name 21 
        :parent (find-node 20)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 6th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 21))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 21)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '6th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 6th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))
 
(setf (p4::nexus-children (find-node 21))
  (list
    (p4::make-applied-op-node 
        :name 22 
        :parent (find-node 21)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 22))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 21)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '6th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 6th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 korea-south))))))

(setf (p4::a-or-b-node-applied (find-node 22))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 22))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed 6th-id korea-south))))))
 
(setf (p4::nexus-children (find-node 22))
  (list
    (p4::make-applied-op-node 
        :name 23 
        :parent (find-node 22)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 23))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'airport2 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object '6th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-deployed security-police-a korea-south))
              (p4::instantiate-consed-literal '(is-deployed hawka korea-south))
              (p4::instantiate-consed-literal '(is-deployed 6th-id korea-south)))))

(setf (p4::a-or-b-node-applied (find-node 23))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 23))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))))))
 
(setf (p4::nexus-children (find-node 23))
  (list
    (p4::make-applied-op-node 
        :name 24 
        :parent (find-node 23)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 24))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 7)
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

(setf (p4::a-or-b-node-applied (find-node 24))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 24))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed a10a-c-squadron korea-south))))))
 
(setf (p4::nexus-children (find-node 24))
  (list
    (p4::make-goal-node 
        :name 25 
        :parent (find-node 24) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed f16-c-squadron korea-south)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 25))
  (list
    (p4::make-operator-node 
        :name 26 
        :parent (find-node 25) 
        :operator (p4::get-operator deploy))))
 
(setf (p4::nexus-children (find-node 26))
  (list
    (p4::make-binding-node 
        :name 27 
        :parent (find-node 26)
        :instantiated-preconds 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 f16-c-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active f16-c-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 27))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 27)
          :values (list 
                    (p4::object-name-to-object 'f16-c-squadron *current-problem-space*)
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'airport2 *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 f16-c-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active f16-c-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))
 
(setf (p4::nexus-children (find-node 27))
  (list
    (p4::make-applied-op-node 
        :name 28 
        :parent (find-node 27)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 28))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 27)
          :values (list 
                    (p4::object-name-to-object 'f16-c-squadron *current-problem-space*)
                    (p4::object-name-to-object 'korea-south *current-problem-space*)
                    (p4::object-name-to-object 'airport2 *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 f16-c-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport2 korea-south))
              (p4::instantiate-consed-literal '(is-active f16-c-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at korea-south airport2))
              (p4::instantiate-consed-literal '(is-usable airport2)))))

(setf (p4::a-or-b-node-applied (find-node 28))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 28))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed f16-c-squadron korea-south))))))
 
(setf (p4::nexus-children (find-node 28))
  (list
    (p4::make-goal-node 
        :name 29 
        :parent (find-node 28) 
        :goal 
            (p4::instantiate-consed-literal '(is-mission-supported sri-lanka 45th-support-group)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 29))
  (list
    (p4::make-operator-node 
        :name 30 
        :parent (find-node 29) 
        :operator (p4::get-operator support-combat-mission))))
 
(setf (p4::nexus-children (find-node 30))
  (list
    (p4::make-binding-node 
        :name 31 
        :parent (find-node 30)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 31))
      (p4::make-instantiated-op
          :op (p4::get-operator support-combat-mission)
          :binding-node-back-pointer (find-node 31)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object '45th-support-group *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka)))))
 
(setf (p4::nexus-children (find-node 31))
  (list
    (p4::make-goal-node 
        :name 32 
        :parent (find-node 31) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka)) 
        :introducing-operators (list (find-node 31) )))) 
 
(setf (p4::nexus-children (find-node 32))
  (list
    (p4::make-operator-node 
        :name 33 
        :parent (find-node 32) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 33))
  (list
    (p4::make-binding-node 
        :name 34 
        :parent (find-node 33)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 45th-support-group))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 34))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 34)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '45th-support-group *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 45th-support-group))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))
 
(setf (p4::nexus-children (find-node 34))
  (list
    (p4::make-applied-op-node 
        :name 35 
        :parent (find-node 34)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 35))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 34)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '45th-support-group *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 45th-support-group))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))

(setf (p4::a-or-b-node-applied (find-node 35))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 35))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka))))))
 
(setf (p4::nexus-children (find-node 35))
  (list
    (p4::make-applied-op-node 
        :name 36 
        :parent (find-node 35)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 36))
      (p4::make-instantiated-op
          :op (p4::get-operator support-combat-mission)
          :binding-node-back-pointer (find-node 31)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object '45th-support-group *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka)))))

(setf (p4::a-or-b-node-applied (find-node 36))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 36))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-mission-supported sri-lanka 45th-support-group))))))
 
(setf (p4::nexus-children (find-node 36))
  (list
    (p4::make-goal-node 
        :name 37 
        :parent (find-node 36) 
        :goal 
            (p4::instantiate-consed-literal '(is-medically-assisted sri-lanka 45th-support-group)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 37))
  (list
    (p4::make-operator-node 
        :name 38 
        :parent (find-node 37) 
        :operator (p4::get-operator provide-medical-assistance))))
 
(setf (p4::nexus-children (find-node 38))
  (list
    (p4::make-binding-node 
        :name 39 
        :parent (find-node 38)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 39))
      (p4::make-instantiated-op
          :op (p4::get-operator provide-medical-assistance)
          :binding-node-back-pointer (find-node 39)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object '45th-support-group *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka)))))
 
(setf (p4::nexus-children (find-node 39))
  (list
    (p4::make-applied-op-node 
        :name 40 
        :parent (find-node 39)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 40))
      (p4::make-instantiated-op
          :op (p4::get-operator provide-medical-assistance)
          :binding-node-back-pointer (find-node 39)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object '45th-support-group *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka)))))

(setf (p4::a-or-b-node-applied (find-node 40))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 40))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-medically-assisted sri-lanka 45th-support-group))))))
 
(setf (p4::nexus-children (find-node 40))
  (list
    (p4::make-goal-node 
        :name 41 
        :parent (find-node 40) 
        :goal 
            (p4::instantiate-consed-literal '(is-evacuated iii-mef sri-lanka)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 41))
  (list
    (p4::make-operator-node 
        :name 42 
        :parent (find-node 41) 
        :operator (p4::get-operator conduct-neo))))
 
(setf (p4::nexus-children (find-node 42))
  (list
    (p4::make-binding-node 
        :name 43 
        :parent (find-node 42)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka us-population1))
              (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka us-population2))
              (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka portuguese-population))
              (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka romanian-population)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 43))
      (p4::make-instantiated-op
          :op (p4::get-operator conduct-neo)
          :binding-node-back-pointer (find-node 43)
          :values (list 
                    (p4::object-name-to-object 'iii-mef *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'us-population1 *current-problem-space*)
                    (p4::object-name-to-object 'us-population2 *current-problem-space*)
                    (p4::object-name-to-object 'portuguese-population *current-problem-space*)
                    (p4::object-name-to-object 'romanian-population *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka us-population1))
              (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka us-population2))
              (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka portuguese-population))
              (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka romanian-population)))))
 
(setf (p4::nexus-children (find-node 43))
  (list
    (p4::make-goal-node 
        :name 44 
        :parent (find-node 43) 
        :goal 
            (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka us-population1)) 
        :introducing-operators (list (find-node 43) )))) 
 
(setf (p4::nexus-children (find-node 44))
  (list
    (p4::make-operator-node 
        :name 45 
        :parent (find-node 44) 
        :operator (p4::get-operator evacuate-non-combatants-by-airlift))))
 
(setf (p4::nexus-children (find-node 45))
  (list
    (p4::make-binding-node 
        :name 46 
        :parent (find-node 45)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(province-of sri-lanka sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(near airport1 safe-haven))
              (p4::instantiate-consed-literal '(loc-at-p us-population1 sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed c141-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-secure safe-haven)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 46))
      (p4::make-instantiated-op
          :op (p4::get-operator evacuate-non-combatants-by-airlift)
          :binding-node-back-pointer (find-node 46)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'us-population1 *current-problem-space*)
                    (p4::object-name-to-object 'safe-haven *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*)
                    (p4::object-name-to-object 'c141-a *current-problem-space*)
                    (p4::object-name-to-object 'iii-mef *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(province-of sri-lanka sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(near airport1 safe-haven))
              (p4::instantiate-consed-literal '(loc-at-p us-population1 sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed c141-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-secure safe-haven)))))
 
(setf (p4::nexus-children (find-node 46))
  (list
    (p4::make-goal-node 
        :name 47 
        :parent (find-node 46) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed c141-a sri-lanka-province)) 
        :introducing-operators (list (find-node 46) )))) 
 
(setf (p4::nexus-children (find-node 47))
  (list
    (p4::make-operator-node 
        :name 48 
        :parent (find-node 47) 
        :operator (p4::get-operator transit))))
 
(setf (p4::nexus-children (find-node 48))
  (list
    (p4::make-binding-node 
        :name 49 
        :parent (find-node 48)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active c141-a))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(airport-secure-at sri-lanka-province airport1))
              (p4::instantiate-consed-literal '(is-usable airport1)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 49))
      (p4::make-instantiated-op
          :op (p4::get-operator transit)
          :binding-node-back-pointer (find-node 49)
          :values (list 
                    (p4::object-name-to-object 'c141-a *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active c141-a))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(airport-secure-at sri-lanka-province airport1))
              (p4::instantiate-consed-literal '(is-usable airport1)))))
 
(setf (p4::nexus-children (find-node 49))
  (list
    (p4::make-goal-node 
        :name 50 
        :parent (find-node 49) 
        :goal 
            (p4::instantiate-consed-literal '(airport-secure-at sri-lanka-province airport1)) 
        :introducing-operators (list (find-node 49) )))) 
 
(setf (p4::nexus-children (find-node 50))
  (list
    (p4::make-operator-node 
        :name 51 
        :parent (find-node 50) 
        :operator (p4::get-operator secure))))
 
(setf (p4::nexus-children (find-node 51))
  (list
    (p4::make-binding-node 
        :name 52 
        :parent (find-node 51)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed 6th-id sri-lanka-province)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 52))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 52)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object '6th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed 6th-id sri-lanka-province)))))
 
(setf (p4::nexus-children (find-node 52))
  (list
    (p4::make-goal-node 
        :name 53 
        :parent (find-node 52) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka-province)) 
        :introducing-operators (list (find-node 52) )))) 
 
(setf (p4::nexus-children (find-node 53))
  (list
    (p4::make-operator-node 
        :name 54 
        :parent (find-node 53) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 54))
  (list
    (p4::make-binding-node 
        :name 55 
        :parent (find-node 54)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka-province))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 55))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 55)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka-province))))))
 
(setf (p4::nexus-children (find-node 55))
  (list
    (p4::make-applied-op-node 
        :name 56 
        :parent (find-node 55)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 56))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 55)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka-province))))))

(setf (p4::a-or-b-node-applied (find-node 56))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 56))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka-province))))))
 
(setf (p4::nexus-children (find-node 56))
  (list
    (p4::make-goal-node 
        :name 57 
        :parent (find-node 56) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka-province)) 
        :introducing-operators (list (find-node 52) )))) 
 
(setf (p4::nexus-children (find-node 57))
  (list
    (p4::make-operator-node 
        :name 58 
        :parent (find-node 57) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 58))
  (list
    (p4::make-binding-node 
        :name 59 
        :parent (find-node 58)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka-province))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 59))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 59)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka-province))))))
 
(setf (p4::nexus-children (find-node 59))
  (list
    (p4::make-applied-op-node 
        :name 60 
        :parent (find-node 59)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 60))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 59)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka-province))))))

(setf (p4::a-or-b-node-applied (find-node 60))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 60))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka-province))))))
 
(setf (p4::nexus-children (find-node 60))
  (list
    (p4::make-goal-node 
        :name 61 
        :parent (find-node 60) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed 6th-id sri-lanka-province)) 
        :introducing-operators (list (find-node 52) )))) 
 
(setf (p4::nexus-children (find-node 61))
  (list
    (p4::make-operator-node 
        :name 62 
        :parent (find-node 61) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 62))
  (list
    (p4::make-binding-node 
        :name 63 
        :parent (find-node 62)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 6th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka-province))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 63))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 63)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '6th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 6th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka-province))))))
 
(setf (p4::nexus-children (find-node 63))
  (list
    (p4::make-applied-op-node 
        :name 64 
        :parent (find-node 63)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 64))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 63)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '6th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 6th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka-province))))))

(setf (p4::a-or-b-node-applied (find-node 64))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 64))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed 6th-id sri-lanka-province))))))
 
(setf (p4::nexus-children (find-node 64))
  (list
    (p4::make-applied-op-node 
        :name 65 
        :parent (find-node 64)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 65))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 52)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object '6th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed 6th-id sri-lanka-province)))))

(setf (p4::a-or-b-node-applied (find-node 65))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 65))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(airport-secure-at sri-lanka-province airport1))))))
 
(setf (p4::nexus-children (find-node 65))
  (list
    (p4::make-applied-op-node 
        :name 66 
        :parent (find-node 65)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 66))
      (p4::make-instantiated-op
          :op (p4::get-operator transit)
          :binding-node-back-pointer (find-node 49)
          :values (list 
                    (p4::object-name-to-object 'c141-a *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active c141-a))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(airport-secure-at sri-lanka-province airport1))
              (p4::instantiate-consed-literal '(is-usable airport1)))))

(setf (p4::a-or-b-node-applied (find-node 66))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 66))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed c141-a sri-lanka-province))))))
 
(setf (p4::nexus-children (find-node 66))
  (list
    (p4::make-goal-node 
        :name 67 
        :parent (find-node 66) 
        :goal 
            (p4::instantiate-consed-literal '(is-secure safe-haven)) 
        :introducing-operators (list (find-node 46) )))) 
 
(setf (p4::nexus-children (find-node 67))
  (list
    (p4::make-operator-node 
        :name 68 
        :parent (find-node 67) 
        :operator (p4::get-operator secure-undefended-perimeter))))
 
(setf (p4::nexus-children (find-node 68))
  (list
    (p4::make-binding-node 
        :name 69 
        :parent (find-node 68)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed 6th-id sri-lanka-province)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 69))
      (p4::make-instantiated-op
          :op (p4::get-operator secure-undefended-perimeter)
          :binding-node-back-pointer (find-node 69)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'safe-haven *current-problem-space*)
                    (p4::object-name-to-object '6th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed 6th-id sri-lanka-province)))))
 
(setf (p4::nexus-children (find-node 69))
  (list
    (p4::make-applied-op-node 
        :name 70 
        :parent (find-node 69)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 70))
      (p4::make-instantiated-op
          :op (p4::get-operator secure-undefended-perimeter)
          :binding-node-back-pointer (find-node 69)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'safe-haven *current-problem-space*)
                    (p4::object-name-to-object '6th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed 6th-id sri-lanka-province)))))

(setf (p4::a-or-b-node-applied (find-node 70))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 70))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-secure safe-haven))))))
 
(setf (p4::nexus-children (find-node 70))
  (list
    (p4::make-applied-op-node 
        :name 71 
        :parent (find-node 70)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 71))
      (p4::make-instantiated-op
          :op (p4::get-operator evacuate-non-combatants-by-airlift)
          :binding-node-back-pointer (find-node 46)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'us-population1 *current-problem-space*)
                    (p4::object-name-to-object 'safe-haven *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*)
                    (p4::object-name-to-object 'c141-a *current-problem-space*)
                    (p4::object-name-to-object 'iii-mef *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(province-of sri-lanka sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(near airport1 safe-haven))
              (p4::instantiate-consed-literal '(loc-at-p us-population1 sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed c141-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-secure safe-haven)))))

(setf (p4::a-or-b-node-applied (find-node 71))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 71))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka us-population1)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(loc-at-p us-population1 sri-lanka-province))))))
 
(setf (p4::nexus-children (find-node 71))
  (list
    (p4::make-goal-node 
        :name 72 
        :parent (find-node 71) 
        :goal 
            (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka us-population2)) 
        :introducing-operators (list (find-node 43) )))) 
 
(setf (p4::nexus-children (find-node 72))
  (list
    (p4::make-operator-node 
        :name 73 
        :parent (find-node 72) 
        :operator (p4::get-operator evacuate-non-combatants-by-airlift))))
 
(setf (p4::nexus-children (find-node 73))
  (list
    (p4::make-binding-node 
        :name 74 
        :parent (find-node 73)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(province-of sri-lanka sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(near airport1 safe-haven))
              (p4::instantiate-consed-literal '(loc-at-p us-population2 sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed c141-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-secure safe-haven)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 74))
      (p4::make-instantiated-op
          :op (p4::get-operator evacuate-non-combatants-by-airlift)
          :binding-node-back-pointer (find-node 74)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'us-population2 *current-problem-space*)
                    (p4::object-name-to-object 'safe-haven *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*)
                    (p4::object-name-to-object 'c141-a *current-problem-space*)
                    (p4::object-name-to-object 'iii-mef *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(province-of sri-lanka sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(near airport1 safe-haven))
              (p4::instantiate-consed-literal '(loc-at-p us-population2 sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed c141-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-secure safe-haven)))))
 
(setf (p4::nexus-children (find-node 74))
  (list
    (p4::make-applied-op-node 
        :name 75 
        :parent (find-node 74)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 75))
      (p4::make-instantiated-op
          :op (p4::get-operator evacuate-non-combatants-by-airlift)
          :binding-node-back-pointer (find-node 74)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'us-population2 *current-problem-space*)
                    (p4::object-name-to-object 'safe-haven *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*)
                    (p4::object-name-to-object 'c141-a *current-problem-space*)
                    (p4::object-name-to-object 'iii-mef *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(province-of sri-lanka sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(near airport1 safe-haven))
              (p4::instantiate-consed-literal '(loc-at-p us-population2 sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed c141-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-secure safe-haven)))))

(setf (p4::a-or-b-node-applied (find-node 75))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 75))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka us-population2)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(loc-at-p us-population2 sri-lanka-province))))))
 
(setf (p4::nexus-children (find-node 75))
  (list
    (p4::make-goal-node 
        :name 76 
        :parent (find-node 75) 
        :goal 
            (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka portuguese-population)) 
        :introducing-operators (list (find-node 43) )))) 
 
(setf (p4::nexus-children (find-node 76))
  (list
    (p4::make-operator-node 
        :name 77 
        :parent (find-node 76) 
        :operator (p4::get-operator evacuate-non-combatants-by-airlift))))
 
(setf (p4::nexus-children (find-node 77))
  (list
    (p4::make-binding-node 
        :name 78 
        :parent (find-node 77)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(province-of sri-lanka sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(near airport1 safe-haven))
              (p4::instantiate-consed-literal '(loc-at-p portuguese-population sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed c141-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-secure safe-haven)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 78))
      (p4::make-instantiated-op
          :op (p4::get-operator evacuate-non-combatants-by-airlift)
          :binding-node-back-pointer (find-node 78)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'portuguese-population *current-problem-space*)
                    (p4::object-name-to-object 'safe-haven *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*)
                    (p4::object-name-to-object 'c141-a *current-problem-space*)
                    (p4::object-name-to-object 'iii-mef *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(province-of sri-lanka sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(near airport1 safe-haven))
              (p4::instantiate-consed-literal '(loc-at-p portuguese-population sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed c141-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-secure safe-haven)))))
 
(setf (p4::nexus-children (find-node 78))
  (list
    (p4::make-applied-op-node 
        :name 79 
        :parent (find-node 78)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 79))
      (p4::make-instantiated-op
          :op (p4::get-operator evacuate-non-combatants-by-airlift)
          :binding-node-back-pointer (find-node 78)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'portuguese-population *current-problem-space*)
                    (p4::object-name-to-object 'safe-haven *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*)
                    (p4::object-name-to-object 'c141-a *current-problem-space*)
                    (p4::object-name-to-object 'iii-mef *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(province-of sri-lanka sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(near airport1 safe-haven))
              (p4::instantiate-consed-literal '(loc-at-p portuguese-population sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed c141-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-secure safe-haven)))))

(setf (p4::a-or-b-node-applied (find-node 79))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 79))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka portuguese-population)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(loc-at-p portuguese-population sri-lanka-province))))))
 
(setf (p4::nexus-children (find-node 79))
  (list
    (p4::make-goal-node 
        :name 80 
        :parent (find-node 79) 
        :goal 
            (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka romanian-population)) 
        :introducing-operators (list (find-node 43) )))) 
 
(setf (p4::nexus-children (find-node 80))
  (list
    (p4::make-operator-node 
        :name 81 
        :parent (find-node 80) 
        :operator (p4::get-operator evacuate-non-combatants-by-airlift))))
 
(setf (p4::nexus-children (find-node 81))
  (list
    (p4::make-binding-node 
        :name 82 
        :parent (find-node 81)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(province-of sri-lanka sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(near airport1 safe-haven))
              (p4::instantiate-consed-literal '(loc-at-p romanian-population sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed c141-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-secure safe-haven)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 82))
      (p4::make-instantiated-op
          :op (p4::get-operator evacuate-non-combatants-by-airlift)
          :binding-node-back-pointer (find-node 82)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'romanian-population *current-problem-space*)
                    (p4::object-name-to-object 'safe-haven *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*)
                    (p4::object-name-to-object 'c141-a *current-problem-space*)
                    (p4::object-name-to-object 'iii-mef *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(province-of sri-lanka sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(near airport1 safe-haven))
              (p4::instantiate-consed-literal '(loc-at-p romanian-population sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed c141-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-secure safe-haven)))))
 
(setf (p4::nexus-children (find-node 82))
  (list
    (p4::make-applied-op-node 
        :name 83 
        :parent (find-node 82)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 83))
      (p4::make-instantiated-op
          :op (p4::get-operator evacuate-non-combatants-by-airlift)
          :binding-node-back-pointer (find-node 82)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka-province *current-problem-space*)
                    (p4::object-name-to-object 'romanian-population *current-problem-space*)
                    (p4::object-name-to-object 'safe-haven *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*)
                    (p4::object-name-to-object 'c141-a *current-problem-space*)
                    (p4::object-name-to-object 'iii-mef *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(province-of sri-lanka sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at safe-haven sri-lanka-province))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka-province))
              (p4::instantiate-consed-literal '(near airport1 safe-haven))
              (p4::instantiate-consed-literal '(loc-at-p romanian-population sri-lanka-province))
              (p4::instantiate-consed-literal '(is-deployed c141-a sri-lanka-province))
              (p4::instantiate-consed-literal '(is-secure safe-haven)))))

(setf (p4::a-or-b-node-applied (find-node 83))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 83))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka romanian-population)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(loc-at-p romanian-population sri-lanka-province))))))
 
(setf (p4::nexus-children (find-node 83))
  (list
    (p4::make-applied-op-node 
        :name 84 
        :parent (find-node 83)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 84))
      (p4::make-instantiated-op
          :op (p4::get-operator conduct-neo)
          :binding-node-back-pointer (find-node 43)
          :values (list 
                    (p4::object-name-to-object 'iii-mef *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'us-population1 *current-problem-space*)
                    (p4::object-name-to-object 'us-population2 *current-problem-space*)
                    (p4::object-name-to-object 'portuguese-population *current-problem-space*)
                    (p4::object-name-to-object 'romanian-population *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka us-population1))
              (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka us-population2))
              (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka portuguese-population))
              (p4::instantiate-consed-literal '(removed-from-loc iii-mef sri-lanka romanian-population)))))

(setf (p4::a-or-b-node-applied (find-node 84))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 84))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-evacuated iii-mef sri-lanka))))))
 
(setf (p4::nexus-children (find-node 84))
  (list
    (p4::make-goal-node 
        :name 85 
        :parent (find-node 84) 
        :goal 
            (p4::instantiate-consed-literal '(is-neo-supported sri-lanka)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 85))
  (list
    (p4::make-operator-node 
        :name 86 
        :parent (find-node 85) 
        :operator (p4::get-operator support-neo))))
 
(setf (p4::nexus-children (find-node 86))
  (list
    (p4::make-binding-node 
        :name 87 
        :parent (find-node 86)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 87))
      (p4::make-instantiated-op
          :op (p4::get-operator support-neo)
          :binding-node-back-pointer (find-node 87)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object '45th-support-group *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka)))))
 
(setf (p4::nexus-children (find-node 87))
  (list
    (p4::make-applied-op-node 
        :name 88 
        :parent (find-node 87)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 88))
      (p4::make-instantiated-op
          :op (p4::get-operator support-neo)
          :binding-node-back-pointer (find-node 87)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object '45th-support-group *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed 45th-support-group sri-lanka)))))

(setf (p4::a-or-b-node-applied (find-node 88))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 88))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-neo-supported sri-lanka))))))
 
(setf (p4::nexus-children (find-node 88))
  (list
    (p4::make-goal-node 
        :name 89 
        :parent (find-node 88) 
        :goal 
            (p4::instantiate-consed-literal '(is-sovereign sri-lanka 11-meu-soc)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 89))
  (list
    (p4::make-operator-node 
        :name 90 
        :parent (find-node 89) 
        :operator (p4::get-operator isolate-battlefield))))
 
(setf (p4::nexus-children (find-node 90))
  (list
    (p4::make-binding-node 
        :name 91 
        :parent (find-node 90)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-blockaded sri-lanka uss-nimitz-cvg carrier-air-wing-9))
              (p4::instantiate-consed-literal '(made-ineffective-by malayasian-brigade 11-meu-soc)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 91))
      (p4::make-instantiated-op
          :op (p4::get-operator isolate-battlefield)
          :binding-node-back-pointer (find-node 91)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*)
                    (p4::object-name-to-object 'carrier-air-wing-9 *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'malayasian-brigade *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-blockaded sri-lanka uss-nimitz-cvg carrier-air-wing-9))
              (p4::instantiate-consed-literal '(made-ineffective-by malayasian-brigade 11-meu-soc)))))
 
(setf (p4::nexus-children (find-node 91))
  (list
    (p4::make-goal-node 
        :name 92 
        :parent (find-node 91) 
        :goal 
            (p4::instantiate-consed-literal '(is-blockaded sri-lanka uss-nimitz-cvg carrier-air-wing-9)) 
        :introducing-operators (list (find-node 91) )))) 
 
(setf (p4::nexus-children (find-node 92))
  (list
    (p4::make-operator-node 
        :name 93 
        :parent (find-node 92) 
        :operator (p4::get-operator do-blockade))))
 
(setf (p4::nexus-children (find-node 93))
  (list
    (p4::make-binding-node 
        :name 94 
        :parent (find-node 93)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(part-of carrier-air-wing-9 uss-nimitz-cvg))
              (p4::instantiate-consed-literal '(naval-blockaded sri-lanka uss-nimitz-cvg))
              (p4::instantiate-consed-literal '(air-blockaded sri-lanka carrier-air-wing-9)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 94))
      (p4::make-instantiated-op
          :op (p4::get-operator do-blockade)
          :binding-node-back-pointer (find-node 94)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'carrier-air-wing-9 *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(part-of carrier-air-wing-9 uss-nimitz-cvg))
              (p4::instantiate-consed-literal '(naval-blockaded sri-lanka uss-nimitz-cvg))
              (p4::instantiate-consed-literal '(air-blockaded sri-lanka carrier-air-wing-9)))))
 
(setf (p4::nexus-children (find-node 94))
  (list
    (p4::make-goal-node 
        :name 95 
        :parent (find-node 94) 
        :goal 
            (p4::instantiate-consed-literal '(naval-blockaded sri-lanka uss-nimitz-cvg)) 
        :introducing-operators (list (find-node 94) )))) 
 
(setf (p4::nexus-children (find-node 95))
  (list
    (p4::make-operator-node 
        :name 96 
        :parent (find-node 95) 
        :operator (p4::get-operator naval-blockade))))
 
(setf (p4::nexus-children (find-node 96))
  (list
    (p4::make-binding-node 
        :name 97 
        :parent (find-node 96)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(is-deployed uss-nimitz-cvg sri-lanka)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 97))
      (p4::make-instantiated-op
          :op (p4::get-operator naval-blockade)
          :binding-node-back-pointer (find-node 97)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(is-deployed uss-nimitz-cvg sri-lanka)))))
 
(setf (p4::nexus-children (find-node 97))
  (list
    (p4::make-goal-node 
        :name 98 
        :parent (find-node 97) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed uss-nimitz-cvg sri-lanka)) 
        :introducing-operators (list (find-node 97) )))) 
 
(setf (p4::nexus-children (find-node 98))
  (list
    (p4::make-operator-node 
        :name 99 
        :parent (find-node 98) 
        :operator (p4::get-operator deploy-ships))))
 
(setf (p4::nexus-children (find-node 99))
  (list
    (p4::make-binding-node 
        :name 100 
        :parent (find-node 99)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active uss-nimitz-cvg)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 100))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy-ships)
          :binding-node-back-pointer (find-node 100)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active uss-nimitz-cvg)))))
 
(setf (p4::nexus-children (find-node 100))
  (list
    (p4::make-applied-op-node 
        :name 101 
        :parent (find-node 100)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 101))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy-ships)
          :binding-node-back-pointer (find-node 100)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active uss-nimitz-cvg)))))

(setf (p4::a-or-b-node-applied (find-node 101))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 101))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed uss-nimitz-cvg sri-lanka))))))
 
(setf (p4::nexus-children (find-node 101))
  (list
    (p4::make-applied-op-node 
        :name 102 
        :parent (find-node 101)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 102))
      (p4::make-instantiated-op
          :op (p4::get-operator naval-blockade)
          :binding-node-back-pointer (find-node 97)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(is-deployed uss-nimitz-cvg sri-lanka)))))

(setf (p4::a-or-b-node-applied (find-node 102))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 102))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(naval-blockaded sri-lanka uss-nimitz-cvg))))))
 
(setf (p4::nexus-children (find-node 102))
  (list
    (p4::make-goal-node 
        :name 103 
        :parent (find-node 102) 
        :goal 
            (p4::instantiate-consed-literal '(air-blockaded sri-lanka carrier-air-wing-9)) 
        :introducing-operators (list (find-node 94) (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 103))
  (list
    (p4::make-operator-node 
        :name 104 
        :parent (find-node 103) 
        :operator (p4::get-operator air-blockade))))
 
(setf (p4::nexus-children (find-node 104))
  (list
    (p4::make-binding-node 
        :name 105 
        :parent (find-node 104)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(part-of carrier-air-wing-9 uss-nimitz-cvg)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 105))
      (p4::make-instantiated-op
          :op (p4::get-operator air-blockade)
          :binding-node-back-pointer (find-node 105)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'carrier-air-wing-9 *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(part-of carrier-air-wing-9 uss-nimitz-cvg)))))
 
(setf (p4::nexus-children (find-node 105))
  (list
    (p4::make-applied-op-node 
        :name 106 
        :parent (find-node 105)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 106))
      (p4::make-instantiated-op
          :op (p4::get-operator air-blockade)
          :binding-node-back-pointer (find-node 105)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'carrier-air-wing-9 *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(part-of carrier-air-wing-9 uss-nimitz-cvg)))))

(setf (p4::a-or-b-node-applied (find-node 106))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 106))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(air-blockaded sri-lanka carrier-air-wing-9))))))
 
(setf (p4::nexus-children (find-node 106))
  (list
    (p4::make-applied-op-node 
        :name 107 
        :parent (find-node 106)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 107))
      (p4::make-instantiated-op
          :op (p4::get-operator do-blockade)
          :binding-node-back-pointer (find-node 94)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'carrier-air-wing-9 *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-nimitz-cvg day-19))
              (p4::instantiate-consed-literal '(part-of carrier-air-wing-9 uss-nimitz-cvg))
              (p4::instantiate-consed-literal '(naval-blockaded sri-lanka uss-nimitz-cvg))
              (p4::instantiate-consed-literal '(air-blockaded sri-lanka carrier-air-wing-9)))))

(setf (p4::a-or-b-node-applied (find-node 107))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 107))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-blockaded sri-lanka uss-nimitz-cvg carrier-air-wing-9))))))
 
(setf (p4::nexus-children (find-node 107))
  (list
    (p4::make-goal-node 
        :name 108 
        :parent (find-node 107) 
        :goal 
            (p4::instantiate-consed-literal '(made-ineffective-by malayasian-brigade 11-meu-soc)) 
        :introducing-operators (list (find-node 91) )))) 
 
(setf (p4::nexus-children (find-node 108))
  (list
    (p4::make-operator-node 
        :name 109 
        :parent (find-node 108) 
        :operator (p4::get-operator specialize-inneffective-2-destroy))))
 
(setf (p4::nexus-children (find-node 109))
  (list
    (p4::make-binding-node 
        :name 110 
        :parent (find-node 109)
        :instantiated-preconds 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(near alice malayasian-brigade)))
              (p4::instantiate-consed-literal '(is-destroyed-by malayasian-brigade 11-meu-soc)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 110))
      (p4::make-instantiated-op
          :op (p4::get-operator specialize-inneffective-2-destroy)
          :binding-node-back-pointer (find-node 110)
          :values (list 
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*)
                    (p4::object-name-to-object 'alice *current-problem-space*)
                    (p4::object-name-to-object 'malayasian-brigade *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(near alice malayasian-brigade)))
              (p4::instantiate-consed-literal '(is-destroyed-by malayasian-brigade 11-meu-soc)))))
 
(setf (p4::nexus-children (find-node 110))
  (list
    (p4::make-goal-node 
        :name 111 
        :parent (find-node 110) 
        :goal 
            (p4::instantiate-consed-literal '(is-destroyed-by malayasian-brigade 11-meu-soc)) 
        :introducing-operators (list (find-node 110) )))) 
 
(setf (p4::nexus-children (find-node 111))
  (list
    (p4::make-operator-node 
        :name 112 
        :parent (find-node 111) 
        :operator (p4::get-operator attack))))
 
(setf (p4::nexus-children (find-node 112))
  (list
    (p4::make-binding-node 
        :name 113 
        :parent (find-node 112)
        :instantiated-preconds 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(impossible-precondition)))
              (p4::instantiate-consed-literal '(is-ready 11-meu-soc))
              (p4::instantiate-consed-literal '(is-deployed malayasian-brigade town-center1))
              (p4::instantiate-consed-literal '(loc-at town-center1 mindanao))
              (p4::instantiate-consed-literal '(is-deployed 11-meu-soc mindanao)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 113))
      (p4::make-instantiated-op
          :op (p4::get-operator attack)
          :binding-node-back-pointer (find-node 113)
          :values (list 
                    (p4::object-name-to-object 'malayasian-brigade *current-problem-space*)
                    (p4::object-name-to-object 'town-center1 *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*)
                    (p4::object-name-to-object 'mindanao *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(impossible-precondition)))
              (p4::instantiate-consed-literal '(is-ready 11-meu-soc))
              (p4::instantiate-consed-literal '(is-deployed malayasian-brigade town-center1))
              (p4::instantiate-consed-literal '(loc-at town-center1 mindanao))
              (p4::instantiate-consed-literal '(is-deployed 11-meu-soc mindanao)))))
 
(setf (p4::nexus-children (find-node 113))
  (list
    (p4::make-goal-node 
        :name 114 
        :parent (find-node 113) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed 11-meu-soc mindanao)) 
        :introducing-operators (list (find-node 113) )))) 
 
(setf (p4::nexus-children (find-node 114))
  (list
    (p4::make-operator-node 
        :name 115 
        :parent (find-node 114) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 115))
  (list
    (p4::make-binding-node 
        :name 116 
        :parent (find-node 115)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 11-meu-soc))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 mindanao))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 116))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 116)
          :values (list 
                    (p4::object-name-to-object 'mindanao *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 11-meu-soc))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 mindanao))))))
 
(setf (p4::nexus-children (find-node 116))
  (list
    (p4::make-applied-op-node 
        :name 117 
        :parent (find-node 116)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 117))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 116)
          :values (list 
                    (p4::object-name-to-object 'mindanao *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 11-meu-soc))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 mindanao))))))

(setf (p4::a-or-b-node-applied (find-node 117))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 117))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed 11-meu-soc mindanao))))))
 
(setf (p4::nexus-children (find-node 117))
  (list
    (p4::make-applied-op-node 
        :name 118 
        :parent (find-node 117)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 118))
      (p4::make-instantiated-op
          :op (p4::get-operator attack)
          :binding-node-back-pointer (find-node 113)
          :values (list 
                    (p4::object-name-to-object 'malayasian-brigade *current-problem-space*)
                    (p4::object-name-to-object 'town-center1 *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*)
                    (p4::object-name-to-object 'mindanao *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(impossible-precondition)))
              (p4::instantiate-consed-literal '(is-ready 11-meu-soc))
              (p4::instantiate-consed-literal '(is-deployed malayasian-brigade town-center1))
              (p4::instantiate-consed-literal '(loc-at town-center1 mindanao))
              (p4::instantiate-consed-literal '(is-deployed 11-meu-soc mindanao)))))

(setf (p4::a-or-b-node-applied (find-node 118))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 118))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-destroyed-by malayasian-brigade 11-meu-soc)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(is-ready 11-meu-soc))))))
 
(setf (p4::nexus-children (find-node 118))
  (list
    (p4::make-applied-op-node 
        :name 119 
        :parent (find-node 118)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 119))
      (p4::make-instantiated-op
          :op (p4::get-operator specialize-inneffective-2-destroy)
          :binding-node-back-pointer (find-node 110)
          :values (list 
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*)
                    (p4::object-name-to-object 'alice *current-problem-space*)
                    (p4::object-name-to-object 'malayasian-brigade *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(near alice malayasian-brigade)))
              (p4::instantiate-consed-literal '(is-destroyed-by malayasian-brigade 11-meu-soc)))))

(setf (p4::a-or-b-node-applied (find-node 119))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 119))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(made-ineffective-by malayasian-brigade 11-meu-soc))))))
 
(setf (p4::nexus-children (find-node 119))
  (list
    (p4::make-applied-op-node 
        :name 120 
        :parent (find-node 119)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 120))
      (p4::make-instantiated-op
          :op (p4::get-operator isolate-battlefield)
          :binding-node-back-pointer (find-node 91)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object '11-meu-soc *current-problem-space*)
                    (p4::object-name-to-object 'carrier-air-wing-9 *current-problem-space*)
                    (p4::object-name-to-object 'uss-nimitz-cvg *current-problem-space*)
                    (p4::object-name-to-object 'malayasian-brigade *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-blockaded sri-lanka uss-nimitz-cvg carrier-air-wing-9))
              (p4::instantiate-consed-literal '(made-ineffective-by malayasian-brigade 11-meu-soc)))))

(setf (p4::a-or-b-node-applied (find-node 120))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 120))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-sovereign sri-lanka 11-meu-soc))))))
 
(setf (p4::nexus-children (find-node 120))
  (list
    (p4::make-goal-node 
        :name 121 
        :parent (find-node 120) 
        :goal 
            (p4::instantiate-consed-literal '(air-defended sri-lanka 18th-wing)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 121))
  (list
    (p4::make-operator-node 
        :name 122 
        :parent (find-node 121) 
        :operator (p4::get-operator air-defense))))
 
(setf (p4::nexus-children (find-node 122))
  (list
    (p4::make-binding-node 
        :name 123 
        :parent (find-node 122)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available 18th-wing day-19))
              (p4::instantiate-consed-literal '(is-deployed 18th-wing sri-lanka)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 123))
      (p4::make-instantiated-op
          :op (p4::get-operator air-defense)
          :binding-node-back-pointer (find-node 123)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object '18th-wing *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available 18th-wing day-19))
              (p4::instantiate-consed-literal '(is-deployed 18th-wing sri-lanka)))))
 
(setf (p4::nexus-children (find-node 123))
  (list
    (p4::make-goal-node 
        :name 124 
        :parent (find-node 123) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed 18th-wing sri-lanka)) 
        :introducing-operators (list (find-node 123) )))) 
 
(setf (p4::nexus-children (find-node 124))
  (list
    (p4::make-operator-node 
        :name 125 
        :parent (find-node 124) 
        :operator (p4::get-operator deploy))))
 
(setf (p4::nexus-children (find-node 125))
  (list
    (p4::make-binding-node 
        :name 126 
        :parent (find-node 125)
        :instantiated-preconds 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 18th-wing)))
              (p4::instantiate-consed-literal '(loc-at colombo-airport sri-lanka))
              (p4::instantiate-consed-literal '(is-active 18th-wing))
              (p4::instantiate-consed-literal '(airport-secure-at sri-lanka colombo-airport))
              (p4::instantiate-consed-literal '(is-usable colombo-airport)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 126))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 126)
          :values (list 
                    (p4::object-name-to-object '18th-wing *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'colombo-airport *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 18th-wing)))
              (p4::instantiate-consed-literal '(loc-at colombo-airport sri-lanka))
              (p4::instantiate-consed-literal '(is-active 18th-wing))
              (p4::instantiate-consed-literal '(airport-secure-at sri-lanka colombo-airport))
              (p4::instantiate-consed-literal '(is-usable colombo-airport)))))
 
(setf (p4::nexus-children (find-node 126))
  (list
    (p4::make-goal-node 
        :name 127 
        :parent (find-node 126) 
        :goal 
            (p4::instantiate-consed-literal '(airport-secure-at sri-lanka colombo-airport)) 
        :introducing-operators (list (find-node 126) )))) 
 
(setf (p4::nexus-children (find-node 127))
  (list
    (p4::make-operator-node 
        :name 128 
        :parent (find-node 127) 
        :operator (p4::get-operator secure))))
 
(setf (p4::nexus-children (find-node 128))
  (list
    (p4::make-binding-node 
        :name 129 
        :parent (find-node 128)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at colombo-airport sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed 6th-id sri-lanka)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 129))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 129)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'colombo-airport *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object '6th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at colombo-airport sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed 6th-id sri-lanka)))))
 
(setf (p4::nexus-children (find-node 129))
  (list
    (p4::make-goal-node 
        :name 130 
        :parent (find-node 129) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka)) 
        :introducing-operators (list (find-node 129) )))) 
 
(setf (p4::nexus-children (find-node 130))
  (list
    (p4::make-operator-node 
        :name 131 
        :parent (find-node 130) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 131))
  (list
    (p4::make-binding-node 
        :name 132 
        :parent (find-node 131)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 132))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 132)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))
 
(setf (p4::nexus-children (find-node 132))
  (list
    (p4::make-applied-op-node 
        :name 133 
        :parent (find-node 132)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 133))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 132)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))

(setf (p4::a-or-b-node-applied (find-node 133))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 133))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka))))))
 
(setf (p4::nexus-children (find-node 133))
  (list
    (p4::make-goal-node 
        :name 134 
        :parent (find-node 133) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka)) 
        :introducing-operators (list (find-node 129) )))) 
 
(setf (p4::nexus-children (find-node 134))
  (list
    (p4::make-operator-node 
        :name 135 
        :parent (find-node 134) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 135))
  (list
    (p4::make-binding-node 
        :name 136 
        :parent (find-node 135)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 136))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 136)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))
 
(setf (p4::nexus-children (find-node 136))
  (list
    (p4::make-applied-op-node 
        :name 137 
        :parent (find-node 136)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 137))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 136)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))

(setf (p4::a-or-b-node-applied (find-node 137))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 137))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka))))))
 
(setf (p4::nexus-children (find-node 137))
  (list
    (p4::make-goal-node 
        :name 138 
        :parent (find-node 137) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed 6th-id sri-lanka)) 
        :introducing-operators (list (find-node 129) )))) 
 
(setf (p4::nexus-children (find-node 138))
  (list
    (p4::make-operator-node 
        :name 139 
        :parent (find-node 138) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 139))
  (list
    (p4::make-binding-node 
        :name 140 
        :parent (find-node 139)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 6th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 140))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 140)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '6th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 6th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))
 
(setf (p4::nexus-children (find-node 140))
  (list
    (p4::make-applied-op-node 
        :name 141 
        :parent (find-node 140)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 141))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 140)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '6th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 6th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))

(setf (p4::a-or-b-node-applied (find-node 141))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 141))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed 6th-id sri-lanka))))))
 
(setf (p4::nexus-children (find-node 141))
  (list
    (p4::make-applied-op-node 
        :name 142 
        :parent (find-node 141)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 142))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 129)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'colombo-airport *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object '6th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at colombo-airport sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed security-police-a sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed 6th-id sri-lanka)))))

(setf (p4::a-or-b-node-applied (find-node 142))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 142))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(airport-secure-at sri-lanka colombo-airport))))))
 
(setf (p4::nexus-children (find-node 142))
  (list
    (p4::make-applied-op-node 
        :name 143 
        :parent (find-node 142)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 143))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 126)
          :values (list 
                    (p4::object-name-to-object '18th-wing *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'colombo-airport *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 18th-wing)))
              (p4::instantiate-consed-literal '(loc-at colombo-airport sri-lanka))
              (p4::instantiate-consed-literal '(is-active 18th-wing))
              (p4::instantiate-consed-literal '(airport-secure-at sri-lanka colombo-airport))
              (p4::instantiate-consed-literal '(is-usable colombo-airport)))))

(setf (p4::a-or-b-node-applied (find-node 143))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 143))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed 18th-wing sri-lanka))))))
 
(setf (p4::nexus-children (find-node 143))
  (list
    (p4::make-applied-op-node 
        :name 144 
        :parent (find-node 143)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 144))
      (p4::make-instantiated-op
          :op (p4::get-operator air-defense)
          :binding-node-back-pointer (find-node 123)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object '18th-wing *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available 18th-wing day-19))
              (p4::instantiate-consed-literal '(is-deployed 18th-wing sri-lanka)))))

(setf (p4::a-or-b-node-applied (find-node 144))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 144))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(air-defended sri-lanka 18th-wing))))))
 
(setf (p4::nexus-children (find-node 144))
  (list
    (p4::make-goal-node 
        :name 145 
        :parent (find-node 144) 
        :goal 
            (p4::instantiate-consed-literal '(naval-blockaded sri-lanka uss-essex-cvg)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 145))
  (list
    (p4::make-operator-node 
        :name 146 
        :parent (find-node 145) 
        :operator (p4::get-operator naval-blockade))))
 
(setf (p4::nexus-children (find-node 146))
  (list
    (p4::make-binding-node 
        :name 147 
        :parent (find-node 146)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-essex-cvg day-19))
              (p4::instantiate-consed-literal '(is-deployed uss-essex-cvg sri-lanka)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 147))
      (p4::make-instantiated-op
          :op (p4::get-operator naval-blockade)
          :binding-node-back-pointer (find-node 147)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'uss-essex-cvg *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-essex-cvg day-19))
              (p4::instantiate-consed-literal '(is-deployed uss-essex-cvg sri-lanka)))))
 
(setf (p4::nexus-children (find-node 147))
  (list
    (p4::make-goal-node 
        :name 148 
        :parent (find-node 147) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed uss-essex-cvg sri-lanka)) 
        :introducing-operators (list (find-node 147) )))) 
 
(setf (p4::nexus-children (find-node 148))
  (list
    (p4::make-operator-node 
        :name 149 
        :parent (find-node 148) 
        :operator (p4::get-operator deploy-ships))))
 
(setf (p4::nexus-children (find-node 149))
  (list
    (p4::make-binding-node 
        :name 150 
        :parent (find-node 149)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active uss-essex-cvg)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 150))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy-ships)
          :binding-node-back-pointer (find-node 150)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'uss-essex-cvg *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active uss-essex-cvg)))))
 
(setf (p4::nexus-children (find-node 150))
  (list
    (p4::make-applied-op-node 
        :name 151 
        :parent (find-node 150)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 151))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy-ships)
          :binding-node-back-pointer (find-node 150)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'uss-essex-cvg *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active uss-essex-cvg)))))

(setf (p4::a-or-b-node-applied (find-node 151))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 151))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed uss-essex-cvg sri-lanka))))))
 
(setf (p4::nexus-children (find-node 151))
  (list
    (p4::make-applied-op-node 
        :name 152 
        :parent (find-node 151)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 152))
      (p4::make-instantiated-op
          :op (p4::get-operator naval-blockade)
          :binding-node-back-pointer (find-node 147)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'uss-essex-cvg *current-problem-space*)
                    (p4::object-name-to-object 'day-19 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-available uss-essex-cvg day-19))
              (p4::instantiate-consed-literal '(is-deployed uss-essex-cvg sri-lanka)))))

(setf (p4::a-or-b-node-applied (find-node 152))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 152))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(naval-blockaded sri-lanka uss-essex-cvg))))))
