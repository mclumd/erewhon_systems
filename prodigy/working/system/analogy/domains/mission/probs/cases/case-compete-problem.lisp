 
(setf (p4::nexus-children (find-node 3))
  (list
    (p4::make-binding-node 
        :name 4 
        :parent (find-node 3)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(dropped noc-list london))
              (p4::instantiate-consed-literal '(dropped x-file london)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 4))
      (p4::make-instantiated-op
          :op (p4::get-operator prodigy4::*finish*)
          :binding-node-back-pointer (find-node 4)
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(dropped noc-list london))
              (p4::instantiate-consed-literal '(dropped x-file london)))))
 
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
            (p4::instantiate-consed-literal '(holding noc-list)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 8))
  (list
    (p4::make-operator-node 
        :name 9 
        :parent (find-node 8) 
        :operator (p4::get-operator steal))))
 
(setf (p4::nexus-children (find-node 9))
  (list
    (p4::make-binding-node 
        :name 10 
        :parent (find-node 9)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley))
              (p4::instantiate-consed-literal '(stored noc-list langley)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 10))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'noc-list *current-problem-space*)
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley))
              (p4::instantiate-consed-literal '(stored noc-list langley)))))
 
(setf (p4::nexus-children (find-node 10))
  (list
    (p4::make-goal-node 
        :name 11 
        :parent (find-node 10) 
        :goal 
            (p4::instantiate-consed-literal '(inside langley)) 
        :introducing-operators (list (find-node 10) )))) 
 
(setf (p4::nexus-children (find-node 11))
  (list
    (p4::make-operator-node 
        :name 12 
        :parent (find-node 11) 
        :operator (p4::get-operator break-in))))
 
(setf (p4::nexus-children (find-node 12))
  (list
    (p4::make-binding-node 
        :name 13 
        :parent (find-node 12)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(insecure langley)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 13))
      (p4::make-instantiated-op
          :op (p4::get-operator break-in)
          :binding-node-back-pointer (find-node 13)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(insecure langley)))))
 
(setf (p4::nexus-children (find-node 13))
  (list
    (p4::make-goal-node 
        :name 14 
        :parent (find-node 13) 
        :goal 
            (p4::instantiate-consed-literal '(dropped x-file london)) 
        :introducing-operators (list (find-node 4) )))) 
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-operator-node 
        :name 15 
        :parent (find-node 14) 
        :operator (p4::get-operator drop-off))))
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-binding-node 
        :name 16 
        :parent (find-node 15)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at london))
              (p4::instantiate-consed-literal '(holding x-file)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 16))
      (p4::make-instantiated-op
          :op (p4::get-operator drop-off)
          :binding-node-back-pointer (find-node 16)
          :values (list 
                    (p4::object-name-to-object 'x-file *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at london))
              (p4::instantiate-consed-literal '(holding x-file)))))
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-goal-node 
        :name 17 
        :parent (find-node 16) 
        :goal 
            (p4::instantiate-consed-literal '(holding x-file)) 
        :introducing-operators (list (find-node 16) )))) 
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-operator-node 
        :name 18 
        :parent (find-node 17) 
        :operator (p4::get-operator steal))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-binding-node 
        :name 19 
        :parent (find-node 18)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley))
              (p4::instantiate-consed-literal '(stored x-file langley)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 19))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 19)
          :values (list 
                    (p4::object-name-to-object 'x-file *current-problem-space*)
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley))
              (p4::instantiate-consed-literal '(stored x-file langley)))))
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-applied-op-node 
        :name 20 
        :parent (find-node 19)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 20))
      (p4::make-instantiated-op
          :op (p4::get-operator break-in)
          :binding-node-back-pointer (find-node 13)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(insecure langley)))))

