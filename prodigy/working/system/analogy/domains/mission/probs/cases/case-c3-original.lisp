 
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
    (p4::make-applied-op-node 
        :name 14 
        :parent (find-node 13)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 14))
      (p4::make-instantiated-op
          :op (p4::get-operator break-in)
          :binding-node-back-pointer (find-node 13)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(insecure langley)))))

(setf (p4::a-or-b-node-applied (find-node 14))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 14))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(inside langley)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(insecure langley))
                 (p4::instantiate-consed-literal '(at langley))))))
 
(setf (p4::nexus-children (find-node 14))
  (list
    (p4::make-applied-op-node 
        :name 15 
        :parent (find-node 14)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 15))
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

(setf (p4::a-or-b-node-applied (find-node 15))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 15))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(holding noc-list)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(stored noc-list langley))))))
 
(setf (p4::nexus-children (find-node 15))
  (list
    (p4::make-goal-node 
        :name 16 
        :parent (find-node 15) 
        :goal 
            (p4::instantiate-consed-literal '(at london)) 
        :introducing-operators (list (find-node 7) )))) 
 
(setf (p4::nexus-children (find-node 16))
  (list
    (p4::make-operator-node 
        :name 17 
        :parent (find-node 16) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 17))
  (list
    (p4::make-binding-node 
        :name 18 
        :parent (find-node 17)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(pass area51 london)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 18))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 18)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(pass area51 london)))))
 
(setf (p4::nexus-children (find-node 18))
  (list
    (p4::make-goal-node 
        :name 19 
        :parent (find-node 18) 
        :goal 
            (p4::instantiate-consed-literal '(at area51)) 
        :introducing-operators (list (find-node 18) )))) 
 
(setf (p4::nexus-children (find-node 19))
  (list
    (p4::make-operator-node 
        :name 20 
        :parent (find-node 19) 
        :operator (p4::get-operator go))))
 
(setf (p4::nexus-children (find-node 20))
  (list
    (p4::make-binding-node 
        :name 21 
        :parent (find-node 20)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley area51)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 21))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 21)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*)
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley area51)))))
 
(setf (p4::nexus-children (find-node 21))
  (list
    (p4::make-goal-node 
        :name 22 
        :parent (find-node 21) 
        :goal 
            (p4::instantiate-consed-literal '(at langley)) 
        :introducing-operators (list (find-node 21) )))) 
 
(setf (p4::nexus-children (find-node 22))
  (list
    (p4::make-operator-node 
        :name 35 
        :parent (find-node 22) 
        :operator (p4::get-operator escape))))
 
(setf (p4::nexus-children (find-node 35))
  (list
    (p4::make-binding-node 
        :name 36 
        :parent (find-node 35)
        :instantiated-preconds 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley)))))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 36))
      (p4::make-instantiated-op
          :op (p4::get-operator escape)
          :binding-node-back-pointer (find-node 36)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley)))))
 
(setf (p4::nexus-children (find-node 36))
  (list
    (p4::make-applied-op-node 
        :name 37 
        :parent (find-node 36)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 37))
      (p4::make-instantiated-op
          :op (p4::get-operator escape)
          :binding-node-back-pointer (find-node 36)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(inside langley)))))

(setf (p4::a-or-b-node-applied (find-node 37))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 37))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at langley))
                 (p4::instantiate-consed-literal '(secure langley)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(inside langley))))))
 
(setf (p4::nexus-children (find-node 37))
  (list
    (p4::make-applied-op-node 
        :name 38 
        :parent (find-node 37)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 38))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 21)
          :values (list 
                    (p4::object-name-to-object 'langley *current-problem-space*)
                    (p4::object-name-to-object 'area51 *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at langley))
              (p4::instantiate-consed-literal '(pass langley area51)))))

(setf (p4::a-or-b-node-applied (find-node 38))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 38))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at area51)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(pass langley area51))
                 (p4::instantiate-consed-literal '(at langley))))))
 
(setf (p4::nexus-children (find-node 38))
  (list
    (p4::make-applied-op-node 
        :name 39 
        :parent (find-node 38)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 39))
      (p4::make-instantiated-op
          :op (p4::get-operator go)
          :binding-node-back-pointer (find-node 18)
          :values (list 
                    (p4::object-name-to-object 'area51 *current-problem-space*)
                    (p4::object-name-to-object 'london *current-problem-space*))
          :precond 
            (list 'and 
              (p4::instantiate-consed-literal '(at area51))
              (p4::instantiate-consed-literal '(pass area51 london)))))

(setf (p4::a-or-b-node-applied (find-node 39))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 39))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(at london)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(pass area51 london))
                 (p4::instantiate-consed-literal '(at area51))))))
 
(setf (p4::nexus-children (find-node 39))
  (list
    (p4::make-applied-op-node 
        :name 40 
        :parent (find-node 39)))) 

(setf (p4::a-or-b-node-instantiated-op (find-node 40))
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

(setf (p4::a-or-b-node-applied (find-node 40))
      (list (p4::make-op-application
                :instantiated-op
                 (p4::applied-op-node-instantiated-op
                  (find-node 40))
                :delta-adds (list
                 (p4::instantiate-consed-literal '(dropped noc-list london)))
                :delta-dels (list
                 (p4::instantiate-consed-literal '(holding noc-list))))))
