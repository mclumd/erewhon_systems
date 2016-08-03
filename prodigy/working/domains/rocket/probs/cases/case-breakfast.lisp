 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at
                                                newcastle-brown-ale
                                                pittsburgh))
              (p4::instantiate-consed-literal '(at kippers pittsburgh)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at
                                                newcastle-brown-ale
                                                pittsburgh))
              (p4::instantiate-consed-literal '(at kippers pittsburgh)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(at
                                              newcastle-brown-ale
                                              pittsburgh)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator unload-rocket))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at rocket pittsburgh))
              (p4::instantiate-consed-literal '(in-rocket newcastle-brown-ale)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator unload-rocket)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'newcastle-brown-ale *current-problem-space*)
                    (p4::object-name-to-object 'pittsburgh *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at rocket pittsburgh))
              (p4::instantiate-consed-literal '(in-rocket newcastle-brown-ale)))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(in-rocket newcastle-brown-ale)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator load-rocket))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at newcastle-brown-ale london))
              (p4::instantiate-consed-literal '(at rocket london)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator load-rocket)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'newcastle-brown-ale *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at newcastle-brown-ale london))
              (p4::instantiate-consed-literal '(at rocket london)))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-applied-op-node 
        :name 11 
        :parent (find-node 10)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 11))
      (p4::make-instantiated-op
          :op (p4::get-operator load-rocket)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'newcastle-brown-ale *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at newcastle-brown-ale london))
              (p4::instantiate-consed-literal '(at rocket london)))))

(setf (p4::a-or-b-node-applied (find-node 11))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 11))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-rocket
                                                   newcastle-brown-ale)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at
                                                   newcastle-brown-ale
                                                   london))))))
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-goal-node 
        :name 12 
        :parent (find-node 11) 
        :goal 
            (p4::instantiate-consed-literal '(at kippers pittsburgh)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-operator-node 
        :name 13 
        :parent (find-node 12) 
        :operator (p4::get-operator unload-rocket))))
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-binding-node 
        :name 14 
        :parent (find-node 13)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at rocket pittsburgh))
              (p4::instantiate-consed-literal '(in-rocket kippers)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 14))
      (p4::make-instantiated-op
          :op (p4::get-operator unload-rocket)
          :binding-node-back-pointer (find-node 14)
          :values (list 
                    (p4::object-name-to-object 'kippers *current-problem-space*)
                    (p4::object-name-to-object 'pittsburgh *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at rocket pittsburgh))
              (p4::instantiate-consed-literal '(in-rocket kippers)))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-goal-node 
        :name 15 
        :parent (find-node 14) 
        :goal 
            (p4::instantiate-consed-literal '(in-rocket kippers)) 
        :introducing-operators (list (find-node 14) )))) 
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-operator-node 
        :name 16 
        :parent (find-node 15) 
        :operator (p4::get-operator load-rocket))))
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-binding-node 
        :name 17 
        :parent (find-node 16)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at kippers london))
              (p4::instantiate-consed-literal '(at rocket london)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 17))
      (p4::make-instantiated-op
          :op (p4::get-operator load-rocket)
          :binding-node-back-pointer (find-node 17)
          :values (list 
                    (p4::object-name-to-object 'kippers *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at kippers london))
              (p4::instantiate-consed-literal '(at rocket london)))))
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-applied-op-node 
        :name 18 
        :parent (find-node 17)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 18))
      (p4::make-instantiated-op
          :op (p4::get-operator load-rocket)
          :binding-node-back-pointer (find-node 17)
          :values (list 
                    (p4::object-name-to-object 'kippers *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at kippers london))
              (p4::instantiate-consed-literal '(at rocket london)))))

(setf (p4::a-or-b-node-applied (find-node 18))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 18))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(in-rocket kippers)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at kippers london))))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-goal-node 
        :name 19 
        :parent (find-node 18) 
        :goal 
            (p4::instantiate-consed-literal '(at rocket pittsburgh)) 
        :introducing-operators (list (find-node 14) (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-operator-node 
        :name 21 
        :parent (find-node 19) 
        :operator (p4::get-operator move-rocket-fast))))
 
(setf (p4::nexus-children (find-node 21))
  (list
    (p4::make-binding-node 
        :name 22 
        :parent (find-node 21)
        :instantiated-preconds 
            (p4::instantiate-consed-literal '(at rocket london))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 22))
      (p4::make-instantiated-op
          :op (p4::get-operator move-rocket-fast)
          :binding-node-back-pointer (find-node 22)
          :precond 
            (p4::instantiate-consed-literal '(at rocket london))))
 
(setf (p4::nexus-children (find-node 22))
  (list
    (p4::make-applied-op-node 
        :name 23 
        :parent (find-node 22)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 23))
      (p4::make-instantiated-op
          :op (p4::get-operator move-rocket-fast)
          :binding-node-back-pointer (find-node 22)
          :precond 
            (p4::instantiate-consed-literal '(at rocket london))))

(setf (p4::a-or-b-node-applied (find-node 23))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 23))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at rocket pittsburgh)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(at rocket london))))))
 
(setf (p4::nexus-children (find-node 23))
  (list
    (p4::make-applied-op-node 
        :name 24 
        :parent (find-node 23)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 24))
      (p4::make-instantiated-op
          :op (p4::get-operator unload-rocket)
          :binding-node-back-pointer (find-node 14)
          :values (list 
                    (p4::object-name-to-object 'kippers *current-problem-space*)
                    (p4::object-name-to-object 'pittsburgh *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at rocket pittsburgh))
              (p4::instantiate-consed-literal '(in-rocket kippers)))))

(setf (p4::a-or-b-node-applied (find-node 24))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 24))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at kippers pittsburgh)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-rocket kippers))))))
 
(setf (p4::nexus-children (find-node 24))
  (list
    (p4::make-applied-op-node 
        :name 25 
        :parent (find-node 24)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 25))
      (p4::make-instantiated-op
          :op (p4::get-operator unload-rocket)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'newcastle-brown-ale *current-problem-space*)
                    (p4::object-name-to-object 'pittsburgh *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at rocket pittsburgh))
              (p4::instantiate-consed-literal '(in-rocket newcastle-brown-ale)))))

(setf (p4::a-or-b-node-applied (find-node 25))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 25))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at
                                                   newcastle-brown-ale
                                                   pittsburgh)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(in-rocket
                                                   newcastle-brown-ale))))))
