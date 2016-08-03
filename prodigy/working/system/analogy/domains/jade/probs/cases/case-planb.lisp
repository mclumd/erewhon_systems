 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed hawka saudi-arabia))
              (p4::instantiate-consed-literal '(is-deployed infantry-battalion-a saudi-arabia))
              (p4::instantiate-consed-literal '(is-deployed f15-c-squadron saudi-arabia))
              (p4::instantiate-consed-literal '(is-interdicted saudi-arabia)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator p4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed hawka saudi-arabia))
              (p4::instantiate-consed-literal '(is-deployed infantry-battalion-a saudi-arabia))
              (p4::instantiate-consed-literal '(is-deployed f15-c-squadron saudi-arabia))
              (p4::instantiate-consed-literal '(is-interdicted saudi-arabia)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed hawka saudi-arabia)) 
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
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling2 saudi-arabia))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'saudi-arabia *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling2 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling2 saudi-arabia))))))
 
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
                    (p4::object-name-to-object 'saudi-arabia *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling2 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling2 saudi-arabia))))))

(setf (p4::a-or-b-node-applied (find-node 8))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 8))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed hawka saudi-arabia))))))
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-goal-node 
        :name 9 
        :parent (find-node 8) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed infantry-battalion-a saudi-arabia)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-operator-node 
        :name 10 
        :parent (find-node 9) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-binding-node 
        :name 11 
        :parent (find-node 10)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active infantry-battalion-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling2 saudi-arabia))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 11))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 11)
          :values (list 
                    (p4::object-name-to-object 'saudi-arabia *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling2 *current-problem-space*)
                    (p4::object-name-to-object 'infantry-battalion-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active infantry-battalion-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling2 saudi-arabia))))))
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-applied-op-node 
        :name 12 
        :parent (find-node 11)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 12))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 11)
          :values (list 
                    (p4::object-name-to-object 'saudi-arabia *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling2 *current-problem-space*)
                    (p4::object-name-to-object 'infantry-battalion-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active infantry-battalion-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling2 saudi-arabia))))))

(setf (p4::a-or-b-node-applied (find-node 12))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 12))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed infantry-battalion-a saudi-arabia))))))
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-goal-node 
        :name 13 
        :parent (find-node 12) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed f15-c-squadron saudi-arabia)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-operator-node 
        :name 14 
        :parent (find-node 13) 
        :operator (p4::get-operator deploy))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-binding-node 
        :name 15 
        :parent (find-node 14)
        :instantiated-preconds 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 f15-c-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport3 saudi-arabia))
              (p4::instantiate-consed-literal '(is-active f15-c-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at saudi-arabia airport3))
              (p4::instantiate-consed-literal '(is-usable airport3)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 15))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 15)
          :values (list 
                    (p4::object-name-to-object 'f15-c-squadron *current-problem-space*)
                    (p4::object-name-to-object 'saudi-arabia *current-problem-space*)
                    (p4::object-name-to-object 'airport3 *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 f15-c-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport3 saudi-arabia))
              (p4::instantiate-consed-literal '(is-active f15-c-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at saudi-arabia airport3))
              (p4::instantiate-consed-literal '(is-usable airport3)))))
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-goal-node 
        :name 16 
        :parent (find-node 15) 
        :goal 
            (p4::instantiate-consed-literal '(airport-secure-at saudi-arabia airport3)) 
        :introducing-operators (list (find-node 15) )))) 
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-operator-node 
        :name 17 
        :parent (find-node 16) 
        :operator (p4::get-operator secure))))
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-binding-node 
        :name 18 
        :parent (find-node 17)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport3 saudi-arabia))
              (p4::instantiate-consed-literal '(is-deployed security-police-b saudi-arabia))
              (p4::instantiate-consed-literal '(is-deployed hawka saudi-arabia))
              (p4::instantiate-consed-literal '(is-deployed infantry-battalion-a saudi-arabia)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 18))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 18)
          :values (list 
                    (p4::object-name-to-object 'saudi-arabia *current-problem-space*)
                    (p4::object-name-to-object 'airport3 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-b *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object 'infantry-battalion-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport3 saudi-arabia))
              (p4::instantiate-consed-literal '(is-deployed security-police-b saudi-arabia))
              (p4::instantiate-consed-literal '(is-deployed hawka saudi-arabia))
              (p4::instantiate-consed-literal '(is-deployed infantry-battalion-a saudi-arabia)))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-goal-node 
        :name 19 
        :parent (find-node 18) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed security-police-b saudi-arabia)) 
        :introducing-operators (list (find-node 18) )))) 
 
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
              (p4::instantiate-consed-literal '(is-active security-police-b))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling2 saudi-arabia))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 21))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 21)
          :values (list 
                    (p4::object-name-to-object 'saudi-arabia *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling2 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-b *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-b))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling2 saudi-arabia))))))
 
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
                    (p4::object-name-to-object 'saudi-arabia *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling2 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-b *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-b))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling2 saudi-arabia))))))

(setf (p4::a-or-b-node-applied (find-node 22))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 22))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed security-police-b saudi-arabia))))))
 