(setf (p4::a-or-b-node-applied (find-node 20))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 20))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(inside langley)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(insecure langley))
                 (p4::instantiate-consed-literal '(at langley))))))
 
(setf (p4::nexus-children (find-node 20))
  (list
    (p4::make-applied-op-node 
        :name 21 
        :parent (find-node 20)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 21))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 19)
          :values (list 
                    (p4::object-name-to-object 'x-file *current-problem-space*)
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley))
              (p4::instantiate-consed-literal '(stored x-file langley)))))

(setf (p4::a-or-b-node-applied (find-node 21))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 21))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding x-file)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(stored x-file langley))))))
 
(setf (p4::nexus-children (find-node 21))
  (list
    (p4::make-goal-node 
        :name 22 
        :parent (find-node 21) 
        :goal 
            (p4::instantiate-consed-literal '(at london)) 
        :introducing-operators (list (find-node 16) (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 22))
  (list
    (p4::make-operator-node 
        :name 23 
        :parent (find-node 22) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 23))
  (list
    (p4::make-binding-node 
        :name 24 
        :parent (find-node 23)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley london)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 24))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 24)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley london)))))
 
(setf (p4::nexus-children (find-node 24))
  (list
    (p4::make-goal-node 
        :name 25 
        :parent (find-node 24) 
        :goal 
            (p4::instantiate-consed-literal '(at langley)) 
        :introducing-operators (list (find-node 24) )))) 
 
(setf (p4::nexus-children (find-node 25))
  (list
    (p4::make-operator-node 
        :name 26 
        :parent (find-node 25) 
        :operator (p4::get-operator escape))))
 
(setf (p4::nexus-children (find-node 26))
  (list
    (p4::make-binding-node 
        :name 27 
        :parent (find-node 26)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 27))
      (p4::make-instantiated-op
          :op (p4::get-operator escape)
          :binding-node-back-pointer (find-node 27)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley)))))
 
(setf (p4::nexus-children (find-node 27))
  (list
    (p4::make-applied-op-node 
        :name 28 
        :parent (find-node 27)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 28))
      (p4::make-instantiated-op
          :op (p4::get-operator steal)
          :binding-node-back-pointer (find-node 10)
          :values (list 
                    (p4::object-name-to-object 'noc-list *current-problem-space*)
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley))
              (p4::instantiate-consed-literal '(stored noc-list langley)))))

(setf (p4::a-or-b-node-applied (find-node 28))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 28))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding noc-list)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(stored noc-list langley))))))
 
(setf (p4::nexus-children (find-node 28))
  (list
    (p4::make-applied-op-node 
        :name 29 
        :parent (find-node 28)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 29))
      (p4::make-instantiated-op
          :op (p4::get-operator escape)
          :binding-node-back-pointer (find-node 27)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley)))))

(setf (p4::a-or-b-node-applied (find-node 29))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 29))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at langley))
                 (p4::instantiate-consed-literal '(secure langley)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(inside langley))))))
 
(setf (p4::nexus-children (find-node 29))
  (list
    (p4::make-applied-op-node 
        :name 30 
        :parent (find-node 29)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 30))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 24)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley london)))))

(setf (p4::a-or-b-node-applied (find-node 30))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 30))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at london)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(pass langley london))
                 (p4::instantiate-consed-literal '(at langley))))))
 
(setf (p4::nexus-children (find-node 30))
  (list
    (p4::make-applied-op-node 
        :name 31 
        :parent (find-node 30)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 31))
      (p4::make-instantiated-op
          :op (p4::get-operator drop-off)
          :binding-node-back-pointer (find-node 16)
          :values (list 
                    (p4::object-name-to-object 'x-file *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at london))
              (p4::instantiate-consed-literal '(holding x-file)))))

(setf (p4::a-or-b-node-applied (find-node 31))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 31))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(dropped x-file london)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(holding x-file))))))
 
(setf (p4::nexus-children (find-node 31))
  (list
    (p4::make-applied-op-node 
        :name 32 
        :parent (find-node 31)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 32))
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

(setf (p4::a-or-b-node-applied (find-node 32))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 32))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(dropped noc-list london)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(holding noc-list))))))
