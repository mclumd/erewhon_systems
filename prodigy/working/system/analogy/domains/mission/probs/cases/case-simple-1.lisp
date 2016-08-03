 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(dropped noc-list london)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(dropped noc-list london)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(dropped noc-list london)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator drop-off))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at london))
              (p4::instantiate-consed-literal '(holding noc-list)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator drop-off)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'noc-list *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at london))
              (p4::instantiate-consed-literal '(holding noc-list)))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(at london)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley london)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley london)))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 44 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(holding noc-list)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 44))
  (list
    (p4::make-operator-node 
        :name 45 
        :parent (find-node 44) 
        :operator (p4::get-operator steal))))
 
(setf (p4::nexus-children (find-node 45))
  (list
    (p4::make-binding-node 
        :name 46 
        :parent (find-node 45)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley))
              (p4::instantiate-consed-literal '(stored noc-list langley)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 46))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 46)
          :values (list 
                    (p4::object-name-to-object 'noc-list *current-problem-space*)
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley))
              (p4::instantiate-consed-literal '(stored noc-list langley)))))
 
(setf (p4::nexus-children (find-node 46))
  (list
    (p4::make-goal-node 
        :name 47 
        :parent (find-node 46) 
        :goal 
            (p4::instantiate-consed-literal '(inside langley)) 
        :introducing-operators (list (find-node 46) )))) 
 
(setf (p4::nexus-children (find-node 47))
  (list
    (p4::make-operator-node 
        :name 48 
        :parent (find-node 47) 
        :operator (p4::get-operator break-in))))
 
(setf (p4::nexus-children (find-node 48))
  (list
    (p4::make-binding-node 
        :name 49 
        :parent (find-node 48)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(insecure langley)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 49))
      (p4::make-instantiated-op
          :op (p4::get-operator break-in)
          :binding-node-back-pointer (find-node 49)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(insecure langley)))))
 
(setf (p4::nexus-children (find-node 49))
  (list
    (p4::make-applied-op-node 
        :name 50 
        :parent (find-node 49)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 50))
      (p4::make-instantiated-op
          :op (p4::get-operator break-in)
          :binding-node-back-pointer (find-node 49)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(insecure langley)))))

(setf (p4::a-or-b-node-applied (find-node 50))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 50))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(inside langley)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(insecure langley))
                 (p4::instantiate-consed-literal '(at langley))))))
 
(setf (p4::nexus-children (find-node 50))
  (list
    (p4::make-applied-op-node 
        :name 51 
        :parent (find-node 50)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 51))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 46)
          :values (list 
                    (p4::object-name-to-object 'noc-list *current-problem-space*)
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley))
              (p4::instantiate-consed-literal '(stored noc-list langley)))))

(setf (p4::a-or-b-node-applied (find-node 51))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 51))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding noc-list)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(stored noc-list langley))))))
 
(setf (p4::nexus-children (find-node 51))
  (list
    (p4::make-goal-node 
        :name 52 
        :parent (find-node 51) 
        :goal 
            (p4::instantiate-consed-literal '(at langley)) 
        :introducing-operators (list (find-node 10) )))) 
 
(setf (p4::nexus-children (find-node 52))
  (list
    (p4::make-operator-node 
        :name 55 
        :parent (find-node 52) 
        :operator (p4::get-operator escape))))
 
(setf (p4::nexus-children (find-node 55))
  (list
    (p4::make-binding-node 
        :name 56 
        :parent (find-node 55)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 56))
      (p4::make-instantiated-op
          :op (p4::get-operator escape)
          :binding-node-back-pointer (find-node 56)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley)))))
 
(setf (p4::nexus-children (find-node 56))
  (list
    (p4::make-applied-op-node 
        :name 57 
        :parent (find-node 56)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 57))
      (p4::make-instantiated-op
          :op (p4::get-operator escape)
          :binding-node-back-pointer (find-node 56)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley)))))

(setf (p4::a-or-b-node-applied (find-node 57))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 57))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at langley))
                 (p4::instantiate-consed-literal '(secure langley)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(inside langley))))))
 
(setf (p4::nexus-children (find-node 57))
  (list
    (p4::make-applied-op-node 
        :name 58 
        :parent (find-node 57)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 58))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley london)))))

(setf (p4::a-or-b-node-applied (find-node 58))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 58))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at london)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(pass langley london))
                 (p4::instantiate-consed-literal '(at langley))))))
 
(setf (p4::nexus-children (find-node 58))
  (list
    (p4::make-applied-op-node 
        :name 59 
        :parent (find-node 58)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 59))
      (p4::make-instantiated-op
          :op (p4::get-operator drop-off)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'noc-list *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at london))
              (p4::instantiate-consed-literal '(holding noc-list)))))

(setf (p4::a-or-b-node-applied (find-node 59))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 59))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(dropped noc-list london)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(holding noc-list))))))
