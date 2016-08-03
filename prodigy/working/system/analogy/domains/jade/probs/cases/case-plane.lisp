 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed f16-c-squadron sri-lanka))
              (p4::instantiate-consed-literal '(airport-secure-at sri-lanka airport1))
              (p4::instantiate-consed-literal '(is-deployed infantry-battalion-a sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed security-police-b sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator p4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-deployed f16-c-squadron sri-lanka))
              (p4::instantiate-consed-literal '(airport-secure-at sri-lanka airport1))
              (p4::instantiate-consed-literal '(is-deployed infantry-battalion-a sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed security-police-b sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed f16-c-squadron sri-lanka)) 
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
                (p4::instantiate-consed-literal '(isa-c141 f16-c-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka))
              (p4::instantiate-consed-literal '(is-active f16-c-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at sri-lanka airport1))
              (p4::instantiate-consed-literal '(is-usable airport1)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator deploy)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'f16-c-squadron *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 f16-c-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka))
              (p4::instantiate-consed-literal '(is-active f16-c-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at sri-lanka airport1))
              (p4::instantiate-consed-literal '(is-usable airport1)))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(airport-secure-at sri-lanka airport1)) 
        :introducing-operators (list (find-node 7) (find-node 4) )))) 
 
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
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed security-police-b sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed infantry-battalion-a sri-lanka)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-b *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object 'infantry-battalion-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed security-police-b sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed infantry-battalion-a sri-lanka)))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 11 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed security-police-b sri-lanka)) 
        :introducing-operators (list (find-node 10) (find-node 4) )))) 
 
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
              (p4::instantiate-consed-literal '(is-active security-police-b))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 13))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 13)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-b *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-b))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))
 
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
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-b *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-b))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))

(setf (p4::a-or-b-node-applied (find-node 14))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 14))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed security-police-b sri-lanka))))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-goal-node 
        :name 15 
        :parent (find-node 14) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka)) 
        :introducing-operators (list (find-node 10) (find-node 4) )))) 
 
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
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 17))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 17)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))
 
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
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))

(setf (p4::a-or-b-node-applied (find-node 18))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 18))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka))))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-goal-node 
        :name 19 
        :parent (find-node 18) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed infantry-battalion-a sri-lanka)) 
        :introducing-operators (list (find-node 10) (find-node 4) )))) 
 
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
              (p4::instantiate-consed-literal '(is-active infantry-battalion-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 21))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 21)
          :values (list 
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'infantry-battalion-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active infantry-battalion-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))
 
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
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'infantry-battalion-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active infantry-battalion-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 sri-lanka))))))

(setf (p4::a-or-b-node-applied (find-node 22))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 22))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed infantry-battalion-a sri-lanka))))))
 
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
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-b *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object 'infantry-battalion-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed security-police-b sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed hawka sri-lanka))
              (p4::instantiate-consed-literal '(is-deployed infantry-battalion-a sri-lanka)))))

(setf (p4::a-or-b-node-applied (find-node 23))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 23))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(airport-secure-at sri-lanka airport1))))))
 
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
                    (p4::object-name-to-object 'f16-c-squadron *current-problem-space*)
                    (p4::object-name-to-object 'sri-lanka *current-problem-space*)
                    (p4::object-name-to-object 'airport1 *current-problem-space*))
          :precond 
            (list 'and 
              (list '~ 
                (p4::instantiate-consed-literal '(isa-c141 f16-c-squadron)))
              (p4::instantiate-consed-literal '(loc-at airport1 sri-lanka))
              (p4::instantiate-consed-literal '(is-active f16-c-squadron))
              (p4::instantiate-consed-literal '(airport-secure-at sri-lanka airport1))
              (p4::instantiate-consed-literal '(is-usable airport1)))))

(setf (p4::a-or-b-node-applied (find-node 24))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 24))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed f16-c-squadron sri-lanka))))))
