 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(airport-secure-at johnston-atoll airport6)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator p4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(airport-secure-at johnston-atoll airport6)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(airport-secure-at johnston-atoll airport6)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator secure))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport6 johnston-atoll))
              (p4::instantiate-consed-literal '(is-deployed security-police-a johnston-atoll))
              (p4::instantiate-consed-literal '(is-deployed hawka johnston-atoll))
              (p4::instantiate-consed-literal '(is-deployed 25th-id johnston-atoll)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'johnston-atoll *current-problem-space*)
                    (p4::object-name-to-object 'airport6 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object '25th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport6 johnston-atoll))
              (p4::instantiate-consed-literal '(is-deployed security-police-a johnston-atoll))
              (p4::instantiate-consed-literal '(is-deployed hawka johnston-atoll))
              (p4::instantiate-consed-literal '(is-deployed 25th-id johnston-atoll)))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed security-police-a johnston-atoll)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator send))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 johnston-atoll))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'johnston-atoll *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 johnston-atoll))))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-applied-op-node 
        :name 11 
        :parent (find-node 10)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 11))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'johnston-atoll *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active security-police-a))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 johnston-atoll))))))

(setf (p4::a-or-b-node-applied (find-node 11))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 11))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed security-police-a johnston-atoll))))))
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-goal-node 
        :name 12 
        :parent (find-node 11) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed hawka johnston-atoll)) 
        :introducing-operators (list (find-node 7) )))) 
 
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
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 johnston-atoll))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 14))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 14)
          :values (list 
                    (p4::object-name-to-object 'johnston-atoll *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 johnston-atoll))))))
 
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
                    (p4::object-name-to-object 'johnston-atoll *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active hawka))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 johnston-atoll))))))

(setf (p4::a-or-b-node-applied (find-node 15))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 15))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed hawka johnston-atoll))))))
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-goal-node 
        :name 16 
        :parent (find-node 15) 
        :goal 
            (p4::instantiate-consed-literal '(is-deployed 25th-id johnston-atoll)) 
        :introducing-operators (list (find-node 7) )))) 
 
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
              (p4::instantiate-consed-literal '(is-active 25th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 johnston-atoll))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 18))
      (p4::make-instantiated-op
          :op (p4::get-operator send)
          :binding-node-back-pointer (find-node 18)
          :values (list 
                    (p4::object-name-to-object 'johnston-atoll *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '25th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 25th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 johnston-atoll))))))
 
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
                    (p4::object-name-to-object 'johnston-atoll *current-problem-space*)
                    (p4::object-name-to-object 'weapons-smuggling1 *current-problem-space*)
                    (p4::object-name-to-object '25th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(is-active 25th-id))
              (list '~ 
                (p4::instantiate-consed-literal '(threat-at weapons-smuggling1 johnston-atoll))))))

(setf (p4::a-or-b-node-applied (find-node 19))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 19))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(is-deployed 25th-id johnston-atoll))))))
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-applied-op-node 
        :name 20 
        :parent (find-node 19)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 20))
      (p4::make-instantiated-op
          :op (p4::get-operator secure)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'johnston-atoll *current-problem-space*)
                    (p4::object-name-to-object 'airport6 *current-problem-space*)
                    (p4::object-name-to-object 'security-police-a *current-problem-space*)
                    (p4::object-name-to-object 'hawka *current-problem-space*)
                    (p4::object-name-to-object '25th-id *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(loc-at airport6 johnston-atoll))
              (p4::instantiate-consed-literal '(is-deployed security-police-a johnston-atoll))
              (p4::instantiate-consed-literal '(is-deployed hawka johnston-atoll))
              (p4::instantiate-consed-literal '(is-deployed 25th-id johnston-atoll)))))

(setf (p4::a-or-b-node-applied (find-node 20))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 20))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(airport-secure-at johnston-atoll airport6))))))