(setf (p4::nexus-children (find-node 22))
  (list
    (p4::make-applied-op-node 
        :name 23 
        :parent (find-node 22)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 23))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 18)
          :values (list 
                    (p4::object-name-to-object 'saudi-arabia *current-problem-space*)
                    (p4::object-name-to-object 'airport3 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-b *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object 'infantry-battalion-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport3 saudi-arabia))
              (p4::instantiate-consed-literal '(is-deployed security-police-b saudi-arabia))
              (p4::instantiate-consed-literal '(is-deployed hawka saudi-arabia))
              (p4::instantiate-consed-literal '(is-deployed infantry-battalion-a saudi-arabia)))))

(setf (p4::a-or-b-node-applied (find-node 23))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 23))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(airport-secure-at saudi-arabia airport3))))))
 
(setf (p4::nexus-children (find-node 23))
  (list
    (p4::make-applied-op-node 
        :name 24 
        :parent (find-node 23)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 24))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 15)
          :values (list 
                    (p4::object-name-to-object 'f15-c-squadron *current-problem-space*)
                    (p4::object-name-to-object 'saudi-arabia *current-problem-space*)
                    (p4::object-name-to-object 'airport3 *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 f15-c-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport3 saudi-arabia))
              (p4::instantiate-consed-literal '(is-active f15-c-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at saudi-arabia airport3))
              (p4::instantiate-consed-literal '(is-usable airport3)))))

(setf (p4::a-or-b-node-applied (find-node 24))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 24))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed f15-c-squadron saudi-arabia))))))
 
(setf (p4::nexus-children (find-node 24))
  (list
    (p4::make-goal-node 
        :name 25 
        :parent (find-node 24) 
        :goal 
            (p4::instantiate-consed-literal '(is-interdicted saudi-arabia)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 25))
  (list
    (p4::make-operator-node 
        :name 26 
        :parent (find-node 25) 
        :operator (p4::get-operator support))))
 
(setf (p4::nexus-children (find-node 26))
  (list
    (p4::make-binding-node 
        :name 27 
        :parent (find-node 26)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed f15-c-squadron saudi-arabia))
              (p4::instantiate-consed-literal '(mission-of f15-c-squadron air-interdiction)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 27))
      (p4::make-instantiated-op
          :op (p4::get-operator support)
          :binding-node-back-pointer (find-node 27)
          :values (list 
                    (p4::object-name-to-object 'f15-c-squadron *current-problem-space*)
                    (p4::object-name-to-object 'air-interdiction *current-problem-space*)
                    (p4::object-name-to-object 'saudi-arabia *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed f15-c-squadron saudi-arabia))
              (p4::instantiate-consed-literal '(mission-of f15-c-squadron air-interdiction)))))
 
(setf (p4::nexus-children (find-node 27))
  (list
    (p4::make-applied-op-node 
        :name 28 
        :parent (find-node 27)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 28))
      (p4::make-instantiated-op
          :op (p4::get-operator support)
          :binding-node-back-pointer (find-node 27)
          :values (list 
                    (p4::object-name-to-object 'f15-c-squadron *current-problem-space*)
                    (p4::object-name-to-object 'air-interdiction *current-problem-space*)
                    (p4::object-name-to-object 'saudi-arabia *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed f15-c-squadron saudi-arabia))
              (p4::instantiate-consed-literal '(mission-of f15-c-squadron air-interdiction)))))

(setf (p4::a-or-b-node-applied (find-node 28))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 28))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-interdicted saudi-arabia))))))
