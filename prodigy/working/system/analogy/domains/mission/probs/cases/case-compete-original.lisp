 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(holding noc-list))
              (p4::instantiate-consed-literal '(at london)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(holding noc-list))
              (p4::instantiate-consed-literal '(at london)))))
 
(setf (p4::nexus-children (find-node 4))
  (list
    (p4::make-goal-node 
        :name 5 
        :parent (find-node 4) 
        :goal 
            (p4::instantiate-consed-literal '(holding noc-list)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 5))
  (list
    (p4::make-operator-node 
        :name 6 
        :parent (find-node 5) 
        :operator (p4::get-operator steal))))
 
(setf (p4::nexus-children (find-node 6))
  (list
    (p4::make-binding-node 
        :name 7 
        :parent (find-node 6)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley))
              (p4::instantiate-consed-literal '(stored noc-list langley)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 7))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'noc-list *current-problem-space*)
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley))
              (p4::instantiate-consed-literal '(stored noc-list langley)))))
 
(setf (p4::nexus-children (find-node 7))
  (list
    (p4::make-goal-node 
        :name 8 
        :parent (find-node 7) 
        :goal 
            (p4::instantiate-consed-literal '(inside langley)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator break-in))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(insecure langley)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator break-in)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(insecure langley)))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-applied-op-node 
        :name 11 
        :parent (find-node 10)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 11))
      (p4::make-instantiated-op
          :op (p4::get-operator break-in)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(insecure langley)))))

(setf (p4::a-or-b-node-applied (find-node 11))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 11))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(inside langley)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(insecure langley))
                 (p4::instantiate-consed-literal '(at langley))))))
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-applied-op-node 
        :name 12 
        :parent (find-node 11)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 12))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 7)
          :values (list 
                    (p4::object-name-to-object 'noc-list *current-problem-space*)
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley))
              (p4::instantiate-consed-literal '(stored noc-list langley)))))

(setf (p4::a-or-b-node-applied (find-node 12))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 12))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding noc-list)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(stored noc-list langley))))))
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-goal-node 
        :name 13 
        :parent (find-node 12) 
        :goal 
            (p4::instantiate-consed-literal '(at london)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-operator-node 
        :name 14 
        :parent (find-node 13) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-binding-node 
        :name 63 
        :parent (find-node 14)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley london)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 63))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 63)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley london)))))
 
(setf (p4::nexus-children (find-node 63))
  (list
    (p4::make-goal-node 
        :name 64 
        :parent (find-node 63) 
        :goal 
            (p4::instantiate-consed-literal '(at langley)) 
        :introducing-operators (list (find-node 63) )))) 
 
(setf (p4::nexus-children (find-node 64))
  (list
    (p4::make-operator-node 
        :name 79 
        :parent (find-node 64) 
        :operator (p4::get-operator escape))))
 
(setf (p4::nexus-children (find-node 79))
  (list
    (p4::make-binding-node 
        :name 80 
        :parent (find-node 79)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 80))
      (p4::make-instantiated-op
          :op (p4::get-operator escape)
          :binding-node-back-pointer (find-node 80)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley)))))
 
(setf (p4::nexus-children (find-node 80))
  (list
    (p4::make-applied-op-node 
        :name 81 
        :parent (find-node 80)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 81))
      (p4::make-instantiated-op
          :op (p4::get-operator escape)
          :binding-node-back-pointer (find-node 80)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley)))))

(setf (p4::a-or-b-node-applied (find-node 81))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 81))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at langley))
                 (p4::instantiate-consed-literal '(secure langley)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(inside langley))))))
 
(setf (p4::nexus-children (find-node 81))
  (list
    (p4::make-applied-op-node 
        :name 82 
        :parent (find-node 81)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 82))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 63)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley london)))))

(setf (p4::a-or-b-node-applied (find-node 82))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 82))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at london)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(pass langley london))
                 (p4::instantiate-consed-literal '(at langley))))))
