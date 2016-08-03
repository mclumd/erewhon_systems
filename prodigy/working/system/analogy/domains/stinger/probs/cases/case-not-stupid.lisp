 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(destroyed luggage1)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(destroyed luggage1)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(destroyed luggage1)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator explode-conventional))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-o luggage1 kingstavern))
              (list 'and 
                (p4::instantiate-consed-literal '(detonating stinger1 kingstavern))))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator explode-conventional)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'stinger1 *current-problem-space*)
                    (p4::object-name-to-object 'kingstavern *current-problem-space*)
                    (p4::object-name-to-object 'luggage1 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-o luggage1 kingstavern))
              (list 'and 
                (p4::instantiate-consed-literal '(detonating stinger1 kingstavern))))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(detonating stinger1 kingstavern)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator launch))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech))
              (p4::instantiate-consed-literal '(holding researcher stinger1))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator launch)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'stinger1 *current-problem-space*)
                    (p4::object-name-to-object 'georgiatech *current-problem-space*)
                    (p4::object-name-to-object 'kingstavern *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech))
              (p4::instantiate-consed-literal '(holding researcher stinger1))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta)))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-applied-op-node 
        :name 11 
        :parent (find-node 10)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 11))
      (p4::make-instantiated-op
          :op (p4::get-operator launch)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'researcher *current-problem-space*)
                    (p4::object-name-to-object 'stinger1 *current-problem-space*)
                    (p4::object-name-to-object 'georgiatech *current-problem-space*)
                    (p4::object-name-to-object 'kingstavern *current-problem-space*)
                    (p4::object-name-to-object 'atlanta *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at-loc-p researcher georgiatech))
              (p4::instantiate-consed-literal '(holding researcher stinger1))
              (p4::instantiate-consed-literal '(in-city-l georgiatech atlanta))
              (p4::instantiate-consed-literal '(in-city-l kingstavern atlanta)))))

(setf (p4::a-or-b-node-applied (find-node 11))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 11))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(destroyed stinger1))
                 (p4::instantiate-consed-literal '(destroyed luggage1))
                 (p4::instantiate-consed-literal '(detonating stinger1 kingstavern)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(detonating stinger1 kingstavern))))))
